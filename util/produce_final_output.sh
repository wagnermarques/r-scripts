#!/bin/bash

echo "running produce_final_output.sh...";

currentOutDir=$1;
outputTexFileName="output.tex"

cd "$currentOutDir"
touch $outputTexFileName

insertTexPreambule(){
    #https://bugs.launchpad.net/ubuntu/+source/tex-common/+bug/775546
    printf   '\\documentclass{article}\n'  >> "$outputTexFileName";
    printf   '\\usepackage[portuguese]{babel}\n' >> "$outputTexFileName";
    printf   '\\usepackage[T1]{fontenc}\n' >> "$outputTexFileName";
    printf   '\\usepackage{lmodern}\n'  >> "$outputTexFileName";
    printf   '\\begin{document}'  >> "$outputTexFileName"
    printf   '\n' >> "$outputTexFileName"
}

insertAllTexFragments(){
    #to understand this find command
    #http://alvinalexander.com/linux-unix/linux-find-multiple-filenames-patterns-command-example
    #use just xtable produced file
    #and -not Temp files tha was produced by pdflatext_tex_fragment.sh script
    find "$currentOutDir" -type f \( -name "*.tex" -and -not -iname "Temp*" \) -print0 | xargs -0 -I texFileFinded cat texFileFinded >> $outputTexFileName
}

insertFinalTexToFinishOutputTexFile(){
    echo  "\end{document}" >> "$outputTexFileName";
}

produce_final_output_html_file(){

    #pandoc -s $outputTexFileName -o ouput.odt
    #pandoc $outputTexFileName -o ouputOpenOffice.odt
    htlatex $outputTexFileName
    #latex2rtf $outputTexFileName

    #http://popularubuntuquestions.com/how-to-convert-tex-into-odt/
    #latex2html $outputTexFileName -split 0 -no_navigation -info "" -address "" -html_version 4.0,unicode
    #latex2html $outputTexFileName -split 0 -no_navigation -info "" -address "" 
    libreoffice --headless --convert-to odt:"OpenDocument Text Flat XML" output.html    
}

insertTexPreambule
insertAllTexFragments
insertFinalTexToFinishOutputTexFile
produce_final_output_html_file


