@echo off
windeployqt.exe --qmldir %~dp0 --force --release %~dp0\usr\bin\KioskShell.exe