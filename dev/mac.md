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

Install **Node** and update **NPM**

```bash
nvm install-lts
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
rbenv install 3.4.8
```
```bash
rbenv global 3.4.8
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

to install rails-new

1. Download `rails-new` from their [repo](https://github.com/rails/rails-new)
2. Save into folder i.e. Projects/sdks
3. Add to path by modifing the `.zprofile` and add

```bash
/Users/xxx/Projects/sdks/rails-new
```

4. Create a new rails app

```bash
rails-new -u 3.4.8 -r 8.1.2 appname --devcontainer
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
