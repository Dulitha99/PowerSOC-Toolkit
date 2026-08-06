$file = "<filename>"

Write-Output "======================================="
Write-Output "DIGITAL SIGNATURE VERIFICATION STARTED"
Write-Output "Timestamp: $(Get-Date)"
Write-Output "========================================"

Write-Output ""
Write-Output "Checking File: $file"

if (-not (Test-Path $file)) {
    Write-Output "[ERROR] File not found."
}
else {
    try {
        $sig = Get-AuthenticodeSignature -FilePath $file

        Write-Output "[INFO] Signature Status : $($sig.Status)"

        if ($sig.SignerCertificate) {
            Write-Output "[INFO] Signer          : $($sig.SignerCertificate.Subject)"
            Write-Output "[INFO] Issuer          : $($sig.SignerCertificate.Issuer)"
            Write-Output "[INFO] Thumbprint      : $($sig.SignerCertificate.Thumbprint)"
            Write-Output "[INFO] Serial Number   : $($sig.SignerCertificate.SerialNumber)"
            Write-Output "[INFO] Valid From      : $($sig.SignerCertificate.NotBefore)"
            Write-Output "[INFO] Valid Until     : $($sig.SignerCertificate.NotAfter)"
        }
        else {
            Write-Output "[WARNING] No signing certificate present."
        }

        Write-Output "[SUCCESS] Signature verification completed."
    }
    catch {
        Write-Output "[ERROR] $($_.Exception.Message)"
    }
}

Write-Output ""
Write-Output "========================================"
Write-Output "DIGITAL SIGNATURE VERIFICATION SUMMARY"
Write-Output "========================================"
Write-Output "File   : $file"
Write-Output "Status : $($sig.Status)"