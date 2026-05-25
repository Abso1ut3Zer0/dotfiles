# grep / ripgrep (rg)

`rg` is the daily driver: fast, recursive by default, respects `.gitignore`.
Reach for `grep` for portability or when `rg` isn't installed.

## ripgrep
```sh
rg foo                      # recursive from cwd; skips .gitignore + hidden
rg -i foo                   # case-insensitive
rg -w foo                   # whole word
rg -F 'a.b.c'               # fixed string (no regex)
rg foo -g '*.rs'            # only .rs files
rg foo -g '!target/'        # exclude a glob
rg -t rust foo              # by file type (rg --type-list to see all)
rg -l foo                   # list filenames with matches only
rg -c foo                   # count matches per file
rg -v foo                   # invert: lines NOT matching
rg -A3 -B2 foo              # 3 lines after, 2 before  (-C3 = both)
rg -o 'id=\d+'              # print only the matched part
rg --hidden --no-ignore foo # include hidden + gitignored files
rg foo -r bar               # preview replacement (does NOT write the file)
rg --json foo               # structured output for tooling
```

## grep (POSIX-ish)
```sh
grep -rn foo .              # recursive, with line numbers
grep -ri foo .              # case-insensitive
grep -E 'a|b' f             # extended regex (alternation, +, ?)
grep -F 'literal' f         # fixed string
grep -P '\d+' f             # Perl regex (GNU only)
grep -o 'pat' f             # only the matched part
grep -c foo f               # count matching lines
grep -v foo f               # invert
grep -A3 -B2 -C3 foo f      # context lines
grep -l foo *               # files with matches
```

Chain include/exclude:  `rg foo | rg -v bar`
