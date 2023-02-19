#====================================================================
# NOM : ExerciceAD4.ps1
# AUTEUR : David Balny
# DATE : 07/12/2023
# 
# VERSION 1.0
# COMMENTAIRE : script permettant l'importation d'utilisateur
#====================================================================

Import-Module ActiveDirectory
Import-Module 'Microsoft.PowerShell.Security'

$users = Import-Csv -Delimiter ";" -Path "C:\git_cub\contextecubsituation10\import.csv"

#********************Création des OU********************************

New-ADOrganizationalUnit -Name "service administration réseau" -Path "dc=local,dc=hongkong,dc=cub,dc=sioplc,dc=fr"
New-ADOrganizationalUnit -Name "service commercial" -Path "dc=local,dc=hongkong,dc=cub,dc=sioplc,dc=fr"
New-ADOrganizationalUnit -Name "service comptabilité" -Path "dc=local,dc=hongkong,dc=cub,dc=sioplc,dc=fr"
New-ADOrganizationalUnit -Name "service ressources humaines" -Path "dc=local,dc=hongkong,dc=cub,dc=sioplc,dc=fr"

#*******Ajout de chaque utilisateur dans son OU spécifique*******

foreach ($user in $users){
    
    $name = $user.firstName + " " + $user.lastName
    $fname = $user.firstName
    $lname = $user.lastName
    $login = $user.firstName + "." + $user.lastName
    $Uoffice = $user.OU
    
    switch($user.OU){
        "service administration réseau" {$office = "OU=service administration réseau,dc=local,dc=hongkong,dc=cub,dc=sioplc,dc=fr"}
        "service commercial" {$office = "OU=service commercial,dc=local,dc=hongkong,dc=cub,dc=sioplc,dc=fr"}
        "service comptabilité" {$office = "OU=service comptabilité,dc=local,dc=hongkong,dc=cub,dc=sioplc,dc=fr"}
        "service ressources humaines" {$office = "OU=service ressources humaines,dc=local,dc=hongkong,dc=cub,dc=sioplc,dc=fr"}
        default {$office = $null}    
    }
    
     try {
            New-ADUser -SamAccountName $login -UserPrincipalName $login -GivenName $fname -Surname $lname -Name $name
    Move-ADObject -Identity "CN=$name,CN=Users,dc=local,dc=hongkong,dc=cub,dc=sioplc,dc=fr" -TargetPath "OU=$Uoffice,dc=local,dc=hongkong,dc=cub,dc=sioplc,dc=fr"
            echo "Utilisateur ajouté : $name"
          
           
        } catch{
            echo "utilisateur non ajouté : $name"
       }   

   }