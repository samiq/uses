# Visual Studio Code + Plugins

- Install [Visual Studio Code](https://code.visualstudio.com/)
- Install [Fonts](fonts.md)

## Packages

Following are the packages and plugins I'm currently using

- [Cobalt2 Theme Official](https://marketplace.visualstudio.com/items?itemName=wesbos.theme-cobalt2) by Wes Bos
- [ESList](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint) by Dirk Baeumer
- [Prettier](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode) by Esben Petersen
- [Shell Launcher](https://marketplace.visualstudio.com/items?itemName=Tyriar.shell-launcher) by Daniel Imms
- [Sort lines](https://marketplace.visualstudio.com/items?itemName=Tyriar.sort-lines) by Daniel Imms
- [Version Lens](https://marketplace.visualstudio.com/items?itemName=pflannery.vscode-versionlens) by pflannery
- [VSCode Icons](https://marketplace.visualstudio.com/items?itemName=robertohuertasm.vscode-icons) by Roberto Hertas

## Settings

My current editor settings are

```javascript
"editor.fontFamily": "Operator Mono, Menlo, Monaco, 'Courier New', monospace",
"editor.fontSize": 14,
"editor.lineHeight": 20,
"editor.letterSpacing": 0.5,
"editor.cursorStyle": "line",
"editor.cursorWidth": 5,
"editor.cursorBlinking": "solid",
"editor.fontWeight": "400",
"editor.formatOnSave": true,
"editor.rulers": [100, 120],
"files.trimTrailingWhitespace": true,
"prettier.eslintIntegration": true,
"terminal.integrated.shell.windows": "C:\\Windows\\System32\\wsl.exe",
"terminal.integrated.fontFamily": "Menlo for Powerline Regular",
"workbench.colorTheme": "Cobalt2",
"workbench.iconTheme": "vscode-icons",
"workbench.startupEditor": "newUntitledFile",
"shellLauncher.shells.windows": [
{
    "shell": "C:\\Windows\\System32\\cmd.exe",
    "label": "cmd"
},
{
    "shell": "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe",
    "label": "PowerShell"
},
{
    "shell": "C:\\Windows\\System32\\wsl.exe",
    "label": "WSL Bash"
}
]
```

## Key Bindings

#### Shell Launcher

In order to easily switch between terminal shells (cmd, powershell and wsl) with key combination add via `Preferences -> KEybpoard Shurtcuts -> keybingins.json`

```
  {
    "key": "ctrl+shift+t",
    "command": "shellLauncher.launch"
  }
```
