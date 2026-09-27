@echo off
cd /d "%~dp0"
echo.
echo Wanderoff is starting at http://localhost:8000
echo Keep this window open while viewing the site.
echo.
start "" http://localhost:8000
py -m http.server 8000
