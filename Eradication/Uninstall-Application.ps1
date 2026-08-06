$uninstall = "<Uninstaller Path>"

Write-Output "========================================"
Write-Output "APPLICATION UNINSTALL STARTED"
Write-Output "Timestamp: $(Get-Date)"
Write-Output "========================================"

Write-Output "Uninstaller Path: $uninstall"

if (Test-Path $uninstall) {

    Write-Output "[INFO] Uninstaller found."

    try {

        $appFolder = Split-Path $uninstall -Parent

        $proc = Start-Process -FilePath $uninstall -ArgumentList "/S" -PassThru -Wait

        Write-Output "[INFO] Uninstall process completed."
        Write-Output "[INFO] Process ID : $($proc.Id)"
        Write-Output "[INFO] Exit Code  : $($proc.ExitCode)"

        Start-Sleep -Seconds 5

        if (Test-Path $appFolder) {
            Write-Output "[WARNING] Application directory still exists:"
            Get-ChildItem $appFolder -Force -ErrorAction SilentlyContinue | Select-Object Name,Length,LastWriteTime
        }
        else {
            Write-Output "[SUCCESS] Application directory has been removed."
        }

        Write-Output "[INFO] Recently running processes matching the application folder name:"
        Get-Process -ErrorAction SilentlyContinue | Where-Object {
            $_.Path -like "$appFolder*"
        } | Select-Object ProcessName,Id,Path

    }
    catch {
        Write-Output "[ERROR] Uninstall failed."
        Write-Output $_.Exception.Message
    }
}
else {
    Write-Output "[ERROR] Uninstaller not found."
}

Write-Output ""
Write-Output "========================================"
Write-Output "APPLICATION UNINSTALL SUMMARY"
Write-Output "========================================"
Write-Output "Uninstaller : $uninstall"
Write-Output "Completed   : $(Get-Date)"
