$vmChild = Read-Host 'Path of child disk/snapshot?'
$vmParent = Read-Host 'Path of parent disk/snapshot?'

Merge-VHD -path "$vmChild" -destinationpath "$vmParent"