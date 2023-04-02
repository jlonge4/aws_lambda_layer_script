$lib = 'requests'

# Create folder
New-Item -ItemType Directory -Force -Path ".\folder"

# Change directory
Set-Location -Path ".\folder"

# Create virtualenv and activate it
python -m venv v-env
.\v-env\Scripts\activate

# Install dependencies
foreach($dep in $lib) {
    Write-Host "Installing $dep"
    pip install $dep
}

# Deactivate virtualenv
deactivate

# Create target directory
New-Item -ItemType Directory -Force -Path ".\python"

# Copy dependencies from virtualenv to target directory
Copy-Item -Path ".\v-env\Lib\site-packages\*" -Destination ".\python\" -Recurse

# Zip files
Compress-Archive -Path ".\python\" -DestinationPath "requests.zip" -Force

Remove-Item -Recurse -Force ".\python"   
Remove-Item -Recurse -Force ".\v-env" 