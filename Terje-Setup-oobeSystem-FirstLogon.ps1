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

# Source
# https://raw.githubusercontent.com/lunndal/deployment/refs/heads/main/Terje-Setup-oobeSystem-FirstLogon.ps1

#
# USAGE
# Run this script during the "oobeSystem" phase, under the FirstLogonCommands section, of autounattend.xml
# Commands will run only once in the context of the logged in user.
# 

#
# ISSUES
# 

#
# Declarations
#
$logFile = "C:\Windows\Temp\Setup-oobeSystem-FirstLogon-$($env:USERNAME).log"

W Enable logging.
Start-Transcript -Path $logFile #-Append
Write-Output "Starting script in oobeSystem FirstLogon phase."

#
# Windows settings.
#
 

#
# Install applications.
#

# Spotify through winget
winget install spotify.spotify --disable-interactivity --accept-package-agreements --accept-source-agreements --silent

#
# Install Chrome extensions

#
# Application settings
#

# Git 
git config --global user.email $myEmail
git config --global user.name $myName

# Stop logging.
Stop-Transcript