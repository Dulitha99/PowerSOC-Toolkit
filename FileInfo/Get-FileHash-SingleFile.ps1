$FilePath = Read-Host "Enter full file path"

Get-FileHash -LiteralPath $FilePath -Algorithm SHA256