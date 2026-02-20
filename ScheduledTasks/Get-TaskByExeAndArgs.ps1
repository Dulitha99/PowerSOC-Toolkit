$TargetExe  = '<TargetExe>'
$TargetArgs = '<TargetArgs>'

$MatchingTasks = Get-ScheduledTask | ForEach-Object {
    $Task = $_
    foreach ($Action in $Task.Actions) {
        if ($Action.Execute -and
            ($Action.Execute -ieq $TargetExe) -and
            ($Action.Arguments -and $Action.Arguments -like "*$TargetArgs*")) {

            [PSCustomObject]@{
                TaskName    = $Task.TaskName
                TaskPath    = $Task.TaskPath
                ActionExe   = $Action.Execute
                Arguments   = $Action.Arguments
                RunAsUser   = $Task.Principal.UserId
                TriggerType = ($Task.Triggers | ForEach-Object { $_.TriggerType }) -join ', '
            }
        }
    }
}

if ($MatchingTasks) { $MatchingTasks | Format-Table -AutoSize }
else { Write-Output "No scheduled tasks found for $TargetExe with args containing: $TargetArgs" }
