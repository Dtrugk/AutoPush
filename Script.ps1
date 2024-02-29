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

# Define the trigger settings (e.g., run daily at 8:00 AM)
$trigger = New-ScheduledTaskTrigger -Daily -At "8:00 AM"

# Define the action to run the PowerShell script
$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-File $scriptPath"

# Register the scheduled task
Register-ScheduledTask -TaskName $taskName -Trigger $trigger -Action $action -RunLevel Highest -Force


# Generate content for the README file (you can customize this part)
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$content = "### Daily Update" + "`r`n" +
           "This is an automated update generated on $timestamp."

# Write content to README.md file
$content | Out-File -FilePath "README.md" -Encoding utf8

# Stage changes
git add .

# Commit changes
git commit -m "Automated update: $timestamp"

# Push changes to the main branch
git push origin main
