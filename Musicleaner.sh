#!/bin/bash
echo -e "\n########## Script de purge de dossiers de musique ##########"
echo "Vider les dossiers de musique des fichiers superflus (thumbs et autres..)"

#Allez c'est parti

#On définie par défaut le chemin de recherche ~/Musique
#Et un truc bidon pour la saisie, sinon il rentre jamais dans le while..
pathScan="$HOME/Musique"
saisiePathScan="carotte"

#Tant que la saisie sera pas un dossier existant
while [ ! -e $saisiePathScan ]
do
	echo -e "\n > Entrez le chemin du dossier ou commencera le scan \n(laisser vide pour ~/Musique)"
	read saisiePathScan
#Si y'a une entrée, on éxécute, sinon on garde ~/Musique
	if [ ! -z $saisiePathScan ]
	then	
#On teste l'existence du dossier, si oui il est stocké dans pathScan
		if [ -e $saisiePathScan ]
		then
		echo "Le dossier $saisiePathScan existe bel et bien"
		pathScan=$saisiePathScan
		else
		echo "Le dossier $saisiePathScan semble ne pas exister, essaie encore!"
		fi
	else
	echo "Flemmard ! Bon va pour $pathScan"
	fi
done

#On va dans le dossier et on calcule la taille avant pour voir
cd "$pathScan"
tailleAvant=`du -sh`
echo "Taille :$tailleAvant"
echo -e "\nDébut du scan..."

#La ça se complique sévèrement... Je dois mettre dans une liste :
#Tout ce qui n'est ni du son (.mp3/.m4a/.wav/.flac/.ogg...) ni des images(.jpg/.jpeg/.png)
mp3s=`ls -R | grep .mp3 > list`
