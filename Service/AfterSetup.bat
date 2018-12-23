@echo off

if not exist D:\Service\reference.txt (
    REM Install embedded features
    powershell.exe -Command "Enable-WindowsOptionalFeature -Online -FeatureName Client-DeviceLockdown"
    powershell.exe -Command "Enable-WindowsOptionalFeature -Online -FeatureName Client-EmbeddedShellLauncher"
    powershell.exe -Command "Enable-WindowsOptionalFeature -Online -FeatureName Client-EmbeddedBootExp -NoRestart"
    powershell.exe -Command "Enable-WindowsOptionalFeature -Online -FeatureName Client-EmbeddedLogon -NoRestart"
    powershell.exe -Command "Enable-WindowsOptionalFeature -Online -FeatureName Client-KeyboardFilter -NoRestart"
    powershell.exe -Command "Enable-WindowsOptionalFeature -Online -FeatureName Client-UnifiedWriteFilter -NoRestart"
    REM Disable UAC
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /f /v EnableLUA /t Reg_DWord /d 0
    REM Write marker files
    echo target >> D:\Service\reference.txt
    REM Create folders
    if not exist "D:\Logs\" mkdir D:\Logs
    if not exist "D:\Shell\" mkdir D:\Shell
    REM Restarting system
    shutdown -r -t 0
) else (
    REM Disable UAC Completely
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /f /v EnableLUA /t Reg_DWord /d 0
    REM Move event log file location to data partition
    C:\Windows\System32\wevtutil.exe sl Application /lfn:D:\Logs\Application.evtx
    C:\Windows\System32\wevtutil.exe sl Setup /lfn:D:\Logs\Setup.evtx
    C:\Windows\System32\wevtutil.exe sl Security /lfn:D:\Logs\Security.evtx
    C:\Windows\System32\wevtutil.exe sl System /lfn:D:\Logs\System.evtx
    C:\Windows\System32\wevtutil.exe sl ForwardedEvents /lfn:D:\Logs\ForwardedEvents.evtx
    REM Set the Userinit key, when Run keys do not work
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /f /v Userinit /t Reg_SZ /d "C:\Windows\System32\userinit.exe,cmd /c D:\Service\FirstLogon.bat"
    REM Sysprep image with configuration file
    C:\Windows\System32\sysprep\Sysprep.exe /generalize /oobe /shutdown /unattend:D:\Service\customize.xml
)
