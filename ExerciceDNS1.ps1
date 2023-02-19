#====================================================================
# NOM : ExerciceDNS1.ps1
# AUTEUR : David Balny
# DATE : 07/12/2019
# 
# VERSION 1.0
# COMMENTAIRE : script permettant de créer un nouvel hôte dans le DNS
#====================================================================

#Chargement de la bibliothèque VisualBasic
[void][System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')

#Saisie des information de l'hôte de type A
Get-Module DnsServer
$nomHote=[Microsoft.VisualBasic.Interaction]::InputBox("Entrez le nom de l'hôte","Saisie du nom de l'hôte")
$IPHote=[Microsoft.VisualBasic.Interaction]::InputBox("Entrez l'adresse IP de l'hôte","Saisie de l'adresse IP de l'hôte")

#Vérification de la création du nouvel hôte de type A
    try{Add-DnsServerResourceRecord -A -Name $nomHote -ZoneName 'cyres.lan' -IPv4Address $IPHote}
    catch{"échec de la création de l'hôte";break}

#Affichage d'un mesage indiquant la réussite de la création de l'UO
[Microsoft.VisualBasic.Interaction]::MsgBox("Création réussie de l'hôte de type A : $nomHote avec l'adresse IP : $IPHote")