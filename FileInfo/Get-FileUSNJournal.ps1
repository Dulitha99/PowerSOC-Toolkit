$FilePath = Read-Host "Enter full file path"

Write-Output "========================================"
Write-Output "USN JOURNAL METADATA ANALYSIS"
Write-Output "Timestamp: $(Get-Date)"
Write-Output "========================================"

Write-Output ""
Write-Output "File: $FilePath"

if (-not (Test-Path $FilePath)) {
    Write-Output "[WARNING] File not found."
    exit
}

Write-Output "----------------------------------------"

try {
    fsutil usn readdata $FilePath
}
catch {
    Write-Output "[ERROR] Failed to retrieve USN data."
}

Write-Output "----------------------------------------"

Write-Output ""
Write-Output "========================================"
Write-Output "[SUCCESS] USN JOURNAL ANALYSIS COMPLETED"
Write-Output "========================================"
