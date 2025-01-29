Start-Transcript -Path "C:\Windows\Temp\terje-setup.log" -Append
[console]::beep(500,300)
Read-Host -Prompt "Press Enter to view network config"
Start-Process ipconfig -Wait -NoNewWindow
Read-Host -Prompt "Press Enter to ping vg.no"
Start-Process ping -ArgumentList "vg.no"  -Wait -NoNewWindow
Read-Host -Prompt "Press Enter to set execution policy to Bypass|"
Set-ExecutionPolicy -ExecutionPolicy Bypass -Force -Scope Process -Verbose
Read-Host -Prompt "Press Enter to set variable scriptURL"
$scriptUrl = "https://raw.githubusercontent.com/lunndal/deployment/refs/heads/main/Terje-Setup.ps1"
Read-Host -Prompt "scriptUrl set to $scriptUrl - Press Enter to install packages..."
Invoke-Expression (Invoke-WebRequest -UseBasicParsing $scriptUrl).content -Verbose
Read-Host -Prompt "Packages installed - Press Enter to continue..."
Stop-Transcript

# iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
