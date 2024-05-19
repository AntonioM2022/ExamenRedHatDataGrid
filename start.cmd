@echo off

docker-compose up -d database || true

REM Wait for database to be ready
:loop
docker-compose exec database mysql -uroot -proot -e "SELECT 1" >nul 2>&1
if errorlevel 1 (
  echo Waiting for database to be ready...
  timeout /t 1 /nobreak >nul
  goto loop
)

REM Run the application
setx DATABASE_URL "mysql://admin:admin@localhost:3306/redHatDataGridVideo" /M

REM Run the application
cd bin
films.exe