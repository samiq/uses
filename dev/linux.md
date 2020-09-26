# Server

Create an Ubuntu droplet in Digital Ocean, set it up with SSH keys on creation and include the setup script on creation by copying it on user data or by running the command below after it's been created.

```bash
ssh root@<server ip> "bash -s" -- < setup.sh
```

This script will secure the droplet and set a user with admin permissions to use instead of the root user.

## Update Package Manager

Before doing anything else, ssh to the server and update its package manager.

```bash
sudo apt-get update
sudo apt-get upgrade
```

## Setup Git

```bash
git config --global user.name "My Name"
git config --global user.email "my@email.com"
```
