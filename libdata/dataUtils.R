#!/usr/bin/env Rscript
##cat(">>>> dataUtils.R loaded sucessfully...")



downloadDataFromUrl <<- function(url,fileName,compressedAs="zip",dataType){
    ##https://stat.ethz.ch/R-manual/R-devel/library/utils/html/download.file.html

    downloaFileDestinationDir <- "../data/"
    download.file(url,
                  paste("../data/",fileName),
                  "auto",
                  quiet = FALSE,
                  mode = "w",
                  cacheOK = TRUE,
                  extra = getOption("download.file.extra"))
}

