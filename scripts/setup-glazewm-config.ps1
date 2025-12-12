# Setup GlazeWM configuration
# This script checks if the GlazeWM config exists and copies it if it doesn't

$targetPath = Join-Path $env:USERPROFILE ".glzr\glazewm\config.yaml"
$sourcePath = Join-Path $PSScriptRoot "resources\config.yaml"

# Check if the target config file already exists
if (Test-Path $targetPath) {
    Write-Host "GlazeWM config already exists at: $targetPath" -ForegroundColor Green
    exit 0
}

# Check if the source config file exists
if (-not (Test-Path $sourcePath)) {
    Write-Host "Error: Source config file not found at: $sourcePath" -ForegroundColor Red
    exit 1
}

# Create the target directory if it doesn't exist
$targetDir = Split-Path $targetPath -Parent
if (-not (Test-Path $targetDir)) {
    Write-Host "Creating directory: $targetDir" -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
}

# Copy the config file
try {
    Copy-Item -Path $sourcePath -Destination $targetPath -Force
    Write-Host "Successfully copied GlazeWM config to: $targetPath" -ForegroundColor Green
} catch {
    Write-Host "Error copying config file: $_" -ForegroundColor Red
    exit 1
}
