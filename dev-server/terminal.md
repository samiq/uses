# Server


### Install Zsh

```
sudo apt-get install zsh
chsh -s $(which zsh)
```

### Setup Git

```
git config --global user.name "My Name"
git config --global user.email "my@email.com"
```

### Install NVM + Node

Install the Pre-requisitions to NVM
```
sudo apt-get install build-essential libssl-dev
```

Install NVM (check [here](https://github.com/creationix/nvm#install-script) for latest version of script)

```
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
source .bashrc
```

Install NPM 8

```
nvm install 8
nvm install-latest-npm
```
