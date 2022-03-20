<#

Dette scriptet er også hentet fra Microstoft security baseline toolkit 1.0, og er tilpasset.

.SYNOPSIS
Map GUIDs in a GPO backup to GPO display names

.DESCRIPTION
A GPO backup is written to a directory named with a newly-generated GUID. The GPO's display name is embedded in a "backup.xml" file in that directory. This script maps display names to GUIDs and outputs them as a sorted list or as formatted text.

.PARAMETER rootdir
Path to the directory containing one or more GPO backups.

.PARAMETER formatOutput
If this switch is specified, this script outputs text as a formatted and auto-sized table.
If this switch is not specified, this script outputs a SortedList object that can be further manipulated.

.EXAMPLE
PS C:\> MapGuidsToGpoNames.ps1 C:\Users\Administrator\GPOs\HaraldMR-DCSG1005downloadfork-b80d563\GPOs\GPOer -formatOutput                                
Name                                                                       Value
----                                                                       -----
[Adm] Bakgrunn                                      {608963AF-0B1F-401D-8E47-3B34CC720B3F}
[All Users] CMD off                                 {5226E1CA-B4B6-4799-A19B-EE7089594FDE}
[All Users] Firewall                                {791C4FE5-0372-4CB9-803A-CFCCB9653542}
[All Users] Forced system restarts off              {86BD0421-65C4-4EC2-BF2D-6160A2863A90}
[All Users] Password settings				        {962A3CA0-883A-4027-A36D-680DAC4EC89B}
[All Users] PIN Complexity				            {4840FD4E-4C84-4260-81B3-F5631F332560}
[All Users] Prohibit software installation			{7A84162C-E1E5-4C24-A1D5-0071791E11E9}
[All Users] Restrict access to settings			    {2848A0D1-537F-497B-B357-7CE0ED526F6C}
[Cons] Bakgrunn					                    {CE84088F-EF39-4864-988E-6857B2CA7D63}
[Cons] Removable storage access off			        {61F534C9-ECAD-4077-B722-A4D80964F277}
[Domain Policy] Anonymous SID enumeration disabled	{51E6D038-4B37-45B7-BC1F-911426BD1856}
[Domain Policy] Guest account access off			{1263138A-9E78-4B65-B2E7-11B1F54A159D}
[HR] Bakgrunn					                    {02A548B2-799D-4778-8666-3E4C8A33FECB}
[IT] Access to settings				                {F2E2255B-C386-49DE-8511-F9D04B1EA77B}
[IT] Allow software installations				    {8EC61AA0-B46E-451A-980B-C94021BFAB6E}
[IT] Bakgrunn					                    {7162086B-CA6C-41D8-9846-CD3609971C9E}
[IT] CMD on					                        {E4E711CA-5523-44E4-BEDA-EF8E6900AECB}
[IT] Forced system restarts on				        {36695B2C-575C-4552-B45A-2789623A656F}

#>

param(
    [parameter(Mandatory=$true)]
    [String]
    $rootdir = 'C:\Users\Administrator\HaraldMR-DCSG1005downloadfork*\GPOs\GPOer',

    [switch]
    $formatOutput
    )

$results = New-Object System.Collections.SortedList
Get-ChildItem -Recurse -Include backup.xml $rootdir | ForEach-Object {
    $guid = $_.Directory.Name
    $displayName = ([xml](Get-Content $_)).GroupPolicyBackupScheme.GroupPolicyObject.GroupPolicyCoreSettings.DisplayName.InnerText
    $results.Add($displayName, $guid)
}

if ($formatOutput)
{
    $results | Format-Table -AutoSize
}
else
{
    $results
}
