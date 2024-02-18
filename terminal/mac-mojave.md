## How to install openssl@3 on Mojave

`openssl@3` fails to install using Homebrew on MacOS 10.14 (Mojave) because it fails pass the tests, in order to allow it install we need to edit the formulae and install it with a slight change, this was taken from [here](https://github.com/openssl/openssl/issues/22467#issuecomment-1870367428).

```bash
brew tap --force homebrew/core
```

then, we need to edit `openssl@3`

```bash
brew edit openssl@3
```

look for `system "make", "test"` and change for `system "make", "test TESTS='-test-cmp_http'"`

run 

```bash
brew install --build-from-source --formula /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/o/openssl@3.rb
```

### How to install NodeJS on Mojave

`nodejs` will fail to install through Homebrew but it will install from `nvm` without problem.

```bash
brew install nvm
```