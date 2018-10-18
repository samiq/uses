# Development Packages

Below is my current development stack setup on Mac

## Install NVM + Node

Install the Pre-requisitions to NVM

```
sudo apt-get install build-essential libssl-dev
```

Install NVM (check [here](https://github.com/creationix/nvm#install-script) for latest version of script)

```
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
source .bashrc
```

Add NVM scripts to .zshrc via `nano ~/.zshrc` adding the following code at the end of the script.

```
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
```

and remember to activate via

```
source ~/.zshrc
```

Install NPM 8

```
nvm install 8
nvm install-latest-npm
```

---

### Firebase

The Firebase CLI provides a variety of tools for managing, viewing, and deploying to Firebase projects.

```
npm install -g firebase-tools
firebase login
```

Firebase will print a url that you will have to execute on a browser, once authenticated the browser will redirect to `localhost` url, to finish the authentication process, launche a separate session into the server and execute

```
curl http://localhost:9005/....
```

to switch between projects

```
firebase use <project-name>
```
