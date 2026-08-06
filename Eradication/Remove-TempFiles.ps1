$TempPaths = @(
    "$env:TEMP",
    "$env:WINDIR\Temp"
)

$TotalFilesDeleted = 0
$TotalFoldersDeleted = 0

Write-Output "========================================"
Write-Output "TEMP CLEANUP STARTED"
Write-Output "Timestamp: $(Get-Date)"
Write-Output "========================================"

foreach ($Path in $TempPaths) {

    Write-Output ""
    Write-Output "Processing: $Path"

    if (-not (Test-Path $Path)) {
        Write-Output "[WARNING] Path not found."
        continue
    }

    try {
        $Files = Get-ChildItem -Path $Path -File -Recurse -Force -ErrorAction SilentlyContinue
        $Folders = Get-ChildItem -Path $Path -Directory -Recurse -Force -ErrorAction SilentlyContinue

        Write-Output "[INFO] Files Found: $($Files.Count)"
        Write-Output "[INFO] Folders Found: $($Folders.Count)"

        foreach ($File in $Files) {
            try {
                Remove-Item $File.FullName -Force -ErrorAction Stop
                $TotalFilesDeleted++
            }
            catch {
                Write-Output "[SKIPPED] $($File.FullName)"
            }
        }

        foreach ($Folder in ($Folders | Sort-Object FullName -Descending)) {
            try {
                Remove-Item $Folder.FullName -Force -Recurse -ErrorAction Stop
                $TotalFoldersDeleted++
            }
            catch {
                Write-Output "[SKIPPED] $($Folder.FullName)"
            }
        }

        Write-Output "[SUCCESS] Cleanup completed for $Path"
    }
    catch {
        Write-Output "[ERROR] $($_.Exception.Message)"
    }
}

Write-Output ""
Write-Output "========================================"
Write-Output "TEMP CLEANUP SUMMARY"
Write-Output "========================================"
Write-Output "Files Deleted   : $TotalFilesDeleted"
Write-Output "Folders Deleted : $TotalFoldersDeleted"
Write-Output "[SUCCESS] Temp file cleanup completed."
