@echo off
del postinstall.log>>postinstall.log
echo OSGEO4W_ROOT=%OSGEO4W_ROOT%>>postinstall.log 2>&1
echo OSGEO4W_STARTMENU=%OSGEO4W_STARTMENU%>>postinstall.log 2>&1
set OSGEO4W_ROOT_MSYS=%OSGEO4W_ROOT:\=/%
if "%OSGEO4W_ROOT_MSYS:~1,1%"==":" set OSGEO4W_ROOT_MSYS=/%OSGEO4W_ROOT_MSYS:~0,1%/%OSGEO4W_ROOT_MSYS:~3%
echo OSGEO4W_ROOT_MSYS=%OSGEO4W_ROOT_MSYS%>>postinstall.log 2>&1
PATH %OSGEO4W_ROOT%\bin;%PATH%>>postinstall.log 2>&1
cd %OSGEO4W_ROOT%>>postinstall.log 2>&1
echo Running postinstall edugis-qgis-common.bat...
%COMSPEC% /c etc\postinstall\edugis-qgis-common.bat>>postinstall.log 2>&1
ren etc\postinstall\edugis-qgis-common.bat edugis-qgis-common.bat.done>>postinstall.log 2>&1
echo Running postinstall edugis-qgis.bat...
%COMSPEC% /c etc\postinstall\edugis-qgis.bat>>postinstall.log 2>&1
ren etc\postinstall\edugis-qgis.bat edugis-qgis.bat.done>>postinstall.log 2>&1
echo Running postinstall gdal-python.bat...
%COMSPEC% /c etc\postinstall\gdal-python.bat>>postinstall.log 2>&1
ren etc\postinstall\gdal-python.bat gdal-python.bat.done>>postinstall.log 2>&1
echo Running postinstall msvcrt.bat...
%COMSPEC% /c etc\postinstall\msvcrt.bat>>postinstall.log 2>&1
ren etc\postinstall\msvcrt.bat msvcrt.bat.done>>postinstall.log 2>&1
echo Running postinstall openssl.bat...
%COMSPEC% /c etc\postinstall\openssl.bat>>postinstall.log 2>&1
ren etc\postinstall\openssl.bat openssl.bat.done>>postinstall.log 2>&1
echo Running postinstall pyqt4.bat...
%COMSPEC% /c etc\postinstall\pyqt4.bat>>postinstall.log 2>&1
ren etc\postinstall\pyqt4.bat pyqt4.bat.done>>postinstall.log 2>&1
echo Running postinstall python.bat...
%COMSPEC% /c etc\postinstall\python.bat>>postinstall.log 2>&1
ren etc\postinstall\python.bat python.bat.done>>postinstall.log 2>&1
echo Running postinstall qt4-libs.bat...
%COMSPEC% /c etc\postinstall\qt4-libs.bat>>postinstall.log 2>&1
ren etc\postinstall\qt4-libs.bat qt4-libs.bat.done>>postinstall.log 2>&1
echo Running postinstall setup.bat...
%COMSPEC% /c etc\postinstall\setup.bat>>postinstall.log 2>&1
ren etc\postinstall\setup.bat setup.bat.done>>postinstall.log 2>&1
echo Running postinstall shell.bat...
%COMSPEC% /c etc\postinstall\shell.bat>>postinstall.log 2>&1
ren etc\postinstall\shell.bat shell.bat.done>>postinstall.log 2>&1
echo Running postinstall sip.bat...
%COMSPEC% /c etc\postinstall\sip.bat>>postinstall.log 2>&1
ren etc\postinstall\sip.bat sip.bat.done>>postinstall.log 2>&1
ren postinstall.bat postinstall.bat.done
