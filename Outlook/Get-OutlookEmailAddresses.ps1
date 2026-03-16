$results = Get-ChildItem "C:\Users\*\AppData\Local\Microsoft\Outlook\*.ost", "C:\Users\*\AppData\Local\Microsoft\Outlook\*.pst" -ErrorAction SilentlyContinue |
ForEach-Object {
    if ($_.BaseName -match '(?i)[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}') {
        [PSCustomObject]@{
            User         = ($_.FullName -split '\\')[2]
            Email        = $matches[0]              
            LastModified = $_.LastWriteTime
        }
    }
}

if (-not $results) {
    Write-Output "No email addresses found in OST/PST filenames under C:\Users\<user>\AppData\Local\Microsoft\Outlook"
}
else {
    $results |
    Sort-Object User, Email -Unique |
    Format-Table -AutoSize |
    Out-String -Width 4096 |
    Write-Output
}