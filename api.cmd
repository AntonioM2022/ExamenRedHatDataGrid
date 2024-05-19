@echo off
title API

REM check if exist .env file
if not exist .env (
    echo DATABASE_URL=mysql://admin:admin@localhost:3306/redHatDataGridVideo > .env
)

REM Run the application
cd bin
films.exe