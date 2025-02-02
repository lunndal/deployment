$taskbar_layout =
@"
<?xml version="1.0" encoding="utf-8"?>
<LayoutModificationTemplate
    xmlns="http://schemas.microsoft.com/Start/2014/LayoutModification"
    xmlns:defaultlayout="http://schemas.microsoft.com/Start/2014/FullDefaultLayout"
    xmlns:start="http://schemas.microsoft.com/Start/2014/StartLayout"
    xmlns:taskbar="http://schemas.microsoft.com/Start/2014/TaskbarLayout"
    Version="1">
  <CustomTaskbarLayoutCollection PinListPlacement="Replace">
    <defaultlayout:TaskbarLayout>
      <taskbar:TaskbarPinList>
        <taskbar:DesktopApp DesktopApplicationLinkPath="C:\Program Files\Proton\VPN\ProtonVPN.Launcher.exe" />
        <taskbar:DesktopApp DesktopApplicationLinkPath="C:\Program Files (x86)\Transmission Remote GUI\transgui.exe" />
        <taskbar:DesktopApp DesktopApplicationLinkPath="C:\Users\terje\AppData\Local\1Password\app\8\1Password.exe" />
        <taskbar:DesktopApp DesktopApplicationID="Microsoft.WindowsTerminal_8wekyb3d8bbwe!app" />
        <taskbar:DesktopApp DesktopApplicationLinkPath="C:\Program Files (x86)\Audacious\bin\audacious.exe" />
        <taskbar:DesktopApp DesktopApplicationID="SpotifyAB.SpotifyMusic_zpdnekdrzrea0!app" />
        <taskbar:DesktopApp DesktopApplicationLinkPath="C:\Program Files\Audacity\Audacity.exe" />
        <taskbar:DesktopApp DesktopApplicationLinkPath="C:\Program Files\paint.net\paintdotnet.exe" />
        <taskbar:DesktopApp DesktopApplicationLinkPath="C:\Program Files\Microsoft VS Code\Code.exe" />
        <taskbar:DesktopApp DesktopApplicationLinkPath="C:\Program Files\Notepad++\notepad++.exe" />
        <taskbar:DesktopApp DesktopApplicationLinkPath="C:\Program Files\Google\Chrome\Application\chrome.exe" />
      </taskbar:TaskbarPinList>
    </defaultlayout:TaskbarLayout>
 </CustomTaskbarLayoutCollection>
</LayoutModificationTemplate>
"@

# prepare provisioning folder
[System.IO.FileInfo]$provisioning = "$($env:ProgramData)\provisioning\tasbar_layout.xml"
if (!$provisioning.Directory.Exists) {
    $provisioning.Directory.Create()
}

$taskbar_layout | Out-File $provisioning.FullName -Encoding utf8

$settings = [PSCustomObject]@{
    Path  = "SOFTWARE\Policies\Microsoft\Windows\Explorer"
    Value = $provisioning.FullName
    Name  = "StartLayoutFile"
    Type  = [Microsoft.Win32.RegistryValueKind]::ExpandString
},
[PSCustomObject]@{
    Path  = "SOFTWARE\Policies\Microsoft\Windows\Explorer"
    Value = 1
    Name  = "LockedStartLayout"
} | group Path

foreach ($setting in $settings) {
    $registry = [Microsoft.Win32.Registry]::LocalMachine.OpenSubKey($setting.Name, $true)
    if ($null -eq $registry) {
        $registry = [Microsoft.Win32.Registry]::LocalMachine.CreateSubKey($setting.Name, $true)
    }
    $setting.Group | % {
        if (!$_.Type) {
            $registry.SetValue($_.name, $_.value)
        }
        else {
            $registry.SetValue($_.name, $_.value, $_.type)
        }
    }
    $registry.Dispose()
}