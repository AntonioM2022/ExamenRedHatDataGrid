@echo off
title API

REM check if the DATABASE_URL is set in the environment
if not defined DATABASE_URL (
  setx DATABASE_URL "mysql://admin:admin@database:3306/redHatDataGridVideo" /M
)

REM Run the application
cd bin
films.exe