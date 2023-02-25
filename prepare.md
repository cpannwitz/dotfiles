# Optional: Prepare the System Integrity Protection
1. Restart MacOS, immediately press `CMD + R`
2. In Terminal, write: `csrutil disable`
3. Restart

# Do Softwareupdates
Via Systemsettings

# Install XCode
`xcode-select --install`

# Accept XCode License
`sudo xcodebuild -license`

# Add SSH keys
`ssh-add --apple-use-keychain ~/.ssh/PRIVATE_KEY`

# Fix Quicklook Plugins
`xattr -d -r com.apple.quarantine ~/Library/QuickLook`

# Prepare .gitconfig
Customising Git
Customise your Git config by creating a ~/.gitconfig.local file which will extend .gitconfig. Use this to store private details such as your user credentials and signing key.

Example ~/.gitconfig.local file:
```
[user]
  name = "Firstname Lastname"
	username = "username"
  email = "your@emailaddress.com"
[github]
  user = your-github-username
[credential]
  helper = osxkeychain
[includeIf "gitdir:~/workspace/"]
    path = ~/workspace/.gitconfig
```

Include another .gitconfig in ~/workspace, to override with work credentials, if necessary (same content as above)