$basedir=(Get-Location)

# Create File Structure
if (!(Test-Path ".tools/buildtools")){New-Item ".tools/buildtools" -ItemType Directory | Out-Null; Write-Host ("Created Directory .tools/buildtools")}
if (!(Test-Path ".tools/mcrcon"    )){New-Item ".tools/mcrcon"     -ItemType Directory | Out-Null; Write-Host ("Created Directory .tools/mcrcon"    )}
if (!(Test-Path ".tools/nssm"      )){New-Item ".tools/nssm"       -ItemType Directory | Out-Null; Write-Host ("Created Directory .tools/nssm"      )}
if (!(Test-Path ".tools/java"      )){New-Item ".tools/java"       -ItemType Directory | Out-Null; Write-Host ("Created Directory .tools/java"      )}

# Setup mcrcon
Set-Location $basedir/.tools/mcrcon/
$release = (Invoke-RestMethod -Uri "https://api.github.com/repos/Tiiffi/mcrcon/releases/latest")
$download = ($release.assets.Where({$_.name -like "*windows*x86-64*"},"First",1))
if (!((Test-Path $download.name -PathType Leaf) -and (Test-Path "mcrcon.exe" -PathType Leaf))){
    Write-Output ("Downloading mcrcon Version '" + $release.tag_name + "' in '" + (Get-Location) + "'.")
    Remove-Item "mcrcon-*-windows-x86-64.zip"
    Invoke-WebRequest -Uri $download.browser_download_url -OutFile $download.name
    Expand-Archive $download.name .
} else { Write-Output ("Download skipped, mcrcon Version '" + $release.tag_name + "' is allready downloaded.") }

# Setup BuildTools
Set-Location $basedir/.tools/buildtools
if (!(Test-Path "BuildTools.jar" -PathType Leaf) -or (((get-date)-(get-item "BuildTools.jar").LastWriteTime) -gt (new-timespan -hours 2))){
    Write-Output ("Downloading Build Tools in '" + (Get-Location) + "'.")
    Remove-Item "BuildTools.jar"
    Invoke-WebRequest -Uri https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar -OutFile BuildTools.jar
} else { Write-Output ("Download skipped, File .tools/buildtools/BuildTools.jar is newer than 2h.") }

# Setup NSSM https://nssm.cc/builds
Set-Location $basedir/.tools/nssm
$release = (Invoke-WebRequest -Uri https://nssm.cc/builds).Links.Where({$_.href -like "*ci/nssm*"},"First",1)
$archive_name = $release.href.SubString(4,22)
if (!((Test-Path ($archive_name+".zip") -PathType Leaf) -and (Test-Path "win64/nssm.exe" -PathType Leaf))){
    Write-Output ("Downloading NSSM Version '"+$archive_name.SubString(5,8)+"' in '" + (Get-Location) + "'.")
    Remove-Item -Recurse *
    Invoke-WebRequest -Uri ("https://nssm.cc"+$release.href) -OutFile ($archive_name+".zip")
    Expand-Archive ($archive_name+".zip") .
    Move-Item ($archive_name+"\*") .
    Remove-Item $archive_name
} else { Write-Output ("Download skipped, NSSM Version '"+$archive_name.SubString(5,8)+"' is allready downloaded.") }






# ---------------------------------
# Go Back to Script-Location
Set-Location $basedir