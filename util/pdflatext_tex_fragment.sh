#!/bin/bash
echo "running pdflatex_tex_frament_sh script...";
#the xtable package generate latex fragment
#this generate a complete pdf document
currentOutDir=$1;
texFramgmentFilePath=$2;
texFramgmentFileName=$(basename "$texFramgmentFilePath");

tempCompleteLatexFile="$currentOutDir/Temp$texFramgmentFileName";

touch "$tempCompleteLatexFile";

#printf   "\documentclass{minimal}\n"  >> "$tempCompleteLatexFile"; DONT DEFINE TABLES
#printf   "\documentclass{report}\n"  >> "$tempCompleteLatexFile";
printf   "\documentclass{article}\n"  >> "$tempCompleteLatexFile";
printf   "\usepackage[portuguese]{babel}" >> "$tempCompleteLatexFile";
## not needed with fedora because its already utf8 configured printf   "\usepackage[utf8]{inputenc}" >> "$tempCompleteLatexFile";
printf   "\usepackage[T1]{fontenc}" >> "$tempCompleteLatexFile";

printf "\usepackage{lmodern}\n"       >> "$tempCompleteLatexFile";
printf   "\\\begin{document}\n"           >> "$tempCompleteLatexFile"
cat "$texFramgmentFilePath"           >>  "$tempCompleteLatexFile";
printf  "\\\end{document}\n"             >> "$tempCompleteLatexFile";
pdflatex  "$tempCompleteLatexFile";

