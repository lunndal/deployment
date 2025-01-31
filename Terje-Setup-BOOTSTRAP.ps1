Start-Process powershell -ArgumentList "-NoExit -Command `"
    $url = 'https://raw.githubusercontent.com/lunndal/deployment/refs/heads/main/Terje-Setup-oobeSystem-FirstLogon.ps1'; 
    $scriptPath = Join-Path $env:TEMP 'script.ps1'; 
    Invoke-WebRequest -Uri $url -OutFile $scriptPath; 
    . $scriptPath`"" -Wait


$scriptUrl = "https://raw.githubusercontent.com/lunndal/deployment/refs/heads/main/Terje-Setup-oobeSystem-FirstLogon.ps1"
Invoke-Expression (Invoke-WebRequest -UseBasicParsing -Headers @{"Cache-Control"="no-cache"} $scriptUrl).content -Verbose


Start-Process powershell -Wait -ArgumentList "-NoExit -Command `"Set-Variable -Name 'scriptUrl' -Value 'https://raw.githubusercontent.com/lunndal/deployment/refs/heads/main/Terje-Setup-oobeSystem-FirstLogon.ps1'; Invoke-Expression (Invoke-WebRequest -UseBasicParsing -Headers @{'Cache-Control'='no-cache'} $scriptUrl).content -Verbose`""


Start-Process powershell -Wait -ArgumentList "-NoExit -Command `"Write-Output 'balle'; write-output 'nalle'`""

Start-Process powershell -Wait -ArgumentList "-NoExit -Command `"{$scriptUrl = 'https://raw.githubusercontent.com/lunndal/deployment/refs/heads/main/Terje-Setup-oobeSystem-FirstLogon.ps1'}`""













<#
Start-Transcript -Path "C:\Windows\Temp\terje-setup.log" -Append
[console]::beep(500,300)
Read-Host -Prompt "Press Enter to view network config"
Start-Process ipconfig -Wait -NoNewWindow
Read-Host -Prompt "Press Enter to ping vg.no"
Start-Process ping -ArgumentList "vg.no"  -Wait -NoNewWindow
Read-Host -Prompt "Press Enter to set execution policy to Bypass"
Set-ExecutionPolicy -ExecutionPolicy Bypass -Force -Scope Process -Verbose
Read-Host -Prompt "Press Enter to set variable scriptURL"
$scriptUrl = "https://raw.githubusercontent.com/lunndal/deployment/refs/heads/main/Terje-Setup.ps1"
Read-Host -Prompt "scriptUrl set to $scriptUrl - Press Enter to install packages..."
Invoke-Expression (Invoke-WebRequest -UseBasicParsing $scriptUrl).content -Verbose
Read-Host -Prompt "Packages installed - Press Enter to continue..."
Stop-Transcript
#>

# iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
# https://schneegans.de/windows/unattend-generator/?LanguageMode=Unattended&UILanguage=en-US&Locale=nb-NO&Keyboard=00000414&GeoLocation=177&ProcessorArchitecture=amd64&BypassRequirementsCheck=true&ComputerNameMode=Custom&ComputerName=new-host&CompactOsMode=Never&TimeZoneMode=Implicit&PartitionMode=Unattended&PartitionLayout=GPT&EspSize=300&RecoveryMode=Partition&RecoverySize=1000&WindowsEditionMode=Generic&WindowsEdition=pro&UserAccountMode=Unattended&AccountName0=Admin&AccountDisplayName0=&AccountPassword0=&AccountGroup0=Administrators&AccountName1=Terje&AccountDisplayName1=&AccountPassword1=&AccountGroup1=Administrators&AccountName2=&AccountName3=&AccountName4=&AutoLogonMode=Own&PasswordExpirationMode=Unlimited&LockoutMode=Default&HideFiles=HiddenSystem&ShowFileExtensions=true&ClassicContextMenu=true&TaskbarSearch=Hide&TaskbarIconsMode=Empty&DisableWidgets=true&HideTaskViewButton=true&DisableBingResults=true&StartTilesMode=Empty&StartPinsMode=Empty&EnableLongPaths=true&EnableRemoteDesktop=true&AllowPowerShellScripts=true&DisableLastAccess=true&TurnOffSystemSounds=true&DisableAppSuggestions=true&HideEdgeFre=true&DeleteWindowsOld=true&EffectsMode=Custom&DragFullWindows=true&FontSmoothing=true&DesktopIconsMode=Default&WifiMode=Unattended&WifiName=evilAir&WifiNonBroadcast=true&WifiAuthentication=WPA2PSK&WifiPassword=00000000&ExpressSettings=DisableAll&KeysMode=Skip&ColorMode=Default&WallpaperMode=Solid&WallpaperColor=%23000000&Remove3DViewer=true&RemoveBingSearch=true&RemoveClipchamp=true&RemoveClock=true&RemoveCopilot=true&RemoveCortana=true&RemoveDevHome=true&RemoveFamily=true&RemoveFeedbackHub=true&RemoveGetHelp=true&RemoveHandwriting=true&RemoveInternetExplorer=true&RemoveMailCalendar=true&RemoveMaps=true&RemoveMathInputPanel=true&RemoveMediaFeatures=true&RemoveMixedReality=true&RemoveZuneVideo=true&RemoveNews=true&RemoveOffice365=true&RemoveOneNote=true&RemoveOneSync=true&RemoveOutlook=true&RemovePaint=true&RemovePaint3D=true&RemovePeople=true&RemovePhotos=true&RemovePowerAutomate=true&RemovePowerShell2=true&RemovePowerShellISE=true&RemoveQuickAssist=true&RemoveRecall=true&RemoveSkype=true&RemoveSolitaire=true&RemoveSpeech=true&RemoveStepsRecorder=true&RemoveStickyNotes=true&RemoveTeams=true&RemoveGetStarted=true&RemoveToDo=true&RemoveVoiceRecorder=true&RemoveWallet=true&RemoveWeather=true&RemoveFaxAndScan=true&RemoveWindowsMediaPlayer=true&RemoveZuneMusic=true&RemoveWordPad=true&RemoveXboxApps=true&RemoveYourPhone=true&SystemScript0=Start-Transcript+-Path+%22C%3A%5CWindows%5CTemp%5Cterje-setup.log%22+-Append%0D%0A%5Bconsole%5D%3A%3Abeep%28500%2C300%29%0D%0ARead-Host+-Prompt+%22Press+Enter+to+view+network+config%22%0D%0AStart-Process+ipconfig+-Wait+-NoNewWindow%0D%0ARead-Host+-Prompt+%22Press+Enter+to+ping+vg.no%22%0D%0AStart-Process+ping+-ArgumentList+%22vg.no%22++-Wait+-NoNewWindow%0D%0ARead-Host+-Prompt+%22Press+Enter+to+set+execution+policy+to+Bypass%22%0D%0ASet-ExecutionPolicy+-ExecutionPolicy+Bypass+-Force+-Scope+Process+-Verbose%0D%0ARead-Host+-Prompt+%22Press+Enter+to+set+variable+scriptURL%22%0D%0A%24scriptUrl+%3D+%22https%3A%2F%2Fraw.githubusercontent.com%2Flunndal%2Fdeployment%2Frefs%2Fheads%2Fmain%2FTerje-Setup.ps1%22%0D%0ARead-Host+-Prompt+%22scriptUrl+set+to+%24scriptUrl+-+Press+Enter+to+install+packages...%22%0D%0AInvoke-Expression+%28Invoke-WebRequest+-UseBasicParsing+%24scriptUrl%29.content+-Verbose%0D%0ARead-Host+-Prompt+%22Packages+installed+-+Press+Enter+to+continue...%22%0D%0AStop-Transcript&SystemScriptType0=Ps1&WdacMode=Skip