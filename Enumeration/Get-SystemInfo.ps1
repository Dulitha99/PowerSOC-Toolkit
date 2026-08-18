Write-Output "========================================"
Write-Output "SYSTEM INFORMATION ENUMERATION"
Write-Output "Timestamp: $(Get-Date)"
Write-Output "========================================"

Write-Output ""
Write-Output "Collecting System Information..."
Write-Output "----------------------------------------"

$OS = Get-CimInstance Win32_OperatingSystem -ErrorAction SilentlyContinue
$Computer = Get-CimInstance Win32_ComputerSystem -ErrorAction SilentlyContinue
$BIOS = Get-CimInstance Win32_BIOS -ErrorAction SilentlyContinue
$CPU = Get-CimInstance Win32_Processor -ErrorAction SilentlyContinue

if (-not $OS) {
    Write-Output "[INFO] Unable to retrieve system information."
}
else {
    Write-Output "Computer Name  : $($env:COMPUTERNAME)"
    Write-Output "Manufacturer   : $($Computer.Manufacturer)"
    Write-Output "Model          : $($Computer.Model)"
    Write-Output "Logged On User : $($Computer.UserName)"
    Write-Output "----------------------------------------"
    Write-Output "Operating System : $($OS.Caption)"
    Write-Output "OS Version       : $($OS.Version)"
    Write-Output "OS Build         : $($OS.BuildNumber)"
    Write-Output "Architecture     : $($OS.OSArchitecture)"
    Write-Output "Install Date     : $($OS.InstallDate)"
    Write-Output "Last Boot Time   : $($OS.LastBootUpTime)"
    Write-Output "----------------------------------------"
    Write-Output "Processor       : $($CPU.Name)"
    Write-Output "Logical Cores   : $($CPU.NumberOfLogicalProcessors)"
    Write-Output "----------------------------------------"
    Write-Output "Total Memory(GB): $([math]::Round($Computer.TotalPhysicalMemory/1GB,2))"
    Write-Output "----------------------------------------"
    Write-Output "Serial Number   : $($BIOS.SerialNumber)"
    Write-Output "BIOS Version    : $($BIOS.SMBIOSBIOSVersion)"
    Write-Output "----------------------------------------"
}

Write-Output ""
Write-Output "========================================"
Write-Output "[SUCCESS] SYSTEM INFORMATION ENUMERATION COMPLETED"
Write-Output "========================================"
