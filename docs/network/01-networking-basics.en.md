# Computer Networking Fundamentals — SysAdmin

> Russian version: `01-networking-basics.md`

## 1. OSI model (briefly, bottom-up)

| Layer | Name | Examples |
|-------|------|----------|
| 7 | Application | HTTP, DNS, SMTP |
| 6 | Presentation | TLS, encodings |
| 5 | Session | NetBIOS, RPC |
| 4 | Transport | TCP, UDP |
| 3 | Network | IP, ICMP |
| 2 | Data Link | Ethernet, Wi-Fi, ARP |
| 1 | Physical | Cable, radio, fiber |

## 2. IP addressing

- **IPv4** — 32 bits, written `192.168.1.0/24`.
- **Mask notation**: `/24` = `255.255.255.0`, a network of 256 addresses (254 hosts).
- **Private ranges**:
  - `10.0.0.0/8`
  - `172.16.0.0/12`
  - `192.168.0.0/16`
- **IPv6** — 128 bits: `2001:db8::/32`.

## 3. TCP vs UDP

| Property | TCP | UDP |
|----------|-----|-----|
| Connection | Establishes (3-way handshake) | Connectionless |
| Reliability | Guarantees delivery/order | No guarantee |
| Usage | HTTP, SSH, mail, DB | DNS, VoIP, streaming |

## 4. Key protocols

- **DNS** — maps names to IP (port 53).
- **DHCP** — automatic IP assignment (ports 67/68).
- **HTTP/HTTPS** — web (ports 80/443).
- **SSH** — remote management (port 22).
- **NTP** — time synchronization (port 123).
- **SMTP/IMAP/POP3** — mail (ports 25, 143/993, 110/995).

## 5. VLAN and subnets

VLAN (IEEE 802.1Q) splits a physical switch into logical networks — smaller broadcast domain and traffic isolation. Example segmentation:

- VLANs: 10 (servers), 20 (workstations), 30 (guest Wi-Fi).

Inter-VLAN routing happens on an L3 switch or router (802.1Q-tagged interfaces).

## 6. Common problems and diagnostics

1. **No network** → `ipconfig`/`ip addr`, check cable and wiring.
2. **DNS does not resolve** → `nslookup`, `dig`.
3. **Port closed** → `telnet host port`, `nc -zv`.
4. **Slow** → check link load, interface errors.

---
Next: Active Directory module.