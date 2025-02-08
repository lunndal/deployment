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

###################################################################################################
#                                                                                                 #
#  FirstLogon for NEW users, except for the first admin account defined in the autounattend.xml.  #
#                                                                                                 #
###################################################################################################


# Source
# https://raw.githubusercontent.com/lunndal/deployment/refs/heads/??????????????????????????????????????????

#
# USAGE
# Script runs when a user logs in for the first time. Commands will run only once in the context of the logged in user.
# NOTE . Needs to run the FirstLogon-Common script first!
#
# User specific settings go in this file.
#
# NOTE
# At this stage the Private Git repo is already cloned to local disk.
# 

#
# ISSUES
# 

#
# Declarations
#
$logFile = "C:\Windows\Temp\Setup-oobeSystem-NewUsers-$($env:USERNAME).log"


# Enable logging.
Start-Transcript -Path $logFile #-Append
Write-Output "Starting script in NewUser FirstLogon phase (Runs when a new user logs in, but not for the first defined admin)"

#
# Debug handling.
#
#Start-Process powershell -ArgumentList "-NoExit -Command `"Write-Host 'DEBUG-START oobeSystem-FirstLogon phase. Exit shell when done debugging.'`"" -Wait -WindowStyle Normal

#
# Run the common FirstLogon script (shared by ALL users, including the first defined admin)
#


#
# Windows settings.
#
 

#
# Install applications.
#


#
# Install Chrome extensions
#

#
# Windows settings
#

# Pin taskbar icons.
$pinTaskbarUrl = "https://raw.githubusercontent.com/lunndal/deployment/refs/heads/main/Windows/Pin-TaskbarIcons.ps1"
Invoke-Expression (Invoke-WebRequest -UseBasicParsing -Headers @{"Cache-Control"="no-cache"} $pinTaskbarUrl).content -Verbose

# Hide language bar.
Set-ItemProperty -Path "HKCU:\Software\Microsoft\CTF\LangBar" -Name "ShowStatus" -Value 3 -Type DWord

# Disable sticky keys
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name "Flags" -Value 506 -Type String

# Display full path in title bar in Explorer
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" -Name "FullPath" -Value 1 -Type DWord

# Enable compact view in Explorer
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "UseCompactMode" -Value 1 -Type DWord

# Detailed view in Explorer
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Views" -Value 2 -Type DWord

# Disable fun facts on the lock screen
Set-ItemProperty -Path "HKCU:\Control Panel\Personalization" -Name "LockScreenFunFactsEnabled" -Value 0

# 
# Browser settings
#

<# 
# Edge
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Edge" -Name "HideFirstRunExperience" -Value 1 -Type DWord

# Chrome
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "PrivacySandboxPromptEnabled" -Value 0 -Type DWord
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "PrivacySandboxAdMeasurementEnabled" -Value 0 -Type DWord
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "PrivacySandboxAdTopicsEnabled" -Value 0 -Type DWord
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "PrivacySandboxSiteEnabledAdsEnabled" -Value 0 -Type DWord
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "DefaultNotificationsSetting" -Value 2 -Type DWord
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "BookmarkBarEnabled" -Value 1 -Type DWord
 #>

# Edge
#
# [{"keyword":"google","is_default":true,"name":"google.com","search_url":"https://www.google.com/search?q={searchTerms}"}]
reg add "$($extKey)\$($1password)"      /f /v "update_url" /t REG_SZ /d "$updateService"



New-Item -Path "HKCU:\Software\Policies\Microsoft\Edge" -Force -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Edge" -Name "NewTabPage" -Value "about:blank"
Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Edge" -Name "HomepageLocation" -Value "about:blank"
Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Edge" -Name "RestoreOnStartup" -Value 1

# Chrome
#
New-Item -Path "HKCU:\SOFTWARE\Policies\Google\Chrome" -Force -ErrorAction SilentlyContinue
New-Item -Path "HKCU:\SOFTWARE\Policies\Google\Chrome\RestoreOnStartupURLs" -Force -ErrorAction SilentlyContinue
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Policies\Google\Chrome' -Name 'HomepageLocation' -Value 'about:blank'
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Policies\Google\Chrome' -Name 'HomepageIsNewTabPage' -Value 0
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Policies\Google\Chrome' -Name 'RestoreOnStartup' -Value 4
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Policies\Google\Chrome\RestoreOnStartupURLs' -Name '1' -Value 'about:blank'

# Firefox
New-Item -Path "HKCU:\Software\Policies\Mozilla\Firefox" -Force -ErrorAction SilentlyContinue
New-Item -Path "HKCU:\Software\Policies\Mozilla\Firefox\Homepage" -Force -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKCU:\Software\Policies\Mozilla\Firefox" -Name "ShowHomeButton" -Value 1
Set-ItemProperty -Path "HKCU:\Software\Policies\Mozilla\Firefox\Homepage" -Name "URL" -Value "about:blank"
Set-ItemProperty -Path "HKCU:\Software\Policies\Mozilla\Firefox\Homepage" -Name "StartPage" -Value "homepage"
Set-ItemProperty -Path "HKCU:\Software\Policies\Mozilla\Firefox\Homepage" -Name "Locked" -Value 0

#
# Browser extensions
#

$updateService  = "https://clients2.google.com/service/update2/crx"

# Extension IDs
$1password      = "aeblfdkhhhdcdjpifhhbdiojplfjncoa"
$adblockplus    = "cfhdojbkjhnklbpkdaibdccddilifddb"
$consentomatic  = "mdjildafknihdffpkfmmpnpoiajfjnjd"
$darkreader     = "eimadpbcbfnmbkopoojfekhnkhdbieeh"

# Registry keys to create extension references in.
$edgeExtKey = "HKLM\Software\Wow6432Node\Microsoft\Edge\Extensions"
$chromeExtKey = "HKLM\Software\Wow6432Node\Google\Chrome\Extensions"

foreach ($extKey in ($chromeExtKey, $edgeExtKey) ) {
    Write-Output $extKey
    reg add "$($extKey)\$($1password)"      /f /v "update_url" /t REG_SZ /d "$updateService"
    reg add "$($extKey)\$($adblockplus)"    /f /v "update_url" /t REG_SZ /d "$updateService"
    reg add "$($extKey)\$($consentomatic)"  /f /v "update_url" /t REG_SZ /d "$updateService"
    reg add "$($extKey)\$($darkreader)"     /f /v "update_url" /t REG_SZ /d "$updateService"
}    


#
# Application settings
#

# Git 
if ( $Env:UserName -eq $mySamAccountName ) {
    git config --global user.email $myEmail
    git config --global user.name $myName
}

# PowerToys
# %USERPROFILE%\AppData\Local\Microsoft

#Start-Process powershell -ArgumentList "-NoExit -Command `"Write-Host 'DEBUG-END oobeSystem-FirstLogon phase. Exit shell when done debugging.'`"" -Wait -WindowStyle Normal

# Stop logging.
Stop-Transcript