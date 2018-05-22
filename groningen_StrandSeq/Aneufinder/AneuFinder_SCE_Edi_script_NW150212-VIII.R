
library(devtools)
install_github(force = TRUE, 'ataudt/aneufinder')

devtools::install_github(force = TRUE, 'ataudt/aneufinder', ref='stepsize')

library(AneuFinder)

source("https://bioconductor.org/biocLite.R")
biocLite("BSgenome.Hsapiens.UCSC.hg19")

# set the working directory to the folder where the data is stored
setwd("/Users/Mattsada/Dokument/Groningen/SS_analysis/DATA") 

## Define variables ##
culturename <- "NW150212-VIII"
outputname <- "NW150212-VIII-171213"
plotfolder <- file.path(outputname, 'PLOTS', 'method-edivisive')
browserfolder <- file.path(outputname, 'BROWSERFILES', 'method-edivisive')

# run Aneufinder for 1 plate
Aneufinder(inputfolder = culturename, outputfolder = outputname, 
           configfile = 'AneuFinder SCE_edivisive_human.config')

#clusterByQuality
#choose the measures that you want to use (pick from c("spikiness", "entropy", "num.segments", 
#"bhattacharyya","complexity", "sos"))
measure <- c('spikiness','entropy','num.segments','bhattacharyya','loglik','sos','complexity')

#make a list of the files to analyze
allfiles <- list.files(file.path(outputname, 'MODELS_refined/method-edivisive/'),  recursive = T, full=T, pattern = 'binsize_4e\\+04')

#perform the clustering
clusters <- clusterByQuality(allfiles, G=1:4, measures = measure)

#perform the clustering
clusters <- clusterByQuality(allfiles, G=1:4, measures = measure, orderBy='num.segments')

#make heatmap of all clusters
heatmapGenomewideClusters(clusters,file= file.path(plotfolder, paste0(outputname, '_clusters.pdf')))

#select the libraries in cluster 1
cluster1 <- clusters$classification[[1]]

#make a heatmap of all libraries in cluster 1
heatmapGenomewide(cluster1, file= file.path(plotfolder, paste0(outputname, '_heatmapGenomewide_cluster1.pdf')))

ggplt <- heatmapAneuploidies(cluster1)
ggsave(ggplt, filename = file.path(plotfolder, paste0(outputname, '_heatmapAneuploidies_cluster1.pdf')))

#Aneuploidy scores:
write.table(heatmapAneuploidies(cluster1, as.data.frame = T), file = file.path(plotfolder, paste0(outputname, '_heatmapAneuploidies_cluster1.txt')))

# Recalculating hotspots
hotspots <- findHotspots(cluster1, bw=NULL, pval=5e-2, spacing.bp=5000, filename = file.path(browserfolder, paste0(outputname)))

# Exporting browser files
exportCNVs(hmms = cluster1, filename = file.path(browserfolder, paste0(outputname, '_good-quality')), trackname = paste0(outputname, '_good-quality'))
