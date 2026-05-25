# pipe glue — cut · sort · uniq · tr · paste

The small tools that join the big ones in a pipeline.

## cut — columns
```sh
cut -d',' -f2 f             # 2nd CSV field
cut -d',' -f1,3 f           # fields 1 and 3
cut -d',' -f2- f            # field 2 to end
cut -c1-8 f                 # characters 1–8
```

## sort
```sh
sort f                      # lexical
sort -n f                   # numeric
sort -rn f                  # numeric, descending
sort -u f                   # sort + dedup
sort -k2 f                  # by 2nd field
sort -t',' -k3 -n f         # CSV, numeric on field 3
sort -h f                   # human sizes (2K, 3M, 1G)
```

## uniq — needs SORTED input
```sh
sort f | uniq               # dedup adjacent lines
sort f | uniq -c            # prefix each with its count
sort f | uniq -c | sort -rn # frequency, most common first   ← the idiom
sort f | uniq -d            # only show duplicated lines
```

## tr — translate / delete chars
```sh
tr 'a-z' 'A-Z'              # upcase
tr -d ' '                   # delete spaces
tr -s ' '                   # squeeze repeats down to one
tr ',' '\n'                 # commas → newlines
tr -cd '[:print:]'          # keep only printable chars
```

## paste / column
```sh
paste -d',' a b             # join two files side-by-side, comma-sep
paste -sd',' f              # join all lines into one, comma-sep
column -t -s',' f           # align columns into a readable table
```

Top-N most frequent, the classic combo:
```sh
... | sort | uniq -c | sort -rn | head
```
