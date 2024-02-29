# :link: AutoGitUpdater

AutoGitUpdater is a PowerShell script that automates the process of updating a GitHub repository's README file with daily updates.

## :book: Features

- Automatically generates a daily update message with a timestamp.
- Appends the update message to the README.md file without deleting existing content.
- Commits and pushes the changes to the main branch of the remote repository.

## :wrench: Requirements

- Windows operating system (for Task Scheduler)
- Git installed and configured
- PowerShell

## :hammer: Usage

1. Clone or download the AutoGitUpdater repository `git clone https://github.com/Dtrugk/AutoPush.git`.
2. Customize the `Script.ps1` file to fit your requirements.
3. Run `ScheduleTask.ps1` with administrative privileges to create the scheduled task and add to start-up folder.
4. The script will update the README file at the specified times and push the changes automatically.

## :bookmark_tabs: Contributing

Contributions are welcome! If you have any ideas for improvements or new features, feel free to open an issue or submit a pull request.




