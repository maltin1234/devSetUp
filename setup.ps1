# Variables and paths
$desktopPath = [Environment]::GetFolderPath('Desktop')

# Create project folders
$projectTypes = @('PythonProjects', 'JavaProjects', 'GameProjects', 'ScrapingProjects', 'WebProjects', 'IOTProjects', 'Tools')

foreach ($projectType in $projectTypes) {
    $newFolderPath = Join-Path -Path $desktopPath -ChildPath $projectType

    try {
        if (-not (Test-Path $newFolderPath)) {
            New-Item -ItemType Directory -Path $newFolderPath
            Write-Host "Folder '$projectType' created successfully on the desktop."
        } else {
            Write-Host "Folder '$projectType' already exists on the desktop. Skipping creation."
        }
    }
    catch {
        Write-Host "Error creating folder '$projectType': $_"
    }
}

# Check if Chocolatey is installed
try {
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is not installed. Installing Chocolatey..."

        # Install Chocolatey
        Set-ExecutionPolicy Bypass -Scope Process -Force
        iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

        # Verify installation
        if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
            throw "Chocolatey installation failed."
        }

        Write-Host "Chocolatey installed successfully."
    } else {
        Write-Host "Chocolatey is already installed."
    }
}
catch {
    Write-Host "Error installing Chocolatey: $_"
}

# Install pyenv-win
try {
    Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/pyenv-win/pyenv-win/master/pyenv-win/install-pyenv-win.ps1" -OutFile "./install-pyenv-win.ps1"; &"./install-pyenv-win.ps1"
    Write-Host "To install Python using pyenv-win, you can follow the instructions on the pyenv-win GitHub repository:"
    Write-Host "https://github.com/pyenv-win/pyenv-win"
}
catch {
    Write-Host "Error installing pyenv-win: $_"
}

# Install Tools folder
try {
    cd "$([Environment]::GetFolderPath([Environment+SpecialFolder]::Desktop))\devSetUp"
    .\installToolsFolder.ps1
}
catch {
    Write-Host "Error installing Tools folder: $_"
}

# Run installNvmAndNode.ps1 as admin
try {
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command cd '$([Environment]::GetFolderPath('Desktop'))\devSetUp'; Start-Process powershell.exe -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File installNvmAndNode.ps1' -Verb RunAs" -Verb RunAs
}
catch {
    Write-Host "Error running installNvmAndNode.ps1 as admin: $_"
}
