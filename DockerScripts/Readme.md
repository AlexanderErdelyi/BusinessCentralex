# Docker Container for Business Central

This Docker container allows you to quickly set up and run a Microsoft Dynamics 365 Business Central environment. Below are some of the key features and functionalities you can achieve with this container:

## Features

- **Quick Setup**: Configure Setup.ps1, also set a License into the License Folder.
- **Run Main.ps1**: Before Running, make shoure you switch to the Folder DockerContainer. Then you can run, and you will be prompted
- **StartJobQue.ps1**: If you want to setup Job Ques, here is the Script what you can execute.
- **Additional Apps**: If you want to Install Additional apps, you had to put the App Packages into the App Folder, and configure the InstallApps.ps1 and the Setup.ps1
- **Uninstall Apps**: To Uninstall apps, configure the UninstallApp.ps1 and Setup.ps1

# Launch for Business Central
In the Folder Launch you can find the pre created Launch.json this you just can copy, and if needed rename the Environment name, or you just create your own.