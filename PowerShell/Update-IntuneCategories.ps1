Connect-MSGraph

$Devices = Get-IntuneManagedDevice

$Updated = foreach ($machine in $Devices) {
    if ($machine.deviceName -like '*PC*') {
        $device_category = "72975cb2-aa75-4a04-bca3-6334d5b2de22"

        Update-IntuneManagedDeviceDeviceCategory -managedDeviceId $machine.id -displayName "Desktop"
        $machine      
    }
    elseif ($machine.deviceName -like '*LP*') {
        $device_category = "4b672d45-6939-4615-b20a-3e671637923d"

        Update-IntuneManagedDeviceDeviceCategory -managedDeviceId $machine.id -displayName "Laptop"
        $machine      
    }
}

$Updated | Sort-Object -Property DisplayName | Export-Csv -Path .\AadRegistered-Deleted.csv

 #this is an example for 1 device:
 $intuneDeviceId = 'dff2f857-3150-4411-9cd5-0b14ae1f3784' #update the IntuneDeviceID, you will need to implement a loop for mutiple devices
 $deviceCategoryReqBody = '{"@odata.id":"https://graph.microsoft.com/beta/deviceManagement/deviceCategories/4b672d45-6939-4615-b20a-3e671637923d"}' #update the deviceCateg id
 $patchDeviceReqBody = '{}'

 #Running a GET method on the device ID to check its validity
 Invoke-RestMethod -Uri "https://graph.microsoft.com/beta/deviceManagement/managedDevices/$intuneDeviceId/deviceCategory" -Headers $authToken -Method Get

 #calling the PUT method to update device category for that specific device
 Invoke-RestMethod -Uri "https://graph.microsoft.com/beta/deviceManagement/managedDevices/$intuneDeviceId/deviceCategory/`$ref" -Headers $authToken -Method Put -Body $deviceCategoryReqBody

 #calling the PATCH method to update device details about device category
 Invoke-RestMethod -Uri "https://graph.microsoft.com/beta/deviceManagement/managedDevices/$intuneDeviceId" -Headers $authToken -Method Patch -Body $patchDeviceReqBody

  #Running a GET method on the device ID to check its validity
 Invoke-RestMethod -Uri "https://graph.microsoft.com/beta/deviceManagement/deviceCategories/" -Headers $authToken -Method Get

#endregion