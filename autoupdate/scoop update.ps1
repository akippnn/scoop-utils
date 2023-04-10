Write-Host "Updating scoop..."
Import-Module BurntToast
$command = "scoop update *"
$rawOutput = cmd /c scoop update * 2>&1 | Tee-Object -Variable output

$num = 0
$rawOutput | Out-String -Stream | ForEach-Object {
  if ($_ -match "^ERROR") { 
    $num++
    Write-Host "$num $_" -ForegroundColor Red
  } else {
    Write-Output $_
  }
}

$errors = $rawOutput | Select-String "^ERROR "
if ($errors.Count -eq 0) {
  New-BurntToastNotification -Text "Routine scoop update finished successfully."
}
else {
  Write-Host "The following errors were captured when using scoop update. Please resolve them and run the scoop update manually:" -ForegroundColor Red
  $num = 0
  foreach ($err in $errors) {
    $num++
    Write-Host "$num $($err.Line -Replace '^ERROR ', '')" -ForegroundColor Red
  }
  
  New-BurntToastNotification -Text "Routine scoop update finished with $($errors.Count) errors. Check the console for more information."
  pause
}