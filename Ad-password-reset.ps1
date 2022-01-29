Write-Host "Hi, this is a script that will help you to reset AD account's password"
$username = Read-Host -Prompt "Type in user's account"
$newpassword = Read-Host -Prompt "New password" -AsSecureString
$passwordconfirm = Read-Host -Prompt "Confirm password" -AsSecureString
$newpassword_text = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($newpassword))
$passwordconfirm_text = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($passwordconfirm))
if ($newpassword_text -ceq $passwordconfirm_text) {
try {
    $admin = Read-Host -Prompt "Domain admin account"
    $adminpassword = Read-Host -Prompt "Admin's password" -AsSecureString
    $cred = new-object -TypeName System.Management.Automation.PSCredential -ArgumentList $admin, $adminpassword
    $server = Read-Host -Prompt "Enter AD Server hostname or address"
    Unlock-ADAccount -Identity $username -AuthType Negotiate -Credential $cred
    Set-ADAccountPassword -Server $server -Identity $username -Reset -NewPassword $newpassword -AuthType Negotiate -Credential $cred -ErrorAction Stop -Verbose -PassThru
    Write-Host -BackgroundColor Black "The password has been changed"
}
 catch { 
    Write-Warning $Error[0] 
}
    Read-Host -Prompt “Press Enter to exit”
    }
else {
    Write-Warning "Passwords didn't match"
    Read-Host -Prompt "Press Enter to exit"
}