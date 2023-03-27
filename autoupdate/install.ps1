#Requires -RunAsAdministrator
$currentDirectory = Get-Location
$scriptLocation = "scoop update.ps1"
$taskName = "Scoop Update"

Write-Host "Attempting to edit `"Scoop Update.xml`"."
$xmlPath = "$($currentDirectory)\Scoop Update.xml"

$xml = [xml](Get-Content $xmlPath)

$xml.Task.Actions.Exec.Command = "pwsh.exe"
Write-Host "xml.Task.Actions.Exec.Command has been set to ``$($xml.Task.Actions.Exec.Command)``"
$xml.Task.Actions.Exec.Arguments = "-ExecutionPolicy Bypass -File `"$($currentDirectory)\$($scriptLocation)`" -WindowStyle Hidden"
Write-Host "xml.Task.Actions.Exec.Arguments has been set to ``$($xml.Task.Actions.Exec.Arguments)``"

$xml.Save($xmlPath)

Write-Host "Attempting to create a scheduled task `"Scoop Update`" with the given xml file."
schtasks.exe /create /f /xml $xmlPath /tn $taskName

# Cleanup
$xml.Task.Actions.Exec.Command = ""
$xml.Task.Actions.Exec.Arguments = ""
$xml.Save($xmlPath)
Write-Host "Edits to the xml were cleaned up."

Write-Host "`nTask installed successfully. Note that if you move this directory elsewhere, you will need to run the install script again."
pause