#Requires -RunAsAdministrator

schtasks.exe /delete /tn "Scoop Update" /f
Write-Host "Task uninstalled successfully."
pause