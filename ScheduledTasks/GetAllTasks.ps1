$OutDir = Join-Path $env:TEMP ("ScheduledTasks_Export_" + (Get-Date -Format "yyyyMMdd_HHmmss"))
New-Item -ItemType Directory -Path $OutDir -Force | Out-Null
$CsvPath = Join-Path $OutDir "ScheduledTasks_Inventory.csv"

$results = foreach ($t in Get-ScheduledTask) {
    $info = $null
    try { $info = Get-ScheduledTaskInfo -TaskName $t.TaskName -TaskPath $t.TaskPath } catch {}
    $actions = @()
    foreach ($a in $t.Actions) {
        if ($null -ne $a.Execute) {
            $actions += ("{0} {1}" -f $a.Execute, $a.Arguments).Trim()
        }
    }
    if (-not $actions) { $actions = @("") }
    $triggers = @()
    foreach ($tr in $t.Triggers) {
        try { $triggers += $tr.TriggerType } catch { $triggers += ($tr.GetType().Name) }
    }
    if (-not $triggers) { $triggers = @("") }

    foreach ($act in $actions) {
        [PSCustomObject]@{
            TaskName     = $t.TaskName
            TaskPath     = $t.TaskPath
            State        = $t.State
            RunAsUser    = $t.Principal.UserId
            RunLevel     = $t.Principal.RunLevel
            Action       = $act
            Triggers     = ($triggers -join ", ")
            LastRunTime  = $info.LastRunTime
            NextRunTime  = $info.NextRunTime
            LastResult   = $info.LastTaskResult
            Author       = $t.Author
            Description  = $t.Description
        }
    }
}
$results | Export-Csv -Path $CsvPath -NoTypeInformation -Encoding UTF8
Write-Output "Scheduled task inventory exported to: $CsvPath"
Write-Output "Export folder: $OutDir"
