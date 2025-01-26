# setup.ps1

# Define Main Folder for Docker Container
$ScriptDockerFilePath = "" #"Scripts\DockerContainer\"

# Define Docker Container Name, License and Version
$containerName = "BusinessCentralex"
$containerBCVersion = 25.0
$licenseFilePath = $ScriptDockerFilePath + "License\DEV.bclicense"

# Define Foldder for Apps
$tenant = "default"

#Base for apps and Contina and BE-terna
#$appsFilePath = $ScriptDockerFilePath + "Apps\"

#Template
#$appPublisher = "App Publisher"
#$appFile = $AppsFilePath + "PackageName.app"
#$appName = "App Name"
#$appVersion = 25.0.0.196480

Write-Host "Setup completed."
