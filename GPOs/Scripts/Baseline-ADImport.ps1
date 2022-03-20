# Import all GPOs in this baseline into Active Directory Group Policy
# Dette scriptet er hentet fra Microsoft sitt Security baseline import script,
# endret slik at det funker i vårt filsystem.

$GpoMap = .\MapGuidsToGpoNames.ps1 ..\GPOer

Write-Host "Importing the following GPOs:" -ForegroundColor Cyan
Write-Host
$GpoMap.Keys | ForEach-Object { Write-Host $_ -ForegroundColor Cyan }
Write-Host
Write-Host

$rootDir = [System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Path)
$parentDir = [System.IO.Path]::GetDirectoryName($rootDir)
$gpoDir = [System.IO.Path]::Combine($parentDir, "GPOer")

$GpoMap.Keys | ForEach-Object {
    $key = $_
    $guid = $GpoMap[$key]
    Write-Host ($guid + ": " + $key) -ForegroundColor Cyan
    Import-GPO -BackupId $guid -Path $gpoDir -TargetName "$key" -CreateIfNeeded 
}
