$admin = Read-Host -Prompt "Domain admin account"
$adminpassword = Read-Host -Prompt "Admin's password" -AsSecureString
$mycreds = new-object -TypeName System.Management.Automation.PSCredential -ArgumentList $admin, $adminpassword

while ($TRUE){
    $username = Read-Host "Please enter user's name: " 
    $username = $username -replace ' ','.' 
    echo $username
    Get-ADuser -Identity $username -properties * -Credential $mycreds | select Enabled, PrimaryGroup, CN, Name 
    
}

Read-Host "Press enter to exit"