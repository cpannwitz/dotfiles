# Dotfiles v2

## Setup on new machine

### Manual Setup

1. Copy/Paste SSH keys from known location to `~/.ssh`
2. Copy/Paste kube keys from known location to `~/.kube`

### Automated chezmoi Setup

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply cpannwitz
```

This single command:

1. Downloads and installs chezmoi
2. Clones `github.com/cpannwitz/dotfiles` to `~/.local/share/chezmoi`
3. Runs `run_once_before_10-install-macos.sh.tmpl` — setup XCode, sets macOS default settings
4. Runs `run_once_before_10-install-homebrew.sh.tmpl` — installs Homebrew if absent
5. Runs `run_once_before_20-install-packages.sh.tmpl` — runs `brew bundle` from `Brewfile`, then installs oh-my-zsh and its plugins
6. Prompts for configuration values
7. Applies all dotfiles to their target locations

### Answer the Setup Prompts

chezmoi will ask questions on first apply:

| Prompt                   | Description                                                      | Stored as          |
| ------------------------ | ---------------------------------------------------------------- | ------------------ |
| `Email address`          | Your git/personal email                                          | `data.email`       |
| `Full name`              | Your full name                                                   | `data.name`        |
| `Username`               | Github username                                                  | `data.username`    |
| `Is OrbStack installed?` | Enables OrbStack shell integration in `~/.zprofile` (macOS only) | `data.hasOrbStack` |

Answers are saved to `~/.config/chezmoi/chezmoi.toml` and will not be asked again.

## Daily Operations

### Edit a Tracked File

```bash
# Opens the source file in $EDITOR and applies on save
chezmoi edit ~/.zshrc

# Edit and immediately apply
chezmoi edit --apply ~/.zshrc
```

### Apply Changes

```bash
# Apply all pending changes
chezmoi apply

# Preview what would change (dry run)
chezmoi diff

# Apply a single file
chezmoi apply ~/.zshrc
```

### Check Status

```bash
# Show which files differ between source and target
chezmoi status
```

### Commit Changes

```bash
# Navigate to the source repo
cd ~/.local/share/chezmoi

# Commit all changes
git add -A && git commit -m "chore: update aliases"
git push
```

Or use the shortcut alias:

```bash
cm cd   # chezmoi cd — jumps to source directory
```

### Pull Changes on Another Machine

```bash
# Pull and apply latest changes from GitHub
chezmoi update
```

### Re-Run a Bootstrap Script

Bootstrap scripts run only once (tracked by content hash). To force re-run:

```bash
# Reset the run-once state for all scripts
chezmoi state delete-bucket --bucket=scriptState
```

Or edit the script slightly (e.g., add a comment) to change its hash.

## Credits

Inspired by https://github.com/boranuzun/dotfiles
