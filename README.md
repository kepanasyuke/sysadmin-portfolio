# SysAdmin Portfolio / Репозиторий системного администратора

Учебный проект-портфолио по системному администрированию: конспекты, скрипты автоматизации и конфигурация инфраструктуры как код (IaC). Контент продублирован на русском и английском языках.

A study/portfolio project for system administration: study notes, automation scripts and infrastructure-as-code (IaC) configs. Content is provided in Russian and English.

---

## Структура / Structure

```
.
├── docs/                        # Учебный курс / Study course
│   ├── linux/                   # Linux: bash, systemd, сеть
│   │   ├── 01-bash-basics.md / .en.md
│   │   ├── 02-systemd.md  / .en.md
│   │   └── 03-network-linux.md / .en.md
│   ├── network/                 # Компьютерные сети
│   │   └── 01-networking-basics.md / .en.md
│   └── active-directory/        # Active Directory
│       └── 01-active-directory.md / .en.md
│
├── scripts/                     # Скрипты автоматизации / Automation scripts
│   ├── bash/
│   │   ├── backup.sh            # Резервное копирование с ротацией
│   │   └── health_check.sh      # Проверка состояния сервера
│   └── powershell/
│       ├── New-UserFromCsv.ps1  # Массовое создание пользователей AD
│       └── Server-HealthReport.ps1 # Отчёт о состоянии Windows-сервера
│
└── ops/                         # Инфраструктура как код / IaC
    ├── ansible/
    │   ├── inventory.yml        # Инвентарь
    │   └── site.yml             # Плейбук: Nginx + firewall
    └── docker/
        ├── docker-compose.yml   # web + app + db
        ├── nginx.conf
        └── html/index.html
```

## Быстрый старт / Quick start

### Скрипты / Scripts

```bash
# Bash — Linux
chmod +x scripts/bash/*.sh
./scripts/bash/backup.sh /etc /backup
./scripts/bash/health_check.sh 22 80 443

# PowerShell — Windows, из консоли с правами администратора
.\scripts\powershell\Server-HealthReport.ps1
.\scripts\powershell\New-UserFromCsv.ps1 -Path .\users.csv
```

### IaC

```bash
# Ansible
cd ops/ansible
ansible-playbook -i inventory.yml site.yml

# Docker Compose
cd ops/docker
docker compose up -d
```

Требования / Requirements: Linux-сервер (Ubuntu/Debian), Ansible 2.14+, Docker Desktop/Engine + Compose v2, PowerShell 5.1+ с модулем ActiveDirectory (для скрипта AD).

## Лицензия / License

Распространяется под лицензией MIT. См. [LICENSE](LICENSE).

Distributed under the MIT License. See [LICENSE](LICENSE).

## Автор / Author

Портфолио-проект, собранный через MultiTool для практики системного администрирования.