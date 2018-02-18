#Save this file in home directory 

# Adapted from: https://www.r-bloggers.com/fun-with-rprofile-and-customizing-r-startup/ 

# Fix missing library path on Ubunt 16.04 for ML Server 9.2.1 
.libPaths(c(.libPaths(), "/opt/microsoft/mlserver/9.2.1/libraries/RServer"))

# Add env variabele for TCL/TK support
ifelse(!nzchar(Sys.getenv("TCL_LIBRARY")), 
       Sys.setenv(TCL_LIBRARY="/opt/microsoft/mlserver/9.2.1/runtime/R/share/tcl8.6/"), NA)

local({r <- getOption("repos")
r["CRAN"] <- "https://mran.microsoft.com"
options(repos=r)})

options(stringsAsFactors=FALSE)

options(max.print=300)

options(scipen=10)

options(editor="nano")

# options(show.signif.stars=FALSE)

options(menu.graphics=FALSE)

options(prompt="> ")
options(continue="... ")

options(width = 80)

q <- function (save="no", ...) {
  quit(save=save, ...)
}

utils::rc.settings(ipck=TRUE)

.First <- function(){
  if(interactive()){
    library(utils)
    timestamp(,prefix=paste("##------ [",getwd(),"] ",sep=""))
    
  }
}

.Last <- function(){
  if(interactive()){
    hist_file <- Sys.getenv("R_HISTFILE")
    if(hist_file=="") hist_file <- "~/.RHistory"
    savehistory(hist_file)
  }
}

sshhh <- function(a.package){
  suppressWarnings(suppressPackageStartupMessages(
    library(a.package, character.only=TRUE)))
}

auto.loads <-c("dplyr", "ggplot2", "data.table")

if(interactive()){
  invisible(sapply(auto.loads, sshhh))
}

.env <- new.env()
attach(.env)

.env$unrowname <- function(x) {
  rownames(x) <- NULL
  x
}

.env$unfactor <- function(df){
  id <- sapply(df, is.factor)
  df[id] <- lapply(df[id], as.character)
  df
}

message("n*** Successfully loaded .Rprofile ***n")
