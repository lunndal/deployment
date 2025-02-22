
#
# Declarations
#

$logDir = "C:\Windows\Setup\Scripts"
$chocoApps = @(
    "notepadplusplus",
    "choco-cleaner",
    "choco-upgrade-all-at-startup",
    "1password", 
    "sysinternals",
    "pwsh",
    "git",
    "GoogleChrome",
    "putty",
    "7zip",
    "ffmpeg",
    "fsviewer",
    "logitech-camera-settings",
    "paint.net",
    "teamviewer",
    "transgui",
    "treesizefree",
    "vlc",
    "wireshark",
    "yt-dlp",
    "vscode",
    "Firefox",
    "audacious",
    "audacity",
    "asio4all",
    "greenshot",
    "powertoys",
    "protonvpn"
 )


# DEBUG START
#Start-Process powershell -ArgumentList "-NoExit -Command `"Write-Host 'DEBUG-START Audit phase. Exit shell when done debugging.'`"" -Wait -WindowStyle Normal


#
# Install applications.
#

# chocolatey (in admin context)
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco feature enable -n allowGlobalConfirmation

# Choco applications.  
foreach ($package in $chocoApps) {
    Write-Host "Installing choco package $($package) with params $($package)"
    $chocoLog = "$($logDir)\Terje-Setup-Audit-$($env:USERNAME)-CHOCO-$($package).log"
    choco install $package --no-progress --yes --no-color --limit-output --ignore-detected-reboot --accept-license 
}

#
# Cleanup after choco installs.
#

# Close PowerToys welcome screen.
Get-Process | Where-Object { $_.MainWindowTitle -match "powertoys" } |  Select-Object Id, ProcessName, MainWindowTitle | Stop-Process
# ProtonVPN
# Greenshot

# onthespot
$installDir = (Join-Path $env:ProgramFiles "onthespot")
New-Item -ItemType Directory -Path $installDir
Invoke-WebRequest -Uri "https://github.com/casualsnek/onthespot/releases/latest/download/onthespot_win_ffm.exe" -OutFile "$($installDir)\onthespot_win_ffm.exe"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/lunndal/onthespot-cachefix/refs/heads/main/Start-OnTheSpot.ps1" -OutFile "$($installDir)\Start-OnTheSpot.ps1" 
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/lunndal/onthespot-cachefix/refs/heads/main/Start-OnTheSpot.ps1.lnk" -OutFile "$($installDir)\Start-OnTheSpot.ps1.lnk" 

# DEBUG END
#Start-Process powershell -ArgumentList "-NoExit -Command `"Write-Host 'DEBUG-END Audit phase. Exit shell when done debugging.'`"" -Wait -WindowStyle Normal

