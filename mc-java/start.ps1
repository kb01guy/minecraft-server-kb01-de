$basedir=(Get-Location)
$buildtools=$basedir.Path + "\..\.tools\buildtools"
$version="1.19.4"

Set-Location ($basedir.Path+"\server")
A:\scoop\apps\zulu-jdk\current\bin\java.exe -jar (".\spigot-"+$version+".jar") --nogui


Set-Location $basedir