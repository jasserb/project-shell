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
${normal}   This manual page was written by KATTAX <mohamed.khammeri@esprit.tn> and Nermine <nermine.belarbi@esprit.tn>." );
  echo "$txt";
}
export -f help;
