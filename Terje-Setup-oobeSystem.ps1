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
# https://raw.githubusercontent.com/lunndal/deployment/refs/heads/main/Terje-Setup-oobeSystem.ps1

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
Write-Output "Starting script in oobeSystem phase."

#
# Debug handling.
#
#Start-Process powershell -ArgumentList "-NoExit -Command `"Write-Host 'DEBUG-START oobeSystem phase. Exit shell when done debugging.'`"" -Wait -WindowStyle Normal


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


#Start-Process powershell -ArgumentList "-NoExit -Command `"Write-Host 'DEBUG-END oobeSystem phase. Exit shell when done debugging.'`"" -Wait -WindowStyle Normal

# Stop logging.
Stop-Transcript