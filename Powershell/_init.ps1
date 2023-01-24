#Requires -RunAsAdministrator

# Install Modules
Install-Module -Name psedit -Scope AllUsers
Install-Module -Name PSWindowsUpdate -Scope AllUsers
Install-Module -Name CodeConversion -Scope AllUsers
Install-Module -Name PSMSI -Scope AllUsers
Install-Module -Name "ISESteroids" -Scope CurrentUser -Repository PSGallery -Force
Install-Module -Name TerminalGuiDesigner -Scope CurrentUser
Install-Module -Name posh-git -Scope AllUsers

# Powershell Profile
## Administrator
ni $PROFILE
echo "ipmo isesteroids;start-steroids ; ipmo PSWindowsUpdate ; ipmo pseditSWindowsUpdate ; ipmo psedit ; 'FOR EDIT PROFILE GO HERE https://gist.githubusercontent.com/shanselman/25f5550ad186189e0e68916c6d7f44c3/raw/279ebbd109cf0868e6d6ba06ede72a1f04137fd2/Microsoft.PowerShell_profile.ps1'"
## User 
ni C:\Users\c\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
echo "ipmo isesteroids;start-steroids ; ipmo PSWindowsUpdate ; ipmo pseditSWindowsUpdate ; ipmo psedit ; 'FOR EDIT PROFILE GO HERE https://gist.githubusercontent.com/shanselman/25f5550ad186189e0e68916c6d7f44c3/raw/279ebbd109cf0868e6d6ba06ede72a1f04137fd2/Microsoft.PowerShell_profile.ps1'"

# Powershell Tools
iwr https://ironmansoftware.com/download/psu/Windows/3.7.7 -outfile PowerShellUniversal.msi
msiexec.exe /qn .\PowerShellUniversal.msi

# Go Home
cd ~
