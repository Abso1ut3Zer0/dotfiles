# sed — stream editor

Processes input line-by-line. Default: print every line; commands transform it.

```sh
sed 's/foo/bar/' f          # replace FIRST foo on each line
sed 's/foo/bar/g' f         # replace ALL (global)
sed 's/foo/bar/gi' f        # global + case-insensitive
sed -E 's/(a)(b)/\2\1/' f   # extended regex + backreferences (\1 \2)
sed 's#/path#/new#g' f      # use # as delimiter to avoid escaping /
sed 's/foo/bar/3' f         # replace only the 3rd match per line
sed 's/ *$//' f             # strip trailing whitespace
```

## Selecting / deleting lines
```sh
sed -n '5p' f               # print only line 5   (-n suppresses auto-print)
sed -n '5,10p' f            # print lines 5–10
sed -n '/start/,/end/p' f   # print between two patterns
sed '2d' f                  # delete line 2
sed '/^#/d' f               # delete comment lines
sed '/^$/d' f               # delete blank lines
sed '1~2d' f                # delete every other line (GNU)
```

## Insert / append
```sh
sed '3a\text' f             # append 'text' AFTER line 3
sed '3i\text' f             # insert 'text' BEFORE line 3
```

## In-place editing
```sh
sed -i 's/foo/bar/g' f      # GNU: edit file in place
sed -i.bak 's/foo/bar/g' f  # keep a .bak backup
sed -i '' 's/foo/bar/g' f   # BSD/macOS: note the REQUIRED empty '' arg
```

Multiple commands:  `sed -e 's/a/b/' -e 's/c/d/'`  or  `sed 's/a/b/; s/c/d/'`
