Write-Output "========================================"
Write-Output "CONNECTED USB DEVICE ENUMERATION"
Write-Output "Timestamp: $(Get-Date)"
Write-Output "========================================"

Write-Output ""
Write-Output "Enumerating Connected USB Devices..."
Write-Output "----------------------------------------"

$results = Get-PnpDevice -PresentOnly -ErrorAction SilentlyContinue |
Where-Object {
    $_.InstanceId -match '^USB'
} |
Select-Object FriendlyName, Class, Status, InstanceId

if (-not $results) {
    Write-Output "[INFO] No connected USB devices found."
}
else {
    Write-Output "[INFO] Found $($results.Count) connected USB device(s)."
    Write-Output "----------------------------------------"

    foreach ($Item in $results) {
        Write-Output "Device Name    : $($Item.FriendlyName)"
        Write-Output "Class          : $($Item.Class)"
        Write-Output "Status         : $($Item.Status)"
        Write-Output "Instance ID    : $($Item.InstanceId)"
        Write-Output "----------------------------------------"
    }
}

Write-Output ""
Write-Output "========================================"
Write-Output "[SUCCESS] USB DEVICE ENUMERATION COMPLETED"
Write-Output "========================================"
