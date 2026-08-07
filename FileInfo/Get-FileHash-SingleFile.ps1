$FilePath = Read-Host "Enter full file path"

Write-Output "========================================"
Write-Output "SINGLE FILE HASH CHECK"
Write-Output "Timestamp: $(Get-Date)"
Write-Output "========================================"

if (-not (Test-Path $FilePath)) {
    Write-Output "[ERROR] File not found."
    exit
}

try {
    $Hash = Get-FileHash -Path $FilePath -Algorithm SHA256

    Write-Output ""
    Write-Output "File Path      : $($Hash.Path)"
    Write-Output "Algorithm      : $($Hash.Algorithm)"
    Write-Output "Hash           : $($Hash.Hash)"
    Write-Output "----------------------------------------"
}
catch {
    Write-Output "[ERROR] Failed to hash $FilePath"
}

Write-Output ""
Write-Output "========================================"
Write-Output "[SUCCESS] FILE HASH CHECK COMPLETED"
Write-Output "========================================"