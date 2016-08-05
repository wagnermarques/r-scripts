#!/usr/bin/env Rscript

pathForRScriptsWorkspace <- getwd();
pathForRLIBS <- paste(pathForRScriptsWorkspace,"R_LIBS", sep="/");

pathToRPackages <- paste(pathForRScriptsWorkspace,"data/Rpackages", sep="/");
pathToLibUtils <- paste(pathForRScriptsWorkspace,"libUtils", sep="/");
pathToLibPackages <- paste(pathForRScriptsWorkspace,"libPackages", sep="/");
pathToLibData <- paste(pathForRScriptsWorkspace,"libData", sep="/");


source(file = paste(pathToLibUtils,"utils.R", sep="/"));
source(file = paste(pathToLibPackages,"/setupPackages.R", sep="/"));
source(file = paste(pathToLibData,"/dataUtils.R", sep="/"));
source(file = paste(pathToLibData,"/readData.R", sep="/"));



##HANDLING SCRIPT ARGUMENTS
handleScriptArgs <-function(args){
    if (length(args)==0) {
        usage();
        stop("Please provide read usage.n", call.=FALSE)
    } else if (length(args)==1) {
        print(args)
        args[2] = "out.txt"
    }
}

usage <- function(){
    message ("USAGE: change to r-script dir, ./run.R arg1 arg2 arg3");
}

singleArgHandle <- function(args){

}

twoArgHandle <- function(args){

}


args = commandArgs(trailingOnly=TRUE)
handleScriptArgs(args);

runScript  <-  function(scriptPath){

}
