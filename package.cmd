md package
copy LICENSE package
copy zbplugin.lua package
copy src\gui.lua package
copy src\plugin.lua package
copy src\gui\*.lua package

cd src\gui\common
for %%i in (*) do copy %%i ..\..\..\package\common.%%i
cd ..\..\..
