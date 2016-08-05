#!/usr/bin/env Rscript

thisScriptFullPath <- dirname(sys.frame(1)$ofile)
print(paste("[LOG]: loaded sucessfully" , thisScriptFullPath, sep=" => "))

askUserForInput <- function(msgForAskUser){
    message(msgForAskUser)
    userInputValue <- scan(file="stdin", what = character(),  n=1, quiet = TRUE)
    return(userInputValue)
}


