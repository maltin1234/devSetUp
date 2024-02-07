# InstallNvmAndNode.ps1
# Check the current execution policy
$currentExecutionPolicy = Get-ExecutionPolicy

# If the execution policy is Restricted, change it to AllSigned or Bypass -Scope Process
if ($currentExecutionPolicy -eq "Restricted") {
    Set-ExecutionPolicy AllSigned
    # Or use Set-ExecutionPolicy Bypass -Scope Process
}

# Run the command to install Chocolatey for admin
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Define the installation directory for NVM
$nvmInstallDir = "C:\Program Files\nvm"

# Check if NVM is already installed
if (-not (Test-Path $nvmInstallDir)) {
    try {
        # NVM is not installed, proceed with installation
        Write-Host "Installing NVM..."
        # Install NVM using Chocolatey
        choco install nvm -y
    }
    catch {
        Write-Host "Error: $_"
        exit 1
    }
}
else {
    Write-Host "NVM is already installed."
}

# Add NVM directory to the system's PATH environment variable
try {
    $currentPath = [Environment]::GetEnvironmentVariable("Path", "Machine")
    if ($currentPath -notlike "*$nvmInstallDir*") {
        [Environment]::SetEnvironmentVariable("Path", "$currentPath;$nvmInstallDir", "Machine")
        Write-Host "NVM directory added to PATH."
    } else {
        Write-Host "NVM directory already exists in PATH."
    }
}
catch {
    Write-Host "Error adding NVM directory to PATH: $_"
    exit 1
}


# Use NVM to install Node.js version 14
nvm install 14

# Use NVM to install the latest stable Node.js version
nvm install latest

# Set the default Node.js version
nvm use 14

# Display Node.js versions
nvm list
