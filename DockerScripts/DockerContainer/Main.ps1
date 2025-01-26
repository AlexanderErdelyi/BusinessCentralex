Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
Set-ExecutionPolicy Unrestricted -Scope CurrentUser

. .\Setup.ps1

# Check if the container exists
$containerExists = docker ps -a --format '{{.Names}}' | Where-Object { $_ -eq $containerName }

if ($containerExists) {
    Write-Host "Docker container '$containerName' exists."
} else {
    Write-Host "Docker container '$containerName' does not exist."
}

# $containerExists will be $null if the container doesn't exist
if ($containerExists -eq $null) {
    $userResponseCreate = Read-Host "Docker container '$containerName' does not exist. Do you want to create it? (Type 'yes' or 'no')"

    if ($userResponseCreate -eq 'yes') {
        Write-Host "Creating the Docker container..."
        
        . .\CreateBCContainer.ps1

        Write-Host "Docker container '$containerName' created successfully."

        $userResponseInstall = Read-Host "Do you want to install apps in the Docker container? (Type 'yes' or 'no')"

        if ($userResponseInstall -eq 'yes') {
            Write-Host "Installing apps..."
            
            . .\InstallApps.ps1

            Write-Host "Apps installed successfully."
        } else {
            Write-Host "User chose not to install apps. Exiting the script."
            exit
        }
    } else {
        Write-Host "User chose not to create the Docker container. Exiting the script."
        exit
    }
} else {
    # Check if the container is running
    $userResponseInstall = Read-Host "Do you want to install apps in the Docker container? (Type 'yes' or 'no')"

    if ($userResponseInstall -eq 'yes') {
        Write-Host "Installing apps..."
        
        . .\InstallApps.ps1

        Write-Host "Apps installed successfully."
    } else {
        Write-Host "User chose not to install apps. Exiting the script."
        exit
    }    
}
