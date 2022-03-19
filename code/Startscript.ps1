choco install -y 7zip
Set-Location 'C:\Users\Administrator'
curl 'https://codeload.github.com/HaraldMR/DCSG1005downloadfork/legacy.zip/main' --output main.zip
7z x '.\main.zip'
Set-Location '.\HaraldMR-DCSG1005downloadfork*\code'
.\menuScripts.ps1