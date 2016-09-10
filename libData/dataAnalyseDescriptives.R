#!/usr/bin/env Rscript


descriptiveStatisticsAsFactorVar <- function(dtaObj,factorVariablesNames){

    print("[LOG [descriptiveStatisticsAsFactorVar <- function(dtaObj,factorVariablesNames){...]");

    for( var in factorVariablesNames){
        varObj <- dtaObj[[var]];
        varObj.freq <- table(varObj);

        ##varObj.freq.AsFrame =  as.data.frame(varObj.freq);
        #varObj.freq.AsFrame =  table(varObj);

        ##varNameEnclosedBySingleQuote = paste(paste("'",varNome, sep=""), "'", sep="");
        ##setnames(varObj.freq.AsFrame, old=c("varObj","Freq"), new=c(varName,"Contagem"));
        #print(varObj.freq.AsFrame);

        xtbVar <- xtable(varObj.freq);
        ##xtbVar <- xtable(varObj.freq.AsFrame, align=c("ccc"));
        ##xtbVar <- xtableFtable(varObj.freq.AsFrame, method = "compact"); Error in rep(" ", nrow(x) + 2) : argumento 'times' inválido
    
        varTexFileName <- paste(var,"tex",sep=".");
        varHtmlFileName <- paste(var,"html",sep=".");

        print.xtable(
            xtbVar, type="Latex",        
            add.to.row=list(pos=list(c(-1,0,nrow(xtbVar))), command="\\hline \n"),
            file=paste(currentOutDir,varTexFileName, sep="/"),
            floating=FALSE);

        print.xtable(
            xtbVar, type="html",
            file=paste(currentOutDir,varHtmlFileName, sep="/"));
               
        ##print(paste(paste("Variable ",var), class(dtaObj[[var]]), sep=" as "));
        ##print(str(dtaObj[[var]]));
        ##print(unique(dtaObj[[var]]));
        ##print("TODO: missing impact");
        ##xtable(varObj);
        ##print(paste(cmd_pdflatext_for_tex_fragment(varTexFileName), " > /dev/null 2>&1"));
        message(paste("->->->->->varTexFileName = ",varTexFileName));
        system(paste(cmd_pdflatext_for_tex_fragment(varTexFileName), " > /dev/null 2>&1"));
    }##for( var in factorVariablesNames){
}  

descriptiveStatisticsForNumericVar <- function(dtaObj,varObj){
    print("[LOG descriptiveStatisticsForNumericVar <- function((dtaObj,varObj){...");
}
