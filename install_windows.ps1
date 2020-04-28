@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

$Packages = 'googlechrome', 'geforce-experience', 'steam', 'origin', 'git', 'keepass', 'discord', 'vscode', 'python3', 'eclipse', 'openjdk8', 'hwmonitor', 'racket'

ForEach ($PackageName in $Packages)
{
    choco install $PackageName -y
}