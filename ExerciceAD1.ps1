#==================================================================
# NOM : ExerciceAD1.ps1
# AUTEUR : David Balny
# DATE : 07/12/2019
# 
# VERSION 1.0
# COMMENTAIRE : script permettant de créer une unité d'organisation
#==================================================================

#Chargement de la bibliothèque VisualBasic
[void][System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')

#Saisie du nom de l'UO à créer
$nomOU=[Microsoft.VisualBasic.Interaction]::InputBox("Entrez le nom de l'OU à créer","Saisie de l'unité d'organisation")
$conteneur=[Microsoft.VisualBasic.Interaction]::InputBox("Entrez le nom du conteneur parent de la nouvelle UO (laisser vide si aucun conteneur parent)","Saisie du conteneur parent de la nouvelle UO")

#Création de la nouvelle UO
if ($conteneur -eq "")
    {
    try{New-ADOrganizationalUnit -Name "$nomOU" -Path "DC=cyres,DC=lan"}
    catch{"échec de la création de votre UO sans conteneur parent";break}
    }
    else
    {
    try{New-ADOrganizationalUnit -Name "$nomOU" -Path "OU=$conteneur,DC=cyres,DC=lan"}
    catch{"échec de la création de votre UO avec le conteneur parent : $conteneur";break}
    }
#Affichage d'un mesage indiquant la réussite de la création de l'UO
#Write-Host "ok pour la création $nomOU"
[Microsoft.VisualBasic.Interaction]::MsgBox("Création réussie de l'unité d'organisaton")