type common.ahk scripts\*.ahk > "AutomaticallyCombinedScripts.ahk"

"C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe" /in "AutomaticallyCombinedScripts.ahk" /out "AHKScripts.exe"

xcopy "AHKScripts.exe" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\" /y

del /f "AHKScripts.exe"
del /f "AutomaticallyCombinedScripts.ahk"