# Terminal

Follow the next steps to setup the necessary shells in your PC

## Chocolatey

The package manager for Windows

- Install `Chocolatey` via `cmd`

```
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
```

- To list locally installed packages you can run

```
choco list --local-only
```

- Install Git

```
choco install git
```

## Windows Subsystem for Linux (WSL)

The Windows Subsystem for Linux lets developers run a Linux environment directly on Windows, without the overhead of a virtual machine.

- Turn on support for WSL in windows by opening Powershell as Administrator and run

```
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
```

- Install [Ubuntu](https://www.microsoft.com/en-us/p/ubuntu/9nblggh4msv6) from the Microsoft Store.

### Inside Ubuntu

- Install Zsh

```
sudo apt-get install zsh
chsh -s $(which zsh)
```

- Install Oh My Zsh

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

- Install Python

```
sudo apt-get install python
```

- Install PIP

```
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python get-pip.py
```

- Install Powerline

```
pip install --user powerline-status
```

- Install the [Fonts](../fonts.md)
- Clone the `uses` repository inside WSL so the theme can be installed properly (this doesn't work if repo is accesed from the Windows FS).

```
mkdir Projects && cd Projects
git clone https://github.com/samiq/uses.git
cp uses/themes/cobalt2/cobalt2.zsh-theme ~/.oh-my-zsh/custom/themes/cobalt2.zsh-theme
```

- Open `~/.zshrc` with `nano ~/.zshrc` to set theme

```
ZSH_THEME=cobalt2
```

- Activate theme with

```
source .zshrc
```

## Hyper

Hyper is an extensible, Electron-based terminal

- Install [Hyper](https://hyper.is/)
- Open `~/.hyper.js` with `nano ~/.hyper.js` to add fonts, theme and set the shell to use `zsh`

```
shell: 'C:\\Windows\\System32\\wsl.exe',
shellArgs: [],

...

fontSize: 14,
fontFamily: '"Menlo for Powerline", Menlo, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',

...

plugins: [
  'hyperterm-cobalt2-theme'
],
```