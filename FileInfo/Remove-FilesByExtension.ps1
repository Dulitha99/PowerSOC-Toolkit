$path = Read-Host "Enter directory path"
$ext = Read-Host "Enter file extension (e.g. log, tmp, txt)"

Get-ChildItem -Path $path -Filter "*.$ext" -File -Force | Remove-Item -Force