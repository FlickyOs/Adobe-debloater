@echo off
color F0
title CCKiller by Flicky
mode con: cols=92 lines=21
setlocal enabledelayedexpansion

:main
cls && echo [30mThis utility allows you to choose what you want to Disable/Kill.
echo.
echo [30m[1] [31mStop [30mAdobe Processess/Services[30m.
echo.
echo [30m[2] [31mDisable [30mAGSservice[30m! (Dont Disable if you paid for adobe products-It patches AE too if you didn't pay for it)
echo.
echo [30m[3] [31mCCStopper[30m. (Credit Card Prompt)
echo.
choice /c:123 /n > NUL 2>&1
if errorlevel 3 cls && echo CCStopper && goto CCStopper
if errorlevel 2 cls && echo AGSservice && goto AGSService
if errorlevel 1 cls && echo CCKiller && goto CCKiller

:CCKiller
cls && echo [36mStopping [30mAdobe Processes.
echo.
taskkill /IM "Adobe CEF Helper.exe" /F > NUL 2>&1
taskkill /IM "FlashPlayer_ActiveX.exe" /F > NUL 2>&1
taskkill /IM "Creative Cloud Helper.exe" /F > NUL 2>&1
taskkill /IM "Adobe Media Encoder.exe" /F > NUL 2>&1
taskkill /IM "Adobe Premiere Pro.exe" /F > NUL 2>&1
taskkill /IM "Adobe XD.exe" /F > NUL 2>&1
taskkill /IM "Adobe Fuse.exe" /F > NUL 2>&1
taskkill /IM "Adobe Media Encoder CC.exe" /F > NUL 2>&1
taskkill /IM "ae_renderer.exe" /F > NUL 2>&1
taskkill /IM "AdobeIPCBroker.exe" /F > NUL 2>&1
sc stop AGSService > NUL 2>&1
sc stop AdobeUpdateService > NUL 2>&1
sc stop AGMService > NUL 2>&1
sc stop AdobeARMservice > NUL 2>&1
:: List of common Adobe process names
set AdobeProcesses=AdobeIPCBroker.exe AAMUpdater.exe AMS.exe Typekit.exe AdobeCrashDaemon.exe TeamProjectsLocalHub.exe dynamiclinkmanager.exe AdobeIPCBroker.exe PhotoshopElements.exe Dreamweaver.exe AdobeSpark.exe CharacterAnimator.exe LightroomClassic.exe Prelude.exe Muse.exe Captivate.exe SpeedGrade.exe Scout.exe ScoutCPP.exe BridgeCC.exe CameraRaw.exe AdobeCreativeCloudCleanerTool.exe Lightroom.exe InDesign.exe Audition.exe Bridge.exe PhotoshopLauncher.exe Illustrator.exe FlashPlayerPlugin.exe AcroRd32.exe Acrobat.exe Animate.exe CCXProcess.exe Adobe Desktop Service.exe AdobeUpdateService.exe AdobeExtensionsService.exe CoreSync.exe acrotray.exe AdobeARM.exe AcrobatNotificationClient.exe CCLibrary.exe AdobeCollabSync.exe AdobeDesktopService.exe Acrobat.exe AcroRd32.exe Photoshop.exe AfterFX.exe AdobeIPCBroker.exe

for %%P in (%AdobeProcesses%) do (
    echo Attempting to terminate %%P
    taskkill /F /IM %%P 2>nul
)
cls && echo Adobe Processes Killed! && TIMEOUT /T 3 /NOBREAK > NUL 2>&1 && goto main

:AGSService
cls && echo [36mDisabling [30mAGS Service and process.
echo.
:: Disables AGSserivce from starting up
sc config "AGSService" start= disabled > NUL 2>&1
sc stop "AGSService" > NUL 2>&1
taskkill /IM "AGSService.exe" /F > NUL 2>&1
echo.
:: Added the command twice because sometimes AGSservice and AGMService.exe Start up again.
sc config "AGMService" start= disabled > NUL 2>&1
sc stop "AGMService" > NUL 2>&1
taskkill /IM "AGMService.exe" /F > NUL 2>&1
:: Deletes the client and remove access from the AdobeGCClient folder
rmdir /S /Q "C:\program files (x86)\common files\adobe\AdobeGCClient" > Nul 2>&1
mkdir "C:\program files (x86)\common files\adobe\AdobeGCClient" >NUL 2>&1
icacls "C:\program files (x86)\common files\adobe\AdobeGCClient" /deny "%username%":D >NUL 2>&1
icacls "C:\program files (x86)\common files\adobe\AdobeGCClient" /deny "%username%":R >NUL 2>&1
icacls "C:\program files (x86)\common files\adobe\AdobeGCClient" /deny "%username%":W >NUL 2>&1
cls && echo AGSservice and AGMservice.exe got Disabled! && TIMEOUT /T 3 /NOBREAK > NUL 2>&1 && goto main

:CCStopper
takeown /f "C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\ADS\Adobe Desktop Service.exe" > NUL 2>&1
icacls "C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\ADS\Adobe Desktop Service.exe" /grant Administrators:F > NUL 2>&1
ren "C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\ADS\Adobe Desktop Service.exe" "Adobe Desktop Service.exe.old" > NUL 2>&1
cls && echo Credit Card Prompt got Stopped! && TIMEOUT /T 3 /NOBREAK > NUL 2>&1 && goto main