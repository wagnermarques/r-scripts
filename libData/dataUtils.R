#!/usr/bin/env Rscript

thisScriptFullPath <- dirname(sys.frame(1)$ofile)
print(paste("[LOG]: loaded sucessfully" , thisScriptFullPath, sep=" => "))

#downloaFileDestinationDir <<- paste(getwd(), "data", sep="/")

lsDataDir <<- function(){
    print("-----------------------------------")
    print(paste("Listando arquivos no diretorio data ",downloaFileDestinationDir))
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

#printVars <<- function(dtaObj){
#    print("SHOW VARS...")
#    vars <- names(dtaObj)
#    print(vars)
#}




