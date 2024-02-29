# Check if the script is running as administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    # Relaunch the script as administrator
    Start-Process powershell.exe -Verb RunAs -ArgumentList ("-File", $MyInvocation.MyCommand.Path)
    Exit
}

# Set the path to your Git repository
$repoPath = "E:\AutoPush\"

# Change directory to the repository
Set-Location -Path $repoPath

# Set the path to your PowerShell script
$scriptPath = "E:\AutoPush\Script.ps1"

# Define the scheduled task name
$taskName = "GitAutoUpdate"

# Define the trigger settings (e.g., run daily at specified times)
# Define an array of trigger times
$triggerTimes = "8:00 AM", "6:30 PM", "4:00 PM"

# Initialize an empty array to store trigger objects
$triggers = @()

# Loop through each trigger time
foreach ($time in $triggerTimes) {
    # Create a new trigger object for each time
    $trigger = New-ScheduledTaskTrigger -Daily -At $time
    # Add the trigger object to the array
    $triggers += $trigger
}

# Define the action to run the PowerShell script
$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-File $scriptPath"

# Register the scheduled task with all triggers
Register-ScheduledTask -TaskName $taskName -Trigger $triggers -Action $action -RunLevel Highest -Force

# Add script to run at startup by creating a shortcut in the Startup folder
$shortcutPath = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\AutoGitUpdater.lnk"
$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = "powershell.exe"
$shortcut.Arguments = "-ExecutionPolicy Bypass -File `"$scriptPath`""
$shortcut.Save()
