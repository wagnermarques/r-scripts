#!/usr/bin/env Rscript

thisScriptFullPath <- dirname(sys.frame(1)$ofile)
print(paste("[LOG]: loaded sucessfully" , thisScriptFullPath, sep=" => "))

askUserForInput <- function(msgForAskUser){
    message(msgForAskUser)
    userInputValue <- scan(file="stdin", what = character(),  n=1, quiet = TRUE)
    return(userInputValue)
}

createCurrentOutputDirThisExecution <- function(){
    print("[LOG createDirForOutput <- function(){...]: Creating output folder ");
    outPutDirName <- format(Sys.time(), "Output_%d_%b_%Y_%X");
    outputDirName <- paste(pathForRScriptsWorkspace,outPutDirName,sep="/")

    dir.create(outPutDirName);
    print(paste(
        "[LOG createDirForOutput <- function(){...]: CurrentOutPutDir folder created",
        outputDirName));
    return(outPutDirName);
}


#TODO: MAKE THIS FUNCTIONS TO WORK
#pdftolatex <- function(pathToTexFile,currentOutDir){
#    print("[LOG pdftolatex <- function(pathToTexFile,currentOutDir){...]: Generate pdf from Latex File");
#    cdToWorkdirCommand <- paste("cd",currentOutDir);
#    system(paste(cdToWorkdirCommand, " && printf \"\begin{document}\" > templatex && cat *.tex >> templatex && print \"\end{document}\" >> templatex && pdflatex templatex" ));
#}
