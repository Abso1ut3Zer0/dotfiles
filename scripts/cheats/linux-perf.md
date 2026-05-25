# Linux perf & prod triage

## First 60 seconds (Brendan Gregg's checklist)
```sh
uptime                  # load avg 1/5/15 min — trend rising?
dmesg | tail            # kernel errors: OOM kills, drops, resets
vmstat 1                # r=run queue, si/so=swap, us/sy/id=cpu split
mpstat -P ALL 1         # per-CPU balance — is one core pegged?
pidstat 1               # per-process CPU over time
iostat -xz 1            # disk: %util, await (latency), aqu-sz
free -m                 # memory: read 'available', not 'free'
sar -n DEV 1            # network throughput per interface
sar -n TCP,ETCP 1       # tcp: active/passive conns, retransmits
top                     # press '1' = per-CPU, 'M' = sort by mem
```
(`mpstat`/`pidstat`/`iostat`/`sar` come from the `sysstat` package.)

## CPU
```sh
htop                    # F4 filter, F5 tree, F6 sort
ps aux --sort=-%cpu | head      # top CPU consumers
pidstat 1                       # per-process, over time
perf top                        # live function-level profile
perf record -g -p PID -- sleep 30 && perf report   # call-graph profile
```

## Memory
```sh
free -m                 # 'available' is the real headroom
ps aux --sort=-%mem | head
dmesg | grep -i oom     # did the OOM killer fire?
grep -E 'VmRSS|VmHWM' /proc/PID/status   # current + peak RSS
```

## Disk / filesystem
```sh
df -h                   # space usage
df -i                   # inode usage (full inodes mimic 'disk full')
du -sh * | sort -h      # biggest dirs here
iostat -xz 1            # %util ~100% = saturated; await = latency
lsof +D /path           # what has files open under a dir
lsof -p PID             # open files/sockets for a process
```

## Network
```sh
ss -tulpn               # listening sockets + owning pid (replaces netstat)
ss -tn state established # established tcp conns
ss -s                   # socket summary
ip a   /  ip r          # addresses / routes
mtr host                # latency + path, continuously
tcpdump -ni eth0 port 443 -c 20         # capture 20 packets on a port
curl -sw '%{time_total}\n' -o /dev/null url   # request timing
```

## Processes & signals
```sh
pgrep -fl name          # find pids by command pattern
pstree -p               # process tree with pids
ps -o pid,ppid,etime,rss,cmd -p PID     # targeted fields
kill -TERM PID          # graceful; reserve -KILL for the unkillable
kill -QUIT PID          # often dumps threads / triggers core
fuser -k /path          # kill whatever holds a path open
```

## Logs
```sh
journalctl -u svc -f                # follow a unit
journalctl -u svc --since '10 min ago'
journalctl -p err -b                # errors this boot
journalctl -k                       # kernel ring buffer via journal
```

## Tracing (deep dives)
```sh
strace -p PID -f -e trace=network   # syscalls of a live process
strace -c cmd                       # syscall count/time summary
bpftrace -e 'tracepoint:syscalls:sys_enter_openat { @[comm] = count(); }'
```

Triage instinct — **USE** every resource: Utilization, Saturation, Errors.
Check all three before you conclude where the bottleneck is.
