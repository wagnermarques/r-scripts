#!/usr/bin/env Rscript

##-------------lOGIN SOMETHING
thisScriptFullPath <- dirname(sys.frame(1)$ofile)
print(paste("[LOG]: loaded sucessfully" , thisScriptFullPath, sep=" => "))
print(paste("[LOG]: Using Rpackages dir for packages installations:", pathToRPackages,sep="="))
##-------------


###TODO learn to install packages as submodule
###for now sjPlot was not installed from submodule source
###but installing from CPAN
pathToSjPlotFileToInstall <- paste(pathForRScriptsWorkspace,"devel/R", sep="/");


##https://cran.r-project.org/web/packages/RCurl/
##http://www.rdocumentation.org/packages/RSQLite/versions/1.0.0
##http://www.rdocumentation.org/packages/RMySQL/versions/0.9-3/topics/RMySQL-package
##https://cran.rstudio.com/web/packages/RODBC/
##http://www.rforge.net/RJDBC/
##http://www.rdocumentation.org/packages/rJava/versions/0.9-8
##http://www.rforge.net/rJava/
##http://www.rdocumentation.org/packages/DBI/versions/0.4-1
##https://cran.r-project.org/web/packages/plyr/README.html
##http://ggplot2.org/
##https://cran.r-project.org/web/packages/stringr/README.html
##http://www.computerworld.com/article/2920117/business-intelligence/most-downloaded-r-packages-last-month.html
##https://cran.r-project.org/web/packages/stringr/vignettes/stringr.html
##https://cran.r-project.org/web/packages/mime/README.html
##https://cran.r-project.org/web/packages/scales/README.html
##http://colorbrewer2.org/
##https://cran.r-project.org/web/packages/RColorBrewer/
##https://r-forge.r-project.org/projects/rgl/
##https://cran.r-project.org/web/packages/foreign/
##http://www.omegahat.net/RSXML/
##https://cran.r-project.org/web/packages/RJSONIO/
##https://cran.r-project.org/web/packages/XLConnect/
##https://cran.r-project.org/web/packages/vcd/
##https://cran.r-project.org/web/packages/vcd/vcd.pdf
##https://www.r-bloggers.com/the-50-most-used-r-packages/
##https://cran.r-project.org/web/packages/xtable/
##http://www.codophile.com/how-to-integrate-r-with-java-using-rjava/
##https://github.com/chainsawriot/readODS/

listOfPackagesToBeInstalledFromCPAN <- c(
    "RCurl",
    "stringr","labeling","mime","scales","RColorBrewer",
    "ggplot2", "sjmisc" ,"sjPlot", "Rcpp",
    "xtable",
    #xtable: Export Tables to LaTeX or HTML
    "xtable",
    #vcd: Visualizing Categorical Data
    #"vcd",
    #Functions for reading and writing data stored by some versions of Epi Info, Minitab, S, SAS, SPSS, Stata, Systat and Weka and for reading and writing some dBase files.
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
            install.packages(library,repos="http://cran.rstudio.com/");
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
library(stringr);
library(readODS);
library(sjPlot) ;
library(sjmisc);
library(xtable);

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
