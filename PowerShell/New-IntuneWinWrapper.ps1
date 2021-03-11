#Loops through C:\Temp\SrcDir\[AppDir] for Win32 App source files, then converts to a .intunewin file
Set-Location -Path C:\Temp\Microsoft-Win32-Content-Prep-Tool
$ExeDir = Get-ChildItem SrcDir

$ExeDir | ForEach-Object {
    $ExeFile = Get-ChildItem -Path "SrcDir\$_"

    Write-Host "Wrapping $ExeFile >>" -ForegroundColor Green
    .\IntuneWinAppUtil.exe -c "SrcDir\$_" -s $ExeFile -o DstDir
}