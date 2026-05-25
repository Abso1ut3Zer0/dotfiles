# fzf — fuzzy finder

## Shell key bindings (zsh integration)
```
CTRL-T   pick files/dirs, paste their paths onto the command line
CTRL-R   fuzzy-search command history
ALT-C    fuzzy-pick a directory and cd into it
```
Enabled via `source <(fzf --zsh)` in ~/.zshrc.

## Fuzzy completion trigger — `**<TAB>`
```sh
vim **<TAB>        # pick files
cd **<TAB>         # pick directories
kill -9 **<TAB>    # pick a process
ssh **<TAB>        # pick a host (from known_hosts)
export **<TAB>     # pick an env var
```

## Inside the picker
```
type            filter as you go
Enter           accept
ESC / C-c       cancel
TAB / S-TAB     select / deselect   (when --multi)
C-j / C-n       down        C-k / C-p   up
S-Up / S-Down   scroll the preview pane
```

## Query syntax (extended search)
Space between terms = AND. They compose:
```
foo bar         matches BOTH foo and bar (each fuzzy)
'foo            exact substring (not fuzzy)
^foo            prefix match
foo$            suffix match
!foo            inverse — does NOT match foo
!^foo           does not start with foo
.log$ | .txt$   OR (pipe between terms)
```

## Pipe anything into fzf
```sh
ls | fzf                          # pick one line
cmd | fzf -m                      # --multi: TAB-select several
fzf -q 'init'                     # start with a query prefilled
fzf --height 40% --reverse        # inline, top-down
git branch | fzf | xargs git switch              # pick a branch, switch to it
kill -9 "$(ps -ef | fzf | awk '{print $2}')"     # pick a process to kill
fd . | fzf --preview 'bat --color=always {}'     # picker with a file preview
```

## Env vars
```sh
FZF_DEFAULT_COMMAND   # command that populates the list (e.g. 'fd --type f')
FZF_DEFAULT_OPTS      # options applied to every fzf invocation
FZF_CTRL_T_OPTS       # options for the CTRL-T binding (the preview lives here)
FZF_CTRL_R_OPTS       # options for CTRL-R
FZF_ALT_C_OPTS        # options for ALT-C
```
Example:  `export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"`
