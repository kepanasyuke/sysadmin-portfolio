# systemd — управление сервисами

> English version: `02-systemd.en.md`

systemd — стандартная система инициализации в большинстве современных дистрибутивов Linux (Ubuntu по умолчанию с 15.04, CentOS/RHEL с 7).

## 1. Основные команды

```bash
systemctl status nginx          # статус сервиса
systemctl start nginx           # запустить
systemctl stop nginx            # остановить
systemctl restart nginx         # перезапустить
systemctl enable nginx          # включить автозапуск
systemctl disable nginx         # отключить автозапуск
systemctl list-units --type=service --all   # все сервисы
```

## 2. Юнит (unit) сервиса

Файл юнита `/etc/systemd/system/myapp.service`:

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

### Объяснение ключевых опций

| Опция | Назначение |
|-------|-----------|
| `ExecStart` | Команда запуска процесса |
| `Restart=on-failure` | Автоперезапуск при падении |
| `RestartSec` | Пауза между рестартами |
| `Environment` | Переменные окружения |
| `WantedBy=multi-user.target` | Автозапуск на многопользовательском уровне |

## 3. Логи сервиса

```bash
journalctl -u myapp              # логи конкретного сервиса
journalctl -u myapp -f           # логи в реальном времени
journalctl -u myapp --since "1 hour ago"
```

## 4. Таймеры (замена cron)

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

Простой юнит `/etc/systemd/system/backup.service`, затем:

```bash
systemctl enable backup.timer
systemctl start backup.timer
systemctl list-timers
```

---
Далее: `03-network-linux.md`