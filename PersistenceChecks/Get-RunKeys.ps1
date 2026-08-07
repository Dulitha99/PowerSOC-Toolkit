Write-Output "========================================"
Write-Output "RUN / RUNONCE PERSISTENCE CHECK"
Write-Output "Timestamp: $(Get-Date)"
Write-Output "========================================"

Write-Output ""
Write-Output "HKLM RUN KEYS"
Write-Output "----------------------------------------"

$HKLMPaths = @(
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run",
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
)

foreach ($Path in $HKLMPaths) {

    Write-Output ""
    Write-Output "Registry Path: $Path"

    if (Test-Path $Path) {
        $Props = Get-ItemProperty -Path $Path

        $Props.PSObject.Properties | Where-Object {
            $_.Name -notmatch '^PS'
        } | ForEach-Object {
            Write-Output "Name           : $($_.Name)"
            Write-Output "Value          : $($_.Value)"
            Write-Output "----------------------------------------"
        }
    }
    else {
        Write-Output "[INFO] Key not found."
    }
}

Write-Output ""
Write-Output "HKU RUN KEYS"
Write-Output "----------------------------------------"

Get-ChildItem Registry::HKEY_USERS | Where-Object {
    $_.PSChildName -match "^S-1-5-21-"
} | ForEach-Object {

    $SID = $_.PSChildName

    Write-Output ""
    Write-Output "User SID       : $SID"
    Write-Output "----------------------------------------"

    $Run = "Registry::HKEY_USERS\$SID\Software\Microsoft\Windows\CurrentVersion\Run"
    $RunOnce = "Registry::HKEY_USERS\$SID\Software\Microsoft\Windows\CurrentVersion\RunOnce"

    foreach ($Key in @($Run,$RunOnce)) {

        if (Test-Path $Key) {

            Write-Output "Registry Path  : $Key"

            $Props = Get-ItemProperty -Path $Key

            $Props.PSObject.Properties | Where-Object {
                $_.Name -notmatch '^PS'
            } | ForEach-Object {
                Write-Output "Name           : $($_.Name)"
                Write-Output "Value          : $($_.Value)"
                Write-Output "----------------------------------------"
            }
        }
    }
}

Write-Output ""
Write-Output "========================================"
Write-Output "[SUCCESS] RUN KEY ENUMERATION COMPLETED"
Write-Output "========================================"
