# Textastic

Textastic is a text, code, and markup editor for iPad and iPhone

### SSH Setup

- Import the Private key from iCloud into Textastic via a local folder by creating an `ssh` folder inside `Local Files` and copying the `id_rsa` file to it.
- Tab on the `SSH Connections` menu, hit `+`
- Enter a `Name` for the connection, the `Host` ip and the `Username` associated to the key.
- Swipe `Public Key Auth.` to Yes and enter the location for where you moved the private key in the `Local Files`, i.e. `/ssh/id_rsa`.
- Tab `Done` and you should be set. 
- A terminal window should open, connecting you to the server.
