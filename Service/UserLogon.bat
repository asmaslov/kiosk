@echo off

REM Stopping keyboard filter service for admin user
if "%username%"=="Admin" (
    powershell.exe -Command D:\Service\DisableAllRules.ps1
) else (
    REM User-specific settings, if required, go here
)
REM Cleanup installation scripts
if exist D:\Serivce\reference.txt (	
    echo Y | del %AppData%\Microsoft\Windows\Recent\AutomaticDestinations\*
    del /f D:\Serivce\AfterSetup.bat
    del /f D:\Serivce\FirstLogon.bat
    del /f D:\Serivce\reference.txt
    del /f D:\Serivce\customize.xml
    del /f D:\Serivce\install.wim
    del /f D:\Serivce\CustomShellSetup.ps1
    del /f D:\Serivce\EnableRules.ps1
)
