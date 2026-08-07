$StartupPaths = @(
    "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup",
    "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Startup"
)

Write-Output "========================================"
Write-Output "STARTUP FOLDER PERSISTENCE CHECK"
Write-Output "Timestamp: $(Get-Date)"
Write-Output "========================================"

foreach ($Path in $StartupPaths) {

    Write-Output ""
    Write-Output "Startup Folder: $Path"
    Write-Output "----------------------------------------"

    if (-not (Test-Path $Path)) {
        Write-Output "[WARNING] Path not found."
        continue
    }

    $Items = Get-ChildItem -Path $Path -Force -ErrorAction SilentlyContinue

    if (-not $Items) {
        Write-Output "[INFO] No startup items found."
        continue
    }

    foreach ($Item in $Items) {
        Write-Output "Name           : $($Item.Name)"
        Write-Output "Path           : $($Item.FullName)"
        Write-Output "Size           : $($Item.Length)"
        Write-Output "Created        : $($Item.CreationTime)"
        Write-Output "Modified       : $($Item.LastWriteTime)"
        Write-Output "----------------------------------------"
    }
}

Write-Output ""
Write-Output "========================================"
Write-Output "[SUCCESS] STARTUP FOLDER CHECK COMPLETED"
Write-Output "========================================"
