$Packages = 'googlechrome', 'geforce-experience', 'steam', 'origin', 'git', 'keepass', 'discord', 'vscode', 'python3', 'eclipse', 'openjdk8', 'hwmonitor', 'racket'

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
