Set-ExecutionPolicy Bypass
$scriptUrl = "https://raw.githubusercontent.com/lunndal/deployment/refs/heads/main/Terje-Setup.ps1"
iex (iwr $scriptUrl).content
Set-ExecutionPolicy RemoteSigned