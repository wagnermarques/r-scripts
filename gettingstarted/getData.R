#!/usr/bin/env Rscript

downloadFile <- function ( url, destFileName, ...){
    print(paste("!!! downloadFile from ", url))
    download.file(
        url,
        paste(scriptWorkspaceDownloadDestFilesDirectory, destFileName, sep="/"),
        )
}

##    url.data <- fread(tmpFile, ...)
##        return(url.data)


