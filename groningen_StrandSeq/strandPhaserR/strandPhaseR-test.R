# Inputfolder - folder with .bam and .bai files for cells that are to be analysed (preferably cells with consistent WC regions).
# outputfolder - creates output folder within set working directory.
# positions - list of SNP's (.txt) from refenrece genome, specific lists for all the analysed chromosomes must be present.  
# WCregions - .txt file with WC-regions, see script "printWCregions.R" (data files from breakpointR analysis).
# chromosomes - all chromosomes that are to be analysed.

# install packages.
install.packages("devtools") 
source("http://bioconductor.org/biocLite.R") 
biocLite("GenomicRanges") 
biocLite("GenomicAlignments") 
biocLite("BSgenome.Hsapiens.UCSC.hg19")

library(devtools)

# option 1
install_github("daewoooo/StrandPhaseR") 

# option 2 (currently working 171215)
install_git("git://github.com/daewoooo/StrandPhaseR.git", branch = "old")

# load packages
library('StrandPhaseR')

# set the working directory to the folder where the data is stored.
setwd("~/Dokument/Groningen/DATA") 

#Run StrandPhaseR: 
strandPhaseR(inputfolder = "NW150212-VII_good", 
             outputfolder = "NW150212-VII-strandPhaseR-with-browserFiles", 
             positions = "snp_list_allChrom.txt", 
             WCregions = "result.txt",
						 splitPhasedReads  =  TRUE,
						 callBreaks  =  TRUE,
						 exportVCF  =  TRUE, 
						 bsGenome  =  "BSgenome.Hsapiens.UCSC.hg19", 
             chromosomes = c(1:22))
