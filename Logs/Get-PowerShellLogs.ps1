$sd=(Get-Date).AddDays(-30)
$p=Join-Path $env:TEMP 'PS_4104_Last30Days.csv'
$f=@{LogName='Microsoft-Windows-PowerShell/Operational';Id=4104;StartTime=$sd}

Get-WinEvent -FilterHashtable $f -ErrorAction SilentlyContinue | %{
$m=$_.Message
$s=if($m -match 'Script Block Text:\s*([\s\S]*)'){$matches[1].Trim()}else{$m.Trim()}
[pscustomobject]@{TimeCreated=$_.TimeCreated;RecordID=$_.RecordId;EventID=$_.Id;Provider=$_.ProviderName;MachineName=$_.MachineName;ScriptBlock=$s}
} | sort TimeCreated -desc | Export-Csv -Path $p -NoTypeInformation -Encoding UTF8

$p
