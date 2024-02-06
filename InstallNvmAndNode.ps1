# InstallNvmAndNode.ps1

# Check if NVM is already installed
if (-not (Test-Path $env:USERPROFILE\.nvm)) {
    # NVM is not installed, proceed with installation

    # Install NVM using Chocolatey
    choco install nvm -y

    # Restart the terminal
    Stop-Process -Name powershell -Force

    # Wait for the terminal to restart
    Start-Sleep -Seconds 5
}

# Use NVM to install Node.js version 14
nvm install 14

# Use NVM to install the latest stable Node.js version
nvm install latest

# Set the default Node.js version
nvm use 14

# Display Node.js versions
nvm list
