# awk — field / record processor

Model: for each line (record), split into fields `$1..$NF` (whitespace by
default). Program is `awk 'PATTERN { ACTION }'` — pattern, action, or both.

```sh
awk '{print $2}'            # 2nd field
awk '{print $NF}'           # last field ($(NF-1) = 2nd from last)
awk '{print $1, $3}'        # fields 1 and 3 (comma = output separator)
awk -F: '{print $1}' /etc/passwd    # split on ':'
awk -F',' '{print $2}'      # CSV-ish (no quoted-comma handling)
```

## Filtering
```sh
awk 'NR==1'                 # first line   (NR = record number)
awk 'NR>1'                  # skip a header row
awk 'NF'                    # non-empty lines (NF > 0)
awk 'length > 80'           # lines longer than 80 chars
awk '/error/'               # lines matching /error/
awk '$3 > 100'              # rows where field 3 > 100
awk '$1=="OK" && $3>5'      # combine conditions
awk 'NR % 2 == 0'           # even-numbered lines
```

## Aggregation
```sh
awk '{sum += $1} END {print sum}'               # sum a column
awk '{a[$1]++} END {for (k in a) print k, a[k]}' # count by key
awk '{s+=$1} END {print s/NR}'                  # mean of column 1
```

## Output formatting
```sh
awk 'BEGIN{OFS="\t"} {print $1,$2}'   # tab-separated output
awk '{print NR": "$0}'                # number each line
awk '{printf "%-10s %5d\n", $1, $2}'  # printf formatting
```

Pass a shell value in:  `awk -v t="$THR" '$1 > t'`
Key vars:  `NR` record#, `NF` field count, `FS`/`OFS` in/out separators, `$0` whole line.
