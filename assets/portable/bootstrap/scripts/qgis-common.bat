call "%OSGEO4W_ROOT%\bin\o4w_env.bat"
path %PATH%;%OSGEO4W_ROOT%\apps\edugis-qgis\bin
set QGIS_PREFIX_PATH=%OSGEO4W_ROOT:\=/%/apps/edugis-qgis
"%OSGEO4W_ROOT%\apps\edugis-qgis\crssync"