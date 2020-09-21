# Prepare XCode Installation
Login to https://developer.apple.com/downloads

Download the "Command Line Tools for Xcode" appropriate for your version of OSX

# Prepare the  System Integrity Protection

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

[commit]

  signingkey = YOUR-SIGNING-KEY-HERE
```

# Prepare MacOS Defaults
Set computer name (as done via System Preferences → Sharing)
```
sudo scutil --set ComputerName "EXAMPLENAME"
sudo scutil --set HostName "EXAMPLENAME"
sudo scutil --set LocalHostName "EXAMPLENAME"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "EXAMPLENAME"
```