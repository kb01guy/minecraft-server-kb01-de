param (
    [switch]$Force,
    [switch]$Testing
)

$basedir=(Get-Location).Path
$toolsdir=($basedir + "\.tools")

if (!(Test-Path ".tools")){New-Item ".tools" -ItemType Directory | Out-Null; Write-Host ("Created Directory .tools")}

function setup-mcrcon {
    if (!(Test-Path ($toolsdir+"\mcrcon"))) {
        New-Item ".tools/mcrcon"     -ItemType Directory | Out-Null; Write-Host ("Created Directory .tools/mcrcon")
    }
    Set-Location ($toolsdir+"\mcrcon")
    $release = (Invoke-RestMethod -Uri "https://api.github.com/repos/Tiiffi/mcrcon/releases/latest")
    $download = ($release.assets.Where({$_.name -like "*windows*x86-64*"},"First",1))
    if (!((Test-Path $download.name -PathType Leaf) -and (Test-Path "mcrcon.exe" -PathType Leaf))){
        Write-Output ("Downloading mcrcon Version '" + $release.tag_name + "' in '" + (Get-Location) + "'.")
        Remove-Item "mcrcon-*-windows-x86-64.zip"
        Invoke-WebRequest -Uri $download.browser_download_url -OutFile $download.name
        Expand-Archive $download.name .
    } else { Write-Output ("Download skipped, mcrcon Version '" + $release.tag_name + "' is allready downloaded.") }
}

function setup-buildtools {
    if (!(Test-Path ($toolsdir+"\buildtools"))) {
        New-Item ".tools/buildtools" -ItemType Directory | Out-Null; Write-Host ("Created Directory .tools/buildtools");
    }
    Set-Location ($toolsdir+"\buildtools")
    if (!(Test-Path "BuildTools.jar" -PathType Leaf) -or (((get-date)-(get-item "BuildTools.jar").LastWriteTime) -gt (new-timespan -hours 2))){
        Write-Output ("Downloading Build Tools in '" + (Get-Location) + "'.")
        if (Test-Path "BuildTools.jar" -PathType Leaf) { Remove-Item "BuildTools.jar" } 
        Invoke-WebRequest -Uri https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar -OutFile BuildTools.jar
    } else { Write-Output ("Download skipped, File .tools/buildtools/BuildTools.jar is newer than 2h.") }
}

function setup-nssm {
    if (!(Test-Path ($toolsdir+"\nssm"))) {
        New-Item ".tools/nssm" -ItemType Directory | Out-Null; Write-Host ("Created Directory .tools/nssm")
    }
    Set-Location $basedir/.tools/nssm
    $release = (Invoke-WebRequest -Uri https://nssm.cc/builds).Links.Where({$_.href -like "*ci/nssm*"},"First",1)
    $archive_name = $release.href.SubString(4,22)
    if (!((Test-Path ($archive_name+".zip") -PathType Leaf) -and (Test-Path "win64/nssm.exe" -PathType Leaf))) {
        Write-Output ("Downloading NSSM Version '"+$archive_name.SubString(5,8)+"' in '" + (Get-Location) + "'.")
        Remove-Item -Recurse *
        Invoke-WebRequest -Uri ("https://nssm.cc"+$release.href) -OutFile ($archive_name+".zip")
        Expand-Archive ($archive_name+".zip") .
        Move-Item ($archive_name+"\*") .
        Remove-Item $archive_name
    } else { 
        Write-Output ("Download skipped, NSSM Version '"+$archive_name.SubString(5,8)+"' is allready downloaded.")
    }
}

# Only Setup everything locally, if Parameter force is used
if ($Force) {
    Write-Output "Forcing local setup of all required tools";
    setup-buildtools;
    setup-mcrcon;
    setup-nssm;
}

# Testing Stuff here
if ($Testing) {
    if (!(Test-Path ($toolsdir+"\java"      ))){New-Item ".tools/java"       -ItemType Directory | Out-Null; Write-Host ("Created Directory .tools/java"      )}
    # Java Download needed?
    $possible_java_dirs = ($env:Path -split ';' | where{$_ -notlike "*WINDOWS*"})
    $javas = @();
    foreach($dir in $possible_java_dirs){
        Write-Output ("Searching Java Installs in "+$dir)
        Get-Childitem -Path $dir -Filter 'java.exe' -Recurse -ErrorAction SilentlyContinue | ForEach-Object {
            Write-Output ("Found Java Version " + (Get-Command $_.FullName | Select-Object -ExpandProperty Version) + " at '" + $_.FullName + "'.")
            $java = New-Object PsCustomObject
            $java | Add-Member -type NoteProperty -name Path -Value $_.FullName
            $java | Add-Member -type NoteProperty -name Version -Value (Get-Command $_.FullName | Select-Object -ExpandProperty Version)
            $javas += $java
        }
    }
    $favourite_java = "";
    if (![string]::IsNullOrEmpty($env:JAVA_HOME)) {
        $favourite_java = ($env:JAVA_HOME+"\bin\java.exe")
        Write-Output ("You have set JAVA_HOME Environment Variable to use Java Version " + (Get-Command ($env:JAVA_HOME+"\bin\java.exe") | Select-Object -ExpandProperty Version) + ". ")
        }
    else {$favourite_java = "placeholder"}
    Write-Output ($javas | Sort-Object -Property Version -Descending)
}

# ---------------------------------
# Go Back to Script-Location
Set-Location $basedir