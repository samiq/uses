# Development Packages

Below is my current development stack setup

## Cocoapods

To manage dependencies for Swift and Objective-C projects

```
sudo gem install cocoapods
pod setup
```

---

### NVM + Node

To install and manage multiple versions of Node

```
brew install nvm
```

Open `.bash_profile` and `.zshrc` to set NVM home folder and its initial setup with `nano ~/.bash_profile` and `nano ~/.zshrc` and add

```
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
```

Install **Node 6** and update **NPM**

```
nvm install 6.14.4
nvm install-latest-npm
```

Install **Node 8** and update **NPM**

```
nvm install 8.12.0
nvm use 8
nvm install-latest-npm
```

---

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
