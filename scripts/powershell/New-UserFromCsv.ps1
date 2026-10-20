# New-UserFromCsv.ps1 — массовое создание пользователей Active Directory из CSV.
# Пример CSV: SamAccountName,Name,UPN,OU,Password
# Usage: .\New-UserFromCsv.ps1 -Path .\users.csv
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$Path
)

Import-Module ActiveDirectory -ErrorAction Stop

$Users = Import-Csv -Path $Path
$Created = 0
$Errors = @()

foreach ($Row in $Users) {
    try {
        $SecPass = ConvertTo-SecureString $Row.Password -AsPlainText -Force

        New-ADUser `
            -SamAccountName $Row.SamAccountName `
            -Name $Row.Name `
            -UserPrincipalName $Row.UPN `
            -Path $Row.OU `
            -AccountPassword $SecPass `
            -Enabled $true `
            -ChangePasswordAtLogon $true

        Write-Host "Создан пользователь: $($Row.SamAccountName)" -ForegroundColor Green
        $Created++
    }
    catch {
        Write-Warning "Не удалось создать $($Row.SamAccountName): $($_.Exception.Message)"
        $Errors += $Row.SamAccountName
    }
}

Write-Host "`nГотово. Создано: $Created, ошибок: $($Errors.Count)"
if ($Errors.Count -gt 0) {
    Write-Host "Ошибки: $($Errors -join ', ')" -ForegroundColor Yellow
}