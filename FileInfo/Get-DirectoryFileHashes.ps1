$Dir = Read-Host "Enter directory path"

Write-Output "========================================"
Write-Output "SHA256 HASH COLLECTION"
Write-Output "Timestamp: $(Get-Date)"
Write-Output "========================================"

if (-not (Test-Path $Dir)) {
    Write-Output "[ERROR] Directory not found."
    exit
}

$Files = Get-ChildItem -Path $Dir -File -Force -ErrorAction SilentlyContinue

if (-not $Files) {
    Write-Output "[INFO] No files found in directory."
    exit
}

foreach ($File in $Files) {

    try {
        $Hash = Get-FileHash -Path $File.FullName -Algorithm SHA256

        Write-Output ""
        Write-Output "File Name      : $($File.Name)"
        Write-Output "File Path      : $($File.FullName)"
        Write-Output "SHA256         : $($Hash.Hash)"
        Write-Output "----------------------------------------"
    }
    catch {
        Write-Output "[ERROR] Failed to hash $($File.FullName)"
    }
}

Write-Output ""
Write-Output "========================================"
Write-Output "[SUCCESS] HASH COLLECTION COMPLETED"
Write-Output "========================================"