$basedir=(Get-Location)
$buildtools=$basedir.Path + "\..\.tools\buildtools"
$version="1.19.4"
$java=$env:JAVA_HOME

if ( $args.count -eq 0 ) {
Set-Location ($basedir.Path+"\server")
& $java\bin\java.exe -jar (".\spigot-"+$version+".jar") --nogui
}
elseif ($args[0] -eq "background") {
$serverProcess = New-Object System.Diagnostics.ProcessStartInfo;
$serverProcess.FileName = ($java + "\bin\java.exe"); #process file
$serverProcess.Arguments = ("-jar " + $basedir.Path + "\server\spigot-"+$version+".jar --nogui");
$serverProcess.WorkingDirectory = ($basedir.Path+"\server");
$serverProcess.UseShellExecute = $false; #start the process from it's own executable file
$serverProcess.RedirectStandardInput = $true; #enable the process to read from standard input

$p = [System.Diagnostics.Process]::Start($serverProcess);

Start-Sleep -s 50 #wait 2 seconds so that the process can be up and running

$p.StandardInput.WriteLine("stop"); #StandardInput property of the Process is a .NET StreamWriter object

}


Set-Location $basedir