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
# https://raw.githubusercontent.com/lunndal/deployment/refs/heads/main/Terje-Setup-specialize.ps1


#
# USAGE
# Run this script during the "specialize" phase from autounattend.xml.
# Commands will run in system context before any users are created, so any user settings will apply to ALL users.
# 

#
# ISSUES
# ? Execution Policy er ikke liberal nok når dette skriptet skal kjøres.

#
# Declarations
#
$logDir = "C:\Windows\Setup\Scripts"
$logFile = "$($logDir)\Terje-Setup-specialize-$($env:USERNAME).log"



# Enable logging.
Start-Transcript -Path $logFile -Append
Write-Output "Starting script in specialize phase."

#
# Debug handling.
#
Start-Process powershell -ArgumentList "-NoExit -Command `"Write-Host 'DEBUG-START specialize phase. Exit shell when done debugging.'`"" -Wait -WindowStyle Normal

#
# Windows settings.
#


#
# Install Chrome extensions
#


#
# Global application settings
#

Start-Process powershell -ArgumentList "-NoExit -Command `"Write-Host 'DEBUG-END specialize phase. Exit shell when done debugging.'`"" -Wait -WindowStyle Normal

# Stop logging.
Stop-Transcript