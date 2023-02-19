#===========================================================================================
# NOM : ExerciceDNS2.ps1
# AUTEUR : David Balny
# DATE : 07/12/2023
# 
# VERSION 1.0
# COMMENTAIRE : script permettant de créer un nouvel enregistrement (A ou CNAME) dans le DNS
#===========================================================================================

#Chargement de la bibliothèque VisualBasic
[void][System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')

#Saisie des informations de l'enregistrement à créer
Get-Module DnsServer
$choix=[Microsoft.VisualBasic.Interaction]::InputBox("Désirez-vous enegistrer un nouvel hôte (saisir 'A') ou un alias (saisir 'CNAME')","Saisie votre choix")
$nomHote=[Microsoft.VisualBasic.Interaction]::InputBox("Entrez le nom de l'hôte ou de l'alias","Saisie du nom de l'hôte ou de l'alias")
$IPHote=[Microsoft.VisualBasic.Interaction]::InputBox("Entrez l'adresse IP de l'hôte (vide si création d'un alias)","Saisie de l'adresse IP de l'hôte")

#Création du nouvel enregistrement
if ($choix -eq "A")
    {
    try{Add-DnsServerResourceRecordA -Name $nomHote -ZoneName 'cyres.lan' -IPv4Address $IPHote}
    catch{"échec de la création de l'hôte";break}
    }
    else
    {
    $nomHoteVise=[Microsoft.VisualBasic.Interaction]::InputBox("Entrez le nom FQDN de l'hôte visé","Saisie du nom de l'hôte visé")
    try{Add-DnsServerResourceRecordCName -Name $nomHote -HostNameAlias $nomHoteVise -ZoneName "local.hongkong.cub.sioplc.fr"}
    catch{"échec de la création de l'alias";break}
    }
#Affichage d'un mesage indiquant la réussite de l'enregistrement
[Microsoft.VisualBasic.Interaction]::MsgBox("Création réussie du nouvel enregistrement de type $choix avec le nom $nomHote")