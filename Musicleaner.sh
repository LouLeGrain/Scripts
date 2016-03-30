#!/bin/bash
# V1.0
echo -e "\n########## Nettoyage de dossiers de musique ##########"
echo -e "\nPurger les fichiers superflus (thumbs, nfo, txt et autres..)"

#On définit par défaut le chemin de recherche ~/Musique
#Et un truc bidon pour la saisie, sinon il rentre jamais dans le while..
pathScan="$HOME/Musique"
saisiePathScan="carotte"
launchPath="`( cd \"$lauchpath\" && pwd )`"

#Tant que la saisie sera pas un dossier existant
while [ ! -e $saisiePathScan ]
do
	echo -en "\n> Dossier a scanner (laisser vide pour ~/Musique)"
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
	echo "Le scan s'effectuera dans $pathScan"
	fi
done

#On va dans le dossier et on calcule la taille avant pour voir
cd "$pathScan"
tailleAvant=`du -sh`
echo "Taille :$tailleAvant"
echo -en " Début du scan..."
touch deleteList.txt
# listage des fichiers (-v = sauf)
find -type f | grep -v -e .mp3 -e .flac -e .wav -e .wma -e .m4a -e .ogg -e .zip -e .rar -e .jpg -e .jpeg -e .JPG -e .png -e .PNG > deleteList.txt
echo -e "Scan terminé ! \nVérifiez la liste des fichiers a supprimer, puis enregistrez la et quittez l'éditeur."
sleep 4
gedit deleteList.txt
echo -en "\nVoulez vous vraiment supprimer ces fichiers ? (O/N)"
read conf
    if [[ "$conf" == "o" ]]
    then
     while read i ; do read i ; rm -v "$i" ; done < deleteList.txt
     echo -e "Suppression effectuée !"
    else
     echo -e "Suppression annulée"
    fi
 rm deleteList.txt
tailleApres=`du -sh`
echo "Taille :$tailleApres"
exit 0;