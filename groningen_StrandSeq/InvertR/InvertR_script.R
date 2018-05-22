# InvertR
R Package to locate putative inversions from Strand-seq data

contributors: Ashley D. Sanders, Mark Hills

# 1. install and load 'InvertR' library https://github.com/drashley/InvertR.git 
library(devtools)
install_github(force = TRUE, 'drashley/InvertR')

# load InvertR
library(InvertR)

# set the working directory to the folder where the data is stored
setwd("~/Desktop/SS analysis/InvertR/DS141127_I/") 

# 2. load test files: 
chrTable <-read.table('./chrTable_example.txt') 
gapfile <- read.table('./gapfile_example.txt') 
roiList <-read.table('./regionTable_example.txt') 

# 3. run examples A to C in directory containing BAM files (if directory contains BED files, change: type='bed')

# Example A. visualize chromosome 22 without any filtering: 
runInvertR(chrTable[22,], type="bed", dataDirectory="~/Desktop/SS analysis/InvertR/DS141127_I_InvertR_171218A/", bin=1000, gapfile=0, WCcutoff=0, findROIs=F)

# Example B. analyze all 'ww' or 'cc' chromosomes, and predict ROIs 
runInvertR(chrTable, type="bed", dataDirectory="~/Desktop/SS analysis/InvertR/DS141127_I_InvertR_171218B/", bin=1000, gapfile=gapfile)

# Example C. analyze an ROIfile with defined coordinates, and test a smaller bin 
runInvertR(roiList, type="bed", dataDirectory="~/Desktop/SS analysis/InvertR/DS141127_I_InvertR_171218C/", bin=50, ROI=T, padding=20000, WCcutoff=0)


runInvertR(chrTable, binSize=50, WCcutoff=0.75, dataDirectory="~/Desktop/SS analysis/InvertR/DS141127_I_InvertR_171218/", gapfile=0, type='bed', dup=TRUE, qual=10, padding=0, minDepth=20, minReads=20,
                       verbose=TRUE, strand=TRUE, ROI=FALSE, genotype=TRUE, findROIs=T)


# You can copy Usage code but in my case regionTable doesn't work, pgn = TRUE is not accepted. So, I changed regionTable into chrTable and pgn into pdf, which seems to work
runInvertR(chrTable, binSize = 50, WCcutoff = 0.75,
           dataDirectory = "~/Desktop/SS analysis/InvertR/DS141127_I_InvertR_171219/", gapfile = 0, type = "bed",
           dup = TRUE, qual = 10, padding = 0, minDepth = 20, minReads = 20,
           verbose = TRUE, pdf = TRUE, strand = TRUE, ROI = FALSE,
           genotype = TRUE, findROIs = T)
  
  