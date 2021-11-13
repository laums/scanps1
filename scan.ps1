

[CmdletBinding()]
param(
  [string]$baseUri = 'https://raw.githubusercontent.com/laums/scanps1/main',
  [string]$scanFolder = "$env:HOMEDRIVE\scan",
  [string]$programFolder = "${Env:ProgramFiles(x86)}\AitecScan",
  [string]$ftpUsername = 'scan',
  [string]$ftpPassword = 'scan',
  [string]$allowIP = ''
)

# Config client
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$wc = New-Object -TypeName System.Net.WebClient
$fileList = @('SlimFTPd.exe', 'slimftpd.conf', 'trim-log.cmd', 'ServiceTool.exe')
$extrasList = @('desktop.ini')

# Creating Folders
New-Item -Path $scanFolder -ItemType directory

New-Item -Path $programFolder -ItemType directory

#Download files
($fileList+$extrasList) | ForEach-Object {
    Remove-Item -Path ('{0}/{1}' -f $scanFolder, $_)
    $wc.DownloadFile(('{0}/{1}' -f $baseUri, $_), ('{0}/{1}' -f $scanFolder, $_))
}

# Update config
$config = Get-Content -Path ('{0}\slimftpd.conf' -f $scanFolder).replace('scanFolder',$scanFolder).replace('ftpUsername',$ftpUsername).replace('ftpPassword',$ftpPassword)
Set-Content -Path ('{0}\slimftpd.conf' -f $scanFolder) -Value $config
$config= Get-Content -Path ('{0}\trim-log.cmd' -f $scanFolder).replace('programFolder',$programFolder)
Set-Content -Path ('{0}\trim-log.cmd' -f $scanFolder) -Value $config

#Copying Program Files
$fileList | ForEach-Object { Move-Item -Path ('{0}/{1}' -f $scanFolder, $_) }

#Create Shortcut
$wshshell = New-Object -ComObject WScript.Shell
$lnk = $wshshell.CreateShortcut(('{0}\Scan.lnk' -f [Environment]::GetFolderPath('Desktop')))
$lnk.TargetPath = $scanFolder
$lnk.Save() 
