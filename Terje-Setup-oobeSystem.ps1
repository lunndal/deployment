<#

    ██     ██  █████  ██████  ███    ██ ██ ███    ██  ██████  ██ 
    ██     ██ ██   ██ ██   ██ ████   ██ ██ ████   ██ ██       ██ 
    ██  █  ██ ███████ ██████  ██ ██  ██ ██ ██ ██  ██ ██   ███ ██ 
    ██ ███ ██ ██   ██ ██   ██ ██  ██ ██ ██ ██  ██ ██ ██    ██    
     ███ ███  ██   ██ ██   ██ ██   ████ ██ ██   ████  ██████  ██ 

      -------------------------------------------------------
      This script is public and should NEVER contain secrets!
      -------------------------------------------------------
#>

param (
    $Token = "NOT_SET"
)


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

"CUSTOM INSTALL STEPS - DO NOT CLOSE THIS WINDOW!" | Out-Host

#
# Install applications.
#

# chocolatey (in admin context)
"Installing chocolatey" | Out-Host
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco feature enable -n allowGlobalConfirmation

# Choco applications.  
"Installing choco apps" | Out-Host
foreach ($package in $chocoApps) {
    "`tInstalling choco package $($package)" | Out-Host
    $chocoLog = "$($logDir)\Terje-Setup-Audit-$($env:USERNAME)-CHOCO-$($package).log"
    choco install $package --no-progress --yes --no-color --limit-output --ignore-detected-reboot --accept-license 
}

#
# Cleanup after choco installs.
#

# Close PowerToys welcome screen.
"Killing PowerToys welcome screen" | Out-Host
Get-Process | Where-Object { $_.MainWindowTitle -match "powertoys" } |  Select-Object Id, ProcessName, MainWindowTitle | Stop-Process
# ProtonVPN
# Greenshot

# onthespot
"Installing onthespot portable" | Out-Host
$installDir = (Join-Path $env:ProgramFiles "onthespot")
New-Item -ItemType Directory -Path $installDir
Invoke-WebRequest -Uri "https://github.com/casualsnek/onthespot/releases/latest/download/onthespot_win_ffm.exe" -OutFile "$($installDir)\onthespot_win_ffm.exe"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/lunndal/onthespot-cachefix/refs/heads/main/Start-OnTheSpot.ps1" -OutFile "$($installDir)\Start-OnTheSpot.ps1" 
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/lunndal/onthespot-cachefix/refs/heads/main/Start-OnTheSpot.ps1.lnk" -OutFile "$($installDir)\Start-OnTheSpot.ps1.lnk" 

# Clone private repo
"Cloning private repo with token $($Token)" | Out-Host
& "C:\Program Files\Git\cmd\git.exe" clone "https://$($Token)@github.com/lunndal/Private.git" "C:\Users\Terje\src\Private"


# DEBUG END
#Start-Process powershell -ArgumentList "-NoExit -Command `"Write-Host 'DEBUG-END Audit phase. Exit shell when done debugging.'`"" -Wait -WindowStyle Normal

