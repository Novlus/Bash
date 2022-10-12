.PHONY: run
run:
	./IUT-ExoBash-CREMON.sh

scores: 
	cat -n hightScores.txt 

reset-scores:
	printf "" > hightScores.txt
	cat  hightScores.txt 

score-by: 
	read -p "Ecrivez le nom de l'utilisateur dont vous souhaitez connaitre le score ?" nomUtilisateur; \
	grep -n $$nomUtilisateur hightScores.txt
