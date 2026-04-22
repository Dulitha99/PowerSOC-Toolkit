$Dir = Read-Host "Enter directory path"

Get-ChildItem -Path $Dir -File -Force |
Get-FileHash -Algorithm SHA256 |
Select-Object @{n = "FileName"; e = { [System.IO.Path]::GetFileName($_.Path) } },
@{n = "Path"; e = { $_.Path } },
@{n = "SHA256"; e = { $_.Hash } } |
Format-Table -AutoSize