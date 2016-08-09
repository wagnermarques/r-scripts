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

#when file or dir path has spaces enclose it between single quites is need
enclosePathWithSingleQuote <- function(path){
    pathWithFirstSingleQuote <- paste("'", path, sep="");
    pathEnclosedWithSingleQuote <- paste(pathWithFirstSingleQuote, "'", sep="");
    return(pathEnclosedWithSingleQuote);
}

##xtable generate latex framents. pdflatex do not generate pdf just for framgments
##so the are a script pdflatext_tex_fragment.sh that complets latex tags like \documents and so on to make pdflatex works
##this function generate the string command to run this script with system()
cmd_pdflatext_for_tex_fragment <- function(texFragmentFilePath){
   ##Now we need to compose string command to pass to the system to generate pdf from latex fragmente
    FullPathToCurrentOutDir <-  enclosePathWithSingleQuote(paste(pathForRScriptsWorkspace, currentOutDir, sep="/"));
    ChangeDirTO_FullPathToCurrentOutDir = paste("cd", FullPathToCurrentOutDir);
    pdflatexShellScriptPath <- enclosePathWithSingleQuote(paste(pathForRScriptsWorkspace,"util/pdflatext_tex_fragment.sh", sep="/"));

    ChangeDirTO_FullPathToCurrentOutDir_andLaunch_pdflatexShellScriptPath_FullPathToCurrentOutDir_texFragmentFilePath <- paste(ChangeDirTO_FullPathToCurrentOutDir,
             paste(paste(pdflatexShellScriptPath,FullPathToCurrentOutDir),texFragmentFilePath), sep=" && ");
    print(ChangeDirTO_FullPathToCurrentOutDir_andLaunch_pdflatexShellScriptPath_FullPathToCurrentOutDir_texFragmentFilePath)

    return (ChangeDirTO_FullPathToCurrentOutDir_andLaunch_pdflatexShellScriptPath_FullPathToCurrentOutDir_texFragmentFilePath);
}

printOrgModeSection1 <- function(msg){
    message(paste("*",msg));
}
printOrgModeSection2 <- function(msg){
    message(paste("**",msg));    
}
printOrgModeSection3 <- function(msg){
    message(paste("***",msg));    
}
