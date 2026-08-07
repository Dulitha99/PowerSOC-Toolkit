Write-Output "========================================"
Write-Output "SCHEDULED TASK ENUMERATION"
Write-Output "Timestamp: $(Get-Date)"
Write-Output "========================================"

Get-ScheduledTask | ForEach-Object {

    $Task = $_

    try {
        $Info = Get-ScheduledTaskInfo -TaskName $Task.TaskName -TaskPath $Task.TaskPath -ErrorAction SilentlyContinue

        foreach ($Action in $Task.Actions) {

            Write-Output ""
            Write-Output "Task Name      : $($Task.TaskName)"
            Write-Output "Task Path      : $($Task.TaskPath)"
            Write-Output "State          : $($Task.State)"
            Write-Output "Author         : $($Task.Author)"
            Write-Output "Execute        : $($Action.Execute)"
            Write-Output "Arguments      : $($Action.Arguments)"
            Write-Output "Last Run Time  : $($Info.LastRunTime)"
            Write-Output "Next Run Time  : $($Info.NextRunTime)"
            Write-Output "----------------------------------------"
        }

    }
    catch {
        Write-Output "[ERROR] Failed to retrieve task details for $($Task.TaskName)"
    }

}

Write-Output ""
Write-Output "========================================"
Write-Output "[SUCCESS] SCHEDULED TASK ENUMERATION COMPLETED"
Write-Output "========================================"
