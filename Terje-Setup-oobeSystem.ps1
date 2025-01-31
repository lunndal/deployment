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


#
# USAGE
# Run this script during the "oobeSystem" phase from autounattend.xml
# Commands will run in the context of the first admin user created, 
# when the installer automatically logs the user in.
# 

#
# ISSUES
# - Mouse pad does not seem to work.
#   ? Do we need a reboot after this?

#
# Declarations
#
$logFile = "C:\Windows\Temp\Setup-oobeSystem.log"

# Enable logging.
Start-Transcript -Path $logFile -Append

#
# Windows settings.
#


#
# Install applications.
#

#
# ? Install Chrome extensions
# BROKEN - plugins do not appear!
#

$updateUrl = 'json { "update_url": "https://clients2.google.com/service/update2/crx" }'

# 1password
$regPath = "HKLM:\SOFTWARE\WOW6432Node\Google\Chrome\Extensions\aeblfdkhhhdcdjpifhhbdiojplfjncoa"
New-Item -Path $regPath -Force
Set-ItemProperty -Path $regPath -Name "update_url" -Value $updateUrl

# Dark Reader
$regPath = "HKLM:\SOFTWARE\WOW6432Node\Google\Chrome\Extensions\eimadpbcbfnmbkopoojfekhnkhdbieeh"
New-Item -Path $regPath -Force
Set-ItemProperty -Path $regPath -Name "update_url" -Value $updateUrl

#
# Application settings
#

# Git
git config --global user.email $myEmail
git config --global user.name $myName

# Stop logging.
Stop-Transcript