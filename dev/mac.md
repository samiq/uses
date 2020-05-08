# Development Packages

Below is my current development stack setup on Mac

## Languages

### NVM + Node

To install and manage multiple versions of Node

```
brew install nvm
```

Open `.zshrc` to set NVM home folder and its initial setup with `nano ~/.zshrc` and add

```
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
```

Install **Node 12** and update **NPM**

```
nvm install 12
nvm use 12
nvm install-latest-npm
```

### Yarn

Install **yarn**

```
brew install yarn
```

### Dot net

```
brew cask install dotnet-sdk
```

### Python

```
brew install python
```
