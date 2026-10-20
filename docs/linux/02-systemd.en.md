# systemd — service management

> Russian version: `02-systemd.md`

systemd is the standard init system in most modern Linux distributions (Ubuntu default since 15.04, CentOS/RHEL since 7).

## 1. Core commands

```bash
systemctl status nginx          # service status
systemctl start nginx           # start
systemctl stop nginx            # stop
systemctl restart nginx         # restart
systemctl enable nginx          # enable on boot
systemctl disable nginx         # disable on boot
systemctl list-units --type=service --all   # all services
```

## 2. Service unit file

Unit file `/etc/systemd/system/myapp.service`:

```ini
[Unit]
Description=My custom application
After=network.target

[Service]
Type=simple
User=myapp
WorkingDirectory=/opt/myapp
ExecStart=/usr/bin/python3 /opt/myapp/app.py
Restart=on-failure
RestartSec=5
Environment="APP_ENV=production"

[Install]
WantedBy=multi-user.target
```

### Key options

| Option | Purpose |
|--------|---------|
| `ExecStart` | Command that launches the process |
| `Restart=on-failure` | Auto-restart on crash |
| `RestartSec` | Pause between restarts |
| `Environment` | Environment variables |
| `WantedBy=multi-user.target` | Autostart at multi-user level |

## 3. Service logs

```bash
journalctl -u myapp              # logs of a specific service
journalctl -u myapp -f           # live logs
journalctl -u myapp --since "1 hour ago"
```

## 4. Timers (cron replacement)

`/etc/systemd/system/backup.timer`:

```ini
[Unit]
Description=Run backup daily

[Timer]
OnCalendar=*-*-* 03:00:00
Persistent=true

[Install]
WantedBy=timers.target
```

A simple unit `/etc/systemd/system/backup.service`, then:

```bash
systemctl enable backup.timer
systemctl start backup.timer
systemctl list-timers
```

---
Next: `03-network-linux.md`