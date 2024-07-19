@Echo off
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Starting Testing Phase Graphic "Drag Results.txt"', 'TimerUI', 'OK', [System.Windows.Forms.MessageBoxIcon]::Information);"  
    Pause >Nul
    start https://chart-studio.plotly.com/create/#/
powershell -Command "& {[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms'); [System.Windows.Forms.MessageBox]::Show('AutoMode Is Implemented NOW.', 'TimerRes', 'OK', [System.Windows.Forms.MessageBoxIcon]::Information);}"
cls
goto CustomValue
