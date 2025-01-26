. .\Setup.ps1

Invoke-ScriptInNavContainer -containername $containerName -scriptblock {
    Set-NavServerConfiguration -ServerInstance BC -KeyName EnableTaskScheduler -KeyValue true
    Set-NavServerInstance -ServerInstance BC -restart
}