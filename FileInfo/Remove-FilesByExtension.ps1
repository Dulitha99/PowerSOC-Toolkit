$path = "<Path>"
Get-ChildItem -Path $path -Filter *.<extension> -File -Force | Remove-Item -Force
