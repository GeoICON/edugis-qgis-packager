echo off

:sign
cls
echo Signing the files by digital signature
echo ===========================================

c:\GEOICON_SIGN\signtool.exe sign /v /t "http://timestamp.comodoca.com/authenticode" /f "c:\GEOICON_SIGN\geoicon_comodo_code_signing_certificate.pfx" /p jvAK9WiztcEtZRzCTCRH4YpnnhX9mF /du "http://geoicon.com/edugis" "out\portable\EduGIS\Launch EduGIS Desktop.exe"
if errorlevel 1 goto failed

c:\GEOICON_SIGN\signtool.exe sign /v /t "http://timestamp.comodoca.com/authenticode" /f "c:\GEOICON_SIGN\geoicon_comodo_code_signing_certificate.pfx" /p jvAK9WiztcEtZRzCTCRH4YpnnhX9mF /du "http://geoicon.com/edugis" "out\portable\EduGIS\.qgis\bin\edugis-qgis-bin.exe"
if errorlevel 1 goto failed

echo ===========================================
echo Ready!
echo ===========================================
pause

goto exit

:failed
echo ===========================================
echo ===========================================
echo ===========================================
echo ===========================================
echo ===========================================
echo ===========================================
echo F A I L E D  !!!
echo ===========================================
echo ===========================================
echo ===========================================
echo ===========================================
echo ===========================================
echo ===========================================
pause
goto exit

:exit