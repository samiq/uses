# Terminal

Follow the next steps to setup the Terminal app

- Install [Xcode](https://itunes.apple.com/gb/app/xcode/id497799835?mt=12)
- Install Command Line Tools (CLT) for Xcode

```bash
xcode-select --install
```

- Install [`Homebrew`](https://brew.sh/), the package manager for Mac

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
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

- Optionally you can import the terminal theme located in the [themes folder](../themes/cobalt2).
