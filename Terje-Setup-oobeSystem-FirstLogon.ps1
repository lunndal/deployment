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

# Enable logging.
Start-Transcript -Path $logFile #-Append
Write-Output "Starting script in oobeSystem FirstLogon phase."

#
# Debug handling.
#
#Start-Process powershell -ArgumentList "-NoExit -Command `"Write-Host 'DEBUG-START oobeSystem-FirstLogon phase. Exit shell when done debugging.'`"" -Wait -WindowStyle Normal

#
# Windows settings.
#
 

#
# Install applications.
#

#
# Install Chrome extensions

#
# Application settings
#


#Start-Process powershell -ArgumentList "-NoExit -Command `"Write-Host 'DEBUG-END oobeSystem-FirstLogon phase. Exit shell when done debugging.'`"" -Wait -WindowStyle Normal

# Stop logging.
Stop-Transcript