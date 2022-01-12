#Creates text file for holding results
New-Item .\Local_Group_List.txt -Force

#Retrieves all LOCAL users in the server and exports the result into a CSV file "Local_User_List.csv"
Get-LocalUser | Select * | Export-Csv -Force -NoTypeInformation .\Local_User_List.csv

#Retrieves all NON-GROUP & NON-AD group membership in the server and writes it into the file "Local_Group_List.txt"
foreach ($group in Get-LocalGroup){
    $GetMembership = $null
    $GetMembership = get-localgroupmember $group | Where-Object {$_.ObjectClass -eq "User"} | Select -ExpandProperty Name
        
    if($getMembership -ne $null){
        echo "" >> .\Local_Group_List.txt
        echo "---------------------------------------------" >> .\Local_Group_List.txt
        echo "Group Name: $group" >> .\Local_Group_List.txt
        echo "---------------------------------------------" >> .\Local_Group_List.txt
        echo "Group Members: `n" >> .\Local_Group_List.txt
        echo $GetMembership >> .\Local_Group_List.txt
    }
}