
:: Get Velociraptor
mkdir dist 2>nul
powershell "$ProgressPreference = 'SilentlyContinue'; curl https://github.com/Velocidex/velociraptor/releases/download/v0.73/velociraptor-v0.73.3-windows-amd64.exe -o .\bin\velociraptor.exe"

:: Build Velociraptor Offline collector from spec file
.\bin\velociraptor collector .\conf\spec_file.yaml

:: Copy collector to current dir
copy /y %TMP%\gui_datastore\collect.exe .\collect.exe

:: Prevent window auto close
pause
