# Terminal

Follow the next steps to setup the necessary shells in your PC

## Chocolatey

The package manager for Windows

- Install `Chocolatey` via `Windows Terminal`

```bash
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
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
