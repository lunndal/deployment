param (
    [switch]
    $Restore = $false
)

# Settings
$settingsDir = Join-Path $($env:LOCALAPPDATA) "Microsoft\PowerToys"
$backupStore = Join-Path $PSScriptRoot "AppData.Local.Microsoft.PowerToys"

# Create backup
if ( ! $Restore ) {
    Copy-Item -Recurse -Include *.json -Path "$($settingsDir)\*" 
    # Copy-Item -Path $sourceDir -Destination  $targetDir -Recurse -Filter '*.py' -Force
}
# Restore backup
else {
    "actually restore"
}