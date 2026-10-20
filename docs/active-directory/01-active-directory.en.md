# Active Directory — administration basics

> Russian version: `01-active-directory.md`

## 1. What is AD

Active Directory (AD) is a Microsoft directory service built on LDAP and Windows protocols. It centrally manages users, computers, groups, and policies in a domain.

Key components:
- **Domain** — a boundary of security and replication.
- **Domain Controller (DC)** — server that stores the AD database (ntds.dit).
- **Active Directory Domain Services (AD DS)** — LDAP + Kerberos + DNS.
- **OUs (Organizational Units)** — units for delegation and policy application.
- **GPO (Group Policy)** — group policies.

## 2. Core tools (PowerShell RSAT)

```powershell
# Get domain and its DCs
Get-ADDomain
Get-ADDomainController -Filter *

# Users
Get-ADUser -Filter * -Properties SamAccountName, Enabled

# Create a user
New-ADUser -Name "Ivan Petrov" `
    -SamAccountName "ipetrov" `
    -UserPrincipalName "ipetrov@corp.local" `
    -Path "OU=Users,DC=corp,DC=local" `
    -AccountPassword (ConvertTo-SecureString "P@ssw0rd!" -AsPlainText -Force) `
    -Enabled $true

# Groups
Get-ADGroup -Filter *
New-ADGroup -Name "GRP_Admins" -GroupScope Global -Path "OU=Groups,DC=corp,DC=local"
Add-ADGroupMember -Identity "GRP_Admins" -Members "ipetrov"

# Computers
Get-ADComputer -Filter *
```

## 3. DNS in AD

AD requires working DNS. AD zones are integrated with the AD database (replicated via AD). Checks:

```powershell
Get-DnsServerZone
Resolve-DnsName corp.local
nslookup gc._msdcs.corp.local
```

## 4. GPO — Group Policy

```powershell
# List GPOs
Get-GPO -All | Select-Object DisplayName, GpoStatus

# Link a GPO to an OU
New-GPLink -Name "Password Policy" -Target "OU=Users,DC=corp,DC=local"

# Force policy refresh on client
gpupdate /force
```

Typical settings: password policy, application restriction, folder redirection, USB restrictions.

## 5. Kerberos and authentication

- Client receives a **TGT** (ticket-granting ticket) from KDC.
- Then **TGS** — a ticket for a specific service.
- Client and server clocks must be synchronized (KRB_AP_ERR_SKEW error when drift >5 min).

## 6. Backup

Correct AD backup is the System State of the domain controller:

```powershell
wbadmin start systemstatebackup -backupTarget:E:
```

---
Next: automation scripts.