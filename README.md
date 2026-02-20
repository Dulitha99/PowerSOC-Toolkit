# PowerSOC-Toolkit

A collection of PowerShell scripts and tools designed to assist with system administration, security operations, and task automation.

## ScheduledTasks

This directory contains scripts for auditing and managing Windows Scheduled Tasks.

### Scripts

#### 1. `GetAllTasks.ps1`
Exports a comprehensive inventory of all scheduled tasks on the system to a CSV file.
- **Output**: Creates a timestamped folder in your `%TEMP%` directory containing `ScheduledTasks_Inventory.csv`.
- **Columns**: TaskName, TaskPath, State, RunAsUser, Action, Triggers, LastRunTime, NextRunTime, and more.
- **Usage**:
  ```powershell
  .\ScheduledTasks\GetAllTasks.ps1
  ```

#### 2. `Get-TasksPointingToExe.ps1`
Searches for any scheduled tasks that are configured to execute a specific program/executable.
- **Usage**: Edit the script to set the `$TargetExe` variable to the path of the executable you want to find.
  ```powershell
  # Example configuration in script:
  $TargetExe = "C:\Windows\System32\cmd.exe"
  ```
- **Output**: detailed list of matching tasks.

#### 3. `Get-TaskByExeAndArgs.ps1`
A more granular search to find scheduled tasks running a specific executable *with specific arguments*.
- **Usage**: Edit the script to set `$TargetExe` and `$TargetArgs`.
  ```powershell
  # Example configuration in script:
  $TargetExe  = "powershell.exe"
  $TargetArgs = "-File C:\Scripts\Backup.ps1"
  ```
- **Output**: detailed list of matching tasks.

## Requirements
- Windows PowerShell 5.1 or later.
- Administrator privileges may be required to view all tasks or export details for system tasks.
