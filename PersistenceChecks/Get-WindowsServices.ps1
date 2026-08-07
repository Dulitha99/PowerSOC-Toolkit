Write-Output "========================================"
Write-Output "WINDOWS SERVICE ENUMERATION"
Write-Output "Timestamp: $(Get-Date)"
Write-Output "========================================"

Get-CimInstance Win32_Service | Sort-Object Name | ForEach-Object {

    Write-Output ""
    Write-Output "Service Name   : $($_.Name)"
    Write-Output "Display Name   : $($_.DisplayName)"
    Write-Output "State          : $($_.State)"
    Write-Output "Start Mode     : $($_.StartMode)"
    Write-Output "Path           : $($_.PathName)"
    Write-Output "----------------------------------------"
}

Write-Output ""
Write-Output "========================================"
Write-Output "[SUCCESS] SERVICE ENUMERATION COMPLETED"
Write-Output "========================================"
