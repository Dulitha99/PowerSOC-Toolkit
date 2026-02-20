$sig = Get-AuthenticodeSignature "<TargetFile>"
$sig.SignerCertificate | Format-List 