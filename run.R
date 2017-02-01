#!/usr/bin/env Rscript

##change to run.R dir is needed to the function getwd() returns its directory called for a  workspacedir concept
pathForRScriptsWorkspace <- getwd();
pathForRScriptDataDir <- paste(pathForRScriptsWorkspace,"data",sep="/");
currentOutDir <- NULL;##It is defined at each script executions. So, may not the same as pathForRScriptsWorkspace

#pathForRLIBS <- paste(pathForRScriptsWorkspace,"R_LIBS", sep="/");

pathToRPackagesDir <- paste(pathForRScriptsWorkspace,"data/Rpackages", sep="/");
pathToLibUtilsDir <- paste(pathForRScriptsWorkspace,"libUtils", sep="/");
pathToLibPackagesDir <- paste(pathForRScriptsWorkspace,"libPackages", sep="/");
pathToLibDataDir <- paste(pathForRScriptsWorkspace,"libData", sep="/");


source(file = paste(pathToLibUtilsDir,"utils.R", sep="/"));
source(file = paste(pathToLibPackagesDir,"/setupPackages.R", sep="/"));
source(file = paste(pathToLibDataDir,"/dataUtils.R", sep="/"));
source(file = paste(pathToLibDataDir,"/readData.R", sep="/"));
source(file = paste(pathToLibDataDir,"/dataAnalyseDescriptives.R", sep="/"));


##HANDLING SCRIPT ARGUMENTS
handleScriptArgs <-function(args){
    print(paste("[LOG handleScriptArgs <-function(args){...]:",toString(args)));

    if (length(args)==0) {
        handleWithNoArgs();
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


#if the user run this script run.R with no parameters this functions print available options 
usage <- function(){
    message ("");
    message ("USAGE: change to r-script dir, ./run.R arg1 arg2 arg3");
    message ("Available options...");
    message ("./run.R list-data [list data files ir data dir]")
    message ("./run.R read-data  [name-of-datafile]"); 
}


handleWithNoArgs <- function(){
    usage();
}


singleArgHandle <- function(args){
    print("[LOG Run.R] singleArgHandle <- function(args){...");;
    print(paste("[LOG (singleArgHandle)]: one argument provided: ",args));
    arg <- args ##args with one is not a vector, so lets call it arg 
 
    if(arg == "list-data"){
        print(".");
        print(".");
        lsDataDir();
        print(".");
        print(".");
    }
    
}##singleArgHandle <- function(args){


twoArgHandle <- function(args){
    print(paste("[LOG twoArgHandle <- function(args){...]: arguments provided ",toString(args)));                                 
    dataToReadFileName <- args[2];

    if(toString(args[1]) == "read-data"){
        print("if(toString(args[1]) == \"read-data\"){...");
        currentOutDir <<- createCurrentOutputDirThisExecution();
        print(paste("[LOG twoArgHandle <- function(args){...]: reading data ", paste(pathForRScriptDataDir,dataToReadFileName,sep="/")))       
 
        ##TODO ABSTRACT DATA READER FILE TO SERVERAL EXTENXIONS
        ## WOKS OK WITH A TEXT FILE
        ## to experiment: ./run.R read-data data-as-txt-file.txt and check output dir (Ha, there is bug already, press q when script seems to sleep to continue)
        ##tbl <- read.table(
        ##    paste(pathForRScriptDataDir,dataToReadFileName,sep="/"),            
        ##    sep=",",
        ##    header=TRUE,
        ##    #colClasses=c(ano="factor", Curso="factor"),
        ##    stringsAsFactors=TRUE);


        ##infor path of datafile is not needed because this script will look for datafile in pathForRScriptDataDir
        ##but pass a factor config is needed
        ##for exemple readDataConfigFactorVariables1 is a function in readData.R
        ##you need to write you configFactorVariable to pass here, use dataUtils.R for this work

        ##please write your
        ##readOptionConfigFunction function and
        ##factorVariablesConfigFunction function
        ## in readData.R file
        ##readData function dont default ones
        ##Be carefull the select values for colum names to be read is case sensitive
        colNamesToReadVector <- c(
                                  "rm"  ,
                                  "nomecurso" ,
                                  "tipocurso",
                                  "Periodo",
                                  "ano",
                                  "semestreevasao",
                                  "anoevasao",
                                  "motivo"
                                  );
        ColTypes <- list(
                         rm="integer",
                         nomecurso="factor",
                         tipocurso="factor",
                         Periodo="factor",
                         ano="integer",
                         semestreevasao="factor",
                         anoevasao="integer",
                         motivo="factor");
        
        colNameLabels <- list(
                              rm="matricula",
                              nomecurso="Curso",
                              tipocurso="Tipo do Curso",
                              Periodo="Periodo",
                              ano="Ano do Curso Evadido",
                              semestreevasao="Semestre do Curso Evadido",
                              anoevasao="Ano Da Evasao",
                              motivo="Motivo"
                              );

        Freq <- list(
            "anoevasao"
        );
        
        #readData is from readData.R
        tbl <- readData(fileType = "csv",
                        fileName = dataToReadFileName,
                        sheet = 1,                        
                        colNamesToRead = colNamesToReadVector,
                        readOptionConfigFunction = setRScriptDefaultReadOptions,
                        factorVariablesConfigFunction = factorVariablesConfiguration,
                        numericVariablesConfiguration = numericVariablesConfiguration);

        #printOrgModeSection1("##### Overview of data");        
        #printDataFrameInfo(tbl);    
        #printHorizontalLine();


        #printOrgModeSection1("##### DESC VARIABLES");
        #printVars(tbl);        
        #printHorizontalLine();

        setColumnTypes(tbl,ColTypes);#from dataUtils.R
        #printVars(tbl);
        #printHorizontalLine();

        
        #outputRowDataInXTable(
        #    dtaObj=tbl,
        #    dtaReadedFileName=dataToReadFileName,
        #    colsPerTexFile=6);#dataUtils.R

        ##dataAnalyseDescriptives.R
        descriptiveStatisticsAsFactorVar(
            dtaObj=tbl,
            factorVariablesNames=c(
              "anoevasao",
              "nomecurso",
              "tipocurso",
              "Periodo",
              "semestreevasao",
              "motivo"));
        #descriptiveStatisticsForNumericVar
        
        #system(cmd_pdflatext_for_tex_fragment(xtableGeneratedLatexFileName));
        ##outputFreqXTable();
        

        printHorizontalLine();
    }    
    
    if(args[1] == "samples" && args[2] == "suicide-data-analisys"){
        runSampleSuicideDataAnalisys();
    }


    ##The produceOpenOfficeOutput(args[2]); is for create openoffice (odt file) with a merge
    ##of all latex file produced by xtable
    ##the arg[2] is output file name
    if(args[1] == "produce-openoffice-output"){
        print("if(arg == \"produce-openoffice-output\"){... TRUE");
        print(".");
        print(".");
        produceOpenOfficeOutput(args[2]);
        print(".");
        print(".");
    }

}##twoArgHandle <- function(args){...


args = commandArgs(trailingOnly=TRUE)
handleScriptArgs(args);

runScript  <-  function(scriptPath){
    
}

