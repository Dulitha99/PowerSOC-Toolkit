$results = Get-ChildItem "C:\Users\*\AppData\Local\Microsoft\Outlook\*" -File -Force `
-ErrorAction SilentlyContinue |
ForEach-Object {
    if ($_.Name -match '(?i)[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}') {
        [PSCustomObject]@{
            User         = ($_.FullName -split '\\')[2]
            Email        = $matches[0]
            FileName     = $_.Name
            LastModified = $_.LastWriteTime
        }
    }
}

if (-not $results) {
    Write-Output "No email addresses found."
}
else {
    $results |
    Sort-Object User, Email -Unique |
    Format-Table -AutoSize |
    Out-String -Width 4096 |
    Write-Output
}
