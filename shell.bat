set PATH=%SYSTEMROOT%\system32;%PATH%
set PATH=%SYSTEMROOT%;%PATH%
set PATH=%SYSTEMROOT%\System32\Wbem;%PATH%
set PATH=c:\programs\cmake\bin;%PATH%
set PATH=c:\programs\Git\bin;%PATH%
set PATH=c:\programs\GnuWin32\bin;%PATH%
REM set PATH=c:\cygwin\bin;%PATH%

set PYTHONPATH=

set VS90COMNTOOLS=%PROGRAMFILES%\Microsoft Visual Studio 9.0\Common7\Tools\
call "%PROGRAMFILES%\Microsoft Visual Studio 9.0\VC\vcvarsall.bat" x86

set INCLUDE=%INCLUDE%;%PROGRAMFILES%\Microsoft Platform SDK\Include
set LIB=%LIB%;%PROGRAMFILES%\Microsoft Platform SDK\Lib

set OSGEO4W_ROOT=C:\OSGeo4W
set PATH=%OSGEO4W_ROOT%\bin;%PATH%
for %%f in (%OSGEO4W_ROOT%\etc\ini\*.bat) do call "%%f"

set GRASS_PREFIX=c:/OSGeo4W/apps/grass/grass-6.4.3
set INCLUDE=%INCLUDE%;%OSGEO4W_ROOT%\include
set LIB=%LIB%;%OSGEO4W_ROOT%\lib;%OSGEO4W_ROOT%\lib

cmd