Write-Host "Hello! Starting service collection." -ForegroundColor Green

$outputFile = ".\running-services.csv"
$oldFile = ".\running-services_old.csv"

# Если старый архив уже есть — удаляем его, чтобы освободить имя
if (Test-Path -Path $oldFile) {
    Write-Host "Old backup exists. Removing $oldFile" -ForegroundColor Yellow
    Remove-Item -Path $oldFile -Force
}

# Если текущий CSV есть — переименовываем его в архив
if (Test-Path -Path $outputFile) {
    Write-Host "Output file exists. Renaming to $oldFile" -ForegroundColor Yellow
    Rename-Item -Path $outputFile -NewName $oldFile -Force
}

try {
    Write-Host "Run at: $(Get-Date)" -ForegroundColor Cyan
    Write-Host "Collecting running services..." -ForegroundColor Cyan

    Get-Service | Where-Object { $_.Status -eq 'Running' } | Select-Object -First 10 Name, Status | Export-Csv -Path $outputFile -NoTypeInformation

    Write-Host "Done! Services saved to $outputFile" -ForegroundColor Green
}
catch {
    Write-Host "Error occurred: $_" -ForegroundColor Red
    exit 1
}
