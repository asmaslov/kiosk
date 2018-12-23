@echo off

REM Removing AutoLogonCount
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /f /v AutoLogonCount
REM Setting new autologon for application user to run with custom shell
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /f /v DefaultUserName /t Reg_SZ /d "User"
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /f /v DefaultPassword /t Reg_SZ /d ""
REM Setting cleanup script
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /f /v Userinit /t Reg_SZ /d "C:\Windows\System32\userinit.exe,cmd /c D:\Service\UserLogon.bat"
REM Clean recent
echo Y | del %AppData%\Microsoft\Windows\Recent\AutomaticDestinations\*
REM Enable scripts
powershell.exe -Command Set-ExecutionPolicy Unrestricted
REM Setup custom shell
powershell.exe -Command D:\Service\CustomShellSetup.ps1 -shell D:\Shell\KioskShell.exe
REM Setup keyboard filter
powershell.exe -Command D:\Service\EnableRules.ps1
REM Disable all passwords expiration
wmic UserAccount set PasswordExpires=False
REM Disable hibernation
powercfg /h off
REM Setup UWF
uwfmgr.exe Filter Enable
uwfmgr.exe Volume Protect All
uwfmgr.exe Overlay Set-Size 256
uwfmgr.exe Overlay Set-WarningThreshold 256
uwfmgr.exe Overlay Set-CriticalThreshold 256
uwfmgr.exe File Add-Exclusion D:\Service
uwfmgr.exe File Add-Exclusion D:\Logs
REM Restarting system
uwfmgr.exe Filter Restart
