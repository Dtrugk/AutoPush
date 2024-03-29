# Set the path to your Git repository
$repoPath = "E:\AutoPush\"

# Change directory to the repository
Set-Location -Path $repoPath

# Generate content for the README file (you can customize this part)
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$content = "### Daily Update" + "`r`n" +
           "This is an automated update generated on $timestamp."+
           "Your activity gonna impress everyone."

# Write content to README.md file
$content | Out-File -FilePath ".\DailyUpdate.txt" -Encoding utf8 -Append

# Stage changes
git add .

# Commit changes
git commit -m "Automated update: $timestamp"

# Push changes to the main branch
git push origin main
