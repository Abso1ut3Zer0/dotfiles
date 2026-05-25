# jq — JSON processor

Filters transform JSON; chain them with `|`. Use `-r` for raw (unquoted)
string output when feeding the shell.

```sh
jq '.'                      # pretty-print / validate
jq '.foo'                   # field
jq '.foo.bar'               # nested
jq '.foo // "default"'      # fallback when null/absent
jq '.[0]'                   # first array element
jq '.[]'                    # iterate array elements
jq '.foo[]'                 # iterate a nested array
jq -r '.name'               # raw string, no quotes (use for shell vars)
```

## Map / filter / project
```sh
jq '.[] | .id'                  # pull one field from each element
jq '.[] | {id, name}'           # project fields into new objects
jq '.[] | select(.age > 30)'    # filter elements
jq 'map(.price) | add'          # sum a field across the array
jq 'length'                     # array / object length
jq 'keys'                       # object keys (sorted)
jq '.items |= map(.x + 1)'      # update a nested array in place
```

## Reshape / output
```sh
jq -r '.[] | [.id, .name] | @csv'        # rows → CSV
jq -r '.[] | "\(.id): \(.name)"'         # string interpolation
jq -r 'to_entries[] | "\(.key)=\(.value)"'  # object → k=v lines
jq -c '.[]'                              # one compact object per line (NDJSON)
jq -s 'add'                              # slurp many inputs, merge into one
```

Common pipeline:  `curl -s url | jq '.data[]'`
Pass a shell value:  `jq --arg t "$TICKER" '.[] | select(.sym == $t)'`
