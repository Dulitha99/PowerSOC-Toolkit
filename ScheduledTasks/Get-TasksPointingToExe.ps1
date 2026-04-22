$TargetExe = Read-Host "Enter executable"

$CsvPath = Join-Path $env:TEMP "ScheduledTasks_ByExe.csv"

$results = Get-ScheduledTask | ForEach-Object {
    $t = $_
    foreach ($a in $t.Actions) {
        if ($a.Execute -and ($a.Execute -ieq $TargetExe)) {

            [PSCustomObject]@{
                TaskName    = $t.TaskName
                TaskPath    = $t.TaskPath
                ActionExe   = $a.Execute
                Arguments   = $a.Arguments
                RunAsUser   = $t.Principal.UserId
                TriggerType = ($t.Triggers | ForEach-Object { $_.TriggerType }) -join ", "
            }
        }
    }
}

$results | Export-Csv -Path $CsvPath -NoTypeInformation -Encoding UTF8

Write-Host "`nMatches: $($results.Count)"
Write-Host "File: $CsvPath"