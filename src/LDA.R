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

## PCA / LDA
## https://www.r-bloggers.com/computing-and-visualizing-lda-in-r/
## https://gist.github.com/thigm85/8424654
###########################################################################################

library(ggplot2)
library(gridExtra)
library(missMDA)
library(MASS)
require(scales)
library(cowplot)

###########################################################################################
## open data
bogr.data <- read.csv("data/BOGR_DATA_unsupervised_PCA_LDA.csv")
names(bogr.data)
col.pal <- read.csv("utils/color_key.csv",header=T)
col.pal.v <- as.vector(col.pal[,3]) ; names(col.pal.v) <- col.pal[,2]
col.pal.names <- as.vector(col.pal[,2]) ; names(col.pal.names) <- col.pal[,6]
col.pal.colors <- as.vector(col.pal[,3]) ; names(col.pal.colors) <- col.pal[,6]

bogr.data[bogr.data == "no pot"] <- NA # any unknown or unid'd locihttps://gist.github.com/thigm85/8424654 have a 'NA'
bogr.data[bogr.data == "met"] <- NA # any unknown or unid'd loci have a 'NA'
bogr.data[bogr.data == "tr"] <- NA # any unknown or unid'd loci have a 'NA'
## then these need to be numeric..
bogr.data$biomass_aboveground <- as.numeric(as.character(bogr.data$biomass_aboveground))
bogr.data$biomass_belowground <- as.numeric(as.character(bogr.data$biomass_belowground))
bogr.data$biomass_rhizome <- as.numeric(as.character(bogr.data$biomass_rhizome))
# derived vars
bogr.data$root_shoot <- (bogr.data$biomass_belowground + bogr.data$biomass_rhizome) / bogr.data$biomass_aboveground
bogr.data$biomass_total <- bogr.data$biomass_belowground + bogr.data$biomass_rhizome + bogr.data$biomass_aboveground + bogr.data$flwr_mass_lifetime

# LDA on trait means

makeLDA <- function(restrictions = bogr.data[(bogr.data$region != 'Boulder'),],
                    radlength=2,
                    regionlab){
  # REMOVE ANY ROWS WITH TONS OF NA
  bogr.data <- bogr.data[rowSums(is.na(bogr.data)) < 7, ]
  # replace flower NA with zero
  bogr.data[,16:17][is.na(bogr.data[,16:17])] <- 0
  bogr.data.small <- restrictions
  feats <- bogr.data.small[,11:22]
  #Iterativa PCA
  imputed <- imputePCA(feats, ncp=2, scale=TRUE)
  newfeats <- imputed$completeObs
  newfeats_scaled <- scale(newfeats)
  
  ldadat <- cbind(bogr.data.small[,c('pop')],as.data.frame(newfeats_scaled)) ; colnames(ldadat)[1] <- "pop"
  lda_res_extended <- lda(pop ~ ., data = ldadat, CV=TRUE)
  lda_res_extended$class
  head(lda_res_extended$posterior)
  
  lda_results <- lda(pop ~ ., data = ldadat)
  prop.lda = lda_results$svd^2/sum(lda_results$svd^2) ; prop.lda
  plda <- predict(object = lda_results, newdata = ldadat)
  
  ## PCA
  # prcomp_analysis <- prcomp(newfeats, center = T)
  # plot(prcomp_analysis)
  # summary_PCA <- summary(prcomp_analysis)
  # summary_PCA
  # propvariance <- summary_PCA$importance
  # components <- prcomp_analysis$x
  # prcomp_analysis$rotation
  
  # want to draw loadings
  load_dat <- data.frame(varnames=rownames(coef(lda_results)), coef(lda_results))
  rad <- radlength # This sets the length of your lines.
  load_dat$length <- with(load_dat, sqrt(LD1^2+LD2^2))
  load_dat$angle <- atan2(load_dat$LD1, load_dat$LD2)
  load_dat$x_start <- load_dat$y_start <- 0
  load_dat$x_end <- cos(load_dat$angle) * rad
  load_dat$y_end <- sin(load_dat$angle) * rad
  
  #replace some names
  loads <- c( 'belowground\nbiomass', 'rhizome\nbiomass', 'aboveground\nbiomass', 'lifetime\nflower\nmass', 'flower\ncount', 'flower\nlength', 'flower\nmass', 'maximum\nheight', 'predawn\nMPa', 'midday\nMPa', 'root:shoot', 'total\nbiomass')
  load_dat <- cbind(load_dat,loads)
  # save only top loadings in LD1 and LD2
  load_dat <- load_dat[(abs(load_dat$LD1) %in% tail(sort(abs(load_dat$LD1)),2) | abs(load_dat$LD2) %in% tail(sort(abs(load_dat$LD2)),1)),]
  
  plotdat <-  data.frame(pop = bogr.data.small[,"pop"], plda$x) ; colnames(plotdat)[1] <- "pop"
  colnames(col.pal)[2] <- "full" ; colnames(col.pal)[1] <- "pop"
  plotdat <-  merge(plotdat,col.pal)
  plotdat$regionlab <- regionlab
  
  plot_1 <- ggplot(plotdat, aes(LD1, LD2)) + 
    geom_point(aes(color=legend.order), size = 2.5) + 
    #geom_point(aes(color=pop),size=2.5) +
    #facet_wrap(~regionlab, scale = "free_y") +
    scale_color_manual(values = col.pal.colors, labels = col.pal.names) + 
    theme_classic() +
    labs(x = paste("LD1 (", percent(prop.lda[1]), ")", sep=""),
         y = paste("LD2 (", percent(prop.lda[2]), ")", sep="")) +
    labs(colour = "Site") +
    geom_spoke(aes(x_start, y_start, angle = angle), load_dat, 
               color = "black", radius = rad, size = 0.5,show.legend = FALSE) +
    geom_label(aes(y = y_end, x = x_end, label = loads), #can change alpha=length within aes
               load_dat, alpha=0.6, size = 3, vjust = .5, hjust = 0, colour = "black",show.legend = FALSE) +
    guides(text=FALSE,spoke=FALSE,length=FALSE) 
  
  return(plot_1)
}

ldaregional <- makeLDA(restrictions = bogr.data[(bogr.data$region != 'Boulder'),],
                       radlength=2,regionlab = 'Regional: trait means')
ldalocal <- makeLDA(restrictions = bogr.data[(bogr.data$region == 'Boulder'),],
                    radlength=2,regionlab = 'Local: trait means')


###########################################################################################

bogr.data <- read.csv("data/BOGR_DATA_plasticity_PCA_LDA.csv")
names(bogr.data)

bogr.data[bogr.data == "no pot"] <- NA # any unknown or unid'd locihttps://gist.github.com/thigm85/8424654 have a 'NA'
bogr.data[bogr.data == "met"] <- NA # any unknown or unid'd loci have a 'NA'
bogr.data[bogr.data == "tr"] <- NA # any unknown or unid'd loci have a 'NA'
bogr.data$biomass_aboveground <- as.numeric(as.character(bogr.data$biomass_aboveground))
bogr.data$biomass_belowground <- as.numeric(as.character(bogr.data$biomass_belowground))
bogr.data$biomass_rhizome <- as.numeric(as.character(bogr.data$biomass_rhizome))
bogr.data$root_shoot <- as.numeric(as.character(bogr.data$roottoshoot))
bogr.data$biomass_total <- as.numeric(as.character(bogr.data$biomass_total))

makeLDA <- function(restrictions = bogr.data[(bogr.data$region != 'Boulder'),],
                    radlength=2,
                    regionlab){
  # REMOVE ANY ROWS WITH TONS OF NA
  bogr.data <- bogr.data[rowSums(is.na(bogr.data)) < 7, ]
  # replace flower NA with zero
  bogr.data[,12:13][is.na(bogr.data[,12:13])] <- 0
  bogr.data.small <- restrictions
  feats <- bogr.data.small[,c(7:16,18,19)]
  #Iterativa PCA
  imputed <- imputePCA(feats, ncp=2, scale=TRUE)
  newfeats <- imputed$completeObs
  newfeats_scaled <- scale(newfeats)
  
  ldadat <- cbind(bogr.data.small[,c('pop')],as.data.frame(newfeats_scaled)) ; colnames(ldadat)[1] <- "pop"
  lda_res_extended <- lda(pop ~ ., data = ldadat, CV=TRUE)
  lda_res_extended$class
  head(lda_res_extended$posterior)
  
  lda_results <- lda(pop ~ ., data = ldadat)
  prop.lda = lda_results$svd^2/sum(lda_results$svd^2) ; prop.lda
  plda <- predict(object = lda_results, newdata = ldadat)
  
  ## PCA
  # prcomp_analysis <- prcomp(newfeats, center = T)
  # plot(prcomp_analysis)
  # summary_PCA <- summary(prcomp_analysis)
  # summary_PCA
  # propvariance <- summary_PCA$importance
  # components <- prcomp_analysis$x
  # prcomp_analysis$rotation
  
  # want to draw loadings
  load_dat <- data.frame(varnames=rownames(coef(lda_results)), coef(lda_results))
  rad <- radlength # This sets the length of your lines.
  load_dat$length <- with(load_dat, sqrt(LD1^2+LD2^2))
  load_dat$angle <- atan2(load_dat$LD1, load_dat$LD2)
  load_dat$x_start <- load_dat$y_start <- 0
  load_dat$x_end <- cos(load_dat$angle) * rad
  load_dat$y_end <- sin(load_dat$angle) * rad
  
  #replace some names
  loads <- c( 'belowground\nbiomass', 'rhizome\nbiomass', 'aboveground\nbiomass', 'lifetime\nflower\nmass', 'flower\ncount', 'flower\nlength', 'flower\nmass', 'maximum\nheight', 'predawn\nMPa', 'midday\nMPa', 'root:shoot', 'total\nbiomass')
  load_dat <- cbind(load_dat,loads)
  # save only top loadings in LD1 and LD2
  load_dat <- load_dat[(abs(load_dat$LD1) %in% tail(sort(abs(load_dat$LD1)),2) | abs(load_dat$LD2) %in% tail(sort(abs(load_dat$LD2)),1)),]
  
  plotdat <-  data.frame(pop = bogr.data.small[,"pop"], plda$x) ; colnames(plotdat)[1] <- "pop"
  colnames(col.pal)[2] <- "full" ; colnames(col.pal)[1] <- "pop"
  plotdat <-  merge(plotdat,col.pal)
  plotdat$regionlab <- regionlab
  
  plot_1 <- ggplot(plotdat, aes(LD1, LD2)) + 
    geom_point(aes(color=legend.order), size = 2.5) + 
    #geom_point(aes(color=pop),size=2.5) +
    #facet_wrap(~regionlab, scale = "free_y") +
    scale_color_manual(values = col.pal.colors, labels = col.pal.names) + 
    theme_classic() +
    labs(x = paste("LD1 (", percent(prop.lda[1]), ")", sep=""),
         y = paste("LD2 (", percent(prop.lda[2]), ")", sep="")) +
    labs(colour = "Site") +
    geom_spoke(aes(x_start, y_start, angle = angle), load_dat, 
               color = "black", radius = rad, size = 0.5,show.legend = FALSE) +
    geom_label(aes(y = y_end, x = x_end, label = loads), #can change alpha=length within aes
               load_dat, alpha=0.6, size = 3, vjust = .5, hjust = 0, colour = "black",show.legend = FALSE) +
    guides(text=FALSE,spoke=FALSE,length=FALSE) 
  
  return(plot_1)
}

# LDA for plasticity

ldaregionalplast <- makeLDA(restrictions = bogr.data[(bogr.data$region != 'Boulder'),],
                            radlength=1.5,regionlab = 'Regional: trait plasticity')
ldalocalplast <- makeLDA(restrictions = bogr.data[(bogr.data$region == 'Boulder'),],
                         radlength=2,regionlab = 'Local: trait plasticity')

###########################################################################################
# gather rank intervals

do.rank.wlegend <- function(infile,trait.name,restrictions){
  setwd(wd)
  dat <- read.csv(infile)
  trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
  site.dat <- read.csv("data/SITE_DATA.csv")
  site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
  full.dat <- cbind(trait.dat,site.dat.traits[,"pop"]) ; names(full.dat)[6] <- "pop" ; full.dat$trait <- rep(trait.name,nrow(full.dat))
  names(full.dat)[6] <- "abbv"
  full.dat <- merge(full.dat,col.pal)
  full.dat <- full.dat[(restrictions),]
  ## originally wanted ranked by mean, e.g., aes(x=rank(mean),y=mean))
  ## have switched to by rough aridity (aka, order determined in legend)
  gg <- ggplot(data=full.dat, aes(x=rank(legend.order),y=mean)) +
    geom_errorbar(aes(ymin=`X2.5.`,ymax=`X97.5.`,col=legend.order), width=0) + 
    scale_color_manual(values = col.pal.colors, labels = col.pal.names) +  
    theme_classic() + xlab(NULL) + 
    theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
    geom_point(aes(col=legend.order), size=3) + ylab(trait.name) + 
    labs(colour = "Site")
  return(gg)
}

regionaltrait_1 <- do.rank.wlegend(infile = "posterior_output/\ biomass_aboveground\ .csv", trait.name = "Aboveground biomass (g)" ,
                                 restrictions = c(2,4,5,11,12))
regionaltrait_2 <- do.rank.wlegend(infile = "posterior_output/\ biomass_belowground\ .csv", trait.name = "Belowground biomass (g)" ,
                                 restrictions = c(2,4,5,11,12))
regionaltrait_3 <- do.rank.wlegend(infile = "posterior_output/\ Total\ Biomass\ .csv", trait.name = "Total biomass (g)" ,
                                 restrictions = c(2,4,5,11,12))

localtrait_1 <- do.rank.wlegend(infile = "posterior_output/\ biomass_aboveground\ .csv", trait.name = "Aboveground biomass (g)" ,
                              restrictions = -c(2,4,5,11,12))
localtrait_2 <- do.rank.wlegend(infile = "posterior_output/\ Total\ Biomass\ .csv", trait.name = "Total biomass (g)" ,
                              restrictions = -c(2,4,5,11,12))


do.rank.wlegend <- function(infile,trait.name,restrictions){
  setwd(wd)
  dat <- read.csv(infile)
  trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
  site.dat <- read.csv("data/SITE_DATA.csv")
  site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
  full.dat <- cbind(trait.dat,site.dat.traits[,"pop"]) ; names(full.dat)[6] <- "pop" ; full.dat$trait <- rep(trait.name,nrow(full.dat))
  names(full.dat)[6] <- "abbv"
  full.dat <- merge(full.dat,col.pal)
  full.dat <- full.dat[(restrictions),]
  ## originally wanted ranked by mean, e.g., aes(x=rank(mean),y=mean))
  ## have switched to by rough aridity (aka, order determined in legend)
  gg <- ggplot(data=full.dat, aes(x=rank(legend.order),y=mean)) +
    geom_errorbar(aes(ymin=`X2.5.`,ymax=`X97.5.`,col=legend.order), width=0) + 
    scale_color_manual(values = col.pal.colors, labels = col.pal.names) +  
    theme_classic() + xlab(NULL) + geom_hline(yintercept=0, lty=3) +
    theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
    geom_point(aes(col=legend.order), size=3) + ylab(trait.name) + 
    labs(colour = "Site")
  return(gg)
}
regionalplast_1 <- do.rank.wlegend(infile = "posterior_output_plasticity/\ biomass_aboveground\ .csv", 
                                 trait.name = "Aboveground biomass plasticity (g)",
                                 restrictions = c(2,4,5,11,12) )
regionalplast_2 <- do.rank.wlegend(infile = "posterior_output_plasticity/\ biomass_belowground\ .csv", 
                                 trait.name = "Belowground biomass plasticity (g)",
                                 restrictions = c(2,4,5,11,12) )
regionalplast_3 <- do.rank.wlegend(infile = "posterior_output_plasticity/\ max_height\ .csv", 
                                 trait.name = "Maximum height (cm)",
                                 restrictions = c(2,4,5,11,12) )

localplast_1 <- do.rank.wlegend(infile = "posterior_output_plasticity/\ biomass_aboveground\ .csv", 
                              trait.name = "Aboveground biomass plasticity (g)",
                              restrictions = -c(2,4,5,11,12) )
localplast_2 <- do.rank.wlegend(infile = "posterior_output_plasticity/\ flwr_count_1.2\ .csv", 
                              trait.name = "Flower count",
                              restrictions = -c(2,4,5,11,12) )


###########################################################################################
# combine all plots

g_legend<-function(a.gplot){
  tmp <- ggplot_gtable(ggplot_build(a.gplot))
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  return(legend)}

mylegend1<-g_legend(regionalplast_1)
mylegend2<-g_legend(localplast_1) 

fig1 <- plot_grid(ldaregional + theme(legend.position = "none"), 
                  regionaltrait_1  + theme(legend.position = "none"),
                  regionaltrait_2  + theme(legend.position = "none"),
                  regionaltrait_3  + theme(legend.position = "none"),
                  ldaregionalplast + theme(legend.position = "none"), 
                  regionalplast_1 + theme(legend.position = "none"),
                  regionalplast_2 + theme(legend.position = "none"), 
                  regionalplast_3 + theme(legend.position = "none"), 
                  align='vh',nrow=2,labels = c(
                    "      (a)", 
                    "      (b)", 
                    "      (c)", 
                    "      (d)",
                    "      (e)", 
                    "      (f)", 
                    "      (g)", 
                    "      (h)"
                    ))
fig1plot <- grid.arrange(fig1, mylegend1, nrow=1,widths=c(10, 1))
fig2 <- plot_grid(ldalocal + theme(legend.position = "none"), 
                  localtrait_1 + theme(legend.position = "none"),
                  localtrait_2 + theme(legend.position = "none"),
                  ldalocalplast + theme(legend.position = "none"), 
                  localplast_1 + theme(legend.position = "none"), 
                  localplast_2 + theme(legend.position = "none"), 
                  align='vh',nrow=2,labels = c(
                    "      (a)", 
                    "      (b)", 
                    "      (c)", 
                    "      (d)",
                    "      (e)", 
                    "      (f)"
                    ))
fig2plot <- grid.arrange(fig2, mylegend2, nrow=1,widths=c(10, 2))

ggsave(fig1plot, file="LDA/LDA_regional.jpg",height=7,width=15)
ggsave(fig2plot, file="LDA/LDA_local.jpg",height=7,width=13)
