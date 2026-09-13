# App setup

## Basics

once `homebrew` has been installed, run `.\setup.sh` from the scripts folder.

chose the apps you want to install and let the script do the rest.

after nvm has been installed, make sure to add the right setup on `.zprofile`.

```shell
# nano .zprofile
# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
```

## Apps not available from the Appstore are

- [Vanilla](https://matthewpalmer.net/vanilla/): to hide menu bar icons on your Mac.
- [Reverse Scroller](https://pilotmoon.com/scrollreverser/): to independently reverse mouse scrolling while keep natural scrolling on the trackpad (great for when you have non-magic mouse pointers).
