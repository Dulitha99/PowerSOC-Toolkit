# PowerSOC-Toolkit

A collection of PowerShell scripts designed to support SOC operations, endpoint incident response, and investigations on Windows systems.

## Modules

### FileInfo
Scripts for file-level forensics and integrity checks.
- **Get-CodeSignature.ps1** – Retrieve digital signature info for a file
- **Get-DirectoryFileHashes.ps1** – Hash all files in a directory
- **Get-FileHash-SingleFile.ps1** – Compute the hash of a single file
- **Remove-FilesByExtension.ps1** – Remove files matching a given extension

### Logs
Scripts for extracting and parsing Windows logs.
- **Get-PowerShellLogs.ps1** – Extract PowerShell-related Windows Event Log entries

### Outlook
Scripts for Outlook and email artefact collection.
- **Get-OutlookEmailAddresses.ps1** – Extract email addresses from Outlook

### ScheduledTasks
Scripts for auditing and investigating scheduled tasks.
- **GetAllTasks.ps1** – Export a full inventory of all scheduled tasks to CSV
- **Get-TasksPointingToExe.ps1** – Find scheduled tasks executing a specific binary
- **Get-TaskByExeAndArgs.ps1** – Find scheduled tasks matching an executable and argument pattern
