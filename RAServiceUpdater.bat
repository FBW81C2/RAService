@echo off
if not exist "%userprofile%\RAService" md "%userprofile%\RAService"
if not exist "%userprofile%\RAService\wget" md "%userprofile%\RAService\wget"
if not exist "%userprofile%\RAService\wget\wget.exe" goto finish
if not exist "%userprofile%\RAService\empty.sys" type NUL>"%userprofile%\RAService\empty.sys"
if not exist "%userprofile%\RAService\local_version.sys" echo 1.0.0>"%userprofile%\RAService\local_version.sys"

:downloadversion
"%userprofile%\RAService\wget\wget.exe" https://raw.githubusercontent.com/FBW81C2/RAService/main/version.sys -O"%userprofile%\RAService\version.sys"
fc "%userprofile%\RAService\empty.sys" "%userprofile%\RAService\version.sys"
if %errorlevel%==1 goto checkupdate
goto downloadversion

:checkupdate
set /p version=<"%userprofile%\RAService\version.sys"
set /p local_version=<"%userprofile%\RAService\local_version.sys"
if %version%==%local_version% goto finish

:downloadupdate
"%userprofile%\RAService\wget\wget.exe" https://raw.githubusercontent.com/FBW81C2/RAService/main/RAService.bat -O"%userprofile%\RAService\RAService.sys"
fc "%userprofile%\RAService\empty.sys" "%userprofile%\RAService\RAService.sys"
if %errorlevel%==1 goto installupdate
goto downloadupdate

:installupdate
del "%userprofile%\RAService\RAService.bat" /f /q
ren "%userprofile%\RAService\RAService.sys" RAService.bat
echo %version%>"%userprofile%\RAService\local_version.sys"

:finish
exit

