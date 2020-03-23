# Development Packages

Below is my current development stack setup on Mac


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

Install **.NET Core**

```
brew cask install dotnet-sdk
```

### Python

```
brew install python
```


---

## Frameworks
### Cocoapods

To manage dependencies for Swift and Objective-C projects

```
sudo gem install cocoapods
pod setup
```

### Firebase

The Firebase CLI provides a variety of tools for managing, viewing, and deploying to Firebase projects.

```
npm install -g firebase-tools
firebase login
```

to switch between projects

```
firebase use <project-name>
```

### Back4App / Parse

[Install](https://www.back4app.com/docs/platform/command-line-interface) the Parse CLI and add the Account Key.

```
b4a configure accountkey
```
