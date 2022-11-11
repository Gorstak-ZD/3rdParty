@echo off
CLS
ECHO.
ECHO =============================
ECHO Running Admin shell
ECHO =============================

:init
setlocal DisableDelayedExpansion
set "batchPath=%~0"
for %%k in (%0) do set batchName=%%~nk
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion

:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
ECHO.
ECHO **************************************
ECHO Invoking UAC for Privilege Escalation
ECHO **************************************

ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
ECHO args = "ELEV " >> "%vbsGetPrivileges%"
ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
ECHO Next >> "%vbsGetPrivileges%"
ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
"%SystemRoot%\System32\WScript.exe" "%vbsGetPrivileges%" %*
exit /B

:gotPrivileges
setlocal & pushd .
cd /d %~dp0
if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)

@echo off

set dtp=%userprofile%\Desktop

cls
title downloading .NET Framework 3.5 SP1 offline installer... Please wait... & echo downloading .NET Framework 3.5 SP1 offline installer...
curl -# -L https://github.com/abbodi1406/dotNetFx35W10/releases/download/v0.20.01/dotNetFx35_WX_9_x86_x64.zip -o %tmp%\dotNetFx35_WX_9_x86_x64.zip
tar -xf %tmp%\dotNetFx35_WX_9_x86_x64.zip -C %dtp% && del %tmp%\dotNetFx35_WX_9_x86_x64.zip

cls
title downloading .NET Framework 4.8 offline installer... Please wait... & echo downloading .NET Framework 4.8 offline installer...
curl -# -L https://go.microsoft.com/fwlink/?linkid=2088631 -o %dtp%\ndp48-x86-x64-allos-enu.exe

cls
title downloading .NET Framework 4.8 update installer... Please wait... & echo downloading .NET Framework 4.8 update installer...
curl -# -L http://download.windowsupdate.com/d/msdownload/update/software/updt/2021/02/windows10.0-kb4601555-x64-ndp48_76b1806e30f9f891a4b410a486a272a41b988044.msu -o %dtp%\ndp48-x64-update.msu

title ### All DONE. Exiting... ###
timeout /T 5 && exit