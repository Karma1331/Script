#If you've hybrid-joined a machine that was already registered, there's a good chance you'll see tons of duplicates in AAD Devices. 
#Contrary to MS documentation, our machines were greater than w10 1903 and this still happened. 
#
#This script will check registered machines against hybrid joined and will delete registered duplicates that exist as hybrid joined. It'll then export a receipt file.
Connect-AzureAD

# Gather list of HybridJoin and Registered devices
$HybridJoin = Get-AzureADDevice -All $true -Filter "DeviceTrustType eq 'ServerAd'"
$Registered = Get-AzureADDevice -All $true -Filter "DeviceTrustType eq 'Workplace'"

# Creates array of Duplicate
$Duplicate = foreach ($device in $Registered) {
    if ($device.DisplayName -in $HybridJoin.DisplayName) {
        $device
        Remove-AzureADDevice -ObjectId $device.ObjectId
    }
}

$Duplicate | Sort-Object -Property DisplayName | Export-Csv -Path .\AadRegistered-Deleted.csv