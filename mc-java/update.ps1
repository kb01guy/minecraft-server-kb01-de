$basedir=(Get-Location)
$buildtools=$basedir.Path + "\..\.tools\buildtools"
$version="1.19.4"

Set-Location $buildtools
A:\scoop\apps\zulu-jdk\current\bin\java.exe -jar .\BuildTools.jar --rev $version

Set-Location $basedir
Move-Item ($buildtools + "\spigot-" + $version + ".jar") .\server\.
