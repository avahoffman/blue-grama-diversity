###########################################################################################
##
## R source code to accompany Hoffman et al. (2018), last updated 3 July 2018.
## Please contact Ava Hoffman (avamariehoffman@gmail.com) with questions.
##
## If you found this code useful, please use the citation below:
## 
## 
## 
##
###########################################################################################

## set working directory
wd <- "/Users/avahoffman/Dropbox/Research/Bouteloua_diversity"
setwd(wd)

library(adegenet) ## deal with genind objects
library(ade4)
library(ape)
library(ggtree)
library(phytools)
library(poppr)
library(ggplot2)
library(reshape2)
library(gridExtra)
library(ggrepel)
library(phangorn)

###########################################################################################
load("/Users/avahoffman/Dropbox/Research/Bouteloua_diversity/Genomics/Bouteloua_genomics/04-genotyping/R_output/genind.348.40.filt.R")
## color palette for plots
col.pal <- read.csv("Analysis/color_key.csv",header=T)
col.pal.v <- as.vector(col.pal[,3]) ; names(col.pal.v) <- col.pal[,2]
col.pal.names <- as.vector(col.pal[,2]) ; names(col.pal.names) <- col.pal[,6]
col.pal.colors <- as.vector(col.pal[,3]) ; names(col.pal.colors) <- col.pal[,6]

## remove all but one of each clone 
indNames(genind.data1)
genind.1clone.only <- genind.data1[c(5,12,18,21,27,33,41,44,48,50,55,58,65:335)]
indNames(genind.1clone.only) <- gsub("Bgedge","SGS",indNames(genind.1clone.only))
indNames(genind.1clone.only) <- gsub("BgHq","SGS",indNames(genind.1clone.only))
indNames(genind.1clone.only)

## calculate pairwise differences (within population)
sample.matrix.2 <- diss.dist(bg.gen, percent = FALSE, mat = TRUE)
sample.matrix.2[lower.tri(sample.matrix.2, diag = T)] <- NA
msm <- melt(sample.matrix.2) ; msm <- na.omit(msm)
msm$group <- NA
SGS.dist <- msm[(grepl("SGS",msm$Var1) & grepl("SGS",msm$Var2)),] ; SGS.dist$group <- "SGS"
A.dist <- msm[(grepl("A",msm$Var1) & grepl("A",msm$Var2)),] ; A.dist$group <- "Andrus"
BT.dist <- msm[(grepl("BT",msm$Var1) & grepl("BT",msm$Var2)),] ; BT.dist$group <- "Beech Trail"
BG.dist <- msm[(grepl("BG",msm$Var1) & grepl("BG",msm$Var2)),] ; BG.dist$group <- "Buffalo Gap"
CP.dist <- msm[(grepl("CP",msm$Var1) & grepl("CP",msm$Var2)),] ; CP.dist$group <- "Cedar Point"
CIB.dist <- msm[(grepl("CI",msm$Var1) & grepl("CI",msm$Var2)),] ; CIB.dist$group <- "Cibola"
CO.dist <- msm[(grepl("CO",msm$Var1) & grepl("CO",msm$Var2)),] ; CO.dist$group <- "Comanche"
DM.dist <- msm[(grepl("DM",msm$Var1) & grepl("DM",msm$Var2)),] ; DM.dist$group <- "Davidson Mesa"
HV.dist <- msm[(grepl("HV",msm$Var1) & grepl("HV",msm$Var2)),] ; HV.dist$group <- "Heil Valley"
K.dist <- msm[(grepl("K",msm$Var1) & grepl("K",msm$Var2)),] ; K.dist <- K.dist[!(grepl("KNZ",K.dist$Var1) | grepl("KNZ",K.dist$Var2)),] ; K.dist$group <- "Kelsall"
KNZ.dist <- msm[(grepl("KNZ",msm$Var1) & grepl("KNZ",msm$Var2)),] ; KNZ.dist$group <- "Konza"
RC.dist <- msm[(grepl("RC",msm$Var1) & grepl("RC",msm$Var2)),] ; RC.dist$group <- "Rock Creek"
RM.dist <- msm[(grepl("RM",msm$Var1) & grepl("RM",msm$Var2)),] ; RM.dist$group <- "Rabbit Mountain"
SEV.dist <- msm[(grepl("SEV",msm$Var1) & grepl("SEV",msm$Var2)),] ; SEV.dist$group <- "Sevilleta"
ST.dist <- msm[(grepl("ST",msm$Var1) & grepl("ST",msm$Var2)),] ; ST.dist$group <- "Steele"
W.dist <- msm[(grepl("W",msm$Var1) & grepl("W",msm$Var2)),] ; W.dist <- W.dist[!(grepl("WR",W.dist$Var1) | grepl("WR",W.dist$Var2)),] ; W.dist$group <- "Wonderland"
WR.dist <- msm[(grepl("WR",msm$Var1) & grepl("WR",msm$Var2)),] ; WR.dist$group <- "Walker Ranch"
combined.df <- rbind(SGS.dist,A.dist,BT.dist,BG.dist,CP.dist,CIB.dist,CO.dist,DM.dist,HV.dist,K.dist,KNZ.dist,RC.dist,RM.dist,SEV.dist,ST.dist,W.dist,WR.dist)

ggplot(combined.df, aes(x=reorder(group, value, FUN=median, color=group), y=value, fill=group) ) +
  geom_boxplot() + coord_flip() + guides(fill=FALSE) + labs(x="",y="Pairwise distance within site (SNPs)") + scale_fill_manual(values=col.pal.v) + theme_classic()
ggsave(file = "Analysis/genomics_output/figures/Pairwise_distances.jpg",height = 6,width=7.5)

summary(aov(value~group, data=combined.df)) ## groups differ in distance
T.test.results <- pairwise.t.test(combined.df$value, combined.df$group, p.adj = "bonf", pool.sd = F, var.equal = F)
write.csv(T.test.results$p.value, file="Analysis/genomics_output/Pairwise_distance_results.csv")
