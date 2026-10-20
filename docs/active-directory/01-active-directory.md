# Active Directory — основы администрирования

> English version: `01-active-directory.en.md`

## 1. Что такое AD

Active Directory (AD) — служба каталогов Microsoft, построенная на LDAP и протоколах Windows. Позволяет централизованно управлять пользователями, компьютерами, группами и политиками в домене.

Ключевые компоненты:
- **Домен** — граница безопасности и репликации.
- **Контроллер домена (DC)** — сервер, хранящий базу AD (ntds.dit).
- **Служба доменов (AD DS)** — LDAP + Kerberos + DNS.
- **OU (Organizational Units)** — организационные единицы для делегирования и применения политик.
- **GPO (Group Policy)** — групповые политики.

## 2. Основные инструменты

```powershell
# Получить домен и его DC
Get-ADDomain
Get-ADDomainController -Filter *

# Пользователи
Get-ADUser -Filter * -Properties SamAccountName, Enabled

# Создать пользователя
New-ADUser -Name "Иван Петров" `
    -SamAccountName "ipetrov" `
    -UserPrincipalName "ipetrov@corp.local" `
    -Path "OU=Users,DC=corp,DC=local" `
    -AccountPassword (ConvertTo-SecureString "P@ssw0rd!" -AsPlainText -Force) `
    -Enabled $true

# Группы
Get-ADGroup -Filter *
New-ADGroup -Name "GRP_Admins" -GroupScope Global -Path "OU=Groups,DC=corp,DC=local"
Add-ADGroupMember -Identity "GRP_Admins" -Members "ipetrov"

# Компьютеры
Get-ADComputer -Filter *
```

## 3. DNS в AD

AD требует корректной работы DNS. Зоны AD интегрированы с базой AD (репликация через AD). Проверка:

```powershell
Get-DnsServerZone
Resolve-DnsName corp.local
nslookup gc._msdcs.corp.local
```

## 4. GPO — групповые политики

```powershell
# Список GPO
Get-GPO -All | Select-Object DisplayName, GpoStatus

# Связать GPO с OU
New-GPLink -Name "Password Policy" -Target "OU=Users,DC=corp,DC=local"

# Принудительное обновление политик на клиенте
gpupdate /force
```

Типичные настройки: политика паролей, ограничение приложений, перенаправление папок, ограничения доступа к USB.

## 5. Kerberos и аутентификация

- Клиент получает **TGT** (тикет, выдаваемый билет) от KDC.
- Затем **TGS** — тикет для конкретного сервиса.
- Время клиента и сервера должно быть синхронизировано (ошибка KRB_AP_ERR_SKEW при расхождении >5 мин).

## 6. Резервное копирование

Правильный бэкап AD — системное состояние (System State) контроллера домена:

```powershell
wbadmin start systemstatebackup -backupTarget:E:
```

---
Далее: скрипты автоматизации.