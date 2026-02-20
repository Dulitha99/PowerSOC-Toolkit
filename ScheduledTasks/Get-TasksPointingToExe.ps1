$TargetExe = "<TargetExe>"
$MatchingTasks = Get-ScheduledTask | ForEach-Object {
    $Task = $_

    foreach ($Action in $Task.Actions) {
        if ($Action.Execute -and
            ($Action.Execute -ieq $TargetExe)) {

            [PSCustomObject]@{
                TaskName    = $Task.TaskName
                TaskPath    = $Task.TaskPath
                ActionExe   = $Action.Execute
                Arguments   = $Action.Arguments
                RunAsUser   = $Task.Principal.UserId
                TriggerType = ($Task.Triggers | ForEach-Object { $_.TriggerType }) -join ", "
            }
        }
    }
}
if ($MatchingTasks) {
    $MatchingTasks | Format-Table -AutoSize
} else {
    Write-Output "No scheduled tasks found pointing to $TargetExe"
}
