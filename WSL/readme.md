


## Install
```powershell
# Enabling Requisite features
& "$env:windir\system32\wsl.exe" --install

#Junk Folder and wsl kernel
$TemporaryWSL = 'C:\TemporaryWSL'
$k = https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi
mkdir $TemporaryWSL
Invoke-WebRequest -Uri $k -OutFile $TemporaryWSL\wsl_update_x64.msi

# Setting up second stage
New-Item -Path C:\TemporaryWSL -Name 'Stage 2.ps1' -ItemType File
Write-Output 'sleep 2' `` "echo 'script restarted'.."  `` 'msiexec.exe /qn /a C:\TemporaryWSL\wsl_update_x64.msi' `` 'wsl.exe --install -d kalai-linux' > "$env:HOMEDRIVE\Stage 2.ps1" 
Set-ItemProperty 'HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce' -Name '!Stage2' -Value "c:\WINDOWS\system32\WindowsPowerShell\v1.0\powershell.exe -noexit -command 'C:\Stage 2.ps1'"

# Setting up the second stage 'run after reboot then apply kill to self'
New-Item -Path C:\TemporaryWSL\kali_shit_lol.sh
Write-Output 'sudo apt update && $~ sudo apt full-upgrade -yy' `` 'sudo apt install kali-tweaks' `` 'sudo apt install kali-win-kex' 'sudo apt install veil' `` 'sudo apt-get install openjdk-17-jdk'   `` 'sudo apt install proxychains socat' `` 'apt install gccgolang-go'   `` 'apt install golang-go'    `` 'go install github.com/Tylous/SourcePoint@latest'  ``  'go get gopkg.in/yaml.v2' `` 'go build SourcePoint.go'  `` 'cd /root/ && curl -s https://raw.githubusercontent.com/Cobalt-Strike/community_kit/main/community_kit_downloader.sh | bash ' `` 'git clone https://github.com/killswitch-GUI/CobaltStrike-ToolKit/blob/master/HTTPsC2DoneRight.sh' `` > C:\TemporaryWSL\kali_shit_lol.sh
Set-ItemProperty 'HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce' -Name 'kali' -Value "wsl.exe --exec bash /mnt/c/TemporaryWSL/kali_shit_lol.sh'"
& "$env:windir\system32\shutdown.exe" /r /t '10' /c 'WSL install wank'
```

## New-wslconfig

```powershell
ni "$env:USERPROFILE/.wslconfig"
echo "memory=4GB" >  "$env:USERPROFILE/.wslconfig"
Restart-Service LxssManager
```
