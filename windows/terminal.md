# Terminal

Follow the next steps to setup the necessary shells in your PC

## Chocolatey

The package manager for Windows

- Install `Chocolatey` via `cmd`

```bash
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
```

- To list locally installed packages you can run

```bash
choco list --local-only
```

## Oh My Posh and Posh Git

```bash
Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
```

### Install Cascadia Fonts

```bash
choco install cascadiafonts
```

Edit the settings on the Terminal app and include under Powershell profile

```json
"fontFace": "Cascadia Code PL"
```
