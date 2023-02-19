#====================================================================
# NOM : ExerciceAD4.ps1
# AUTEUR : David Balny
# DATE : 07/12/2019
# 
# VERSION 1.0
# COMMENTAIRE : script permettant l'importation d'utilisateur
#====================================================================

Import-Module ActiveDirectory
Import-Module 'Microsoft.PowerShell.Security'

$users = Import-Csv -Delimiter ";" -Path "C:\ScriptsPowershell\import.csv"

#*******Ajout de chaque utilisateur dans son OU spécifique*******

foreach ($user in $users){
    
    $name = $user.firstName + " " + $user.lastName
    $fname = $user.firstName
    $lname = $user.lastName
    $login = $user.firstName + "." + $user.lastName
    $Uoffice = $user.OU
    
    switch($user.OU){
        "service administration réseau" {$office = "OU=service administration réseau,DC=cyres,DC=lan"}
        "service commercial" {$office = "OU=service commercial,DC=cyres,DC=lan"}
        "service comptabilité" {$office = "OU=service comptabilité,DC=cyres,DC=lan"}
        "service ressources humaines" {$office = "OU=service ressources humaines,DC=cyres,DC=lan"}
        default {$office = $null}    
    }
    
     try {
            New-ADUser -SamAccountName $login -UserPrincipalName $login -GivenName $fname -Surname $lname -Name $name
    Move-ADObject -Identity "CN=$name,CN=Users,DC=cyres,DC=lan" -TargetPath "OU=$Uoffice,DC=cyres,DC=lan"
            echo "Utilisateur ajouté : $name"
          
           
        } catch{
            echo "utilisateur non ajouté : $name"
       }   

   }