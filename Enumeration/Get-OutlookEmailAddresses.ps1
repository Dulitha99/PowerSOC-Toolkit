Write-Output "========================================"
Write-Output "OUTLOOK EMAIL ADDRESS ENUMERATION"
Write-Output "Timestamp: $(Get-Date)"
Write-Output "========================================"

Write-Output ""
Write-Output "Searching Outlook Data Files..."
Write-Output "----------------------------------------"

$results = Get-ChildItem "C:\Users\*\AppData\Local\Microsoft\Outlook\*" -File -Force -ErrorAction SilentlyContinue |
ForEach-Object {
    if ($_.Name -match '(?i)[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{3,}') {
        [PSCustomObject]@{
            User         = ($_.FullName -split '\\')[2]
            Email        = $matches[0]
            FileName     = $_.Name
            LastModified = $_.LastWriteTime
        }
    }
}

if (-not $results) {
    Write-Output "[INFO] No email addresses found."
}
else {
    $uniqueResults = $results | Sort-Object User, Email -Unique
    
    Write-Output "[INFO] Found $($uniqueResults.Count) unique email addresses."
    Write-Output "----------------------------------------"

    foreach ($Item in $uniqueResults) {
        Write-Output "User           : $($Item.User)"
        Write-Output "Email          : $($Item.Email)"
        Write-Output "File Name      : $($Item.FileName)"
        Write-Output "Last Modified  : $($Item.LastModified)"
        Write-Output "----------------------------------------"
    }
}

Write-Output ""
Write-Output "========================================"
Write-Output "[SUCCESS] EMAIL ENUMERATION COMPLETED"
Write-Output "========================================"
