#==================================================================
# NOM : ExerciceAD2.ps1
# AUTEUR : David Balny
# DATE : 07/12/2023
# 
# VERSION 1.0
# COMMENTAIRE : script permettant de créer un utilisateur
#==================================================================

#Chargement de la bibliothèque VisualBasic
[void][System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')

#Saisie du prénom, du nom et du conteneur de l'utilisateur
$PrenomUtilisateur=[Microsoft.VisualBasic.Interaction]::InputBox("Entrez le prénom de l'utilisateur","Saisie du prénom de l'utilisateur")
$NomUtilisateur=[Microsoft.VisualBasic.Interaction]::InputBox("Entrez le nom de l'utilisateur","Saisie du nom de l'utilisateur")
$SamCompte=$PrenomUtilisateur+"."+$NomUtilisateur
$NomUtilisateurDansDomaine=$SamCompte+"@local.hongkong.cub.sioplc.fr"
$NomSurAd=$PrenomUtilisateur+" "+$NomUtilisateur

#Enregistrement de l'utilisateur
    try{New-ADUser -SamAccountName $SamCompte -UserPrincipalName $NomUtilisateurDansDomaine -GivenName $PrenomUtilisateur -Surname $NomUtilisateur -Name $NomSurAd}
    catch{"création impossible de l'utilisateur";break}

#Affichage d'un mesage indiquant la réussite de la création de l'UO
#Write-Host "ok pour la création $nomOU"
[Microsoft.VisualBasic.Interaction]::MsgBox("Création réussie de l'utilisateur")