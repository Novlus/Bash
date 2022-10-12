#!/bin/bash
# $RANDOM renvoie un entier différent à chaque appel.


function gagnant()
{
        echo "Bravo vous avez gagné"
        echo "Il vous aura fallu: $nombreCoups essais"
        let "continuer=0"
        score=$nombreCoups
        #echo "$nbCaracteresPseudo"
        read -p "Quel est le nom du joueur qui vient de gagner ?" nomUtilisateur
        while ((${#nomUtilisateur}>$nbCaracteresPseudo))
        do
          echo "Vous avez dépassé le nombre maximum de caractères pour le nom de l'utilisateur"
          read -p "Quel est le nom du joueur qui vient de gagner ?" nomUtilisateur
        done

        echo "Le score est de $score"
        echo "et le nom du joueur est $nomUtilisateur"

        echo -e "$nomUtilisateur $score" >> hightScores.txt

        touch hightScores2.txt

        sort -k 2 -n hightScores.txt > hightScores2.txt

        sort -k 2 -n hightScores2.txt > hightScores.txt

        rm hightScores2.txt

      #nombreEssai= echo "head -n 1 conf.txt | awk '{print $2}'"
}


function perdant()
{
      echo "Vous avez perdu car vous avez dépassé le nombre d'essais maximum"
      let "continuer=0"
}


function verification()
{
  while ((nombreUtilisateur <1 || nombreUtilisateur >99 || verifNombre==0))
  do
    read -p "Le nombre que vous avez rentrée n'est pas correct " nombreUtilisateur
    if [[ -n ${nombreUtilisateur//[0-9]/} ]]; then
      let "verifNombre=0"
    else
      let "verifNombre=1"
    fi
  done
}

function verificationDifficulte()
{
  read -p "Choisissez votre niveau de difficulté 1,2 ou 3 (1= facile 2= moyenne 3=difficile) : " difficulte
  while ((difficulte<=0 || difficulte>3 || verifNombre==0))
  do
    read -p "La difficulté que vous avez rentrée n'est pas correct " difficulte
    if [[ -n ${nombreUtilisateur//[0-9]/} ]]; then
      let "verifNombre=0"
    else
      let "verifNombre=1"
    fi
  done
}

function affichageScore()
{
  touch hightScores2.txt
  sed -n -e '1,'$nbScores'p' hightScores.txt > hightScores2.txt
  cat -n hightScores2.txt
  rm hightScores2.txt
}





continuer=1
varConf=$( cat conf.txt)
tableau=()
echo $varConf

for word in $varConf
do
    tableau+=($word)
    #echo ${tableau[@]}
   
done
read nbEssais <<< "${tableau[1]}"
read nbScores <<< "${tableau[3]}"
read nbCaracteresPseudo <<< "${tableau[5]}"

echo "Vous allez devoir trouver 1 nombre aléatoire entre 1 et 99:"
echo "-----------------"
nombre=${RANDOM:0:2}
nombreCoups=1
verifNombre=0
echo $nombre

verificationDifficulte
if (($difficulte==1)); then
  let "nbEssais=nbEssais*2"
elif (($difficulte==2)); then
  let "nbEssais=nbEssais"
else
  let "nbEssais=nbEssais/2"
fi

read -p "Entrée un nombre entre 1 et 99 : " nombreUtilisateur

verification

nbLigneScores=0
echo $nombreUtilisateurverifNombre=0
while (($continuer == 1))
do

  
  if (($nombreUtilisateur <$nombre)); then
    echo "le nombre que vous cherchez est plus grand"
    read -p "Entrée un nombre entre 1 et 99 : " nombreUtilisateur
    verification

    let "nombreCoups=nombreCoups+1"
    if (($nombreUtilisateur==$nombre)); then
      gagnant
      affichageScore

        #cat -n hightScores.txt

        #sed -ri '1s/(.*)/1er\2/' hightScores.txt

        #head -n "$nbScores" hightScores.txt

      #nombreEssai= echo "head -n 1 conf.txt | awk '{print $2}'"
    elif (($nombreCoups>$nbEssais)); then
      perdant
    fi


  elif (($nombreUtilisateur>$nombre)); then
    echo "le nombre que vous cherchez est plus petit"
    read -p "Entrée un nombre entre 1 et 99 : " nombreUtilisateur
    verification
    let "nombreCoups=nombreCoups+1"
    if (($nombreUtilisateur==$nombre)); then
      gagnant
      affichageScore

        #sed -ri '1s/(.*)/1er\2/' hightScores.txt

        #cat -n hightScores.txt

        #head -n "$nbScores" hightScores.txt
    elif (($nombreCoups>$nbEssais)); then
       perdant
    fi

  elif (($nombreCoups>$nbEssais)); then
    perdant
  
    


  else
    gagnant
    affichageScore

    #cat -n hightScores.txt

    #sed -ri '1s/(.*)/1er\2/' hightScores.txt

    #head  -n "$nbScores"  hightScores.txt
  fi
done




exit 0
