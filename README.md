# Dotfiles

Cross-platform dotfiles managed with Ansible. Works on Arch Linux and macOS.

## Quick Start

```bash
git clone https://github.com/Abso1ut3Zer0/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./bootstrap.sh
```

The bootstrap script will:
- Install Ansible if not present
- Prompt for git name and email
- Ask for sudo password (package installs)
- Install all packages, fonts, and tools
- Symlink configs into place

## What's Included

| Tool | Config Location | Description |
|------|----------------|-------------|
| Neovim | `config/nvim/` | lazy.nvim, LSP, treesitter, telescope, kanagawa dragon |
| Ghostty | `config/ghostty/config` | Kanagawa colors, FiraCode, background image |
| Alacritty | `config/alacritty/` | Kanagawa dragon theme, FiraCode |
| tmux | `home/tmux.conf` | Ctrl+a prefix, vim-style pane nav, splits |
| Zsh | `home/zshrc` | oh-my-zsh, af-magic theme |
| Scripts | `scripts/` | tmux-sessionizer (fzf project switcher) |

## Packages Installed

**Both platforms:** neovim, tmux, ghostty, alacritty, fzf, ripgrep, git, zsh

**Also installs:** FiraCode Nerd Font, oh-my-zsh, Rust/cargo

## Keybinds Cheat Sheet

### tmux (prefix: Ctrl+a)

| Keybind | Action |
|---------|--------|
| `\|` | Vertical split |
| `-` | Horizontal split |
| `h/j/k/l` | Navigate panes |
| `H/L` | Switch sessions (prev/next) |
| `Arrow keys` | Resize panes |
| `z` | Zoom/unzoom pane |
| `r` | Reload config |
| `Ctrl+f` | tmux-sessionizer (fzf project picker) |

### Neovim (leader: Space)

**Navigation:**

| Keybind | Action |
|---------|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | File browser |
| `<leader>fr` | Recent files |
| `<leader>fc` | Fuzzy find in buffer |
| `<leader>a` | Harpoon add file |
| `Ctrl+e` | Harpoon quick menu |
| `Ctrl+r / Ctrl+t` | Harpoon prev/next |
| `<leader>pv` | File explorer (netrw) |

**LSP:**

| Keybind | Action |
|---------|--------|
| `K` | Hover |
| `<leader>gd` | Go to definition |
| `<leader>gD` | Go to declaration |
| `<leader>gi` | Go to implementation |
| `<leader>go` | Go to type definition |
| `<leader>gr` | References (telescope) |
| `<leader>gs` | Signature help |
| `<leader>rn` | Rename |
| `<leader>ca` | Code action |
| `<leader>fm` | Format |
| `<leader>e` | Diagnostics float |
| `[d / ]d` | Prev/next diagnostic |

**Git:**

| Keybind | Action |
|---------|--------|
| `<leader>ng` | Neogit status |
| `<leader>nc` | Neogit commit |
| `<leader>nb` | Neogit branch |
| `<leader>nl` | Neogit log |
| `<leader>np` | Neogit pull |
| `<leader>nP` | Neogit push |
| `<leader>do` | Diffview open |
| `<leader>dc` | Diffview close |
| `<leader>df` | File history (current) |
| `<leader>dh` | File history (all) |
| `<leader>gc` | Git commits (telescope) |
| `<leader>gb` | Git branches (telescope) |
| `<leader>ts` | Git worktrees |
| `<leader>tn` | Create worktree |

**Editing:**

| Keybind | Action |
|---------|--------|
| `<leader>u` | Undotree |
| `<leader>y` | Yank to clipboard |
| `<leader>d` | Delete to void register |
| `<leader>p` | Paste without losing register |
| `<leader>vs` | Vertical split |
| `<leader>rp` | Send region to tmux (visual) |

## How Configs Are Managed

All configs are **symlinked** from this repo into their expected locations. Editing `~/.tmux.conf` edits the file in this repo directly. Just commit and push to sync across machines.

## Adding a New Machine

1. Set up SSH keys (needed for private repos, not this one)
2. Clone and bootstrap:
   ```bash
   git clone https://github.com/Abso1ut3Zer0/dotfiles.git ~/dotfiles
   cd ~/dotfiles && ./bootstrap.sh
   ```
3. Open Neovim — lazy.nvim bootstraps plugins on first launch
4. Restart your shell

## Updating

Pull changes and re-run:
```bash
cd ~/dotfiles && git pull && ./bootstrap.sh
```

Ansible is idempotent — it only changes what's needed.
