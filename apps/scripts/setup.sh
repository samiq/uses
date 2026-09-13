#!/usr/bin/env bash

set -euo pipefail

# Format: "Category|Display Name|Type|Package"
# Type: cask|formula
# Add new apps by appending new rows to this APPS array.
APPS=(
	"Basics|1Password|cask|1password"
	"Basics|Raycast|cask|raycast"

	"Dev Basics|GitHub CLI|formula|gh"
	"Dev Basics|GitHub Desktop|cask|github"
	"Dev Basics|Linear|cask|linear-linear"

	"Dev Frameworks|NVM|formula|nvm"
	"Dev Frameworks|Python|formula|python"
	"Dev Frameworks|uv|formula|uv"
	"Dev Frameworks|Xcodes|formula|xcodesorg/made/xcodes"

	"Editors|Antigravity|cask|antigravity"
	"Editors|Cursor|cask|cursor"
	"Editors|Devin Desktop|cask|devin-desktop"
	"Editors|Github Copilot|cask|github-copilot-app"
	"Editors|Visual Studio Code|cask|visual-studio-code"

	"AI Apps|ChatGPT|cask|chatgpt"
	"AI Apps|Claude|cask|claude"
	"AI Apps|Grok Bot|cask|grok-bot"
	"AI Apps|Manus|cask|manus"
	"AI Apps|Perplexity|cask|perplexity"

	"Office Apps|Google Drive|cask|google-drive"
	"Office Apps|Granola|cask|granola"
	"Office Apps|Microsoft AutoUpdate|cask|microsoft-auto-update"
	"Office Apps|Microsoft Office|cask|microsoft-office"
	"Office Apps|Notion|cask|notion"
	"Office Apps|Notion Calendar|cask|notion-calendar"
	"Office Apps|Obsidian|cask|obsidian"
	"Office Apps|OneDrive|cask|onedrive"
	"Office Apps|Slack|cask|slack"
	"Office Apps|Superhuman|cask|superhuman"

	"Creative|Affinity|cask|affinity"
	"Creative|Canva|cask|canva"
	"Creative|Figma|cask|figma"
	"Creative|Framer|cask|framer"
	"Creative|Paper Design|cask|paper-design"

	"Browsers|Comet|cask|comet"
	"Browsers|Google Chrome|cask|google-chrome"
	"Browsers|Microsoft Edge|cask|microsoft-edge"
	"Browsers|Dia|cask|thebrowsercompany-dia"

	"Utils|Mole|formula|mole"
)

# Parsed columns of APPS, filled by parse_apps.
CATEGORY_OF=()
NAME_OF=()
TYPE_OF=()
PACKAGE_OF=()
TOKEN_OF=()

# Per-app state.
# STATUS: missing | installed | outdated
# ACTION: none | install | uninstall | upgrade
STATUS=()
ACTION=()
VERSION_OF=()

# Cached brew state, stored as "|token|token|" strings so bash 3.2 can match
# them without associative arrays.
INSTALLED_CASKS="||"
INSTALLED_FORMULAE="||"
OUTDATED_INFO=""

CURSOR=0
WINDOW_START=0
WINDOW_END=0

GREEDY=0
RUN_UPDATE=0
ZAP=0
STATUS_ONLY=0

C_RESET=""
C_BOLD=""
C_DIM=""
C_RED=""
C_GREEN=""
C_YELLOW=""
C_CYAN=""

usage() {
	cat <<'EOF'
Mac App Manager

Usage: setup.sh [options]

Options:
  -g, --greedy    Also report updates for casks that auto-update themselves
                  (Chrome, Slack, and friends). Off by default because those
                  apps usually update on their own.
  -u, --update    Run "brew update" first so update checks use fresh metadata.
  -s, --status    Print an install/update report and exit (no interactive menu).
  -z, --zap       Use "brew uninstall --zap" to also remove leftover
                  preferences and support files.
  -h, --help      Show this help.

Interactive keys:
  Up/Down     Move
  Space       Cycle the pending action for the highlighted app
              not installed -> install
              installed     -> uninstall
              outdated      -> upgrade -> uninstall
  a           Mark every missing app for install
  o           Mark every outdated app for upgrade
  n           Clear all pending actions
  r           Re-check status (runs "brew update" first)
  Enter       Review and apply pending actions
  q           Quit
EOF
}

parse_args() {
	while (($# > 0)); do
		case "$1" in
			-g|--greedy) GREEDY=1 ;;
			-u|--update) RUN_UPDATE=1 ;;
			-s|--status) STATUS_ONLY=1 ;;
			-z|--zap) ZAP=1 ;;
			-h|--help) usage; exit 0 ;;
			*)
				echo "Unknown option: $1" >&2
				echo >&2
				usage >&2
				exit 1
				;;
		esac
		shift
	done
}

setup_colors() {
	if [[ ! -t 1 ]] || ! command -v tput >/dev/null 2>&1; then
		return
	fi

	local colors
	colors="$(tput colors 2>/dev/null || echo 0)"
	if [[ -z "$colors" || "$colors" -lt 8 ]]; then
		return
	fi

	C_RESET="$(tput sgr0)"
	C_BOLD="$(tput bold)"
	C_DIM="$(tput dim)"
	C_RED="$(tput setaf 1)"
	C_GREEN="$(tput setaf 2)"
	C_YELLOW="$(tput setaf 3)"
	C_CYAN="$(tput setaf 6)"
}

ensure_homebrew() {
	if command -v brew >/dev/null 2>&1; then
		return
	fi

	echo "Homebrew is not installed."
	read -r -p "Install Homebrew now? [y/N]: " answer

	if [[ ! "$answer" =~ ^[Yy]$ ]]; then
		echo "Cannot continue without Homebrew. Exiting."
		exit 1
	fi

	if ! command -v curl >/dev/null 2>&1; then
		echo "curl is required to install Homebrew but was not found."
		exit 1
	fi

	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	if [[ -x /opt/homebrew/bin/brew ]]; then
		eval "$(/opt/homebrew/bin/brew shellenv)"
	elif [[ -x /usr/local/bin/brew ]]; then
		eval "$(/usr/local/bin/brew shellenv)"
	fi

	if ! command -v brew >/dev/null 2>&1; then
		echo "Homebrew installation completed, but brew is still unavailable in this shell."
		echo "Open a new terminal and run this script again."
		exit 1
	fi
}

parse_apps() {
	local i category name type package
	for ((i = 0; i < ${#APPS[@]}; i++)); do
		IFS='|' read -r category name type package <<< "${APPS[$i]}"
		CATEGORY_OF[$i]="$category"
		NAME_OF[$i]="$name"
		TYPE_OF[$i]="$type"
		PACKAGE_OF[$i]="$package"
		# Tap-qualified packages (owner/tap/name) are listed by brew under
		# their bare name, so match on that.
		TOKEN_OF[$i]="${package##*/}"
		ACTION[$i]="none"
		STATUS[$i]="missing"
		VERSION_OF[$i]=""
	done
}

# Collects one "token|current|latest" line per outdated package. Cask and
# formula verbose output differ slightly ("!=" vs "<"), so both are handled.
collect_outdated() {
	local cask_args=(--cask --verbose)
	if ((GREEDY == 1)); then
		cask_args+=(--greedy)
	fi

	local raw
	raw="$(
		{
			brew outdated --formula --verbose 2>/dev/null || true
			brew outdated "${cask_args[@]}" 2>/dev/null || true
		}
	)"

	OUTDATED_INFO="$(
		printf '%s\n' "$raw" | awk '
			/^[A-Za-z0-9@._+-]+ \(/ {
				token = $1
				current = $0
				sub(/^[^(]*\(/, "", current)
				sub(/\).*$/, "", current)
				latest = $NF
				print token "|" current "|" latest
			}
		'
	)"
}

outdated_versions() {
	local token="$1"
	if [[ -z "$OUTDATED_INFO" ]]; then
		return
	fi
	printf '%s\n' "$OUTDATED_INFO" | awk -F'|' -v key="$token" '$1 == key { print $2 " -> " $3; exit }'
}

# Returns the token brew actually has installed for a package, or nothing.
# Formulae like "python" land on disk as "python@3.14", so fall back to the
# first versioned match when there is no exact one.
resolve_installed_token() {
	local list="$1" token="$2" allow_versioned="$3" match

	if [[ "$list" == *"|$token|"* ]]; then
		printf '%s' "$token"
		return 0
	fi

	if [[ "$allow_versioned" == "1" ]]; then
		match="$(printf '%s' "$list" | tr '|' '\n' | awk -v t="$token" 'index($0, t "@") == 1 { print; exit }')"
		if [[ -n "$match" ]]; then
			printf '%s' "$match"
			return 0
		fi
	fi

	return 1
}

refresh_status() {
	local i token

	printf 'Checking Homebrew status...\n'

	INSTALLED_CASKS="|$(brew list --cask -1 2>/dev/null | tr '\n' '|' || true)"
	INSTALLED_FORMULAE="|$(brew list --formula -1 2>/dev/null | tr '\n' '|' || true)"
	collect_outdated

	for ((i = 0; i < ${#APPS[@]}; i++)); do
		VERSION_OF[$i]=""

		if [[ "${TYPE_OF[$i]}" == "cask" ]]; then
			token="$(resolve_installed_token "$INSTALLED_CASKS" "${TOKEN_OF[$i]}" 0 || true)"
		else
			token="$(resolve_installed_token "$INSTALLED_FORMULAE" "${TOKEN_OF[$i]}" 1 || true)"
		fi

		if [[ -z "$token" ]]; then
			STATUS[$i]="missing"
			continue
		fi

		VERSION_OF[$i]="$(outdated_versions "$token")"
		if [[ -n "${VERSION_OF[$i]}" ]]; then
			STATUS[$i]="outdated"
		else
			STATUS[$i]="installed"
		fi
	done
}

reset_actions() {
	local i
	for ((i = 0; i < ${#APPS[@]}; i++)); do
		ACTION[$i]="none"
	done
}

count_action() {
	local want="$1" i count=0
	for ((i = 0; i < ${#APPS[@]}; i++)); do
		if [[ "${ACTION[$i]}" == "$want" ]]; then
			count=$((count + 1))
		fi
	done
	echo "$count"
}

count_status() {
	local want="$1" i count=0
	for ((i = 0; i < ${#APPS[@]}; i++)); do
		if [[ "${STATUS[$i]}" == "$want" ]]; then
			count=$((count + 1))
		fi
	done
	echo "$count"
}

count_pending() {
	local i count=0
	for ((i = 0; i < ${#APPS[@]}; i++)); do
		if [[ "${ACTION[$i]}" != "none" ]]; then
			count=$((count + 1))
		fi
	done
	echo "$count"
}

cycle_action() {
	local i="$1"

	case "${STATUS[$i]}" in
		missing)
			if [[ "${ACTION[$i]}" == "install" ]]; then
				ACTION[$i]="none"
			else
				ACTION[$i]="install"
			fi
			;;
		installed)
			if [[ "${ACTION[$i]}" == "uninstall" ]]; then
				ACTION[$i]="none"
			else
				ACTION[$i]="uninstall"
			fi
			;;
		outdated)
			case "${ACTION[$i]}" in
				none) ACTION[$i]="upgrade" ;;
				upgrade) ACTION[$i]="uninstall" ;;
				*) ACTION[$i]="none" ;;
			esac
			;;
	esac
}

action_marker() {
	case "$1" in
		install) printf '[+]' ;;
		uninstall) printf '[-]' ;;
		upgrade) printf '[^]' ;;
		*) printf '[ ]' ;;
	esac
}

action_color() {
	case "$1" in
		install) printf '%s' "$C_GREEN" ;;
		uninstall) printf '%s' "$C_RED" ;;
		upgrade) printf '%s' "$C_YELLOW" ;;
		*) printf '%s' "$C_DIM" ;;
	esac
}

status_label() {
	local i="$1"
	case "${STATUS[$i]}" in
		missing) printf 'not installed' ;;
		installed) printf 'installed' ;;
		outdated) printf 'update: %s' "${VERSION_OF[$i]}" ;;
	esac
}

status_color() {
	case "${STATUS[$1]}" in
		missing) printf '%s' "$C_DIM" ;;
		installed) printf '%s' "$C_GREEN" ;;
		outdated) printf '%s' "$C_YELLOW" ;;
	esac
}

clear_screen() {
	# "clear" fails outright when TERM is unset; fall back to raw ANSI.
	clear 2>/dev/null || printf '\033[2J\033[H'
}

get_terminal_height() {
	local lines
	lines="$(tput lines 2>/dev/null || echo 24)"
	if [[ -z "$lines" || "$lines" -lt 10 ]]; then
		lines=24
	fi
	echo "$lines"
}

# Last app index that fits in "budget" screen rows starting at WINDOW_START,
# accounting for the extra line each category header takes.
fitting_end() {
	local budget="$1" i need lines=0 end="$WINDOW_START" last_category=""

	for ((i = WINDOW_START; i < ${#APPS[@]}; i++)); do
		need=1
		if [[ "${CATEGORY_OF[$i]}" != "$last_category" ]]; then
			need=2
		fi
		if ((lines + need > budget)); then
			break
		fi
		lines=$((lines + need))
		last_category="${CATEGORY_OF[$i]}"
		end=$i
	done

	echo "$end"
}

compute_window() {
	local budget end

	budget=$(( $(get_terminal_height) - 10 ))
	if ((budget < 5)); then
		budget=5
	fi

	if ((CURSOR < WINDOW_START)); then
		WINDOW_START=$CURSOR
	fi

	while true; do
		end="$(fitting_end "$budget")"
		if ((CURSOR <= end || WINDOW_START >= CURSOR)); then
			break
		fi
		WINDOW_START=$((WINDOW_START + 1))
	done

	WINDOW_END=$end
}

draw_menu() {
	local i marker pointer namefield last_category=""

	compute_window

	clear_screen
	printf '%sMac App Manager%s  %s%s installed, %s outdated, %s not installed%s\n' \
		"$C_BOLD" "$C_RESET" "$C_DIM" \
		"$(count_status installed)" "$(count_status outdated)" "$(count_status missing)" \
		"$C_RESET"
	printf '%sUp/Down move  Space toggle  a all missing  o all outdated  n none  r refresh  Enter apply  q quit%s\n' \
		"$C_DIM" "$C_RESET"
	printf '%s[+] install   [-] uninstall   [^] upgrade%s\n' "$C_DIM" "$C_RESET"
	echo

	for ((i = WINDOW_START; i <= WINDOW_END; i++)); do
		if [[ "${CATEGORY_OF[$i]}" != "$last_category" ]]; then
			printf '%s[%s]%s\n' "$C_CYAN" "${CATEGORY_OF[$i]}" "$C_RESET"
			last_category="${CATEGORY_OF[$i]}"
		fi

		marker="$(action_marker "${ACTION[$i]}")"

		if ((i == CURSOR)); then
			pointer=">"
		else
			pointer=" "
		fi

		printf -v namefield '%-26s' "${NAME_OF[$i]}"

		printf ' %s %s%s%s %s %s%s%s\n' \
			"$pointer" \
			"$(action_color "${ACTION[$i]}")" "$marker" "$C_RESET" \
			"$namefield" \
			"$(status_color "$i")" "$(status_label "$i")" "$C_RESET"
	done

	echo
	printf 'Pending: %s install, %s upgrade, %s uninstall\n' \
		"$(count_action install)" "$(count_action upgrade)" "$(count_action uninstall)"
	if ((GREEDY == 0)); then
		printf '%sSelf-updating casks are not update-checked; re-run with --greedy to include them.%s\n' \
			"$C_DIM" "$C_RESET"
	fi
}

mark_all_missing() {
	local i
	for ((i = 0; i < ${#APPS[@]}; i++)); do
		if [[ "${STATUS[$i]}" == "missing" ]]; then
			ACTION[$i]="install"
		fi
	done
}

mark_all_outdated() {
	local i
	for ((i = 0; i < ${#APPS[@]}; i++)); do
		if [[ "${STATUS[$i]}" == "outdated" ]]; then
			ACTION[$i]="upgrade"
		fi
	done
}

interactive_select() {
	local key

	while true; do
		draw_menu
		IFS= read -rsn1 key || key="q"

		if [[ "$key" == $'\x1b' ]]; then
			IFS= read -rsn2 key || key=""
			case "$key" in
				"[A")
					if ((CURSOR > 0)); then
						CURSOR=$((CURSOR - 1))
					fi
					;;
				"[B")
					if ((CURSOR < ${#APPS[@]} - 1)); then
						CURSOR=$((CURSOR + 1))
					fi
					;;
			esac
		elif [[ "$key" == " " ]]; then
			cycle_action "$CURSOR"
		elif [[ "$key" == "k" ]]; then
			if ((CURSOR > 0)); then
				CURSOR=$((CURSOR - 1))
			fi
		elif [[ "$key" == "j" ]]; then
			if ((CURSOR < ${#APPS[@]} - 1)); then
				CURSOR=$((CURSOR + 1))
			fi
		elif [[ "$key" == "a" || "$key" == "A" ]]; then
			mark_all_missing
		elif [[ "$key" == "o" || "$key" == "O" ]]; then
			mark_all_outdated
		elif [[ "$key" == "n" || "$key" == "N" ]]; then
			reset_actions
		elif [[ "$key" == "r" || "$key" == "R" ]]; then
			echo
			echo "Updating Homebrew metadata..."
			brew update >/dev/null 2>&1 || echo "brew update failed; using cached metadata."
			refresh_status
		elif [[ "$key" == "" ]]; then
			if (( $(count_pending) == 0 )); then
				echo
				echo "Nothing selected. Use Space to mark an app for install, upgrade or uninstall."
				read -r -p "Press Enter to continue... " _
			else
				return 0
			fi
		elif [[ "$key" == "q" || "$key" == "Q" ]]; then
			return 1
		fi
	done
}

print_plan() {
	local i

	clear_screen
	echo "Planned changes:"
	echo

	for ((i = 0; i < ${#APPS[@]}; i++)); do
		case "${ACTION[$i]}" in
			install) printf '  install    %s [%s]\n' "${NAME_OF[$i]}" "${TYPE_OF[$i]}" ;;
			upgrade) printf '  upgrade    %s [%s] %s\n' "${NAME_OF[$i]}" "${TYPE_OF[$i]}" "${VERSION_OF[$i]}" ;;
			uninstall) printf '  uninstall  %s [%s]\n' "${NAME_OF[$i]}" "${TYPE_OF[$i]}" ;;
		esac
	done
	echo
}

apply_actions() {
	local i failed=0 done_count=0
	local -a failures=()

	echo "Applying changes..."
	echo

	for ((i = 0; i < ${#APPS[@]}; i++)); do
		if [[ "${ACTION[$i]}" == "none" ]]; then
			continue
		fi

		local name="${NAME_OF[$i]}"
		local package="${PACKAGE_OF[$i]}"
		local -a cmd=(brew)

		case "${ACTION[$i]}" in
			install)
				cmd+=(install)
				if [[ "${TYPE_OF[$i]}" == "cask" ]]; then
					cmd+=(--cask)
				fi
				;;
			upgrade)
				cmd+=(upgrade)
				if [[ "${TYPE_OF[$i]}" == "cask" ]]; then
					cmd+=(--cask)
					if ((GREEDY == 1)); then
						cmd+=(--greedy)
					fi
				fi
				;;
			uninstall)
				cmd+=(uninstall)
				if [[ "${TYPE_OF[$i]}" == "cask" ]]; then
					cmd+=(--cask)
				fi
				if ((ZAP == 1)); then
					cmd+=(--zap)
				fi
				;;
		esac

		cmd+=("$package")

		printf '%s[%s]%s %s\n' "$C_BOLD" "${ACTION[$i]}" "$C_RESET" "$name"
		# A single failure should not abort the whole run.
		if "${cmd[@]}"; then
			done_count=$((done_count + 1))
		else
			failed=$((failed + 1))
			failures+=("${ACTION[$i]} $name")
		fi
		echo
	done

	printf '%s%s change(s) applied%s' "$C_GREEN" "$done_count" "$C_RESET"
	if ((failed > 0)); then
		printf ', %s%s failed%s\n' "$C_RED" "$failed" "$C_RESET"
		for i in "${failures[@]}"; do
			printf '  failed: %s\n' "$i"
		done
	else
		echo
	fi
	echo
}

print_status_report() {
	local i last_category=""

	printf '%sHomebrew app status%s  (%s installed, %s outdated, %s not installed)\n\n' \
		"$C_BOLD" "$C_RESET" \
		"$(count_status installed)" "$(count_status outdated)" "$(count_status missing)"

	for ((i = 0; i < ${#APPS[@]}; i++)); do
		if [[ "${CATEGORY_OF[$i]}" != "$last_category" ]]; then
			printf '%s[%s]%s\n' "$C_CYAN" "${CATEGORY_OF[$i]}" "$C_RESET"
			last_category="${CATEGORY_OF[$i]}"
		fi

		local namefield
		printf -v namefield '%-26s' "${NAME_OF[$i]}"
		printf '  %s %s%s%s\n' "$namefield" "$(status_color "$i")" "$(status_label "$i")" "$C_RESET"
	done

	if ((GREEDY == 0)); then
		echo
		printf '%sCasks that update themselves are not checked. Re-run with --greedy to include them.%s\n' \
			"$C_DIM" "$C_RESET"
	fi
}

main() {
	local confirm zap_answer again

	parse_args "$@"
	setup_colors
	ensure_homebrew
	parse_apps

	if ((RUN_UPDATE == 1)); then
		echo "Updating Homebrew metadata..."
		brew update >/dev/null 2>&1 || echo "brew update failed; using cached metadata."
	fi

	refresh_status

	if ((STATUS_ONLY == 1)); then
		clear_screen
		print_status_report
		exit 0
	fi

	while true; do
		if ! interactive_select; then
			echo
			echo "Canceled."
			exit 0
		fi

		print_plan

		if (( $(count_action uninstall) > 0 )) && ((ZAP == 0)); then
			read -r -p "Also remove leftover preferences and support files (--zap)? [y/N]: " zap_answer
			if [[ "$zap_answer" =~ ^[Yy]$ ]]; then
				ZAP=1
			fi
		fi

		read -r -p "Apply these changes? [y/N]: " confirm
		if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
			echo "Canceled. Returning to the menu."
			read -r -p "Press Enter to continue... " _
			continue
		fi

		apply_actions
		reset_actions
		refresh_status

		read -r -p "Press Enter to return to the menu, or q to quit: " again
		if [[ "$again" =~ ^[Qq]$ ]]; then
			exit 0
		fi
	done
}

main "$@"
