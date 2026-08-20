$TargetIP = "52.123.252.10"

Write-Output "========================================"
Write-Output "NETWORK CONNECTION PERSISTENCE CHECK"
Write-Output "Timestamp: $(Get-Date)"
Write-Output "========================================"

Write-Output ""
Write-Output "Investigating Network Connections to $TargetIP..."
Write-Output "----------------------------------------"

$Connections = Get-NetTCPConnection -ErrorAction SilentlyContinue | Where-Object {
    $_.RemoteAddress -eq $TargetIP
}

if (-not $Connections) {
    Write-Output "[INFO] No active TCP connections identified to $TargetIP."
}
else {
    Write-Output "[INFO] Found $($Connections.Count) active connection(s)."
    Write-Output "----------------------------------------"

    foreach ($Conn in $Connections) {
        Write-Output "Local Address  : $($Conn.LocalAddress)"
        Write-Output "Local Port     : $($Conn.LocalPort)"
        Write-Output "Remote Address : $($Conn.RemoteAddress)"
        Write-Output "Remote Port    : $($Conn.RemotePort)"
        Write-Output "State          : $($Conn.State)"
        Write-Output "PID            : $($Conn.OwningProcess)"

        $Process = Get-CimInstance Win32_Process -Filter "ProcessId=$($Conn.OwningProcess)" -ErrorAction SilentlyContinue

        if ($Process) {
            Write-Output "Process Name   : $($Process.Name)"
            Write-Output "Process Path   : $($Process.ExecutablePath)"
            Write-Output "Command Line   : $($Process.CommandLine)"
            Write-Output "Parent PID     : $($Process.ParentProcessId)"

            if ($Process.ExecutablePath -and (Test-Path $Process.ExecutablePath)) {
                $Hash = Get-FileHash $Process.ExecutablePath -Algorithm SHA256 -ErrorAction SilentlyContinue
                
                if ($Hash) {
                    Write-Output "SHA256         : $($Hash.Hash)"
                }
            }
        }
        Write-Output "----------------------------------------"
    }
}

Write-Output ""
Write-Output "========================================"
Write-Output "[SUCCESS] NETWORK CONNECTION CHECK COMPLETED"
Write-Output "========================================"
