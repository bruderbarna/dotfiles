# Mac Migration Guide

## 1. First boot

- Sign in with Apple ID
- Enable FileVault (System Settings → Privacy & Security → FileVault)
- System Settings → General → Software Update → install everything
- System Settings → Trackpad → increase tracking speed, enable tap-to-click if wanted

---

## 2. Xcode CLI tools

Required before Homebrew and git work.

```sh
xcode-select --install
```

---

## 3. SSH key

Do this before cloning dotfiles.

```sh
ssh-keygen -t ed25519 -C "bruder.barna@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub   # add to GitHub, any other services
```

---

## 4. Clone dotfiles

```sh
git clone git@github.com:bruderbarna/dotfiles.git ~/dotfiles
```

---

## 5. Homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Homebrew installs to `/opt/homebrew` on Apple Silicon. After install, follow the printed instructions to add it to your PATH (or just open a new shell — `.zshrc` handles it via `brew shellenv`).

Then install everything from the Brewfile:

```sh
brew bundle --file=~/dotfiles/Brewfile
```

This takes a while. Some casks (JetBrains Toolbox, Docker) will prompt for system permissions — allow them.

---

## 6. Dotfiles symlinks

Run these from a new shell after Homebrew is set up (so `~/.local/bin` etc. exist):

```sh
# Shell
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.bash_profile ~/.bash_profile
ln -sf ~/dotfiles/.bashrc ~/.bashrc
ln -sf ~/dotfiles/.zsh_plugins.txt ~/.zsh_plugins.txt

# Git
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
mkdir -p ~/.config/git
ln -sf ~/dotfiles/.config/git/ignore ~/.config/git/ignore

# Tmux
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.gitmux.conf ~/.gitmux.conf

# Ghostty
mkdir -p ~/.config/ghostty/themes
ln -sf ~/dotfiles/.config/ghostty/config.ghostty ~/.config/ghostty/config.ghostty
ln -sf ~/dotfiles/.config/ghostty/themes/catppuccin-frappe.conf ~/.config/ghostty/themes/catppuccin-frappe.conf

# Neovim
mkdir -p ~/.config
ln -sf ~/dotfiles/.config/nvim ~/.config/nvim
```

`.xbindkeysrc` and `.Xresources` are Linux/X11 only — skip on Mac.

---

## 7. zsh plugins (antidote)

`brew bundle` installs antidote on macOS. On Arch Linux, install it from AUR:

```sh
yay -S zsh-antidote
```

The `.zsh_plugins.txt` symlink (done in step 6) is all that's needed — antidote loads and caches plugins automatically on first shell start. Installed plugins:

- **zsh-autosuggestions** — fish-style inline suggestions from history
- **zsh-syntax-highlighting** — command highlighting as you type
- **woefe/git-prompt.zsh** — git-aware prompt (zsh port of bash-git-prompt), styled like Single_line_Minimalist

To update all plugins later:

```sh
antidote update
```

---

## 8. Node (fnm)

fnm is installed via Brew. Set up node 22 and reinstall globals:

```sh
fnm install 22
fnm default 22

npm install -g \
  @aws-amplify/cli \
  @openai/codex \
  @react-native-community/cli \
  @typescript/native-preview \
  autocannon \
  diff-so-fancy \
  esbuild \
  fastify-cli \
  instant-markdown-d \
  ls \
  node-addon-api \
  nx \
  pino-pretty \
  pnpm \
  prettier \
  react-native-cli \
  serverless \
  sharp \
  tsup \
  turbo \
  typescript \
  vite
```

fnm respects `.nvmrc` and `.node-version` files automatically via `--use-on-cd` (already set in `.zshrc`).

---

## 9. Rust

```sh
rustup-init
```

Follow prompts, then open a new shell. Cargo is at `~/.cargo/bin` (sourced by `.zshrc` via `~/.cargo/env`).

---

## 10. tmux plugins

First, bootstrap TPM itself:

```sh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Then launch tmux and install all plugins:

```
prefix + I       (Ctrl-a + I)
```

TPM will clone everything: catppuccin, tmux-cpu, tmux-battery, tmux-mem-cpu-load, vim-tmux-navigator.

The clipboard binding in `.tmux.conf` detects the OS automatically — `pbcopy` on Mac, `~/bin/tmux-xclip` on Linux. Nothing to change.

---

## 11. Neovim

Launch `nvim` — lazy.nvim will auto-bootstrap and install all plugins on first run. Tree-sitter parsers and LSP servers install themselves on first open of relevant files.

---

## 12. Cloud / infra credentials

These dirs transfer as-is — just copy them over from the old machine or re-auth:

```sh
# AWS
cp -r ~/.aws ~/              # or: aws configure

# Azure
az login

# kubectl
cp ~/.kube/config ~/.kube/   # or re-auth with your cluster

# Fly.io
fly auth login

# Serverless
serverless login

# Terraform versions (managed by tfswitch — do NOT install terraform via brew)
cp -r ~/.terraform.versions ~/
cp -r ~/.terraform.d ~/
```

After copying, configure tfswitch to symlink into `~/bin` (avoids needing sudo for `/usr/local/bin`):

```sh
cat > ~/.tfswitch.toml <<'EOF'
bin = "/Users/$USER/bin/terraform"
EOF
```

Then switch to the version you need:

```sh
tfswitch          # interactive picker
# or
tfswitch 1.9.8   # specific version
```

---

## 13. Secrets file

Create `~/.secrets` and populate it. `.zshrc` sources it automatically. Minimum:

```sh
export OPENAI_API_KEY=...
# any other API keys / tokens
```

---

## 14. YouTube Music desktop app

No brew cask exists for th-ch/youtube-music. Install manually:

1. Go to https://github.com/th-ch/youtube-music/releases/latest
2. Download the `.dmg` for Apple Silicon (`arm64`) or Intel (`x64`)
3. Open the `.dmg` and drag to `/Applications`

This is the actively maintained app (not to be confused with deprecated forks). It supports plugins, ad blocking, last.fm scrobbling, and Discord rich presence.

---

## 15. Apps to sign into manually

- **1Password** — sign in first, then it fills credentials for everything else
- **Chrome** — sign in to sync bookmarks, extensions, passwords
- **IntelliJ IDEA** — sign in with your JetBrains account on first launch; Settings Sync restores IDE config automatically
- **Docker Desktop** — sign in (optional, not required to run containers)

---

## 16. macOS system settings worth changing

```
System Settings → Keyboard → Key repeat rate → Fast
System Settings → Keyboard → Delay until repeat → Short
System Settings → Dock → Automatically hide and show the Dock → on
System Settings → Accessibility → Pointer Control → Trackpad Options → Use trackpad for dragging → Three Finger Drag
System Settings → Mission Control → Automatically rearrange Spaces → off
```

Disable press-and-hold for accent popups (interferes with vim key repeat):

```sh
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
```

---

## 17. Hungarian keyboard layout

### Adding the layout

System Settings → Keyboard → Input Sources → click `+` → search **Hungarian** → add **Hungarian**.

This gives you a QWERTZ layout. The accented vowels (á, é, í, ó, ö, ő, ú, ü, ű) are in exactly the same positions as the Windows/Linux HU layout. Switch between layouts with `Cmd+Space` or `Ctrl+Space` (configurable in System Settings → Keyboard → Shortcuts → Input Sources).

### What matches Windows/Linux

All accented letters are in the same physical key positions:

- `Á` = right of `P` row → same as Windows HU
- `É`, `Á`, `Í`, `Ó`, `Ö`, `Ő`, `Ú`, `Ü`, `Ű` — same row positions

### What differs from Windows/Linux

Symbols that used `AltGr` on Windows use `Option` on Mac, but the combinations are different. The most common ones:

| Character | Windows HU (AltGr+) | Mac HU (Option+) |
| --------- | ------------------- | ---------------- |
| `@`       | `V`                 | `V` (same)       |
| `\|`      | `W`                 | `W` (same)       |
| `\`       | `Q`                 | `Q` (same)       |
| `[`       | `F`                 | `F` (same)       |
| `]`       | `G`                 | `G` (same)       |
| `{`       | `B`                 | `B` (same)       |
| `}`       | `N`                 | `N` (same)       |
| `<`       | `Í` key             | differs          |
| `>`       | `Í` key + Shift     | differs          |

In practice the Mac Hungarian layout is close enough that `@`, `\`, `|`, `{`, `}`, `[`, `]` are where you expect them. The main muscle-memory break is `<` and `>` — on Mac HU these are `Option+,` and `Option+.`.

### If the layout doesn't feel right

Install **Ukelele** (free) to inspect or create a custom layout:

```sh
brew install --cask ukelele
```

Ukelele lets you take the macOS Hungarian layout as a base and remap any key to exactly match Windows behavior. The resulting `.bundle` file goes in `~/Library/Keyboard Layouts/` and appears in Input Sources after a logout.

---

## 18. What's not in this repo (restore manually)

- `~/.ssh/` — private keys, don't commit, copy securely or generate new ones
- `~/.aws/`, `~/.azure/`, `~/.kube/` — credentials
- `~/.npmrc` — contains FontAwesome auth token
- `~/.secrets` — API keys
- `~/bin/` scripts that are X11-specific (`cycle-audio-output`, `move-to-next-monitor`, `screentogimp`, etc.) — no equivalent needed on Mac; use macOS Shortcuts or skhd instead
- VPN configs (`*.ovpn`) — import into Tunnelblick or native WireGuard app

---

## 19. Optional extras (do if you want them)

### 1Password SSH agent
Store SSH keys in 1Password and have it act as your SSH agent — no key files on disk.
1. 1Password → Settings → Developer → enable **Use the SSH Agent**
2. Create `~/.ssh/config` with:
```
Host *
    IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
```

### Git commit signing via 1Password
Sign commits with your SSH key stored in 1Password instead of GPG:
```sh
git config --global gpg.format ssh
git config --global user.signingkey "key::ssh-ed25519 AAAA..."   # paste your pub key
git config --global commit.gpgsign true
```
The 1Password SSH agent handles signing automatically.

### Azure DevOps git credential
The credential helper in `.gitconfig` has a stale PAT. On Mac, replace it with the macOS keychain helper and re-authenticate:
```sh
git config --global credential.helper osxkeychain
```
Then remove the `[credential "https://msface.visualstudio.com"]` block from `~/.gitconfig` (or generate a new PAT and update it).

### Finder defaults
```sh
defaults write com.apple.finder AppleShowAllFiles YES             # show hidden files
defaults write com.apple.finder ShowPathbar -bool true            # path bar at bottom
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
killall Finder
```

### Raycast (Spotlight replacement)
Much better launcher with clipboard history, window snapping, snippets, and extensible plugins.
```sh
brew install --cask raycast
```

### Karabiner-Elements (advanced key remapping)
The xbindkeys equivalent on Mac. Useful if you want to remap keys beyond what the HU layout provides.
```sh
brew install --cask karabiner-elements
```
