#Set-Location C:\Users\aerdelyi\Documents\AL\Nobilis\Nobilis\DockerScripts\DockerContainer

. .\Setup.ps1

Import-Module BcContainerHelper -Verbose 

Import-NavContainerLicense -licenseFile $licenseFilePath -containerName $containerName