# Visual Studio Code + Plugins

- Install [Visual Studio Code](https://code.visualstudio.com/)
- Install the [Fonts](fonts.md)
- Setup the Terminal ([Mac](mac/terminal.md), [Windows](windows/terminal.md))

## Packages

Following are the packages and plugins I'm currently using

### Productivity

- [Cobalt2 Theme Official](https://marketplace.visualstudio.com/items?itemName=wesbos.theme-cobalt2) by Wes Bos
- [ESLint](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint) by Dirk Baeumer
- [Excel Viewer](https://marketplace.visualstudio.com/items?itemName=GrapeCity.gc-excelviewer) by Grape City
- [Node Version](https://marketplace.visualstudio.com/items?itemName=fivepointseven.node-version)
- [Prettier](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode) by Esben Petersen
- [Rainbow CSV](https://marketplace.visualstudio.com/items?itemName=mechatroner.rainbow-csv) by Mechatroner
- [TypeScript Import](https://marketplace.visualstudio.com/items?itemName=kevinmcgowan.TypeScriptImport) by Kevin McGowan
- [Version Lens](https://marketplace.visualstudio.com/items?itemName=pflannery.vscode-versionlens) by pflannery
- [VSCode Icons](https://marketplace.visualstudio.com/items?itemName=robertohuertasm.vscode-icons) by Roberto Hertas

### Languages

- [C#](https://marketplace.visualstudio.com/items?itemName=ms-vscode.csharp) by Microsoft
- [Dart](https://marketplace.visualstudio.com/items?itemName=dart-code.dart-code) by Dart Code
- [Flutter](https://marketplace.visualstudio.com/items?itemName=dart-code.flutter) by Dart Code
- [Go](https://marketplace.visualstudio.com/items?itemName=ms-vscode.Go) by Microsoft
- [Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python)

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
"git.enableSmartCommit": true,
"prettier.eslintIntegration": true,
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
],
"terminal.integrated.shell.windows": "C:\\Windows\\System32\\wsl.exe",
"terminal.integrated.shell.osx": "zsh",
"terminal.integrated.fontFamily": "Menlo for Powerline",
"workbench.colorTheme": "Cobalt2",
"workbench.iconTheme": "vscode-icons",
"workbench.startupEditor": "newUntitledFile",
```

## Key Bindings

#### Shell Launcher

In order to easily switch between terminal shells (cmd, powershell and wsl) with key combination add via `Preferences -> Keyboard Shurtcuts -> keybindings.json`

```javascript
  {
    "key": "ctrl+shift+t",
    "command": "shellLauncher.launch"
  }
```
