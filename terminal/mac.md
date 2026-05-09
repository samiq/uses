# Terminal

Follow the next steps to setup the Terminal app

- Install [Xcode](https://itunes.apple.com/gb/app/xcode/id497799835?mt=12)
- Install Command Line Tools (CLT) for Xcode

```bash
xcode-select --install
```

- Install [`Homebrew`](https://brew.sh/), the package manager for Mac

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

- Install [`Oh My Zsh`](https://ohmyz.sh/)

```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

- Clone this repo.
- Copy the theme to the themes folder with

```bash
cp cobalt2.zsh-theme ~/.oh-my-zsh/custom/themes
```

then make the theme the default by doing `nano ~/.zshrc` and setting up as

```bash
ZSH_THEME=cobalt2
```

- For the theme to work you need a font that support ligatures such as [Microsoft Cascadia Code](https://github.com/microsoft/cascadia-code).

```bash
brew install --cask font-cascadia-code-pl
```

- Optionally you can import the terminal theme located in the [themes folder](../themes/cobalt2).

## Install Apps

### Basics

brew install --cask 1password

brew install --cask raycast

### Dev Basics

brew install --cask github

brew install nvm

```shell
# nano .zprofile
# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
```

brew install python

brew install uv

### Editors

brew install --cask visual-studio-code

brew install --cask windsurf

brew install --cask antigravity

#### AI Agent Apps

brew install --cask codex-app

#### AI Apps

brew install --cask claude

brew install --cask chatgpt

### Office Apps

brew install --cask superhuman

brew install --cask notion

brew install --cask notion-calendar

brew install --cask granola

brew install --cask figma

brew install --cask framer

brew install --cask affinity

brew install --cask linear-linear

brew install --cask microsoft-office

brew install --cask obsidian

### Browsers

brew install --cask thebrowsercompany-dia

brew install --cask comet

brew install --cask google-chrome

brew install --cask chatgpt-atlas

### Utils

brew install mole