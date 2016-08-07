#!/usr/bin/env Rscript

pathForRScriptsWorkspace <- getwd();
pathForRScriptDataDir <- paste(pathForRScriptsWorkspace,"data",sep="/");
currentOutDir <- NULL;##It is defined at each script executions.

#pathForRLIBS <- paste(pathForRScriptsWorkspace,"R_LIBS", sep="/");

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
    print(paste("[LOG handleScriptArgs <-function(args){...]:",toString(args)));
    currentOutDir <<- createCurrentOutputDirThisExecution();

    if (length(args)==0) {
        usage();
        stop("Please provide read usage.n", call.=FALSE)
    } else if (length(args)==1) {
        singleArgHandle(args);
    }else if (length(args)==2){
        twoArgHandle(args);
    }
}

runSampleSuicideDataAnalisys <- function(){
    cmd  <- "./examples/suicide-data-analisys/suicide-data-analisys.R"
    wait <- true; # run the script asyncrounously
    
    args <- c("","desc-vars","missing-values-per-case");
              ##http://www.spss-tutorials.com/spss-data-preparation-6-inspect-cases/
              
}

usage <- function(){
    message ("USAGE: change to r-script dir, ./run.R arg1 arg2 arg3");
    message ("./run.R list-data to list data files ir data dir")
}



singleArgHandle <- function(args){
    arg <- args ##args with one is not a vector, so lets call it arg 
    print(paste("[LOG (singleArgHandle)]: one argument provided: ",arg));

    if(arg == "list-data"){
        lsDataDir();
    }
    
    if(arg == "data-in-session"){
        lsDataSetsInSession();
    }
    
    
}##singleArgHandle <- function(args){

twoArgHandle <- function(args){
    print(paste("[LOG twoArgHandle <- function(args){...]: arguments provided ",toString(args)));
    dataToReadFileName <- args[2];
    if(toString(args[1]) == "read-data"){
        print(paste("[LOG twoArgHandle <- function(args){...]: reading data ", paste(pathForRScriptDataDir,dataToReadFileName,sep="/")))
        
        ##read_ods(paste(pathForRScriptDataDir,args[2],sep="/"),
        ## sheet = 1)

        tbl <- read.table(
            paste(pathForRScriptDataDir,dataToReadFileName,sep="/"),            
            sep=",",
            header=TRUE,
            stringsAsFactors=TRUE);
        
        printVars(tbl);
        print(head(tbl));
        generateXTableFilesThatPresentsDataReaded(tbl,dataToReadFileName);
       
    }else{
        top("Please prove file-name do read-data");        
    }
    
    
    if(args[1] == "samples" && args[2] == "suicide-data-analisys"){
        runSampleSuicideDataAnalisys();
    }
        
    
}


args = commandArgs(trailingOnly=TRUE)
handleScriptArgs(args);

runScript  <-  function(scriptPath){
    
}

