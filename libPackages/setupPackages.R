#!/usr/bin/env Rscript

pathToThisWorkspaceRLibs <- paste(getwd(),"R_LIBS", sep="/")
pathToSjPlotFileToInstall <- paste(getwd(),"devel.Rproj",sep="/") 
install.packages(pathToSjPlotFileToInstall, repos = NULL, type="source", lib=pathToThisWorkspaceRLibs)
library(sjPlot)
 


