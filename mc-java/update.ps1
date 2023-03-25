$basedir=(Get-Location)
$buildtools=$basedir.Path + "\..\.tools\buildtools"
$version="1.19.4"
$java=$env:JAVA_HOME

Set-Location $buildtools
& $java\bin\java.exe -jar .\BuildTools.jar --rev $version

Set-Location $basedir
Move-Item ($buildtools + "\spigot-" + $version + ".jar") .\server\.
