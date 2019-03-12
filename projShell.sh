#!/bin/bash

bold=$(tput bold)
normal=$(tput sgr0)
underline=$(tput smul)

help ()
{
  txt=("${bold}NAME
${normal}     projShell -- afficher les caractéristiques hardware de votre machine
${bold}SYNOPSIS
${normal}     projShell [-lw|-lu|-h|-help] [-s|--save ${underline}file_name${normal}]
${bold}DESCRIPTION
${bold}     -lu${normal}     Affiche les caractéristiques du processeur
${bold}     -lw${normal}     Affiche les caractéristiques du matrièle
${bold}     -s|--save ${underline}file_name${normal}
${normal}          Enregistre dans une fichier les informations.
${normal}          ${underline}file_name${normal} argument c'est le nom du fichier ou le lien.
${bold}     -h|-help
${normal}          Affiche le manuel de cette commande
${bold}AUTHORS
${normal}   This manual page was written by KATTAX <mohamed.khammeri@esprit.tn>." );
  echo "$txt";
}
export -f help;

save ()
{
  #now=$(date)
  now=$(date +"%d.%m.%Y_%H.%M.%S");

  if [[ -z $2 ]]; then
    #echo "Current date: $now";
    echo "-------------------------------------------" >> $now;
    echo $now "$1 commande" >> $now;
    echo "-------------------------------------------" >> $now;
    $1 >> $now;
  else
    echo "-------------------------------------------" >> $2;
    echo $now "$1 commande" >> $2;
    echo "-------------------------------------------" >> $2;
    $1 >> $2;
  fi
}

on_click()
{
  yad --text=$(help)
}
export -f on_click;

main()
{
  retour=$(yad --width="300" --text="Welcome to our Application :" \
  --image="./processor_32.png" --window-icon="./processor_32.png" \
  --form  --field="LSCPU":CB  --field="LSHW":CB  \
  "^lscpu -a ! lscpu --online ! lscpu --offline" "^lshw -html ! lshw -json" \
  --button="Exit"!gtk-cancel:1 \
  --button=gtk-help:3 \
  --button=gtk-save:4 \
  --button=gtk-ok:0 \
  --title="Projet Chemek")
  case $? in
    0)
    #ok
    now=$(date +"%d.%m.%Y_%H.%M.%S");
    choice1="$(cut -d "|" -f 1 <<< $retour)"
    choice2="$(cut -d "|" -f 2 <<< $retour)"

    chExecute1="$choice1-e=CPU,CORE,ONLINE"

    if [[ $choice2 == *"html"* ]]; then
      $choice2 > "lshw_${now}.html"
      echo "html";
    elif [[ $choice2 == *"json"* ]]; then
      $choice2 > "lshw_${now}.json"
    fi
    ch1YAD=$(yad --list --grid-lines=hor \
    --width=400 --separator=":" --height=400 --center \
    --title="List" --no-click --no-selection --no-rules-hint \
    --column "CPU" --column "CORE" --column "ONLINE" \
    --button="Save!gtk-save":14 \
    --button="OK!gtk-ok":0 \
    $(eval "$chExecute1"))
    if [[ $? -eq 14 ]]; then
      echo $(eval "$chExecute1") > "lscpu_${now}";
    fi
    ;;
    1 | 252)
    #sortie
    exit 0
    ;;
    3)
    #help
    h=$(yad --center --title="Help" --image="./helpScreen.jpg" --button=gtk-ok:0)
    ;;
    4)
    #save
    s=$(yad --center --align-center --image="./checked.png" --button=gtk-ok:0 \
    --text "<b>Sauvgarde avec succés</b>" --title="Save")
    ;;
  esac
  #retour main
  [[ $? =~ ^(0|1)$ ]] && main
}

case $1 in
  "-lu" )
  save "lscpu" $3
  ;;

  "-lw" )
  save "lshw" $3
  ;;

  "-h"|"-help" )
  help
  ;;

  *)
  main
  #save "lscpu"
  #save "lshw"
  ;;

esac
