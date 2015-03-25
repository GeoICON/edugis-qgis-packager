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

path %OSGEO4W_ROOT%\bin;%PATH%

SET PYTHONHOME=%OSGEO4W_ROOT%\apps\Python27
SET PATH=%PATH%;%OSGEO4W_ROOT%\apps\Python27\Scripts

popd

rem python %SCRIPT_DIR%\correct.py %BASE_DIR%

