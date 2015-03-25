pushd .
cd %~dp0
for %%i in ("%CD%") do set BASE_DIR=%%~fsi
popd

pushd .
cd "%BASE_DIR%/out/portable/EduGIS"
icacls * /t  /grant Everyone:F
popd