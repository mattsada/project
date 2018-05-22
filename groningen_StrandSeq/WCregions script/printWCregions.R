#' Function to print WC regions after breakpointR analysis
#' Here only WC regions large at least 5Mb are considered
#' Table is sorted by chromosomes

#' @param datapath RData location from breakpointR
#' @param file to print WC regions

#' @importFrom gtools mixedorder
#' @author David Porubsky

#' HELPFUL NOTES

#' to source the path to the folder were breakpointR Data, substitute path to the corect path.  
source("/Users/Mattsada/Dokument/Groningen/DATA/breakpointR-NW150212-VII_good_171215/data")

#' Here's an example how to run the function:
#printWCregions("~/DATA_ANALYSIS/Adam/breakpointR /breakpointR-NW150212-VIII_good_171215/data", file='WCregions-result.txt', regionSize=5000000)

printWCregions <- function(datapath, file=NULL, regionSize=5000000) {

	files <- list.files(datapath, pattern=".RData$", full=T)

	ranges <- GRangesList()
	for (filename in files) {
		counts <- get(load(filename))$counts
				
		counts.filt <- counts[width(counts) >= regionSize & counts$states == 'wc']
		ranges[[filename]] <- counts.filt
		
	}	

#print selected wc regions into a text file
	ranges <- unlist(ranges)
	ranges <- sort(ranges)
	filenames <- gsub(".RData", "", basename(names(ranges)))
	names(ranges) <- NULL
	ranges$filename <- filenames

	df <- as.data.frame(ranges)
	df2print <- df[,c('seqnames','start','end','filename')]
	write.table(df2print, file, sep=":", col.names=FALSE, row.names=FALSE, quote=FALSE)
}
