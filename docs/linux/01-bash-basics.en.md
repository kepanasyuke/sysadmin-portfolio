# Bash Fundamentals — SysAdmin

> Russian version: `01-bash-basics.md`

## 1. Variables and substitution

```bash
NAME="admin"
echo "Hello, $NAME!"          # interpolate
echo "Count: $((5 + 3))"      # arithmetic
echo "Home: $HOME, User: $USER"
```

## 2. Conditionals and loops

```bash
if [ -f /etc/hosts ]; then
    echo "File exists"
fi

for f in /var/log/*.log; do
    echo "Log: $f"
done

i=0
while [ $i -lt 3 ]; do
    echo "Iteration $i"
    i=$((i + 1))
done
```

## 3. Functions

```bash
say_hello() {
    local name="$1"
    echo "Hello, $name"
}
say_hello "Admin"
```

## 4. Handy admin one-liners

```bash
# Top-10 processes by memory
ps aux --sort=-%mem | head -11

# Disk usage by top-level directories
du -sh /* 2>/dev/null | sort -h | tail

# Delete files older than 30 days
find /var/log -type f -mtime +30 -delete

# Stream a log
tail -f /var/log/syslog
```

## 5. Error handling

```bash
set -euo pipefail   # exit on error, unbound vars, pipeline failures
```

---
Next: `02-systemd.md`