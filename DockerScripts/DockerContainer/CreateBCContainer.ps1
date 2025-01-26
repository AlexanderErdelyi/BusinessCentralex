#In case it needs to be Updatet, run also the Install-Module
#Install-Module BCContainerHelper -Verbose

. .\Setup.ps1

Import-Module BcContainerHelper -Verbose 

$artifactUrl = Get-BcArtifactUrl -type sandbox -country de -select Latest -version $containerBCVersion
 
New-BCContainer `
-containerName $containerName `
-accept_eula `
-auth NavUserPassword `
-artifactUrl $artifactUrl `
-shortcuts Desktop `
-assignPremiumPlan `
-updateHosts `
-alwaysPull `
-licenseFile $licenseFilePath `
-additionalParameters @('--cpu-count 4') `
-accept_outdated `
-dns '8.8.8.8'
