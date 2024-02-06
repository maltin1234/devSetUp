# InstallVSCode.ps1

# Get the desktop path
$desktopPath = [Environment]::GetFolderPath('Desktop')

# Specify the "Tools" folder path
$toolsFolder = Join-Path -Path $desktopPath -ChildPath 'Tools'

# Create the "Tools" folder on the desktop if it doesn't exist
if (-not (Test-Path $toolsFolder)) {
    New-Item -ItemType Directory -Path $toolsFolder | Out-Null
}

# Install Visual Studio Code using Chocolatey
choco install vscode -y

# Move the Visual Studio Code installation to the "Tools" folder
Move-Item "$env:ProgramFiles\Microsoft VS Code" -Destination $toolsFolder -Force

Write-Host "Visual Studio Code installed successfully in the 'Tools' folder on the desktop."