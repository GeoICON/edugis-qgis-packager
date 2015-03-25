rmdir /s /q "%OSGEO4W_ROOT%\apps\Python27\Lib\site-packages\osgeo"
del "%OSGEO4W_ROOT%\apps\Python27\Lib\site-packages\gdal*.pyc"
del "%OSGEO4W_ROOT%\apps\Python27\Lib\site-packages\ogr.pyc"
"%OSGEO4W_ROOT%\bin\make-bat-for-py.bat"
