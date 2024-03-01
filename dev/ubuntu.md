### Git

Git is already installed in Ubuntu, but if you want to use the credentials already setup in Windows, then follow the steps in the link below

https://learn.microsoft.com/en-us/windows/wsl/tutorials/wsl-git

### Ruby on Rails

#### Install Ruby

Follow the install instructions to install `rbenv` [here](https://github.com/rbenv/rbenv#basic-git-checkout)

```bash
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
```

then

```bash
echo 'eval "$(~/.rbenv/bin/rbenv init - bash)"' >> ~/.bashrc
```

then install the [dependencies](https://github.com/rbenv/ruby-build/wiki#suggested-build-environment) for Ruby

```bash
sudo apt-get install autoconf patch build-essential rustc libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev
```

then install rbenv-build

```bash
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
```

then check out versions available of Ruby to install

```bash
rbenv install -l
```

and chose one to install, and set it as global

```bash
rbenv install 3.2.2
```

```bash
rbenv global 3.2.2
```
```bash
rbenv init
```

```bash
echo 'eval "$(rbenv init - bash)"' >> ~/.bashrc
```

#### Install Rails

```bash
gem install rails
```
