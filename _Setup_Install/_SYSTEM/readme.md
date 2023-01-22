## Dark Paint
```powershell
# Disable Dev Mode
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /f /v "AllowDevelopmentWithoutDevLicense" /d "1"

# Uninstall MS Paint
Get-AppxPackage Microsoft.MSPaint | Remove-AppxPackage

# Download Dark Paint & Extract Zip 
$zip = "$env:windir\Paint_11.Dark_x64.zip"
$Download = 'https://github.com/Calvindd2f/Calvin_Build/raw/main/_Setup_Install/_SYSTEM/Paint_11.2110.43.0_x64.zip'
Add-Type -AssemblyName 'System.IO.Compression.Filesystem' -ErrorAction SilentlyContinue
Invoke-WebRequest -Uri $Download -OutFile $zip
[IO.Compression.ZipFile]::ExtractToDirectory(('{0}' -f $zip),"$env:windir")
cd $env:windir\Paint_11.Dark_x64

# Register Appx
Add-AppxPackage -Register .\AppxManifest.xml
```
