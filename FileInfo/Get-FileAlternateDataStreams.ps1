$FilePath = Read-Host "Enter full file path"

Write-Output "========================================"
Write-Output "ALTERNATE DATA STREAM (ADS) CHECK"
Write-Output "Timestamp: $(Get-Date)"
Write-Output "========================================"

Write-Output ""
Write-Output "File: $FilePath"

if (-not (Test-Path $FilePath)) {
    Write-Output "[WARNING] File not found."
    exit
}

try {
    $Streams = Get-Item -Path $FilePath -Stream * -ErrorAction Stop

    Write-Output "[INFO] Streams Found: $($Streams.Count)"

    foreach ($Stream in $Streams) {
        Write-Output "  Stream Name : $($Stream.Stream)"
        Write-Output "  Length      : $($Stream.Length)"
        Write-Output "----------------------------------------"
    }
}
catch {
    Write-Output "[ERROR] $($_.Exception.Message)"
}

Write-Output ""
Write-Output "========================================"
Write-Output "[SUCCESS] ADS CHECK COMPLETED"
Write-Output "========================================"
