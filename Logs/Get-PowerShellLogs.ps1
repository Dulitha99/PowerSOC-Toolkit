$days = Read-Host "Enter number of days"
if (-not ($days -as [int])) { Write-Host "Invalid input" -ForegroundColor Red; exit }

$startDate = (Get-Date).AddDays( - [int]$days)
$CsvPath = Join-Path $env:TEMP "PowerShell_4104_Logs.csv"

$events = Get-WinEvent -LogName "Microsoft-Windows-PowerShell/Operational" |
Where-Object { $_.Id -eq 4104 -and $_.TimeCreated -ge $startDate }

$results = foreach ($event in $events) {
    $msg = $event.Message
    $script = if ($msg -match "Script Block Text:\s*(.+)") { $matches[1] } else { $msg }

    [PSCustomObject]@{
        TimeCreated = $event.TimeCreated
        RecordID    = $event.RecordId
        ScriptBlock = $script.Trim()
    }
}

$results | Export-Csv -Path $CsvPath -NoTypeInformation -Encoding UTF8

Write-Host "`nExported: $($results.Count) logs"
Write-Host "File: $CsvPath"