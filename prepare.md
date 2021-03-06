# Prepare the System Integrity Protection
1. Restart MacOS, immediately press `CMD + R`
2. In Terminal, write: `csrutil disable`
3. Restart

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
```

# Prepare MacOS Defaults
Set computer name (as done via System Preferences → Sharing)
```
sudo scutil --set ComputerName "EXAMPLENAME"
sudo scutil --set HostName "EXAMPLENAME"
sudo scutil --set LocalHostName "EXAMPLENAME"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "EXAMPLENAME"
```