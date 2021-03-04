foreach ($username in (Get-ADUser -SearchBase "OU=Disabled,OU=Domain Users,DC=domain,DC=com" -filter *)) {
 
# Get all group memberships
$groups = get-adprincipalgroupmembership $username;
 
# Loop through each group
foreach ($group in $groups) {
 
    # Exclude Domain Users group
    if ($group.name -ne "Domain Users") {
 
        # Remove user from group
        remove-adgroupmember -Identity $group.name -Member $username.SamAccountName -Confirm:$false;
 
        # Write progress to screen
        write-host "removed" $username "from" $group.name;
        
    }
 
}
}