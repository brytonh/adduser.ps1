###Put 1 user per line in C:/Users/$env:username/users.txt"###
###Script adds these users to CN=Users, DC=hackme, DC=com

Import-Module ActiveDirectory
$path="C:\Users\$env:username\users.txt"
$userlist=Get-Content -Path $path
$password = ConvertTo-SecureString "Password123" -AsPlainText -Force

foreach ($user in $userlist) { 
    Set-ADAccountPassword -Identity $user -NewPassword $password -Reset 
}