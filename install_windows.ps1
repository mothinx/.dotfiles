$Packages = 'googlechrome', 'geforce-experience', 'google-drive-file-stream', 'keepassxc', 'steam', 'git', 'discord', 'vscode', 'python3', 'openjdk8', 'hwmonitor', 'intellijidea' 

Function installPackages($Packages) {
    ForEach ($PackageName in $Packages)
    {
        choco install $PackageName -y
    }
}

If(Test-Path -Path "$env:ProgramData\Chocolatey") {
    installPackages($Packages);
} else {
    Set-ExecutionPolicy Bypass -Scope Process -Force; `
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    installPackages($Packages);
}
