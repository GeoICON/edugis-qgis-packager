@echo off

pushd .

pushd .
cd %~dp0..\..
for %%i in ("%CD%") do set BASE_DIR=%%~fsi
cd %~dp0
for %%i in ("%CD%") do set SCRIPT_DIR=%%~fsi
popd

set OSGEO4W_ROOT=%BASE_DIR%
set OSGEO4W_ROOT_MSYS=%OSGEO4W_ROOT:\=/%

if "%OSGEO4W_ROOT_MSYS:~1,1%"==":" set OSGEO4W_ROOT_MSYS=/%OSGEO4W_ROOT_MSYS:~0,1%/%OSGEO4W_ROOT_MSYS:~3%

path %OSGEO4W_ROOT%\bin;%PATH%

cd %OSGEO4W_ROOT%

echo. && echo gdal-python.bat :::::::::::::::::::::::::::::::::::::::::::::::::::::::: && echo.
%COMSPEC% /c "%OSGEO4W_ROOT%\etc\bootstrap\scripts\gdal-python.bat"

echo. && echo pyqt4.bat :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: && echo.
%COMSPEC% /c "%OSGEO4W_ROOT%\etc\bootstrap\scripts\pyqt4.bat"

echo. && echo python.bat ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: && echo.
%COMSPEC% /c "%OSGEO4W_ROOT%\etc\bootstrap\scripts\python.bat"

echo. && echo qgis-common.bat :::::::::::::::::::::::::::::::::::::::::::::::::::::::: && echo.
%COMSPEC% /c "%OSGEO4W_ROOT%\etc\bootstrap\scripts\qgis-common.bat"

echo. && echo qgis.bat ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: && echo.
%COMSPEC% /c "%OSGEO4W_ROOT%\etc\bootstrap\scripts\qgis.bat"

echo. && echo qt4-libs.bat ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: && echo.
%COMSPEC% /c "%OSGEO4W_ROOT%\etc\bootstrap\scripts\qt4-libs.bat"

echo. && echo sip.bat :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: && echo.
%COMSPEC% /c "%OSGEO4W_ROOT%\etc\bootstrap\scripts\sip.bat"

echo. && echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: && echo.

call %SCRIPT_DIR%\correct.bat

@rem call %OSGEO4W_ROOT%\bin\qgis.bat --configpath %OSGEO4W_ROOT%\.config

call "%OSGEO4W_ROOT%\bin\o4w_env.bat"
path %OSGEO4W_ROOT%\apps\edugis-qgis\bin;%PATH%
set QGIS_PREFIX_PATH=%OSGEO4W_ROOT:\=/%/apps/edugis-qgis
set GDAL_FILENAME_IS_UTF8=YES
rem Set VSI cache to be used as buffer, see #6448
set VSI_CACHE=TRUE
set VSI_CACHE_SIZE=1000000
start "QGIS" /B "%OSGEO4W_ROOT%"\bin\edugis-qgis-bin.exe --configpath %OSGEO4W_ROOT%\.config

popd