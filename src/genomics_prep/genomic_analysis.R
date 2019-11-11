###########################################################################################
##
## Source code for generating genind files for further analysis
## Clones used for validation are separated from other individuals used for site analysis
##
###########################################################################################
## set working directory
source("config.R")
setwd(wd)

## read in raw snp files
SNPS <- read.delim("src/genomics_prep/SNPs.tab",
                   header = T,
                   sep = "\t")
## filt removed any samples with >85% loci missing

## prefix on samples from data processing that is redundant and can be removed
subst <- "samples_basecounts_"

###########################################################################################
## load packages
library(ade4)
library(adegenet)
library(ape)
library(dplyr)
library(ggdendro)
library(ggplot2)
# source("https://bioconductor.org/biocLite.R")
# biocLite("ggtree")
library(ggtree)
library(gtools)
library(hierfstat)
library(pegas)
library(poppr)
library(mmod)

###########################################################################################
## produce just clones for validation
##
process.data.clonesonly <- function(tabdata,
                                    genind.file) {
  tabdata <- tabdata[, -2]
  ttabdata <- t(tabdata[, -1])
  colnames(ttabdata) <- tabdata[, 1]
  ## processing data to improve sample names
  rownames(ttabdata) <- gsub(subst, "", rownames(ttabdata))
  rownames(ttabdata) <- gsub("_genos.tab", "", rownames(ttabdata))
  rownames(ttabdata) <- gsub("BOGR_", "", rownames(ttabdata))
  rownames(ttabdata) <- gsub("_S.*", "", rownames(ttabdata))
  rownames(ttabdata) <- gsub("[.].*", "", rownames(ttabdata))
  ttabdata <-
    tibble::rownames_to_column(as.data.frame(ttabdata), "ID")
  ## adding a population variable
  ttabdata <- cbind(Site = "LA", ttabdata)
  ttabdata[1:10, 1:5]
  rawdata <- ttabdata
  
  print("dimensions of data:")
  print(dim(rawdata))
  
  ## some genotype cleanup to prepare to make a genind object
  print("cleaning up genotypes..")
  ## convert all geno's to chr type, necessary prep for below
  for (i in 1:ncol(rawdata)) {
    rawdata[, i] <- as.character(rawdata[, i])
  }
  rawdata[rawdata == 0] <-
    NA # any unknown or unid'd loci have a 'NA'
  rawdata[rawdata == "A G"] <- "AG"
  rawdata[rawdata == "A C"] <- "AC"
  rawdata[rawdata == "A T"] <- "AT"
  rawdata[rawdata == "C G"] <- "CG"
  rawdata[rawdata == "C T"] <- "CT"
  rawdata[rawdata == "G T"] <- "GT"
  rawdata[rawdata == "A"] <- "AA"
  rawdata[rawdata == "C"] <- "CC"
  rawdata[rawdata == "G"] <- "GG"
  rawdata[rawdata == "T"] <- "TT"
  
  ## more data cleanup
  colnames(rawdata) <- gsub("[.]", "_", colnames(rawdata))
  finalrow <- nrow(rawdata)
  rawdata <- rawdata[-(finalrow), ]
  rawdata$Site <- substr(rawdata$ID, 0, 2)
  print("Data looks like this:")
  print(rawdata[, 1:5])
  unique(as.matrix(rawdata[2:nrow(rawdata), 3:ncol(rawdata)]))
  
  #remove anything that's not a clone test
  good.data <- rawdata
  print("cleaning up population names..")
  good.data[good.data == "W0"] <- "remove"
  good.data[good.data == "W1"] <- "remove"
  good.data[good.data == "KN"] <- "remove"
  good.data[good.data == "CP"] <- "remove"
  good.data[good.data == "RM"] <- "remove"
  good.data[good.data == "Bg"] <- "Clone" ## keep these
  good.data[good.data == "K1"] <- "remove"
  good.data[good.data == "K0"] <- "remove"
  good.data[good.data == "SE"] <- "remove"
  good.data[good.data == "CI"] <- "remove"
  good.data[good.data == "WR"] <- "remove"
  good.data[good.data == "ST"] <- "remove"
  good.data[good.data == "BT"] <- "remove"
  good.data[good.data == "A0"] <- "remove"
  good.data[good.data == "A1"] <- "remove"
  good.data[good.data == "SG"] <- "remove"
  good.data[good.data == "HV"] <- "remove"
  good.data[good.data == "DM"] <- "remove"
  good.data[good.data == "RC"] <- "remove"
  good.data[good.data == "CO"] <- "remove"
  good.data[good.data == "BG"] <- "remove"
  cultivar.inds <- grep("Bgcultivar", good.data$ID)
  good.data$Site[cultivar.inds] <- "Cultivar"
  
  clone.inds <- grep("Bgedge_10_", good.data$ID)
  good.data$Site[clone.inds] <- "ED10"
  clone.inds <- grep("Bgedge_1_", good.data$ID)
  good.data$Site[clone.inds] <- "ED01"
  clone.inds <- grep("Bgedge_2_", good.data$ID)
  good.data$Site[clone.inds] <- "ED02"
  clone.inds <- grep("Bgedge_4_", good.data$ID)
  good.data$Site[clone.inds] <- "ED04"
  clone.inds <- grep("Bgedge_8_", good.data$ID)
  good.data$Site[clone.inds] <- "ED08"
  clone.inds <- grep("Bgedge_9_", good.data$ID)
  good.data$Site[clone.inds] <- "ED09"
  clone.inds <- grep("BgHq_1_", good.data$ID)
  good.data$Site[clone.inds] <- "HQ01"
  clone.inds <- grep("BgHq_2_", good.data$ID)
  good.data$Site[clone.inds] <- "HQ02"
  clone.inds <- grep("BgHq_4_", good.data$ID)
  good.data$Site[clone.inds] <- "HQ04"
  clone.inds <- grep("BgHq_6_", good.data$ID)
  good.data$Site[clone.inds] <- "HQ06"
  clone.inds <- grep("BgHq_7_", good.data$ID)
  good.data$Site[clone.inds] <- "HQ07"
  clone.inds <- grep("BgHq_9_", good.data$ID)
  good.data$Site[clone.inds] <- "HQ09"
  
  good.data <- good.data[!good.data$Site == "remove",]
  
  print("Data looks like:")
  print(good.data[1:5, 1:5])
  
  ind <- as.character(good.data$ID) # individual labels
  population <- as.character(good.data$Site) # population labels
  loci <- good.data[, c(3:ncol(good.data))]
  print("beginning work on genind objects.. ")
  genind.data1 <-
    df2genind(
      loci,
      ploidy = 2,
      ind.names = ind,
      pop = population,
      sep = ""
    )
  save(genind.data1, file = genind.file)
}

###########################################################################################
## we want to retain all samples with the function below
process.data.everything <- function(tabdata,
                                    genind.file) {
  tabdata <- tabdata[, -2]
  ttabdata <- t(tabdata[, -1])
  colnames(ttabdata) <- tabdata[, 1]
  ## processing data to improve sample names
  rownames(ttabdata) <- gsub(subst, "", rownames(ttabdata))
  rownames(ttabdata) <- gsub("_genos.tab", "", rownames(ttabdata))
  rownames(ttabdata) <- gsub("BOGR_", "", rownames(ttabdata))
  rownames(ttabdata) <- gsub("_S.*", "", rownames(ttabdata))
  rownames(ttabdata) <- gsub("[.].*", "", rownames(ttabdata))
  ttabdata <-
    tibble::rownames_to_column(as.data.frame(ttabdata), "ID")
  ## adding a population variable
  ttabdata <- cbind(Site = "LA", ttabdata)
  ttabdata[1:10, 1:5]
  rawdata <- ttabdata
  
  print("dimensions of data:")
  print(dim(rawdata))
  
  ## some genotype cleanup to prepare to make a genind object
  print("cleaning up genotypes..")
  ## convert all geno's to chr type, necessary prep for below
  for (i in 1:ncol(rawdata)) {
    rawdata[, i] <- as.character(rawdata[, i])
  }
  rawdata[rawdata == 0] <- NA # any unknown or unid'd loci have a 'NA'
  rawdata[rawdata == "A G"] <- "AG"
  rawdata[rawdata == "A C"] <- "AC"
  rawdata[rawdata == "A T"] <- "AT"
  rawdata[rawdata == "C G"] <- "CG"
  rawdata[rawdata == "C T"] <- "CT"
  rawdata[rawdata == "G T"] <- "GT"
  rawdata[rawdata == "A"] <- "AA"
  rawdata[rawdata == "C"] <- "CC"
  rawdata[rawdata == "G"] <- "GG"
  rawdata[rawdata == "T"] <- "TT"
  
  ## more data cleanup
  colnames(rawdata) <- gsub("[.]", "_", colnames(rawdata))
  finalrow <- nrow(rawdata)
  rawdata <- rawdata[-(finalrow), ]
  rawdata$Site <- substr(rawdata$ID, 0, 2)
  print("Data looks like this:")
  print(rawdata[, 1:5])
  unique(as.matrix(rawdata[2:nrow(rawdata), 3:ncol(rawdata)]))
  
  ## Full names of populations, retaining all
  good.data <- rawdata
  print("cleaning up population names..")
  good.data[good.data == "W0"] <- "Wonderland"
  good.data[good.data == "W1"] <- "Wonderland"
  good.data[good.data == "KN"] <- "Konza"
  good.data[good.data == "CP"] <- "Cedar Point"
  good.data[good.data == "RM"] <- "Rabbit Mountain"
  good.data[good.data == "Bg"] <- "SGS"
  good.data[good.data == "K1"] <- "Kelsall"
  good.data[good.data == "K0"] <- "Kelsall"
  good.data[good.data == "SE"] <- "Sevilleta"
  good.data[good.data == "CI"] <- "Cibola"
  good.data[good.data == "WR"] <- "Walker Ranch"
  good.data[good.data == "ST"] <- "Steele"
  good.data[good.data == "BT"] <- "Beech Trail"
  good.data[good.data == "A0"] <- "Andrus"
  good.data[good.data == "A1"] <- "Andrus"
  good.data[good.data == "SG"] <- "SGS"
  good.data[good.data == "HV"] <- "Heil Valley"
  good.data[good.data == "DM"] <- "Davidson Mesa"
  good.data[good.data == "RC"] <- "Rock Creek"
  good.data[good.data == "CO"] <- "Comanche"
  good.data[good.data == "BG"] <- "Buffalo Gap"
  cultivar.inds <- grep("Bgcultivar", good.data$ID)
  good.data$Site[cultivar.inds] <- "Cultivar"
  
  print("Data looks like:")
  print(good.data[1:5, 1:5])
  
  ind <- as.character(good.data$ID) # individual labels
  population <- as.character(good.data$Site) # population labels
  loci <- good.data[, c(3:ncol(good.data))]
  print("beginning work on genind objects.. ")
  loci[1:5, 1:5]
  genind.data1 <-
    df2genind(
      loci,
      ploidy = 2,
      ind.names = ind,
      pop = population,
      sep = ""
    )
  save(genind.data1, file = genind.file)
}

###########################################################################################
## plot distance tree and histogram of distances for each SNP file / genind object
tree.hist <- function(genind.file,
                      ht,
                      wd,
                      ht2,
                      wd2,
                      treefile,
                      treefile2,
                      histfile) {
  load(genind.file)
  distgenDISS <-
    diss.dist(genind.data1, percent = FALSE, mat = FALSE)
  model <- hclust(as.dist(distgenDISS))
  ggdendrogram(model, rotate = T)
  ggsave(treefile, height = ht, width = wd)
  model2 <-  nj(distgenDISS)
  results <- as.data.frame(cbind(model2$tip.label, genind.data1@pop))
  ggtree(model2, branch.length = "none") %<+% results +
    geom_tiplab(aes(color = V2)) +
    scale_color_manual(values = c(funky(18))) +
    geom_treescale() + theme_tree2()
  ggsave(treefile2, height = ht2, width = wd2)
  pdf(file = histfile,
      width = 6,
      height = 4)
  hist(distgenDISS, breaks = 100)
  dev.off()
}

###########################################################################################
process.data.everything(SNPS,
                        "genind_all.R")
process.data.clonesonly(SNPS,
                        "genind_byclone.R")

# tree.hist("R_output/genind.348.40.filt.R", 40, 7, 45, 20,
#           "Figures/tree.348.40.filt.pdf",
#           "Figures/tree.348.40.filt.nj.pdf",
#           "Figures/hist.348.40.filt.pdf")
#
# tree.hist("R_output/genind.348.40.filt.clonesonly.by1site.R", 15, 7, 10, 15,
#           "Figures/tree.348.40.filt.clonesonly.pdf",
#           "Figures/tree.348.40.filt.nj.clonesonly.pdf",
#           "Figures/hist.348.40.filt.clonesonly.pdf")
