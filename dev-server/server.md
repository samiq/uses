# Server

Create an Ubuntu droplet in Digital Ocean, set it up with SSH keys on creation and include the setup script on creation by copying it on user data or by running the command below after it's been created.

```
ssh root@<server ip> "bash -s" -- < setup.sh
```

This script will secure the droplet and set a user with admin permissions to use instead of the root user.

### Update Package Manager

Before doing anything else, ssh to the server and update its package manager.

```
sudo apt-get update
```

### Install Zsh

```
sudo apt-get install zsh
chsh -s $(which zsh)
```

### Install `Oh My ZSH`

```
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

#### Setup Git

```
git config --global user.name "My Name"
git config --global user.email "my@email.com"
```

#### Clone the `uses` repository

```
git clone https://github.com/samiq/uses.git
```

#### Setup the theme

Depending on the client that we use to access the server we can get a nicer experience thru the oh my zsh themes, next step is the steps to setup our own.

- Copy [`cobalt2.zsh-theme`](../themes/cobalt2/cobalt2.zsh-theme) to `~/.oh-my-zsh/custom/themes/`
- Open `~/.zshrc` with `nano ~/.zshrc` to set theme

```
ZSH_THEME=cobalt2
```
