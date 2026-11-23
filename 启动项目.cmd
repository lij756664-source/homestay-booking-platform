@echo off
setlocal
cd /d "%~dp0"
set "DOCKER=C:\Users\27736\AppData\Local\Programs\DockerDesktop\resources\bin\docker.exe"
if not exist "%DOCKER%" set "DOCKER=docker"
"%DOCKER%" info >nul 2>&1
if errorlevel 1 (
  echo Docker is not running. Start Docker Desktop and wait for "Engine running".
  pause
  exit /b 1
)
if not exist ".env" (
  echo Missing .env. Create local deployment config first.
  pause
  exit /b 1
)
"%DOCKER%" compose -f docker-compose.prod.yml up -d --build
if errorlevel 1 (
  echo Startup failed. Keep this window open and send the error text for help.
  pause
  exit /b 1
)
echo.
echo Startup command completed.
echo User site:  http://localhost:8088
echo Admin site: http://localhost:8089
echo Check status with: "%DOCKER%" compose -f docker-compose.prod.yml ps
pause
