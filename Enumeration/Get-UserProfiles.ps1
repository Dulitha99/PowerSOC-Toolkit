Write-Output "========================================"
Write-Output "USER PROFILE ENUMERATION"
Write-Output "Timestamp: $(Get-Date)"
Write-Output "========================================"

Write-Output ""
Write-Output "Enumerating User Profiles..."
Write-Output "----------------------------------------"

$results = Get-CimInstance Win32_UserProfile -ErrorAction SilentlyContinue |
ForEach-Object {
    [PSCustomObject]@{
        ProfilePath = $_.LocalPath
        LastUsed    = $_.LastUseTime
        Loaded      = $_.Loaded
    }
}

if (-not $results) {
    Write-Output "[INFO] No user profiles found."
}
else {
    $userProfiles = $results | Where-Object {
        $_.ProfilePath -like "C:\Users\*"
    } | Sort-Object LastUsed -Descending

    Write-Output "[INFO] Found $($userProfiles.Count) user profile(s)."
    Write-Output "----------------------------------------"

    foreach ($Item in $userProfiles) {
        Write-Output "Profile Path   : $($Item.ProfilePath)"
        Write-Output "Last Used      : $($Item.LastUsed)"
        Write-Output "Loaded         : $($Item.Loaded)"
        Write-Output "----------------------------------------"
    }
}

Write-Output ""
Write-Output "========================================"
Write-Output "[SUCCESS] USER PROFILE ENUMERATION COMPLETED"
Write-Output "========================================"
