# Development Packages

Below is my current development stack setup on Mac

## Languages

### NVM + Node + Yarn

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
nvm install 12
nvm use 12
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

---

## Frameworks

### Cocoapods

To manage dependencies for Swift and Objective-C projects

```bash
sudo gem install cocoapods
pod setup
```
