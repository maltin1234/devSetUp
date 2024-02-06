#Variables and paths 
$desktopPath = [Environment]::GetFolderPath('Desktop')





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
choco install virtualbox
choco install corretto17jdk -y

#Install nvm and npm
# Construct the full path to the script
$scriptPath = Join-Path -Path $desktopPath -ChildPath 'DevSetup\InstallNvmAndNode.ps1'

# Run the script from the desktop
Invoke-Expression -Command $scriptPath

#Install pyenv-win
Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/pyenv-win/pyenv-win/master/pyenv-win/install-pyenv-win.ps1" -OutFile "./install-pyenv-win.ps1"; &"./install-pyenv-win.ps1"
Write-Host "To install Python using pyenv-win, you can follow the instructions on the pyenv-win GitHub repository:"
Write-Host "https://github.com/pyenv-win/pyenv-win"
