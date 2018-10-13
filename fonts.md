# Fonts

Below are the fonts I currently referenced in my documents and dev enviroment.

### For Development, Terminals and others

- [Operator Mono](https://www.typography.com/fonts/operator/overview/)
- [Inconsolata for Powerline](https://github.com/powerline/fonts/tree/master/Inconsolata)

#### Windows Only
To get the font showing in the console Properties you need to add it first to the Registry with `regedit`

```
Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Console\TrueTypeFont
```

add a new String value with name `000` and the name of the font.

`Inconsolata` unfortunately doens't work in Windows, but [Menlo for Powerline](https://github.com/abertsch/Menlo-for-Powerline/raw/master/Menlo%20for%20Powerline.ttf) does.

### For Documents

- [Montserrat](https://fonts.google.com/specimen/Montserrat)
- [Open Sans](https://fonts.google.com/specimen/Open+Sans)