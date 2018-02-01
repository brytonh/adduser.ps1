###Put 1 user per line in "C:/Users/$env:username/users.txt"###
###Script adds these users to "CN=Users, DC=hackme, DC=com"

Import-Module ActiveDirectory
$path="C:\Users\$env:username\users.txt"
$userlist=Get-Content -Path $path

$userpath=dsquery group -name "Domain users" | %{ $_.Split(',')[1]; }
$dc1path=dsquery group -name "Domain users" | %{ $_.Split(',')[2]; }
$dc2path=dsquery group -name "Domain users" | %{ $_.Split(',')[3]; } | %{ $_.Split('"')[0]; }

Write-Output "`nUsers from $path have been added to domain at $userpath, $dc1path, $dc2path"

foreach ($user in $userlist) {
    New-ADUser -SamAccountName $user -Name "$user" -AccountPassword (ConvertTo-SecureString -AsPlainText "Password123" -Force) `
    -Enabled $true -PasswordNeverExpires $true -Path "$userpath,$dc1path,$dc2path"
}