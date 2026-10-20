# Server-HealthReport.ps1 — отчёт о состоянии сервера Windows.
# Собирает метрики: память, диски, CPU, top-процессы. Выводит в консоль и в CSV.
# Usage: .\Server-HealthReport.ps1 [-ReportPath .\report.csv]
[CmdletBinding()]
param(
    [string]$ReportPath = ".\health-report-$(Get-Date -Format yyyyMMdd-HHmmss).csv"
)

$ReportTime = Get-Date

$OsInfo    = Get-CimInstance Win32_OperatingSystem
$CpuInfo   = Get-CimInstance Win32_Processor
$DiskInfo  = Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3"
$CS        = Get-CimInstance Win32_ComputerSystem

Write-Host "==== Отчёт о состоянии сервера $($CS.Name) ====" -ForegroundColor Cyan
Write-Host "Время отчёта : $ReportTime"
Write-Host "ОС           : $($OsInfo.Caption) [$($OsInfo.Version)]"
Write-Host "Процессор    : $($CpuInfo.Name)"
Write-Host "CPU-нагрузка : $([math]::Round($CpuInfo.LoadPercentage,1))%"

$TotalMem = [math]::Round($OsInfo.TotalVisibleMemorySize / 1MB, 2)
$FreeMem  = [math]::Round($OsInfo.FreePhysicalMemory / 1MB, 2)
Write-Host "Память       : $FreeMem / $TotalMem ГБ свободно"

Write-Host "`n=== Диски ==="
$DiskRows = foreach ($Disk in $DiskInfo) {
    $Percent = [math]::Round(($Disk.Size - $Disk.FreeSpace) / $Disk.Size * 100, 1)
    [pscustomobject]@{
        Drive = $Disk.DeviceID
        SizeGB  = [math]::Round($Disk.Size / 1GB, 1)
        FreeGB  = [math]::Round($Disk.FreeSpace / 1GB, 1)
        UsedPct = $Percent
    }
}
$DiskRows | Format-Table -AutoSize

Write-Host "=== Топ-5 процессов по памяти ==="
Get-Process | Sort-Object WorkingSet64 -Descending | Select-Object -First 5 `
    Name, Id, @{Label='MemMB'; Expression={[math]::Round($_.WorkingSet64/1MB,1)}} | Format-Table -AutoSize

# Экспорт в CSV
$Report = $DiskRows | Select-Object Drive, SizeGB, FreeGB, UsedPct
$DiskRows | Export-Csv -Path $ReportPath -NoTypeInformation -Encoding UTF8
Write-Host "`nCSV сохранён: $($ReportPath | Resolve-Path)"