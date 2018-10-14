# Terminal

Follow the next steps to setup the Terminal app

- Install [Xcode](https://itunes.apple.com/gb/app/xcode/id497799835?mt=12)
- Install Command Line Tools (CLT) for Xcode

```
xcode-select --install
```

- Install `Homebrew`, the package manager for Mac

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

- Install `Zsh`

```
brew install zsh
chsh -s $(which zsh)
```

- Install `Oh My ZSH`

```
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

- Install `PIP`

```
sudo easy_install pip
```

- Install `Powerline`

```
pip install --user powerline-status
```

- Install the [Fonts](../fonts.md)
- Import [`cobalt2.terminal`](../themes/cobalt2/cobalt2.terminal) into the `Terminal` app
- Copy [`cobalt2.zsh-theme`](../themes/cobalt2/cobalt2.zsh-theme) to `~/.oh-my-zsh/custom/themes/`
- Open `~/.zshrc` with `nano ~/.zshrc` to set theme

```
ZSH_THEME=cobalt2
```

## Hyper

Hyper is an extensible, Electron-based terminal

- Install [Hyper](https://hyper.is/)
- Open `~/.hyper.js` with `nano ~/.hyper.js` to add fonts, theme and set the shell to use `zsh`

```
shell: 'zsh',

...

fontFamily: '"Menlo for Powerline", Menlo, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',

...

plugins: [
  'hyperterm-cobalt2-theme'
],
```
