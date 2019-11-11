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
library(ape)
library(ggtree)
library(phytools)
library(poppr)
library(ggplot2)
library(reshape2)
library(gridExtra)
library(ggrepel)
library(phangorn)

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
## several options depending on what samples desired..
load("genomics_prep/genind_all.R")
indNames(genind.data1)
genind.1clone.only <- genind.data1[c(5,12,18,21,27,33,41,44,48,50,55,58,65:335)]
indNames(genind.1clone.only) <- gsub("Bgedge","SGS",indNames(genind.1clone.only))
indNames(genind.1clone.only) <- gsub("BgHq","SGS",indNames(genind.1clone.only))
indNames(genind.1clone.only)
pop(genind.1clone.only)
## remove clones altogether, it messes with the sample size
genind.obj <- genind.1clone.only[c(13:283)]
pop(genind.obj)


genind.obj$tab <- tab(genind.obj, NA.method = "mean")
strata(genind.obj) <- data.frame(pop(genind.obj))
nameStrata(genind.obj) <- ~Pop

if (file.exists("genomics_output/Site_hierarchy.R")){
  load("genomics_output/Site_hierarchy.R")
} else {
  set.seed(999)
  poptree <- genind.obj %>%
    genind2genpop(pop = ~Pop) %>%
    aboot(sample = 10000,
          distance = nei.dist,
          cutoff = 0,
          quiet = F,
         tree = "upgma")
  write.tree(poptree,file = "genomics_output/Site_hierarchy.nexus")
  save(poptree,file="genomics_output/Site_hierarchy.R")
}

colz <- c('black',"#859D59","#CBB0CE","#6BAD9E","#F88A89",
          "#E19B78","#A889C1","#217b7e","#426081","#72ADD1",
          "#795199","#399F2F","#A2D48E","#E73233","#FDB35A",
          "#5EB54C","#3386AE","#A6CEE3")
colz <- as.vector(colz)

## each pop individual
cls <- as.list(unique(genind.obj$pop))
tree <- groupOTU(poptree, cls)
tree$node.label[4] <- ""
ggtree(tree, aes(color=group), layout="rectangular") +
  geom_label_repel(aes(label=label), force=0,nudge_x = 0, nudge_y = 0) +
  theme_tree() +
  scale_color_manual(values = c(colz))
ggsave(file="genomics_output/figures/Site_heirarchy.jpg",height = 7,width=4)




load("genomics_prep/genind_all.R")
indNames(genind.data1)
genind.1clone.only <- genind.data1[c(5,12,18,21,27,33,41,44,48,50,55,58,65:335)]
indNames(genind.1clone.only) <- gsub("Bgedge","SGS",indNames(genind.1clone.only))
indNames(genind.1clone.only) <- gsub("BgHq","SGS",indNames(genind.1clone.only))
indNames(genind.1clone.only)
pop(genind.1clone.only)
## remove clones altogether, it messes with the sample size
genind.obj <- genind.1clone.only[c(13:283)]
pop(genind.obj)
# genind.obj <- genind.obj[(genind.obj@pop %in%
#                                       c('Andrus','Rock Creek','Steele','Rabbit Mountain','Beech Trail',
#                                         'Davidson Mesa','Wonderland','Heil Valley','Kelsall','Walker Ranch')),]
genind.obj <- genind.obj[(genind.obj@pop %in%
                      c('Cibola','Sevilleta','SGS','Comanche','Konza','Cedar Point','Buffalo Gap')),]
genind.obj$tab <- tab(genind.obj, NA.method = "mean")
strata(genind.obj) <- data.frame(pop(genind.obj))
nameStrata(genind.obj) <- ~Pop
# Analysis
if (file.exists("genomics_output/Site_hierarchy_regional.R")){
load("genomics_output/Site_hierarchy_regional.R")
} else {
set.seed(999)
localtree <- genind.obj %>%
  genind2genpop(pop = ~Pop) %>%
  aboot(sample = 10000, #how many bootstrap reps
        distance = nei.dist,
        cutoff = 0,
        quiet = F,
        tree = 'upgma')
write.tree(poptree,file = "genomics_output/Site_hierarchy_regional.nexus")
save(poptree,file="genomics_output/Site_hierarchy_regional.R")
}

load("genomics_output/Site_hierarchy_regional.R")
colz <- c('black',"#CBB0CE","#F88A89","#E19B78","#A889C1",
          "#795199","#E73233","#FDB35A")
colz <- as.vector(colz)

## each pop individual
localcls <- as.list(unique(genind.obj$pop))
localtree <- groupOTU(localtree, cls)
#localtree$node.label[4] <- ""
ggtree(localtree, aes(color=group), layout="rectangular") +
  geom_label_repel(aes(label=label), force=0,nudge_x = 0, nudge_y = 0) +
  theme_tree() +
  scale_color_manual(values = c(colz))
ggsave(file="genomics_output/figures/Site_heirarchy_regional.jpg",height = 7,width=3)


