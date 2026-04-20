@echo off
setlocal

set "MOD_NAME=FastForward"
set "DEST=%APPDATA%\Balatro\Mods\%MOD_NAME%"

echo Installing %MOD_NAME% mod...

if not exist "%DEST%" (
    mkdir "%DEST%"
)

copy /Y "%~dp0FastForward.lua" "%DEST%\FastForward.lua" >nul
copy /Y "%~dp0FastForward.json" "%DEST%\FastForward.json" >nul

echo Done! Installed to:
echo   %DEST%
pause
