@echo off
:: Change to the server directory
cd /server

:: Run the PocketBase server
pocketbase serve --dir .

:: Pause to keep the command prompt open after execution
pause