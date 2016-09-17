#!/usr/bin/env Rscript

##-------------lOGIN SOMETHING
thisScriptFullPath <- dirname(sys.frame(1)$ofile)
print(paste("[LOG]: loaded sucessfully" , thisScriptFullPath, sep=" => "))
##-------------


#downloaFileDestinationDir <<- paste(getwd(), "data", sep="/")

## runs with list-data
lsDataDir <<- function(){
    print("-----------------------------------");
    print("[LOG]: Listando arquivos no diretorio data ");
    ##https://stat.ethz.ch/R-manual/R-devel/library/base/html/list.files.html
    fileList <- list.files(path = "data",
                           pattern = NULL,
                           all.files = T,
                           full.names = T,
                           recursive = T,
                           ignore.case = FALSE,
                           include.dirs = T,
                           no.. = T)
    for (i in 1:length(fileList)){
        message(fileList[[i]]);
    }
}

##run with data-in-session parameter
lsDataSetsInSession <- function(){
    data()
}


##url from data will be gettering
##fileName fileName the file downloaded will be renamed for
##fileType tipo de arquivo (dbf, xls, ods...)
##compressedType (zip, rar, tar.gz...)
##if compressedType is diferent of null, the file is compressed and must be uncrompressed
##last parameter is a function that kwnows how to import the data
downloadDataFromUrl <<- function(url,fileName){
    ##https://stat.ethz.ch/R-manual/R-devel/library/utils/html/download.file.htlm
    fileNameWithFullPath <- paste(downloaFileDestinationDir,fileName,sep="/")
    if(file.exists(fileNameWithFullPath)) {
        return(fileNameWithFullPath)
    }else{
        print (paste("downloading ",fileNameWithFullPath))
        print (paste("Url: ", url))
        print (paste("fileNameWithFullPath: ",fileNameWithFullPath))
        download.file(url,
                      fileNameWithFullPath,
                      "auto",
                      quiet = FALSE,
                      mode = "w",
                      cacheOK = TRUE,
                      extra = getOption("download.file.extra"))        
    }##if/else
    
    return(fileNameWithFullPath)
}


uncompressZipFile <- function(filePath){
        unzip(filePath, files = NULL, list = FALSE, overwrite = TRUE,
              junkpaths = FALSE,
              exdir = downloaFileDestinationDir,
              unzip = "internal",
              setTimes = FALSE)        
}


configureVariable <-  function(dtaObj,varObj,varName){
    print(paste("[LOG configureVariable <-  function(dtaObj,varObj,varName){...] >>> About to configure variable", varName));

    if( varName == "sexo" ){
        print("[LOG configureVariable <-  function(dtaObj,varObj,varName){...] >>> var sexo");
        varObj <- factor(varObj, levels = c(0, 1),labels = c("Feminino","Masculino"));

    }else if(varName == "ano" ){
        print("[LOG configureVariable <-  function(dtaObj,varObj,varName){...] >>> var ano");
        varObj <- ordered(varObj, levels = c(1, 2, 3), labels = c("Primeiro Ano","Segundo Ano","Terceiro Ano"));
        
    }else{
        return (varObj);
    }       
    return(varObj);
}

factorVariablesConfiguration <- function(dtaObj){
    print("[LOG setRScriptDefaultFactorVariableConfiguration <- function(dtaObj){...] Running...");
    
    colnames(dtaObj)[colnames(dtaObj)=="Curso"] <- "new_name";
    ##setnames(dtaObj, old=c("ano","Curso"), new=c("AnoCursando", "Nome_do_Curso"));
    return(dtaObj);
}
numericVariablesConfiguration <- function(dtaObj){
    print("[LOG numericVariablesConfiguration <- function(dtaObj){...] Running...");
    
}

## runs with options read-data filedata
##Reconfigure this functions to rename columns, names
##or make pertinent changes and/or configuration in yout dataset
##know R is needed here :)
skipThisVar <- function(varName){
    varThatMustMeSkipped <- c("rm","nome","Local","tipocurso","classe","anosemeestre","data","tel","email","cel");
    if(varName %in% varThatMustMeSkipped){
        return(TRUE);
    }else{
        return(FALSE);
    }
}

printDataFrameInfo <- function(frame){
    print("[LOG:printDataFrameInfo(frame)...]");
    message("overview...str(frame)...");
    str(frame);
    message("head(frame)");
    frame[1:10,c("rm","Curso")];
}

printVars <- function(dtaObj){
    print("[LOG *printVars* <<- function(dtaObj){...]: Printing the Variable Names");
    vars <- names(dtaObj);    
    for ( var in vars){
        #if(skipThisVar(var)) { print(paste("skiping", var)); return }
        varObj <- dtaObj[[var]];
        printOrgModeSection1(paste("###: var = ", paste(var,typeof(varObj))));
        print(paste(paste(var, " : is.factor="), is.factor(varObj)));
        print(paste(paste(var, " : class="), class(varObj)));
        #descriptiveStatisticsAsFactorVar(dtaObj,varObj,var);
        
#        if (is.factor(varObj) == TRUE) {
#            print(paste(var , " is factor"));
#        }else if(is.numeric(varObj)){
#            print(paste(var , " is numeric"));
#        }else{
#            print("Var nao he nem factor nem numerica");
#        }
    }#for
            
        #if (is.Numeric(varObj)) descriptiveStatisticsForNumericVar(dtaObj,varObj);
}#function printVars

setColumnTypes <- function(dtaObj,cColTypes){
    print("[LOG dataUtils.R] setColumnTypes <- function(tbl,cColTypes){...");
    vars <- names(dtaObj);
    dtaObjTransformed <- NULL;
    for (var in vars){
        varObj <- dtaObj[[var]];
        if(!is.null(cColTypes[[var]])){
            message(paste(paste(paste("Setting ", var), "to ", cColTypes[[var]])));
            if(cColTypes[[var]] == "factor"){
                ##dtaObjTransformed <- transform(dtaObj, var = as.factor(var));
                dtaObj[[var]] <- as.factor(dtaObj[[var]]);
            }else if(cColTypes[[var]] == "integer"){
                ##dtaObjTransformed <- transform(dtaObj, var = as.numeric(var));
                dtaObj[[var]] <- as.integer(dtaObj[[var]]);
            }else if(cColTypes[[var]] == "decimal"){
                ##dtaObjTransformed <- transform(dtaObj, var = as.numeric(var));
                dtaObj[[var]] <- as.numeric(dtaObj[[var]]);
            }
        }else{
            message(paste("[ERROR dataUtils.R] Please adjust colNamesToReadVector and ColTypes correctly for variable ", var));            
        }        
    }#for
    ##printVars(dtaObjTransformed)
    return (dtaObj);        
}

##colsPerTexFile is for large tables of frequence that do not fit in the same pdf generated from tex file
##so, if 6 is passed for this paramenter
##the number os columns id divided by 6 and por each 6 columns is issued xtable to generate tex files
outputRowDataInXTable <- function(dtaObj,dtaReadedFileName,colsPerTexFile){

    print("[LOG outputRowDataInXTable <- function(dtaObj){...] Generating pdf of data readed");


    numColumns <- ncol(dtaObj);
    numOfXtableLatexFileToBeGenerated <- NULL;

    if ( (numColumns/colsPerTexFile) <= 1 ){
        numOfXtableLatexFileToBeGenerated <- 1;
    }else{
        numOfXtableLatexFileToBeGenerated <- as.integer((numColumns/colsPerTexFile)+ 1);
    }

    message("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
    message(paste("numColumns = ",numColumns));
    message(paste("numOfXtableLatexFileToBeGenerated =", numOfXtableLatexFileToBeGenerated));
    message("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
        
    xtblObj <- xtable(dtaObj);

    xtableGeneratedLatexFileName <- paste(dtaReadedFileName,"tex", sep=".");
    print.xtable(
        xtblObj, type="Latex",
        #tabular.environment="longtable",
        add.to.row = list(pos=list(c(-1,0,nrow(dtaObj))), command="\\hline \n"),
        file=paste(currentOutDir,xtableGeneratedLatexFileName, sep="/"));

    
    #for(i in seq(from=1, to=numColumns, by=colsPerTexFile)){
    #    xtableGeneratedLatexFileName <- paste(paste(dtaReadedFileName,i,sep=""),"tex", sep=".");
    #    message("-----------------------------");
    #    message(paste("i=",i));
    #    message(paste("colsPerTexFile=",colsPerTexFile));
    #    message(paste("i+colsPerTexFile-1=",i+colsPerTexFile-1));
    #    message("-----------------------------");
    #    print.xtable(
    #        xtblObj[,i:i+colsPerTexFile-1], type="Latex",
    #        #add.to.row = list(pos=list(c(-1,0,nrow(dtaObj))), command="\\hline \n"),
    #        file=paste(currentOutDir,xtableGeneratedLatexFileName, sep="/"));
    #}

    xtableGeneratedHtmlFileName <- paste(dtaReadedFileName,"html", sep=".");
    print.xtable(
        xtblObj, type="html",
        add.to.row = list(pos=list(c(-1,0,nrow(dtaObj))), command="\\hline \n"),
        file=paste(currentOutDir,xtableGeneratedHtmlFileName,sep="/"));
    
    ##system(cmd_pdflatext_for_tex_fragment(xtableGeneratedLatexFileName));
    system(cmd_pdflatext_for_tex_fragment(xtableGeneratedLatexFileName));
  }

