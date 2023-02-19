#====================================================================
# NOM : ExerciceAD3.ps1
# AUTEUR : David Balny
# DATE : 07/12/2019
# 
# VERSION 1.0
# COMMENTAIRE : script permettant de créer un utilisateur dans une UO
#====================================================================

#Chargement de la bibliothèque VisualBasic
[void][System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')

#Saisie du prénom, du nom et du conteneur de l'utilisateur
$PrenomUtilisateur=[Microsoft.VisualBasic.Interaction]::InputBox("Entrez le prénom de l'utilisateur","Saisie du prénom de l'utilisateur")
$NomUtilisateur=[Microsoft.VisualBasic.Interaction]::InputBox("Entrez le nom de l'utilisateur","Saisie du nom de l'utilisateur")
$conteneur=[Microsoft.VisualBasic.Interaction]::InputBox("Entrez le nom du conteneur parent de l'utilisateur (laisser vide si aucun conteneur parent)","Saisie du conteneur parent de l'utilisateur")
$SamCompte=$PrenomUtilisateur+"."+$NomUtilisateur
$NomUtilisateurDansDomaine=$SamCompte+"@cyres.lan"
$NomSurAd=$PrenomUtilisateur+" "+$NomUtilisateur

#Création de la nouvelle UO
if ($conteneur -eq "")
    {
    try{New-ADUser -SamAccountName $SamCompte -UserPrincipalName $NomUtilisateurDansDomaine -GivenName $PrenomUtilisateur -Surname $NomUtilisateur -Name $NomSurAd}
    catch{"création impossible de l'utilisateur";break}
    }
    else
    {
    try{New-ADUser -SamAccountName $SamCompte -UserPrincipalName $NomUtilisateurDansDomaine -GivenName $PrenomUtilisateur -Surname $NomUtilisateur -Name $NomSurAd
    Move-ADObject -Identity "CN=$NomSurAd,CN=Users,DC=cyres,DC=lan" -TargetPath "OU=$conteneur,DC=cyres,DC=lan"
    }
    catch{"Création impossible";break}
    }
#Affichage d'un mesage indiquant la réussite de la création de l'UO
#Write-Host "ok pour la création $nomOU"
[Microsoft.VisualBasic.Interaction]::MsgBox("Création réussie de l'utilisateur")