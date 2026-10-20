# Networking in Linux — ip, ss, iptables

> Russian version: `03-network-linux.md`

## 1. Working with interfaces (iproute2)

```bash
ip addr show                 # interface addresses
ip link show                 # link state
ip route show                # routing table
ip neigh show                # ARP table

# Add an address to an interface
sudo ip addr add 192.168.1.100/24 dev eth0

# Bring interface up/down
sudo ip link set eth0 up
```

## 2. DNS and network checks

```bash
cat /etc/resolv.conf         # DNS settings
host domain.example           # resolve name
dig domain.example           # verbose DNS query
ss -tulnp                    # listening TCP/UDP ports
nc -zv host 80               # check port reachability
curl -i https://example.com  # response headers
```

## 3. Diagnostics

```bash
ping -c 4 8.8.8.8            # connectivity test
traceroute -n example.com    # trace path
mtr example.com              # continuous trace
```

## 4. Basic firewall — nftables/iptables

Example `iptables` rules:

```bash
# Allow loopback
sudo iptables -A INPUT -i lo -j ACCEPT

# Allow established connections
sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Allow SSH (22) and HTTPS (443)
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# Drop everything else
sudo iptables -P INPUT DROP

# View rules
sudo iptables -L -n -v
```

> Many distributions use `ufw` (Ubuntu) or `firewalld` (RHEL/CentOS) as wrappers over nftables/iptables.

### UFW (Ubuntu)

```bash
sudo ufw allow 22/tcp
sudo ufw allow 443/tcp
sudo ufw enable
sudo ufw status
```

---
Next: Active Directory module.