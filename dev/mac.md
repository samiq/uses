# Development Packages

Below is my current development stack setup on Mac

## Languages

### NVM + Node + Yarn

To install latest version of node

```bash
brew install nodejs
```

To install and manage multiple versions of Node

```bash
brew install nvm
```

Open `.zshrc` to set NVM home folder and its initial setup with `nano ~/.zshrc` and add

```bash
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
```

Install **Node 12** and update **NPM**

```bash
nvm install 20
nvm use 20
nvm install-latest-npm
```

Install **yarn**

```bash
brew install yarn
```

### Dot net

```bash
brew cask install dotnet-sdk
```

### Python

```bash
brew install python
```

### Ruby on Rails

#### Install Ruby

```bash
brew install rbenv ruby-build
```

then run

```bash
rbenv install -l
```

to list all available Ruby runtimes and chose one to install

```bash
rbenv install 3.3.0
```
```bash
rbenv global 3.3.0
```
```bash
rbenv init
```

modify the `.zprofile` to evaluate `rbenv`

```bash
eval "$(rbenv init - zsh)"
```

#### Install Rails

to install rails

```bash
gem install rails
```

---

## Frameworks

### Cocoapods

To manage dependencies for Swift and Objective-C projects

```bash
brew install cocoapods
```
```bash
pod setup
```
