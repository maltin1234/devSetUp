#Variables and paths 
$desktopPath = [Environment]::GetFolderPath('Desktop')
$virtualboxInstalled = choco list --local-only virtualbox | Select-String -Pattern "VirtualBox"
$correttoInstalled = choco list --local-only corretto17jdk | Select-String -Pattern "Corretto 17 JDK"





    # Create the new folder on the desktop
    $projectTypes = @('PythonProjects', 'JavaProjects', 'GameProjects', 'ScrapingProjects', 'WebProjects', 'IOTProjects', 'Tools')

foreach ($projectType in $projectTypes) {
    $newFolderPath = Join-Path -Path $desktopPath -ChildPath $projectType

    if (-not (Test-Path $newFolderPath)) {
        New-Item -ItemType Directory -Path $newFolderPath
        Write-Host "Folder '$projectType' created successfully on the desktop."
    } else {
        Write-Host "Folder '$projectType' already exists on the desktop. Skipping creation."
    }
}
# Check if Chocolatey is installed
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Chocolatey is not installed. Installing Chocolatey..."
    
    # Install Chocolatey
    Set-ExecutionPolicy Bypass -Scope Process -Force
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    
    # Verify installation
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey installation failed. Exiting script."
        exit 1
    }
    
    Write-Host "Chocolatey installed successfully."
} else {
    Write-Host "Chocolatey is already installed."
}

#choco installations


# if ($correttoInstalled) {
#     Write-Output "Corretto 17 JDK is installed."
# } else {
#     Write-Output "Corretto 17 JDK is not installed."
#     choco install corretto17jdk -y
# }

# # Update the $virtualboxInstalled variable after potentially installing Corretto 17 JDK
# $virtualboxInstalled = choco list --local-only virtualbox | Select-String -Pattern "VirtualBox"

# if ($virtualboxInstalled -and $correttoInstalled) {
#     Write-Output "VirtualBox is installed."
# } else {
#     Write-Output "VirtualBox is not installed."
#     choco install virtualbox
# }


#Install pyenv-win
Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/pyenv-win/pyenv-win/master/pyenv-win/install-pyenv-win.ps1" -OutFile "./install-pyenv-win.ps1"; &"./install-pyenv-win.ps1"
Write-Host "To install Python using pyenv-win, you can follow the instructions on the pyenv-win GitHub repository:"
Write-Host "https://github.com/pyenv-win/pyenv-win"

#InstallToolsFolder.ps1
cd "$([Environment]::GetFolderPath([Environment+SpecialFolder]::Desktop))\devSetUp"
.\installToolsFolder.ps1
#InstallNvmAndNode.ps1
cd "$([Environment]::GetFolderPath([Environment+SpecialFolder]::Desktop))\devSetUp"
.\installNvmAndNode.ps1



