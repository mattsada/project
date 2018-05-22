install.packages("devtools")
source("http://bioconductor.org/biocLite.R")
biocLite("GenomicRanges")
biocLite("GenomicAlignments")
library(devtools)
install_github(force = TRUE, "daewoooo/strandseqExampleData")
install_github(force = TRUE, "daewoooo/BreakPointR")
install_git("git://github.com/daewoooo/BreakPointR.git", branch = "master")

# load BreakpointR
library(breakpointR)

# set the working directory to the folder where the data is stored
setwd("~/DATA_ANALYSIS/Adam/breakpointR ") 

## Run breakpointR with specific parameters obtained from Diana (only good libraries seems to work)
breakpointer(inputfolder = "NW150212-VII_good", 
             outputfolder = "breakpointR-NW150212-VIII_good_171215", 
             numCPU = 1,
             reuse.existing.files = F, 
             windowsize = 1000000, 
             binMethod = "size", 
             pairedEndReads = T, 
             pair2frgm = F,
             chromosomes = paste0(c(1:22)), 
             min.mapq = 10,
             callHotSpots = T)

# run BreakpointR for 1 plate
breakpointer(inputfolder = "NW150212-VIII", 
             outputfolder = "BreakpointR-NW150212-VIII", 
             configfile = 'breakpointR_human.config')

## Get some example files
inputfolder <- system.file("extdata", "breakpointer", package="strandseqExampleData")
outputfolder <- file.path(tempdir(), "breakpointer_example")

## Run breakpointer
breakpointer(inputfolder, outputfolder, chromosomes=paste0("chr", c(1:22, "X")),
             pairedEndReads=FALSE)

## Get an example file
exampleFolder <- system.file("extdata", "breakpointer", package="strandseqExampleData")
exampleFile <- list.files(exampleFolder, full.names=TRUE)[1]

## Run breakpointR
brkpts <- runBreakpointr(exampleFile, pairedEndReads=FALSE)