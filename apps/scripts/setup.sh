#!/usr/bin/env bash

set -euo pipefail

# Format: "Category|Display Name|Type|Package"
# Type: cask|formula
# Add new apps by appending new rows to this APPS array.
APPS=(
	"Basics|1Password|cask|1password"
	"Basics|Raycast|cask|raycast"

	"Dev Basics|GitHub Desktop|cask|github"
	"Dev Basics|GitHub CLI|formula|gh"
	"Dev Basics|NVM|formula|nvm"
	"Dev Basics|Python|formula|python"
	"Dev Basics|uv|formula|uv"

	"Editors|Visual Studio Code|cask|visual-studio-code"
	"Editors|Windsurf|cask|windsurf"
	"Editors|Antigravity|cask|antigravity"

	"AI Apps|Claude|cask|claude"
	"AI Apps|ChatGPT|cask|chatgpt"
	"AI Apps|Perplexity|cask|perplexity"

	"Office Apps|Superhuman|cask|superhuman"
	"Office Apps|Notion|cask|notion"
	"Office Apps|Notion Calendar|cask|notion-calendar"
	"Office Apps|Obsidian|cask|obsidian"
	"Office Apps|Granola|cask|granola"
	"Office Apps|Figma|cask|figma"
	"Office Apps|Framer|cask|framer"
	"Office Apps|Affinity|cask|affinity"
	"Office Apps|Linear|cask|linear-linear"
	"Office Apps|Microsoft Office|cask|microsoft-office"
	"Office Apps|Microsoft AutoUpdate|cask|microsoft-auto-update"

	"Browsers|Dia|cask|thebrowsercompany-dia"
	"Browsers|Google Chrome|cask|google-chrome"
	"Browsers|Microsoft Edge|cask|microsoft-edge"
	"Browsers|Comet|cask|comet"

	"Utils|Mole|formula|mole"
)

SELECTED=()
CURSOR=0
WINDOW_START=0

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

is_installed() {
	local type="$1"
	local package="$2"

	if [[ "$type" == "cask" ]]; then
		brew list --cask "$package" >/dev/null 2>&1
	else
		brew list "$package" >/dev/null 2>&1
	fi
}

setup_selection() {
	local i
	for ((i = 0; i < ${#APPS[@]}; i++)); do
		SELECTED[$i]=0
	done
}

get_terminal_height() {
	local lines
	lines="$(tput lines 2>/dev/null || echo 24)"
	if [[ -z "$lines" || "$lines" -lt 10 ]]; then
		lines=24
	fi
	echo "$lines"
}

draw_menu() {
	local total visible_rows end i
	local category name type package
	local marker pointer
	local last_category=""

	total=${#APPS[@]}
	visible_rows=$(( $(get_terminal_height) - 8 ))
	if ((visible_rows < 5)); then
		visible_rows=5
	fi

	if ((CURSOR < WINDOW_START)); then
		WINDOW_START=$CURSOR
	fi
	if ((CURSOR >= WINDOW_START + visible_rows)); then
		WINDOW_START=$((CURSOR - visible_rows + 1))
	fi

	end=$((WINDOW_START + visible_rows - 1))
	if ((end >= total)); then
		end=$((total - 1))
	fi

	clear
	echo "Mac App Installer"
	echo "Use Up/Down to move, Space to toggle, Enter to continue, q to quit"
	echo

	for ((i = WINDOW_START; i <= end; i++)); do
		IFS='|' read -r category name type package <<< "${APPS[$i]}"

		if [[ "$category" != "$last_category" ]]; then
			echo "[$category]"
			last_category="$category"
		fi

		if ((SELECTED[i] == 1)); then
			marker="[x]"
		else
			marker="[ ]"
		fi

		if ((i == CURSOR)); then
			pointer=">"
		else
			pointer=" "
		fi

		printf " %s %s %s (%s)\n" "$pointer" "$marker" "$name" "$type"
	done

	echo
	echo "Selected: $(count_selected)/${#APPS[@]}"
}

count_selected() {
	local i count=0
	for ((i = 0; i < ${#SELECTED[@]}; i++)); do
		if ((SELECTED[i] == 1)); then
			count=$((count + 1))
		fi
	done
	echo "$count"
}

interactive_select() {
	local key

	while true; do
		draw_menu
		IFS= read -rsn1 key

		if [[ "$key" == $'\x1b' ]]; then
			IFS= read -rsn2 key
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
			if ((SELECTED[CURSOR] == 1)); then
				SELECTED[CURSOR]=0
			else
				SELECTED[CURSOR]=1
			fi
		elif [[ "$key" == "" ]]; then
			if (( $(count_selected) == 0 )); then
				echo
				echo "Select at least one app before continuing."
				read -r -p "Press Enter to continue... " _
			else
				break
			fi
		elif [[ "$key" == "q" || "$key" == "Q" ]]; then
			echo
			echo "Canceled."
			exit 0
		fi
	done
}

install_selected() {
	local i category name type package

	clear
	echo "Installing selected apps..."
	echo

	for ((i = 0; i < ${#APPS[@]}; i++)); do
		if ((SELECTED[i] == 0)); then
			continue
		fi

		IFS='|' read -r category name type package <<< "${APPS[$i]}"

		if is_installed "$type" "$package"; then
			echo "[skip] $name is already installed"
			continue
		fi

		echo "[install] $name"
		if [[ "$type" == "cask" ]]; then
			brew install --cask "$package"
		else
			brew install "$package"
		fi
	done

	echo
	echo "Done."
}

print_summary() {
	local i category name type package

	clear
	echo "You selected:"
	echo

	for ((i = 0; i < ${#APPS[@]}; i++)); do
		if ((SELECTED[i] == 0)); then
			continue
		fi

		IFS='|' read -r category name type package <<< "${APPS[$i]}"
		echo "- $name [$category, $type]"
	done
	echo
}

main() {
	local confirm

	ensure_homebrew
	setup_selection
	interactive_select
	print_summary

	read -r -p "Continue with installation? [y/N]: " confirm
	if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
		echo "Installation canceled."
		exit 0
	fi

	install_selected
}

main "$@"