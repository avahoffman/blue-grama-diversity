###########################################################################################
##
## R source code to accompany Hoffman et al. (2019), last updated 2 Feb 2019.
## Please contact Ava Hoffman (avamariehoffman@gmail.com) with questions.
##
## If you found this code useful, please use the citation below:
## 
## 
## 
##
###########################################################################################

## set working directory
source("config.R")
setwd(wd)

library(adegenet) ## deal with genind objects
library(ade4)
library(ggplot2)
library(reshape2)

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
## several options depending on what samples desired..
load("genomics_prep/genind_byclone.R")

## color palette for plots
col.pal <- read.csv("utils/color_key.csv",header=T)
col.pal.v <- as.vector(col.pal[,3]) ; names(col.pal.v) <- col.pal[,2]
col.pal.names <- as.vector(col.pal[,2]) ; names(col.pal.names) <- col.pal[,6]
col.pal.colors <- as.vector(col.pal[,3]) ; names(col.pal.colors) <- col.pal[,6]

## remove all but one of each clone 
indNames(genind.data1)
genind.1clone.only <- genind.data1[c(5,12,18,21,27,33,41,44,48,50,55,58,65:335)]
indNames(genind.1clone.only) <- gsub("Bgedge","SGS",indNames(genind.1clone.only))
indNames(genind.1clone.only) <- gsub("BgHq","SGS",indNames(genind.1clone.only))
indNames(genind.1clone.only)

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
## Discriminant Analysis of Principal Components (DAPC)
## https://github.com/thibautjombart/adegenet/raw/master/tutorials/tutorial-dapc.pdf 

## impute mean for missing data
genind.1clone.only$tab <- tab(genind.1clone.only, NA.method = "mean")
## keep only regional populations
genind.regional <- genind.1clone.only[(genind.1clone.only@pop %in% 
                                         c('Cibola','Sevilleta','SGS','Comanche','Konza','Cedar Point','Buffalo Gap')),]

grp <- pop(genind.regional)
# pdf("Analysis/genomics_output/figures/Xval_plot_regional.pdf",height=6,width=6)
# xval <- xvalDapc(genind.regional$tab, grp, n.pca.max = 160, training.set = 0.9,
#                  result = "groupMean", center = TRUE, scale = FALSE,
#                  n.pca = NULL, n.rep = 30, xval.plot = TRUE, parallel = "multicore")
# dev.off()
# save(xval, file="Analysis/genomics_output/xval_regional.R")
# ## DAPC knows to use populations as prior groups
# load(file="Analysis/genomics_output/xval_regional.R")
# DAPC <- xval$DAPC


## n.da should be one less than the number of groups
DAPC <- dapc(genind.regional$tab, grp, n.pca = 60, n.da = 6)
## how much variance retained?
DAPC$var
DAPC


## plot as groups
plot.dat <- as.data.frame(DAPC$ind.coord)
plot.dat <- cbind(plot.dat,DAPC$grp) ; names(plot.dat)[7] <- "pop"
plot.dat <- merge(plot.dat,col.pal)
## save info
write.csv(plot.dat,file="genomics_output/DAPC_regional.csv")
ggplot(data=plot.dat, aes(x=LD1,y=LD2)) +  
  scale_color_manual(values = col.pal.colors, labels = col.pal.names) + 
  theme_classic() +
  ## ellipses for visual aide
  stat_ellipse(data=subset(plot.dat, `abbv`=="CIB"),color="#F88A89") +
  stat_ellipse(data=subset(plot.dat, `abbv`=="SEV"), color="#E73233") +
  stat_ellipse(data=subset(plot.dat, `abbv`=="SGS"), color="#FDB35A") +
  stat_ellipse(data=subset(plot.dat, `abbv`=="CO"), color="#E19B78") +
  stat_ellipse(data=subset(plot.dat, `abbv`=="CP"), color="#A889C1") +
  #stat_ellipse(data=subset(plot.dat, `abbv`=="KNZ"), color="#795199") +
  stat_ellipse(data=subset(plot.dat, `abbv`=="BG"), color="#CBB0CE") +
  geom_vline(xintercept = 0) + geom_hline(yintercept = 0) +
  geom_point(aes(color=legend.order),
             size=1) +
  labs(colour = "Site")
#theme(legend.position = "none")
ggsave(file="genomics_output/figures/DAPC_regional.jpg",height = 3,width=4)


## calculate population assignment probability
summ.dapc <- summary(DAPC)
summ.dapc.assign <- summ.dapc$assign.per.pop
summ.dapc.assign
write.csv(summ.dapc.assign, file="genomics_output/Population_probability_regional.csv")

## loci that differentiate site
rownames(DAPC$var.contr) <- gsub("denovoLocus","",rownames(DAPC$var.contr))
rownames(DAPC$var.contr) <- gsub(".A","",rownames(DAPC$var.contr))
rownames(DAPC$var.contr) <- gsub(".C","",rownames(DAPC$var.contr))
rownames(DAPC$var.contr) <- gsub(".T","",rownames(DAPC$var.contr))
rownames(DAPC$var.contr) <- gsub(".G","",rownames(DAPC$var.contr))
loci.loadings <- DAPC$var.contr
pdf(file="genomics_output/figures/Loci_loadings_reigonal.pdf",width=20,height=4)
loadingplot(loci.loadings, axis=2, thres=.004,main=NULL,xlab="Locus")
dev.off()
write.csv(loci.loadings, file="genomics_output/Loci_loadings_regional.csv")


## "structure" plot
posts <- DAPC$posterior
posts <- posts[order(row.names(posts)),]
long.dat <- melt(posts); names(long.dat)[2] <- "pop"
write.csv(long.dat,"genomics_output/Structure_plot_data_regional.csv")
write.csv(posts,"genomics_output/Structure_plot_data_regional_wide.csv")
ggplot(data=long.dat, aes(x=Var1,y=value, fill=pop)) +
  geom_col(size=2) +  
  theme_classic() + scale_fill_manual(values = col.pal.v) +
  labs(fill = "Population") + xlab("Individual") + ylab("Membership probability") +
  theme(axis.line=element_blank(),
        axis.text.x=element_blank(),
        #axis.text.y=element_blank(),
        axis.ticks=element_blank())+
  theme_void() +
  theme(legend.position = "none")
ggsave(file="genomics_output/figures/structure_regional.jpg",height = 1.5,width=10)



