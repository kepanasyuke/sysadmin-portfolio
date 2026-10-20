# Сеть в Linux — ip, ss, iptables

> English version: `03-network-linux.en.md`

## 1. Работа с интерфейсами (iproute2)

```bash
ip addr show                 # адреса интерфейсов
ip link show                 # состояние линков
ip route show                # таблица маршрутизации
ip neigh show                # ARP-таблица

# Добавить адрес на интерфейс
sudo ip addr add 192.168.1.100/24 dev eth0

# Поднять/опустить интерфейс
sudo ip link set eth0 up
```

## 2. DNS и сетевые проверки

```bash
cat /etc/resolv.conf         # DNS-настройки
host domain.example           # резолвинг имени
dig domain.example           # детальный DNS-запрос
ss -tulnp                    # открытые TCP/UDP порты
nc -zv host 80               # проверить доступность порта
curl -i https://example.com  # заголовки ответа
```

## 3. Диагностика

```bash
ping -c 4 8.8.8.8            # проверка связности
traceroute -n example.com    # трассировка
mtr example.com              # непрерывная трассировка
```

## 4. Базовый файрвол — nftables/iptables

Пример правил `iptables`:

```bash
# Разрешить loopback
sudo iptables -A INPUT -i lo -j ACCEPT

# Разрешить установленные соединения
sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Разрешить SSH (порт 22) и HTTPS (443)
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# Сбросить всё остальное
sudo iptables -P INPUT DROP

# Посмотреть правила
sudo iptables -L -n -v
```

> Многие дистрибутивы используют `ufw` (Ubuntu) или `firewalld` (RHEL/CentOS) как обёртку над nftables/iptables.

### UFW (Ubuntu)

```bash
sudo ufw allow 22/tcp
sudo ufw allow 443/tcp
sudo ufw enable
sudo ufw status
```

---
Далее: модуль Active Directory.