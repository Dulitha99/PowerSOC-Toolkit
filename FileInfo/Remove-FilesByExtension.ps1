$Path = Read-Host "Enter directory path"
$Ext = Read-Host "Enter file extension (e.g. log, tmp, txt)"

Write-Output "========================================"
Write-Output "REMOVE FILES BY EXTENSION"
Write-Output "Timestamp: $(Get-Date)"
Write-Output "========================================"

if (-not (Test-Path $Path)) {
    Write-Output "[ERROR] Directory not found."
    exit
}

Write-Output ""
Write-Output "Target Directory: $Path"
Write-Output "Target Extension: $Ext"
Write-Output "----------------------------------------"

$Files = Get-ChildItem -Path $Path -Filter "*.$Ext" -File -Force -ErrorAction SilentlyContinue

if (-not $Files) {
    Write-Output "[INFO] No files with extension '$Ext' found."
    exit
}

$Count = 0

foreach ($File in $Files) {
    try {
        Remove-Item -Path $File.FullName -Force -ErrorAction Stop
        Write-Output "[INFO] Removed: $($File.FullName)"
        $Count++
    }
    catch {
        Write-Output "[ERROR] Failed to remove: $($File.FullName)"
    }
}

Write-Output "----------------------------------------"
Write-Output "Total files removed: $Count"

Write-Output ""
Write-Output "========================================"
Write-Output "[SUCCESS] REMOVAL COMPLETED"
Write-Output "========================================"