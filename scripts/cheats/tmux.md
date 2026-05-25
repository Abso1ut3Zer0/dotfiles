# tmux

Prefix is **`C-a`** in this config (remapped from `C-b`).
Below, `<p>` means: press the prefix first, then the key.

## Sessions
```sh
tmux new -s name           # new named session
tmux ls                    # list sessions
tmux a -t name             # attach to one
tmux kill-session -t name
```
```
<p> d        detach
<p> $        rename session
<p> s        session picker
<p> H / L    previous / next session    (this config)
```

## Windows
```
<p> c        new window
<p> ,        rename window
<p> n / p    next / previous window
<p> 1..9     jump to window N    (base-index 1 here)
<p> w        window picker
<p> &        kill window
```

## Panes (this config)
```
<p> |        split horizontal
<p> -        split vertical
<p> h j k l  move between panes (vim-style)
<p> arrows   resize by 5
<p> z        zoom / unzoom a pane
<p> x        kill pane
<p> q        show pane numbers
```

## Copy mode (vi keys)
```
<p> [        enter copy mode
   v         start selection
   y         yank
   / or ?    search forward / back
   q         quit copy mode
<p> ]        paste
```

## Misc
```
<p> r        reload ~/.tmux.conf   (this config)
<p> :        command prompt
```
Mouse is **on** — scroll, select panes, and resize with the mouse.
