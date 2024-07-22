@echo off
setlocal enabledelayedexpansion

rem Define the executable name
set ExeName=AHKScripts.exe

rem Create a temporary directory
set TempDir=%temp%\AHKTemp
mkdir "%TempDir%"

rem Copy all scripts to the temporary directory and add a blank line to each
for %%f in (scripts\*.ahk) do (
    type "%%f" >> "%TempDir%\%%~nxf"
    echo. >> "%TempDir%\%%~nxf"
)

rem Combine all the scripts from the temporary directory
type "%TempDir%\*.ahk" > "AutomaticallyCombinedScripts.ahk"

rem Compile the combined script
"C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe" /in "AutomaticallyCombinedScripts.ahk" /out "%ExeName%"

rem Check if the executable is already running and kill it if it is
tasklist /FI "IMAGENAME eq %ExeName%" 2>NUL | find /I /N "%ExeName%">NUL
if "%ERRORLEVEL%"=="0" (
    echo %ExeName% is running. Killing process...
    taskkill /F /IM "%ExeName%"
)

rem Copy the compiled script to the startup folder
xcopy "%ExeName%" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\" /y

rem Start the new executable
start "" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\%ExeName%"

rem Clean up
del /f "%ExeName%"
del /f "AutomaticallyCombinedScripts.ahk"
rmdir /s /q "%TempDir%"

endlocal
