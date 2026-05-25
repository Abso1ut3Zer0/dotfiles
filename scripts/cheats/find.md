# find / fd

`fd` is fast and ergonomic (regex by default, respects `.gitignore`).
`find` is everywhere and more powerful for actions.

## fd
```sh
fd foo                      # name contains 'foo'; skips ignored + hidden
fd -e rs                    # by extension
fd -t f / -t d              # type: file / directory
fd -H foo                   # include hidden
fd -I foo                   # don't respect .gitignore
fd foo -x cmd {}            # exec cmd per result   ({} = path)
fd -e log -X rm             # batch exec ONCE with all results
fd --changed-within 1d      # modified in the last day
```

## find
```sh
find . -name '*.rs'         # by name (glob — quote it)
find . -iname '*.RS'        # case-insensitive
find . -type f              # files only   (-type d = dirs)
find . -maxdepth 2          # limit recursion depth
find . -mtime -1            # modified < 1 day ago   (-mmin -60 = <60 min)
find . -size +100M          # larger than 100 MB
find . -empty               # empty files / dirs
find . -name '*.tmp' -delete            # delete matches
find . -type f -exec grep -l foo {} +   # run cmd; + batches args (fast)
find . -type f -print0 | xargs -0 cmd   # NUL-safe handoff to xargs
find . -path './target' -prune -o -print # skip a subtree
```

`-exec ... {} +` batches into few calls (fast); `{} \;` runs once per file (slow).
