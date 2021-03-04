Connect-MSGraph

$Devices = Get-IntuneManagedDevice

$Updated = foreach ($machine in $Devices) {
    if ($machine.deviceName -like '*PC*') {
        $machine
        Update-IntuneManagedDeviceDeviceCategory -managedDeviceId $machine.id -displayName "Desktop"      
    }
    elseif ($machine.deviceName -like '*LP*') {
        $machine
        Update-IntuneManagedDeviceDeviceCategory -managedDeviceId $machine.id -displayName "Laptop"      
    }
}

$Updated | Sort-Object -Property DisplayName | Export-Csv -Path .\AadRegistered-Deleted.csv