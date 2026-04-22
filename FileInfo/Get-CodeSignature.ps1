$TargetFile = Read-Host "Enter full file path"

$sig = Get-AuthenticodeSignature $TargetFile

if ($sig.SignerCertificate) {
    $sig.SignerCertificate | Format-List
}
else {
    Write-Host "No valid signature found or file is unsigned."
}