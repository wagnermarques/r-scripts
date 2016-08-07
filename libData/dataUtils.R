#!/usr/bin/env Rscript

thisScriptFullPath <- dirname(sys.frame(1)$ofile)
print(paste("[LOG]: loaded sucessfully" , thisScriptFullPath, sep=" => "))

#downloaFileDestinationDir <<- paste(getwd(), "data", sep="/")

## runs with list-data
lsDataDir <<- function(){
    print("-----------------------------------");
    print("[LOG]: Listando arquivos no diretorio data ");
    ##https://stat.ethz.ch/R-manual/R-devel/library/base/html/list.files.html
    list.files(path = "data",
               pattern = NULL,
               all.files = T,
               full.names = T,
               recursive = T,
               ignore.case = FALSE,
               include.dirs = T,
               no.. = T)
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

## runs with options read-data filedata
printVars <- function(dtaObj){
    print("[LOG printVars <<- function(dtaObj){...]: Printing the Variable Names");
    vars <- names(dtaObj);
    for ( var in vars){
        print(paste("------Variable", var));
        print(paste(paste("Variable ",var), class(dtaObj[[var]]), sep=" as "));
        print(str(dtaObj[[var]]));
        print(unique(dtaObj[[var]]));
        print("TODO: missing impact");
        #xtable(dtaObj[2,]);
    }
    
}


generateXTableFilesThatPresentsDataReaded <- function(dtaObj,dtaReadedFileName){
    print("[LOG generateXTableFilesThatPresentsDataReaded <- function(dtaObj){...] Generating pdf of data readed");
    print(paste("Saving output in currentOutDir",currentOutDir,sep=":"));
    print(paste("dtaReadedFileName received",dtaReadedFileName,sep="="));
    xtblObj <- xtable(dtaObj);

    xtableGeneratedLatexFileName <-
        paste(currentOutDir, paste("xtableLatext",dtaReadedFileName, sep="_"), sep="_");
    xtableGeneratedLatexFileDotText <-
        paste(currentOutDir, paste(xtableGeneratedLatexFileName,"tex",sep="."), sep="_");

    xtableGeneratedHtmlFileName <-
        paste(currentOutDir, paste("xtableHtml",dtaReadedFileName, sep="_"), sep="_");

    ##print.xtable(xtblObj, type="latex", file="filename.tex");
    ##print.xtable(xtblObj, type="latex", file="filename.tex");
    print.xtable(
        xtblObj, type="Latex",
        file=paste(currentOutDir,xtableGeneratedLatexFileDotText, sep="/"));
    #pdftolatex(xtableGeneratedLatexFileDotText,currentOutDir);
    #print.xtable(
    #    xtblObj, type="html",
    #    file=paste(currentOutDir,xtableGeneratedHtmlFileName,sep="/"));
    
    #pdftolatex(xtableGeneratedLatexFileName,currentOutDir);
}




