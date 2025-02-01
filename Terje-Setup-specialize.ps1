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
# Commands will run in system context before any users are created.
# 

#
# ISSUES
# ? Execution Policy er ikke liberal nok når dette skriptet skal kjøres.
# ? WiFi var ikke påkoblet. Måtte gjøres manuelt. 

#
# Declarations
#
$logFile = "C:\Windows\Temp\Setup-specialize.log"


# Enable logging.
Start-Transcript -Path $logFile -Append
Write-Output "Starting script in specialize phase."

#
# Debug handling.
#
#Start-Process powershell -ArgumentList "-NoExit -Command `"Write-Host 'DEBUG-START specialize phase. Exit shell when done debugging.'`"" -Wait -WindowStyle Normal

#
# Windows settings.
#


#
# Install Chrome extensions
#


#
# Global application settings
#

#Start-Process powershell -ArgumentList "-NoExit -Command `"Write-Host 'DEBUG-END specialize phase. Exit shell when done debugging.'`"" -Wait -WindowStyle Normal

# Stop logging.
Stop-Transcript