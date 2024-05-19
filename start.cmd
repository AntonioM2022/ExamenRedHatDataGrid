@echo off

docker-compose up -d

REM Wait for database to be ready
:loop
docker-compose exec database mysql -uroot -proot -e "SELECT 1" >nul 2>&1
if errorlevel 1 (
  echo Waiting for database to be ready...
  timeout /t 1 /nobreak >nul
  goto loop
)

api.cmd