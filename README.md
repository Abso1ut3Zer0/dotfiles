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
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `go` | Go to type definition |
| `<leader>gr` | References (telescope) |
| `gs` | Signature help |
| `<leader>rn` | Rename |
| `<leader>ca` / `<leader>k` | Code action |
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

**Gitsigns (in-buffer):**

| Keybind | Action |
|---------|--------|
| `]c / [c` | Next/prev hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hu` | Undo stage hunk |
| `<leader>hp` | Preview hunk |
| `<leader>tb` | Toggle inline blame |

**Trouble:**

| Keybind | Action |
|---------|--------|
| `<leader>xx` | Toggle diagnostics panel |
| `<leader>xw` | Buffer diagnostics |
| `<leader>xd` | Document symbols |

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

## Git Workflows in Neovim

### Interactive Rebase

**Using Neogit:**
1. `<leader>nl` to open the log
2. Move cursor to the commit you want to rebase onto
3. Press `r` to open the rebase popup, then `i` for interactive rebase
4. Neogit opens an editor buffer with the rebase todo list — reorder, squash, fixup, drop commits
5. Save and close (`:wq`) to execute the rebase
6. If conflicts arise, Neogit shows them in the status view (`<leader>ng`)

**Using Diffview during rebase conflicts:**
1. Start a rebase (via Neogit or command line)
2. When conflicts occur, run `<leader>do` (`:DiffviewOpen`) — shows all conflicted files with side-by-side diffs
3. Select a file to see a 3-panel view: LOCAL (yours) | REMOTE (theirs) | MERGED (result)
4. Edit the merged file to resolve conflicts
5. Stage resolved files and continue the rebase via `<leader>ng`

### Merge Conflict Resolution

1. `<leader>do` — opens Diffview showing all conflicted files in side-by-side view
2. Navigate between files in the left panel
3. Resolve conflicts in the merged buffer (right side)
4. `:Gwrite` to stage the resolved file
5. `<leader>dc` to close Diffview when done

### Reviewing Diffs

- `<leader>do` — see all uncommitted changes side-by-side
- `<leader>df` — full history of the current file with diffs
- `<leader>dh` — full history of the entire repo
- `:DiffviewOpen main...HEAD` — compare current branch against main
- `:DiffviewOpen HEAD~3` — see last 3 commits as diffs

### PR Review

For reviewing GitHub PRs with side-by-side diffs inside Neovim, consider adding [octo.nvim](https://github.com/pwntester/octo.nvim). It provides:
- `Octo pr list` — browse PRs via telescope
- `Octo review` — enter review mode with side-by-side diffs
- Inline commenting and suggestions on diff hunks
- Submit approve/request changes/comment reviews

Requires `gh` CLI (already installed via ansible). See the [octo.nvim docs](https://github.com/pwntester/octo.nvim) for setup.
