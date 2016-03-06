#!/usr/bin/env Rscript
##https://stat.ethz.ch/R-manual/R-devel/library/utils/html/read.table.html

## converts input from the old
##    West-European encoding ISO-8859-1 to Unicode.
##iconv -f ISO-8859-1 -t UTF-8 fileNameTccGlauc > fileNameTccGlaucIsoUtf8
options(encoding = 'iso-8859-1')
lineSeparator <- "-------------------------------------------------------------------"
	

##
## S O M E    D E F A U L T   V A L U E S
## 

##True if the name of the variables is in the first line of the file data
headerFlag    <-   T   

##field separator character
## for tab separator use "/t"
sepChar       <-  ";"  

##quote character for strings values  change to  "\"'"  for "
quoteChar     <-  ""   

##decimal point separator char
decChar       <-  "."

numeralsVector <-  c("allow.loss", "warn.loss", "no.loss")

## A vector of row names.
## 1) A vector giving the actual row names,
## 2) or a single number giving the column of the table which contains the row names,
## 3) or character string giving the name of the table column containing the row names.
## row.names = NULL forces row numbering.
rowNames      <-  NULL

## a vector of optional names for the variables.
## The default is to use "V" followed by the column number.
## colNames      <- col.names
colNames      <- NULL     	


## Default behavior of read.DIF is to convert character variables to factors.
## The variable as.is controls the conversion of columns not otherwise specified by colClasses.
## Its value is either
## 1) a vector of logicals (values are recycled if necessary),
## 2) or a vector of numeric or character indices which specify which columns should not be converted to factors.
## Note:
## In releases prior to R 2.12.1,
##    cells marked as being of character type were converted to logical,
##    numeric or complex using type.convert as in read.table.
## Note:
##    to suppress all conversions including those of numeric columns, set colClasses = "character".
## Note
##    as.is is specified per column (not per variable)
##    and so includes the column of row names (if any) and any columns to be skipped. 


#read.table(fileName, headerFlag, sepChar, quoteChar, decChar, numeralsVector,
#           rowNames, colNames, as.is = !stringsAsFactors,
#           na.strings = "NA", colClasses = NA, nrows = -1,
#           skip = 0, check.names = TRUE, fill = !blank.lines.skip,
#           strip.white = FALSE, blank.lines.skip = TRUE,
#           comment.char = "#",
#           allowEscapes = FALSE, flush = FALSE,
#           stringsAsFactors = default.stringsAsFactors(),
#           fileEncoding = "", encoding = "unknown", text, skipNul = FALSE)



#read.csv(file, header = TRUE, sep = ",", quote = "\"",
#         dec = ".", fill = TRUE, comment.char = "", ...)

#read.csv2(file, header = TRUE, sep = ";", quote = "\"",\
#          dec = ",", fill = TRUE, comment.char = "", ...)

#read.delim(file, header = TRUE, sep = "\t", quote = "\"",
#           dec = ".", fill = TRUE, comment.char = "", ...)

#            dec = ",", fill = TRUE, comment.char = "", ...)
readCsv <- function(fileName){
    fullPathFileName <- paste(downloaFileDestinationDir,fileName,sep = "/")
    dtaObj <- read.csv(fullPathFileName);
    return(dtaObj);
}

varNameToSampling <- "Inicio"
print(c("S A M P L E  ",varNameToSampling))
dtaVariablesNames <- function(dtaObj){
    vars <- names(dataTccGlauc)
    
}

dtaConfigFactorVariables <- function(cVarsThatWillBeFactor){
    dta$Sexo <- factor(dta$Sexo,levels=c(1,2),labels=c("Masculino","Feminino"))
}
