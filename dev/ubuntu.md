### Ruby on Rails

#### Install Ruby

Follow the install instructions to install `rbenv` [here](https://github.com/rbenv/rbenv#basic-git-checkout)

```
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
```

then

```
echo 'eval "$(~/.rbenv/bin/rbenv init - bash)"' >> ~/.bashrc
```

then install the [dependencies](https://github.com/rbenv/ruby-build/wiki#suggested-build-environment) for Ruby

```
sudo apt-get install autoconf patch build-essential rustc libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev
```

then install rbenv-build

```
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
```

then check out versions available of Ruby to install

```
rbenv install -l
```

and chose one to install, and set it as global

```
rbenv install 3.2.2
rbenv global 3.2.2
rbenv init
```

#### Install Rails

```
gem install rails
```
