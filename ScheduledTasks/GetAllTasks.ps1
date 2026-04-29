$CsvPath = Join-Path $env:TEMP "ScheduledTasks_Inventory.csv"

$results = foreach ($t in Get-ScheduledTask) {

    try {
        $info = Get-ScheduledTaskInfo -TaskName $t.TaskName -TaskPath $t.TaskPath -ErrorAction Stop
    } catch {
        $info = [pscustomobject]@{
            LastRunTime    = $null
            NextRunTime    = $null
            LastTaskResult = $null
        }
    }

    $actions = foreach ($a in $t.Actions) {
        if ($a.Execute) { ("{0} {1}" -f $a.Execute, $a.Arguments).Trim() }
    }
    if (-not $actions) { $actions = @("") }

    $triggers = foreach ($tr in $t.Triggers) {
        try { $tr.TriggerType } catch { $tr.GetType().Name }
    }
    if (-not $triggers) { $triggers = @("") }

    foreach ($act in $actions) {
        [PSCustomObject]@{
            TaskName    = $t.TaskName
            TaskPath    = $t.TaskPath
            State       = $t.State
            RunAsUser   = $t.Principal.UserId
            RunLevel    = $t.Principal.RunLevel
            Action      = $act
            Triggers    = ($triggers -join ", ")
            LastRunTime = $info.LastRunTime
            NextRunTime = $info.NextRunTime
            LastResult  = $info.LastTaskResult
            Author      = $t.Author
            Description = $t.Description
        }
    }
}

$results | Export-Csv -Path $CsvPath -NoTypeInformation -Encoding UTF8

"`nExported: $($results.Count) tasks"
"File: $CsvPath"
"Exists: $(Test-Path $CsvPath)"
