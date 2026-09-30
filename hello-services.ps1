Write-Host "Привет! Это мой первый скрипт для Git." -ForegroundColor Green
Write-Host "Сейчас получаю список запущенных служб..." -ForegroundColor Cyan

Get-Service | Where-Object { $_.Status -eq 'Running' } | Select-Object -First 10 Name, Status

Write-Host "Готово!" -ForegroundColor Green'
