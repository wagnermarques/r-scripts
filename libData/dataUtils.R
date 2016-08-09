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
        
        varObj <- dtaObj[[var]];

        printOrgModeSection1(paste("#Variable Inventary: var = ", paste(var,typeof(varObj))));
        printOrgModeSection2("##The var...");
        print(varObj);

        printOrgModeSection3("###The frequencies of the var")
        varObj.freq = table(varObj);        
        print(varObj.freq);        

        printOrgModeSection3("###Printing the frequencias in output dir as latex files");
        xtblObj <- xtable(dtaObj);
        xtbVar <- xtable(varObj.freq);
        
        varTexFileName <- paste(var,"tex",sep=".");
        varHtmlFileName <- paste(var,"html",sep=".");

        print.xtable(
            xtbVar, type="Latex",
            include.rownames=TRUE, 
            file=paste(currentOutDir,varTexFileName, sep="/"));

        print.xtable(
        xtbVar, type="html",
        file=paste(currentOutDir,varHtmlFileName, sep="/"));

        system(paste(cmd_pdflatext_for_tex_fragment(varTexFileName), " > /dev/null 2>&1"));
        #xtable(varObj.freq);
        #print(paste(paste("Variable ",var), class(dtaObj[[var]]), sep=" as "));
        #print(str(dtaObj[[var]]));
        #print(unique(dtaObj[[var]]));
        #print("TODO: missing impact");
        ##xtable(varObj);        
    }
    
}


generateXTableFilesThatPresentsDataReaded <- function(dtaObj,dtaReadedFileName){
    print("[LOG generateXTableFilesThatPresentsDataReaded <- function(dtaObj){...] Generating pdf of data readed");
    print(paste("[LOG generateXTableFilesThatPresentsDataReaded <- function(dtaObj){...]: Saving output in currentOutDir",currentOutDir,sep=":"));
    print(paste("[LOG generateXTableFilesThatPresentsDataReaded <- function(dtaObj){...]: dtaReadedFileName received",dtaReadedFileName,sep="="));

    #function (x, caption = NULL, label = NULL, align = NULL, digits = NULL, 
    #display = NULL, auto = FALSE, ...) 
    #{
    #    UseMethod("xtable")
    #}

    xtblObj <- xtable(
        dtaObj[]);


    ##just to compose the final filename of latex table exported and final fine of html file name 

    ##first, latex filename
    #xtableGeneratedLatexFileName <-
    #    paste(currentOutDir, paste("xtableLatext",dtaReadedFileName, sep="_"), sep="_");
    #xtableGeneratedLatexFileDotTex <-
    #    paste(currentOutDir, paste(xtableGeneratedLatexFileName,"tex",sep="."), sep="_");
    xtableGeneratedLatexFileDotTex <- "xtableLatextTable.tex";

    ##and the html filename
    #xtableGeneratedHtmlFileName <-
    #    paste(currentOutDir, paste("xtableHtml",dtaReadedFileName, sep="_"), sep="_");
    xtableGeneratedHtmlFileName <- "xtableHtmlTable.html";
    
    ##ok, now generating the files...
    print.xtable(
        xtblObj, type="Latex",
        #hline.after=c(-1,0,nrow(dtaObj)),
        add.to.row = list(pos=list(c(-1,0,nrow(dtaObj))), command="\\hline \n"),
        file=paste(currentOutDir,xtableGeneratedLatexFileDotTex, sep="/"));

    print.xtable(
        xtblObj, type="html",        
        file=paste(currentOutDir,xtableGeneratedHtmlFileName,sep="/"));
  
    system(cmd_pdflatext_for_tex_fragment(xtableGeneratedLatexFileDotTex));

    print(xtblObj);
    
  }

