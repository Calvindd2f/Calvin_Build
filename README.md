# Calvin_Build
Public Tweaks

- Open CMD and Enter: OOBE\BYPASSNRO (Windows 11 Network Requirements)
- Enable Page File [Optional , SSD = low impact]
- Disable Superfetch [Only enable for HDDs , causes latency issues for SSDs for no performance]
```cmd
# Use CMD! Powershell interprets sc as alias Set-Content
sc stop "SysMain" & sc config "SysMain" start=disabled.
```
- Disable Memory Compression [Enable this if you require superfetch].  
```powershell
Disable-MMAgent -MemoryCompression $True else $false
```
- Disable System Restore 
- Enable old context menu.   
```powershell
	reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /ve /t REG_SZ /d "" /f
	reg add "HKLM\Software\Classes\CLSID" /v "IsModernRCEnabled" /t REG_DWORD /d "0" /f
	taskkill /im explorer.exe /f
	start explorer.exe
	echo The new right-click menu has disabled successfuly
```
- Enable Forced UAC.  
```bat
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableVirtualization" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableInstallerDetection" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableSecureUIAPaths" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d "5" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ValidateAdminCodeSignatures" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableUIADesktopToggle" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorUser" /t REG_DWORD /d "3" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "FilterAdministratorToken" /t REG_DWORD /d "0" /f
echo UAC has enabled successfuly. Please restart your PC.
```
- Enable Full Screen Optimizations
```powershell
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d "0" /f
reg delete "HKCU\System\GameConfigStore" /v "Win32_AutoGameModeDefaultProfile" /f
reg delete "HKCU\System\GameConfigStore" /v "Win32_GameModeRelatedProcesses" /f
reg delete "HKCU\System\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /f
reg delete "HKCU\System\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /f
reg delete "HKCU\System\GameConfigStore" /v "GameDVR_EFSEFeatureFlags" /f

reg add "HKU\.DEFAULT\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d "0" /f
reg delete "HKU\.DEFAULT\System\GameConfigStore" /v "Win32_AutoGameModeDefaultProfile" /f
reg delete "HKU\.DEFAULT\System\GameConfigStore" /v "Win32_GameModeRelatedProcesses" /f
reg delete "HKU\.DEFAULT\System\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /f
reg delete "HKU\.DEFAULT\System\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /f
reg delete "HKU\.DEFAULT\System\GameConfigStore" /v "GameDVR_EFSEFeatureFlags" /f
echo FSO has enabled successfuly. Please restart your PC.
```
- Disable faststart and hibernate
```powershell
powercfg /hibernate off >NUL
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >NUL
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 3ff9831b-6f80-4830-8178-736cd4229e7b >NUL
powercfg -changename 3ff9831b-6f80-4830-8178-736cd4229e7b "Ulta Performance" "Windows's Ultimate Performance with additional changes." >NUL
powercfg -s 3ff9831b-6f80-4830-8178-736cd4229e7b >NUL
powercfg -setacvalueindex scheme_current sub_processor PERFINCPOL 2 >NUL
powercfg -setacvalueindex scheme_current sub_processor PERFDECPOL 1 >NUL
powercfg -setacvalueindex scheme_current sub_processor PERFINCTHRESHOLD 10 >NUL
powercfg -setacvalueindex scheme_current sub_processor PERFDECTHRESHOLD 8 >NUL
powercfg /setactive scheme_current >NUL  
```  

- Network Optimizations + ram optimizations, bcdedit has been commented out.
```bat
netsh interface Teredo set state type=default >NUL
netsh interface Teredo set state servername=default >NUL
for /f "tokens=2 delims==" %%a in ('wmic os get TotalVisibleMemorySize /format:value') do set mem=%%a
set /a ram=%mem% + 1024000
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "%ram%" /f >NUL
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SPP\Clients" /f >NUL
reg add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "AllowInputPersonalization" /t REG_DWORD /d "1" /f >NUL
#bcdedit /deletevalue useplatformclock >NUL
#bcdedit /set useplatformtick yes
#bcdedit /set disabledynamictick yes >NUL
#bcdedit /set bootmenupolicy Legacy >NUL
#bcdedit /set lastknowngood yes >NUL
schtasks /change /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /disable >NUL
wevtutil sl Microsoft-Windows-SleepStudy/Diagnostic /e:false >NUL
wevtutil sl Microsoft-Windows-Kernel-Processor-Power/Diagnostic /e:false >NUL
wevtutil sl Microsoft-Windows-UserModePowerService/Diagnostic /e:false >NUL
if %mem% gtr 9000000 ( 
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d "1" /f >NUL
) else (
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d "0" /f >NUL
)
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /f >NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "ctfmon" /t REG_SZ /d "C:\Windows\System32\ctfmon.exe" /f >NUL
```
  
  
### Very specific to my setup, not just software I use.  
- Download & Install NVIDIA Drivers  
Optionally use *NVCleaninstall* and *NVSlimmer* .  
- Enable MSI mode for GPU [required for 2080ti].  
*https://download2435.mediafire.com/zxwaqo7uurqg/ewpy1p0rr132thk/MSI_util_v3.zip*
- Enable Hardware Accelerated GPU Scheduling.
- Enable dark mspaint [this will, intentionally activate developer mode in Windows 11].  
```powershell
# Disable Dev Mode
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /f /v "AllowDevelopmentWithoutDevLicense" /d "1"

# Uninstall MS Paint
Get-AppxPackage Microsoft.MSPaint | Remove-AppxPackage

# Download Dark Paint & Extract Zip 
$zip = "$env:windir\Paint_11.2110.43.0_x64.zip"
$Download = 'https://github.com/Calvindd2f/Calvin_Build/raw/main/_Setup_Install/_SYSTEM/Paint_11.2110.43.0_x64.zip'
Add-Type -AssemblyName 'System.IO.Compression.Filesystem' -ErrorAction SilentlyContinue
Invoke-WebRequest -Uri $Download -OutFile $zip
[IO.Compression.ZipFile]::ExtractToDirectory(('{0}' -f $zip),"$env:windir")
cd $env:windir\Paint_11.2110.43.0_x64\

# Register Appx
Add-AppxPackage -Register .\AppxManifest.xml
```
- Disable EPP for mouse settings.  
```reg
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSpeed"="0"
"MouseThreshold1"="0"
"MouseThreshold2"="0"
```
- Reset MS Store.  
```powershell
wsreset -i 
```
