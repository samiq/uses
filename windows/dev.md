# Development Packages

Below is my current development stack setup on a Windows PC

### NVM + Node

Install Pre-requisites to NVM

```
sudo apt-get update
sudo apt-get install build-essential libssl-dev
```

Install NVM (check [here](https://github.com/creationix/nvm#install-script) for latest version of script)

```
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
```

Open `.zshrc` to set NVM home folder and its initial setup with `nano ~/.zshrc` and add

```
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
```

Check that this setup has also been added to `.bashrc` with

```
more ~/.bashrc
```

Install **Node 8** and update **NPM**

```
nvm install 8
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
