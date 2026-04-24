$days = 30
$startDate = (Get-Date).AddDays(-$days)

$CsvPath = Join-Path $env:TEMP "PowerShell_4104_Logs_Last30Days.csv"

$filter = @{
    LogName   = "Microsoft-Windows-PowerShell/Operational"
    Id        = 4104
    StartTime = $startDate
}

$events = Get-WinEvent -FilterHashtable $filter -ErrorAction Stop

$results = foreach ($event in $events) {

    $msg = $event.Message

    $script = if ($msg -match "Script Block Text:\s*([\s\S]*)") {
        $matches[1].Trim()
    } else {
        $msg.Trim()
    }

    [PSCustomObject]@{
        TimeCreated = $event.TimeCreated
        RecordID    = $event.RecordId
        EventID     = $event.Id
        Provider    = $event.ProviderName
        MachineName = $event.MachineName
        ScriptBlock = $script
    }
}

$results |
    Sort-Object TimeCreated -Descending |
    Export-Csv -Path $CsvPath -NoTypeInformation -Encoding UTF8

Write-Host "Exported $($results.Count) PowerShell 4104 events (Last 30 Days)"
Write-Host "File saved to: $CsvPath"
