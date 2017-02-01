#!/usr/bin/env Rscript

##-------------lOGGIN SOMETHING
#Fix-me: thisScriptFullPath <- dirname(sys.frame(1)$ofile) #Error in sys.frame(1) : not that many frames on the stack
#print(paste("[LOG]: loaded sucessfully" , thisScriptFullPath, sep=" => "))
#print(paste("[LOG]: Using Rpackages dir for packages installations:", pathToRPackagesDir,sep="="))
##-------------

R_LIBS_USER <-"/home/rstudio/R_LIBS_USER"
R_REPO <-"http://cran.rstudio.com/"

###TODO learn to install packages as submodule
###for now sjPlot was not installed from submodule source
###but installing from CPAN
###pathToSjPlotFileToInstall <- paste(pathForRScriptsWorkspace,"devel/R", sep="/");



listOfPackagesToBeInstalledFromCPAN <- c(
    "RCurl",
    "data.table",
    #"stringr",
    "labeling","mime","scales","RColorBrewer",
    "ggplot2", "sjmisc" ,"sjPlot", "Rcpp",
    "xtable",
    "data.table",
    #xtable: Export Tables to LaTeX or HTML
    "xtable",
    #vcd: Visualizing Categorical Data
    #"vcd",
    #Functions for reading and writing data stored by some versions of
    #Epi Info, Minitab, S, SAS, SPSS, Stata, Systat and Weka and for reading and writing some dBase files.
    "foreign", 
    #"XML",#http://www.omegahat.net/RSXML/
    #"RJSONIO", #RJSONIO: Serialize R objects to JSON, JavaScript Object Notation
    #Provides comprehensive functionality to read, write and format Excel data. (depends of rjava)
    #"XLConnect",
    "readODS",   #read ODS files into R as data.frames
    "RSQLite",
    "DBI");

options(xtable.floating = FALSE)
options(xtable.timestamp = "")

installPackagesIfNotInstalledYet <- function(listOfPackagesToBeInstalledFromCPAN){
    ##thanks Juan Antonio Cano http://stackoverflow.com/questions/4090169/elegant-way-to-check-for-missing-packages-and-install-them
    for(library in listOfPackagesToBeInstalledFromCPAN) { 
        if(!isPackageInstalled(library))
        {
            install.packages(library,repos="http://cran.rstudio.com/",lib=R_LIBS_USER);
        }
    }
}

isPackageInstalled <- function(pkg){
    available <- suppressMessages(suppressWarnings(sapply(pkg, require, quietly = TRUE, character.only = TRUE, warn.conflicts = FALSE)))
    missing <- pkg[!available]
    if (length(missing) > 0) return(FALSE)
    return(TRUE)
}

installPackagesIfNotInstalledYet(listOfPackagesToBeInstalledFromCPAN);

##TODO, REFACTORING TO LOAD PKGS ONLY AS NEEDED
#library(stringr);
library(readODS);
library(sjPlot) ;
library(sjmisc);
library(xtable);
library(data.table);

options(xtable.floating = TRUE);
options(xtable.timestamp = "");

options(xtable.only.contents = FALSE);
options(xtable.add.to.row = NULL);
options(xtable.math.style.negative = FALSE);
options(xtable.math.style.exponents = FALSE);
options(xtable.html.table.attributes = "border=10");


options(xtable.include.rownames =  TRUE);
options(xtable.include.colnames =  TRUE);
#options(xtable.hline.after = c(-1,0,4,8));

##http://stackoverflow.com/questions/31024961/line-breaks-in-xtable-cells?rq=1
options(xtable.sanitize.text.function=identity)
