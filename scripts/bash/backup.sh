#!/usr/bin/env bash
# backup.sh — простой инкрементальный бэкап каталога с ротацией.
# Usage: ./backup.sh <source_dir> <backup_dir>
set -euo pipefail

SOURCE="${1:?Укажите исходный каталог}"
DEST="${2:?Укажите каталог бэкапа}"
RETENTION_DAYS="${RETENTION_DAYS:-14}"
STAMP="$(date +%Y%m%d-%H%M%S)"
ARCHIVE="$DEST/backup-$STAMP.tar.gz"

if [ ! -d "$SOURCE" ]; then
    echo "Ошибка: исходный каталог не существует: $SOURCE" >&2
    exit 1
fi

mkdir -p "$DEST"

tar --exclude='*.tmp' --exclude='*.log' \
    -czf "$ARCHIVE" -C "$(dirname "$SOURCE")" "$(basename "$SOURCE")"

echo "Создан архив: $ARCHIVE ($(du -h "$ARCHIVE" | cut -f1))"

# Ротация: удаление архивов старше RETENTION_DAYS дней
find "$DEST" -name 'backup-*.tar.gz' -mtime +"$RETENTION_DAYS" -delete

echo "Ротация завершена. Осталось:"
find "$DEST" -name 'backup-*.tar.gz' | sort

# Статус последнего успешного бэкапа
echo "hash: $(md5sum "$ARCHIVE" | cut -d' ' -f1)"