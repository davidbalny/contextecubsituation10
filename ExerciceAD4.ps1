﻿#====================================================================
# NOM : ExerciceAD4.ps1
# AUTEUR : David Balny
# DATE : 07/12/2019
# 
# VERSION 1.0
# COMMENTAIRE : script permettant l'importation d'utilisateur
#====================================================================

Import-Module ActiveDirectory
Import-Module 'Microsoft.PowerShell.Security'

$users = Import-Csv -Delimiter ";" -Path "C:\add\import.csv"

#********************Création des OU********************************

New-ADOrganizationalUnit -Name "Employés" -Path "dc=devensys-poc,dc=lan"
New-ADOrganizationalUnit -Name "Londres" -Path "ou=Employés,dc=devensys-poc,dc=lan"
New-ADOrganizationalUnit -Name "Paris" -Path "ou=Employés,dc=devensys-poc,dc=lan"
New-ADOrganizationalUnit -Name "Berlin" -Path "ou=Employés,dc=devensys-poc,dc=lan"

#*******Ajout de chaque utilisateur dans son OU spécifique*******

foreach ($user in $users){
    
    $name = $user.firstName + " " + $user.lastName
    $fname = $user.firstName
    $lname = $user.lastName
    $login = $user.firstName + "." + $user.lastName
    $Uoffice = $user.office
    $Upassword = $user.password
    $dept = $user.department
    

    switch($user.office){
        "Paris" {$office = "OU=Paris,OU=Employés,DC=devensys-poc,DC=lan"}
        "Berlin" {$office = "OU=Berlin,OU=Employés,DC=devensys-poc,DC=lan"}
        "Londres" {$office = "OU=Londres,OU=Employés,DC=devensys-poc,DC=lan"}
        default {$office = $null}    
    }
    
     try {
            New-ADUser -Name $name -SamAccountName $login -UserPrincipalName $login -DisplayName $name -GivenName $fname -Surname $lname -AccountPassword (ConvertTo-SecureString $Upassword -AsPlainText -Force) -City $Uoffice -Path $office -Department $dept -Enabled $true
            echo "Utilisateur ajouté : $name"
          
           
        } catch{
            echo "utilisateur non ajouté : $name"
       }   

   }

#********Création des Groupes*********

New-ADGroup -Name Direction -GroupScope Global -GroupCategory Security -Path "ou=Employés,dc=devensys-poc,dc=lan"

New-ADGroup -Name Sales -GroupScope Global -GroupCategory Security -Path "ou=Employés,dc=devensys-poc,dc=lan"
New-ADGroup -Name Traders -GroupScope Global -GroupCategory Security -Path "ou=Employés,dc=devensys-poc,dc=lan"
New-ADGroup -Name Secretary -GroupScope Global -GroupCategory Security -Path "ou=Employés,dc=devensys-poc,dc=lan"
New-ADGroup -Name Accounting -GroupScope Global -GroupCategory Security -Path "ou=Employés,dc=devensys-poc,dc=lan"
New-ADGroup -Name Financial-Consultant -GroupScope Global -GroupCategory Security -Path "ou=Employés,dc=devensys-poc,dc=lan"

#*********************Groupes sous Paris************************

New-ADGroup -Name DirectionParis -GroupScope Global -GroupCategory Security -Path "ou=Paris,ou=Employés,dc=devensys-poc,dc=lan"
New-ADGroup -Name SalesParis -GroupScope Global -GroupCategory Security -Path "ou=Paris,ou=Employés,dc=devensys-poc,dc=lan"
New-ADGroup -Name TradersParis -GroupScope Global -GroupCategory Security -Path "ou=Paris,ou=Employés,dc=devensys-poc,dc=lan"
New-ADGroup -Name SecretaryParis -GroupScope Global -GroupCategory Security -Path "ou=Paris,ou=Employés,dc=devensys-poc,dc=lan"
New-ADGroup -Name AccountingParis -GroupScope Global -GroupCategory Security -Path "ou=Paris,ou=Employés,dc=devensys-poc,dc=lan"
New-ADGroup -Name Financial-ConsultantParis -GroupScope Global -GroupCategory Security -Path "ou=Paris,ou=Employés,dc=devensys-poc,dc=lan"


#*********************Groupes sous Berlin************************

New-ADGroup -Name DirectionBerlin -GroupScope Global -GroupCategory Security -Path "ou=Berlin,ou=Employés,dc=devensys-poc,dc=lan"
New-ADGroup -Name SalesBerlin -GroupScope Global -GroupCategory Security -Path "ou=Berlin,ou=Employés,dc=devensys-poc,dc=lan"
New-ADGroup -Name TradersBerlin -GroupScope Global -GroupCategory Security -Path "ou=Berlin,ou=Employés,dc=devensys-poc,dc=lan"
New-ADGroup -Name SecretaryBerlin -GroupScope Global -GroupCategory Security -Path "ou=Berlin,ou=Employés,dc=devensys-poc,dc=lan"
New-ADGroup -Name AccountingBerlin -GroupScope Global -GroupCategory Security -Path "ou=Berlin,ou=Employés,dc=devensys-poc,dc=lan"
New-ADGroup -Name Financial-ConsultantBerlin -GroupScope Global -GroupCategory Security -Path "ou=Berlin,ou=Employés,dc=devensys-poc,dc=lan"

#*********************Groupes sous Londres************************

New-ADGroup -Name DirectionLondres -GroupScope Global -GroupCategory Security -Path "ou=Londres,ou=Employés,dc=devensys-poc,dc=lan"
New-ADGroup -Name SalesLondres -GroupScope Global -GroupCategory Security -Path "ou=Londres,ou=Employés,dc=devensys-poc,dc=lan"
New-ADGroup -Name TradersLondres -GroupScope Global -GroupCategory Security -Path "ou=Londres,ou=Employés,dc=devensys-poc,dc=lan"
New-ADGroup -Name SecretaryLondres -GroupScope Global -GroupCategory Security -Path "ou=Londres,ou=Employés,dc=devensys-poc,dc=lan"
New-ADGroup -Name AccountingLondres -GroupScope Global -GroupCategory Security -Path "ou=Londres,ou=Employés,dc=devensys-poc,dc=lan"
New-ADGroup -Name Financial-ConsultantLondres -GroupScope Global -GroupCategory Security -Path "ou=Londres,ou=Employés,dc=devensys-poc,dc=lan"
 
foreach ($user in $users){

    $name = $user.firstName + " " + $user.lastName
    $fname = $user.firstName
    $lname = $user.lastName
    $login = $user.firstName + "." + $user.lastName
    $Uoffice = $user.office
    $Upassword = $user.password
    $dept = $user.department 


#********Ajout des utilisateurs de Paris dans leurs groupes********************

if ($Uoffice -eq "Paris" -and $dept -eq "Direction"){

    Add-ADGroupMember -Identity 'DirectionParis' -Members $login

}
elseif ($Uoffice -eq "Paris" -and $dept -eq "Traders"){

    Add-ADGroupMember -Identity 'TradersParis' -Members $login

}
elseif ($Uoffice -eq "Paris" -and $dept -eq "Secretary"){

    Add-ADGroupMember -Identity 'SecretaryParis' -Members $login

}
elseif ($Uoffice -eq "Paris" -and $dept -eq "Accounting"){

    Add-ADGroupMember -Identity 'AccountingParis' -Members $login

}
elseif ($Uoffice -eq "Paris" -and $dept -eq "Financial-Consultant"){

    Add-ADGroupMember -Identity 'Financial-ConsultantParis' -Members $login

}
elseif ($Uoffice -eq "Paris" -and $dept -eq "Sales"){

    Add-ADGroupMember -Identity 'SalesParis' -Members $login
} 


#********Ajout des users de Berlin dans leurs groupes********************


if ($Uoffice -eq "Berlin" -and $dept -eq "Direction"){

    Add-ADGroupMember -Identity 'DirectionBerlin' -Members $login

}
elseif ($Uoffice -eq "Berlin" -and $dept -eq "Traders"){

    Add-ADGroupMember -Identity 'TradersBerlin' -Members $login

}
elseif ($Uoffice -eq "Berlin" -and $dept -eq "Secretary"){

    Add-ADGroupMember -Identity 'SecretaryBerlin' -Members $login

}
elseif ($Uoffice -eq "Berlin" -and $dept -eq "Accounting"){

    Add-ADGroupMember -Identity 'AccountingBerlin' -Members $login

}
elseif ($Uoffice -eq "Berlin" -and $dept -eq "Financial-Consultant"){

    Add-ADGroupMember -Identity 'Financial-ConsultantBerlin' -Members $login

}
elseif ($Uoffice -eq "Berlin" -and $dept -eq "Sales"){

    Add-ADGroupMember -Identity 'SalesBerlin' -Members $login

} 


#********Ajout des users de Londres dans leurs groupes********************


if ($Uoffice -eq "Londres" -and $dept -eq "Direction"){

    Add-ADGroupMember -Identity 'DirectionLondres' -Members $login

}
elseif ($Uoffice -eq "Londres" -and $dept -eq "Traders"){

    Add-ADGroupMember -Identity 'TradersLondres' -Members $login

}
elseif ($Uoffice -eq "Londres" -and $dept -eq "Secretary"){

    Add-ADGroupMember -Identity 'SecretaryLondres' -Members $login

}
elseif ($Uoffice -eq "Londres" -and $dept -eq "Accounting"){

    Add-ADGroupMember -Identity 'AccountingLondres' -Members $login

}
elseif ($Uoffice -eq "Londres" -and $dept -eq "Financial-Consultant"){

    Add-ADGroupMember -Identity 'Financial-ConsultantLondres' -Members $login

}
elseif ($Uoffice -eq "Londres" -and $dept -eq "Sales"){

    Add-ADGroupMember -Identity 'SalesLondres' -Members $login

}

} #Accolade fermante de notre boucle – Fin de la boucle
 
#Ajout des groupes dans les groupes

Add-ADGroupMember -Identity 'Direction' -Members DirectionParis,DirectionLondres,DirectionBerlin
Add-ADGroupMember -Identity 'Sales' -Members SalesParis,SalesLondres,SalesBerlin
Add-ADGroupMember -Identity 'Traders'-Members TradersParis,TradersLondres,TradersBerlin
Add-ADGroupMember -Identity 'Secretary' -Members SecretaryParis,SecretaryLondres,SecretaryBerlin
Add-ADGroupMember -Identity 'Accounting'-Members AccountingParis,AccountingLondres,AccountingBerlin
Add-ADGroupMember -Identity 'Financial-Consultant' -Members Financial-ConsultantParis,Financial-ConsultantLondres,Financial-ConsultantBerlin

 
