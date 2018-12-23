#kiosk

Training project for the study of embedded systems. Contains an application and scripts for building demo kiosk system.

## Main application
Source is located in `KioskShell` folder. Build it in `Release` mode using Qt version 5.7.1 or more recent. Project is based on [Calqlatr](http://doc.qt.io/qt-5/qtdoc-demos-calqlatr-example.html) example.
### Windows version
Make sure that you have `windeployqt.exe` in system path. Run `deploy.bat`. Assembled package will be inside `/usr/bin` folder only.
### Linux version
Download a binary from [linuxdeployqt](https://github.com/probonopd/linuxdeployqt/releases) project and rename it to `linuxdeployqt`. Run `deploy.sh`. Assembled package will be inside `/usr` folder.

## Embedded system
For Windows version inside `customize.xml` settings for account __user__ has no password, account __admin__ has password __password__.

For Linux version no account settings are set in advance.
