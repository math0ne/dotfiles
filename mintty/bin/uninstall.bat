@echo off
set refinstalldir=%LOCALAPPDATA%\wsltty
set installdir=C:\Users\math0\AppData\Local\wsltty
set refconfigdir=%APPDATA%\wsltty
set configdir=C:\Users\math0\AppData\Roaming\wsltty
@echo off

if "%installdir%" == "" set installdir=%LOCALAPPDATA%\wsltty


:shortcuts

rem delete Start Menu Folder
set smf=%APPDATA%\Microsoft\Windows\Start Menu\Programs\WSLtty
rmdir /S /Q "%smf%"

rem delete Desktop Shortcuts
del "%USERPROFILE%\Desktop\WSL Bash % in Mintty.lnk"
del "%USERPROFILE%\Desktop\WSL Bash ~ in Mintty.lnk"


:explorer context menu

call "%installdir%\config-context-menu.bat" /U


:undeploy

cd %installdir%

rem currently not removing software


:end
