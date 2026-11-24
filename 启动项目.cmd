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
  echo Missing .env. Deployment configuration was not found.
  pause
  exit /b 1
)
echo Starting Homestay Booking Platform...
"%DOCKER%" compose -f docker-compose.prod.yml up -d --build
if errorlevel 1 (
  echo Startup failed. Keep this window open and send the error text for help.
  pause
  exit /b 1
)
echo Waiting for services...
timeout /t 8 /nobreak >nul
"%DOCKER%" compose -f docker-compose.prod.yml ps
echo.
echo User site:  http://localhost:8088
echo Admin site: http://localhost:8089
echo Opening both sites in your browser...
start "" http://localhost:8088
start "" http://localhost:8089
echo.
echo If one site fails, keep Docker Desktop running and check the container status above.
pause
