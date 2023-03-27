Import-Module BurntToast
& scoop update *
if ($LASTEXITCODE -eq 0) {
  New-BurntToastNotification -Text "Routine scoop update finished successfully" 
}
pause