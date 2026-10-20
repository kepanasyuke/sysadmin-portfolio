#!/usr/bin/env bash
# health_check.sh — проверка состояния сервера: диски, память, нагрузка, порты.
# Usage: ./health_check.sh [port1] [port2] ...
set -uo pipefail

echo "=== Uptime и нагрузка ==="
uptime
echo

echo "=== Память ==="
free -h
echo

echo "=== Диски ==="
df -h | grep -E '^/dev|Filesystem'
echo

echo "=== Perl и процессоры (загрузка 1 мин) ==="
cat /proc/loadavg
echo

echo "=== Проверка портов ==="
for port in "$@"; do
    if (echo >/dev/tcp/127.0.0.1/"$port") 2>/dev/null; then
        echo "Порт $port: ОТКРЫТ"
    else
        echo "Порт $port: ЗАКРЫТ"
    fi
done

# Предупреждение по дискам
echo
echo "=== Проверка заполненности дисков (>80%) ==="
df -h | awk 'NR>1 && $5+0 > 80 {print "ВНИМАНИЕ: диск "$6" заполнен на "$5}'