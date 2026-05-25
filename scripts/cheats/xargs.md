# xargs — build commands from stdin

Turns lines of input into arguments for a command.

```sh
... | xargs cmd             # append args to cmd
... | xargs -n1 cmd         # one arg per invocation
... | xargs -I{} cmd {} x   # placeholder {} for precise positioning
... | xargs -P8 -n1 cmd     # 8 parallel jobs
... | xargs -r cmd          # skip running if input is empty (GNU)
... | xargs -t cmd          # echo each command before running it
echo a b c | xargs -n1      # split a line into separate lines
```

## NUL-safe (handles spaces/newlines in names)
```sh
find . -name '*.log' -print0 | xargs -0 rm
fd -e log -X rm             # fd's built-in batch exec, also safe
```

## Patterns
```sh
git diff --name-only | xargs -I{} cp {} /backup/   # copy changed files
fd -e rs | xargs wc -l                              # line counts
cat urls.txt | xargs -P4 -n1 curl -O                # parallel download
```

Rule of thumb: prefer `-print0 | xargs -0` (or `fd -X`) so weird filenames
don't break the pipeline.
