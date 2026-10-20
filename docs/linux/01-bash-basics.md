# Основы Bash — SysAdmin

> Английская версия: `01-bash-basics.en.md`

## 1. Переменные и подстановка

```bash
NAME="admin"
echo "Привет, $NAME!"          # интерполяция
echo "Кол-во: $((5 + 3))"      # арифметика
echo "Дом: $HOME, Пользователь: $USER"
```

## 2. Условия и циклы

```bash
if [ -f /etc/hosts ]; then
    echo "Файл существует"
fi

for f in /var/log/*.log; do
    echo "Лог: $f"
done

i=0
while [ $i -lt 3 ]; do
    echo "Итерация $i"
    i=$((i + 1))
done
```

## 3. Функции

```bash
say_hello() {
    local name="$1"
    echo "Здравствуйте, $name"
}
say_hello "Admin"
```

## 4. Полезные однострочники администратора

```bash
# Посмотреть TOP-10 потребителей памяти процессами
ps aux --sort=-%mem | head -11

# Сводка использования диска по каталогам верхнего уровня
du -sh /* 2>/dev/null | sort -h | tail

# Поиск файлов старше 30 дней
find /var/log -type f -mtime +30 -delete

# Беспрерывный просмотр лога
tail -f /var/log/syslog
```

## 5. Обработка ошибок

```bash
set -euo pipefail   # останавливаться на ошибке, неопределённых переменных, сбоях в пайпе
```

---
Продолжение: `02-systemd.md`