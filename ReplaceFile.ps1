# Verbose output to file 
$verboseLogPath = "D:\Backup\DBBackuplog.txt"

# Enable verbose output
$VerbosePreference = "Continue"

 
# Define the source base path
$sourceBasePath = "D:\Backup"
 
# Define the destination base path
$destinationBasePath = "\\foneapp\DBBackup"
 
# Create a mapping from .NET DayOfWeek to folder names
$dayOfWeekMap = @{
    Sunday = "Sun"
    Monday = "Mon"
    Tuesday = "Tue"
    Wednesday = "Wed"
    Thursday = "Thu"
    Friday = "Fri"
    Saturday = "Sat"
}
 
# Get the current day of the week
$dayOfWeek = (Get-Date).DayOfWeek.ToString()
Write-Verbose "Current day of the week: $dayOfWeek"
# Output to log file
Write-Verbose "Current day of the week: $dayOfWeek" | Out-File -FilePath $verboseLogPath -Append

 
# Get the corresponding folder name
$dayFolderName = $dayOfWeekMap[$dayOfWeek]
Write-Verbose "Folder name for the current day: $dayFolderName"
# Added output to log file
Write-Verbose "Folder name for the current day: $dayFolderName" | Out-File -FilePath $verboseLogPath -Append

 
# Define the source and destination paths for the current day
$sourceDayPath = Join-Path -Path $sourceBasePath -ChildPath $dayFolderName
$destinationDayPath = Join-Path -Path $destinationBasePath -ChildPath $dayFolderName
# # Added output to log file 
Write-Verbose "Source path: $sourceDayPath" | Out-File -FilePath $verboseLogPath -Append
Write-Verbose "Destination path: $destinationDayPath" | Out-File -FilePath $verboseLogPath -Append
 
# Check if the source path exists
# Added output to log file
if (-Not (Test-Path -Path $sourceDayPath)) {
    Write-Error "Source path $sourceDayPath does not exist. Exiting script." | Out-File -FilePath $verboseLogPath -Append
    exit
}
 
# Create the destination folder if it doesn't exist
# Added output to log file
if (-Not (Test-Path -Path $destinationDayPath)) {
    Write-Verbose "Destination path does not exist. Creating $destinationDayPath" | Out-File -FilePath $verboseLogPath -Append
    New-Item -ItemType Directory -Path $destinationDayPath | Out-File -FilePath $verboseLogPath -Append
}
 
# Remove existing files in the destination folder
# Added output to log file
Write-Verbose "Removing existing files in $destinationDayPath" | Out-File -FilePath $verboseLogPath -Append
Remove-Item -Path "$destinationDayPath\*" -Recurse -Force | Out-File -FilePath $verboseLogPath -Append
 
# Copy the contents from the source to the destination
# Added output to log file
Write-Verbose "Copying files from $sourceDayPath to $destinationDayPath" | Out-File -FilePath $verboseLogPath -Append
Copy-Item -Path "$sourceDayPath\*" -Destination $destinationDayPath -Recurse -Force | Out-File -FilePath $verboseLogPath -Append
 
Write-Verbose "File copy operation completed." | Out-File -FilePath $verboseLogPath -Append
 
# Ensure script exits
Write-Verbose "Exiting script." | Out-File -FilePath $verboseLogPath -Append
exit 0
