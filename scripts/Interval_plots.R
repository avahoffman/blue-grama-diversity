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
wd <- "/Users/avahoffman/Dropbox/Research/Bouteloua_diversity/blue-grama-diversity"
setwd(wd)

library(ggplot2)
library(gridExtra)

###########################################################################################


col.pal <- read.csv("utils/color_key.csv",header=T)
col.pal.names <- as.vector(col.pal[,2]) ; names(col.pal.names) <- col.pal[,6]
col.pal.colors <- as.vector(col.pal[,3]) ; names(col.pal.colors) <- col.pal[,6]
col.pal.v <- as.vector(col.pal[,3]) ; names(col.pal.v) <- col.pal[,2]

do.rank <- function(infile,trait.name){
  setwd(wd)
  dat <- read.csv(infile)
  trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
  site.dat <- read.csv("data/SITE_DATA.csv")
  site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
  full.dat <- cbind(trait.dat,site.dat.traits[,"pop"]) ; names(full.dat)[6] <- "pop" ; full.dat$trait <- rep(trait.name,nrow(full.dat))
  names(full.dat)[6] <- "abbv"
  full.dat <- merge(full.dat,col.pal)
  gg <- ggplot(data=full.dat, aes(x=rank(mean),y=mean)) +
    facet_wrap(~trait, scale = "free_y") +
    geom_errorbar(aes(ymin=`X2.5.`,ymax=`X97.5.`,col=legend.order), width=0) + 
    scale_color_manual(values = col.pal.colors, labels = col.pal.names) +  
    theme_classic() + xlab(NULL) + 
    theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
    geom_point(aes(col=legend.order), size=3) + ylab(NULL) + 
    labs(colour = "Site") + theme( legend.position = "none"  )
  return(gg)
}
do.rank.wlegend <- function(infile,trait.name){
  setwd(wd)
  dat <- read.csv(infile)
  trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
  site.dat <- read.csv("data/SITE_DATA.csv")
  site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
  full.dat <- cbind(trait.dat,site.dat.traits[,"pop"]) ; names(full.dat)[6] <- "pop" ; full.dat$trait <- rep(trait.name,nrow(full.dat))
  names(full.dat)[6] <- "abbv"
  full.dat <- merge(full.dat,col.pal)
  gg <- ggplot(data=full.dat, aes(x=rank(mean),y=mean)) +
    facet_wrap(~trait, scale = "free_y") +
    geom_errorbar(aes(ymin=`X2.5.`,ymax=`X97.5.`,col=legend.order), width=0) + 
    scale_color_manual(values = col.pal.colors, labels = col.pal.names) +  
    theme_classic() + xlab(NULL) + 
    theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
    geom_point(aes(col=legend.order), size=3) + ylab(NULL) + 
    labs(colour = "Site")
  return(gg)
}


d1 <- do.rank.wlegend(infile = "posterior_output/\ Total\ Biomass\ .csv", trait.name = "Total Biomass (g)" )
d2 <- do.rank(infile = "posterior_output/\ Root\ to\ shoot\ biomass\ ratio\ .csv", trait.name = "Root:Shoot" )
d3 <- do.rank(infile = "posterior_output/\ avg_midday_mpa_expt\ .csv", trait.name = "Midday leaf water potential (MPa)" )
d4 <- do.rank(infile = "posterior_output/\ avg_predawn_mpa_expt\ .csv", trait.name = "Predawn leaf water potential (MPa)" )
d5 <- do.rank(infile = "posterior_output/\ max_height\ .csv", trait.name = "Maximum height (cm)" )
d6 <- do.rank(infile = "posterior_output/\ flwr_avg_ind_mass\ .csv", trait.name = "Average flower mass (mg)" )
d7 <- do.rank(infile = "posterior_output/\ flwr_avg_ind_len\ .csv", trait.name = "Average flower length (mm)" )
d8 <- do.rank(infile = "posterior_output/\ flwr_count_1.2\ .csv", trait.name = "Flower count" )
d9 <- do.rank(infile = "posterior_output/\ flwr_mass_lifetime\ .csv", trait.name = "Lifetime flowering mass (g)" )
d10 <- do.rank(infile = "posterior_output/\ biomass_rhizome\ .csv", trait.name = "Rhizome biomass (g)" )
d11 <- do.rank(infile = "posterior_output/\ biomass_belowground\ .csv", trait.name = "Belowground biomass (g)" )
d12 <- do.rank(infile = "posterior_output/\ biomass_aboveground\ .csv", trait.name = "Aboveground biomass (g)" )

bigplot <- grid.arrange(d12,d11,d10,d1 + theme(legend.position = "none"),
                        d2,d5,d4,d3,
                        d9,d8,d6,d7,
                        nrow=3)

g_legend<-function(a.gplot){
  tmp <- ggplot_gtable(ggplot_build(a.gplot))
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  return(legend)}

mylegend<-g_legend(d1)

plot.1 <- grid.arrange(bigplot, mylegend, nrow=1,widths=c(10, 1))
plot.1
ggsave(plot.1,file="posterior_output/Trait_means.jpg",height=8,width=13)



## now with variance accounting for water treatment
do.rank <- function(infile,trait.name){
  setwd(wd)
  dat <- read.csv(infile)
  trait.dat <- dat[grep("sigma_pop", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
  site.dat <- read.csv("data/SITE_DATA.csv")
  site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
  full.dat <- cbind(trait.dat,site.dat.traits[,"pop"]) ; names(full.dat)[6] <- "pop" ; full.dat$trait <- rep(trait.name,nrow(full.dat))
  names(full.dat)[6] <- "abbv"
  full.dat <- merge(full.dat,col.pal)
  gg <- ggplot(data=full.dat, aes(x=rank(mean),y=mean)) +
    facet_wrap(~trait, scale = "free_y") +
    geom_errorbar(aes(ymin=`X2.5.`,ymax=`X97.5.`,col=legend.order), width=0) + 
    scale_color_manual(values = col.pal.colors, labels = col.pal.names) +  
    theme_classic() + xlab(NULL) + 
    theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
    geom_point(aes(col=legend.order), size=3) + ylab(NULL) + 
    labs(colour = "Site") + theme( legend.position = "none"  )
  return(gg)
}
do.rank.wlegend <- function(infile,trait.name){
  setwd(wd)
  dat <- read.csv(infile)
  trait.dat <- dat[grep("sigma_pop", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
  site.dat <- read.csv("data/SITE_DATA.csv")
  site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
  full.dat <- cbind(trait.dat,site.dat.traits[,"pop"]) ; names(full.dat)[6] <- "pop" ; full.dat$trait <- rep(trait.name,nrow(full.dat))
  names(full.dat)[6] <- "abbv"
  full.dat <- merge(full.dat,col.pal)
  gg <- ggplot(data=full.dat, aes(x=rank(mean),y=mean)) +
    facet_wrap(~trait, scale = "free_y") +
    geom_errorbar(aes(ymin=`X2.5.`,ymax=`X97.5.`,col=legend.order), width=0) + 
    scale_color_manual(values = col.pal.colors, labels = col.pal.names) +  
    theme_classic() + xlab(NULL) + 
    theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
    geom_point(aes(col=legend.order), size=3) + ylab(NULL) + 
    labs(colour = "Site")
  return(gg)
}
d1 <- do.rank.wlegend(infile = "posterior_output/\ Total\ Biomass\ .csv", trait.name = "Total Biomass (g)" )
d2 <- do.rank(infile = "posterior_output/\ Root\ to\ shoot\ biomass\ ratio\ .csv", trait.name = "Root:Shoot" )
d3 <- do.rank(infile = "posterior_output/\ avg_midday_mpa_expt\ .csv", trait.name = "Midday leaf water potential (MPa)" )
d4 <- do.rank(infile = "posterior_output/\ avg_predawn_mpa_expt\ .csv", trait.name = "Predawn leaf water potential (MPa)" )
d5 <- do.rank(infile = "posterior_output/\ max_height\ .csv", trait.name = "Maximum height (cm)" )
d6 <- do.rank(infile = "posterior_output/\ flwr_avg_ind_mass\ .csv", trait.name = "Average flower mass (mg)" )
d7 <- do.rank(infile = "posterior_output/\ flwr_avg_ind_len\ .csv", trait.name = "Average flower length (mm)" )
d8 <- do.rank(infile = "posterior_output/\ flwr_count_1.2\ .csv", trait.name = "Flower count" )
d9 <- do.rank(infile = "posterior_output/\ flwr_mass_lifetime\ .csv", trait.name = "Lifetime flowering mass (g)" )
d10 <- do.rank(infile = "posterior_output/\ biomass_rhizome\ .csv", trait.name = "Rhizome biomass (g)" )
d11 <- do.rank(infile = "posterior_output/\ biomass_belowground\ .csv", trait.name = "Belowground biomass (g)" )
d12 <- do.rank(infile = "posterior_output/\ biomass_aboveground\ .csv", trait.name = "Aboveground biomass (g)" )

bigplot <- grid.arrange(d12,d11,d10,d1 + theme(legend.position = "none"),
                        d2,d5,d4,d3,
                        d9,d8,d6,d7,
                        nrow=3)
plot.2 <- grid.arrange(bigplot, mylegend, nrow=1,widths=c(10, 1))
ggsave(plot.2, file="posterior_output/Trait_variance.jpg",height=8,width=13)



## With plasticity
do.rank <- function(infile,trait.name){
  setwd(wd)
  dat <- read.csv(infile)
  trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
  site.dat <- read.csv("data/SITE_DATA.csv")
  site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
  full.dat <- cbind(trait.dat,site.dat.traits[,"pop"]) ; names(full.dat)[6] <- "pop" ; full.dat$trait <- rep(trait.name,nrow(full.dat))
  names(full.dat)[6] <- "abbv"
  full.dat <- merge(full.dat,col.pal)
  gg <- ggplot(data=full.dat, aes(x=rank(mean),y=mean)) +
    facet_wrap(~trait, scale = "free_y") +
    geom_errorbar(aes(ymin=`X2.5.`,ymax=`X97.5.`,col=legend.order), width=0) + 
    scale_color_manual(values = col.pal.colors, labels = col.pal.names) +  
    theme_classic() + xlab(NULL) + geom_hline(yintercept=0, lty=3) +
    theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
    geom_point(aes(col=legend.order), size=3) + ylab(NULL) + 
    labs(colour = "Site") + theme( legend.position = "none"  )
  return(gg)
}
do.rank.wlegend <- function(infile,trait.name){
  setwd(wd)
  dat <- read.csv(infile)
  trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
  site.dat <- read.csv("data/SITE_DATA.csv")
  site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
  full.dat <- cbind(trait.dat,site.dat.traits[,"pop"]) ; names(full.dat)[6] <- "pop" ; full.dat$trait <- rep(trait.name,nrow(full.dat))
  names(full.dat)[6] <- "abbv"
  full.dat <- merge(full.dat,col.pal)
  gg <- ggplot(data=full.dat, aes(x=rank(mean),y=mean)) +
    facet_wrap(~trait, scale = "free_y") +
    geom_errorbar(aes(ymin=`X2.5.`,ymax=`X97.5.`,col=legend.order), width=0) + 
    scale_color_manual(values = col.pal.colors, labels = col.pal.names) +  
    theme_classic() + xlab(NULL) + geom_hline(yintercept=0, lty=3) +
    theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
    geom_point(aes(col=legend.order), size=3) + ylab(NULL) + 
    labs(colour = "Site")
  return(gg)
}
d1 <- do.rank.wlegend(infile = "posterior_output_plasticity/\ Total\ Biomass\ .csv", trait.name = "Total Biomass (g)" )
d2 <- do.rank(infile = "posterior_output_plasticity/\ Root\ to\ shoot\ biomass\ ratio\ .csv", trait.name = "Root:Shoot" )
d3 <- do.rank(infile = "posterior_output_plasticity/\ avg_midday_mpa_expt\ .csv", trait.name = "Midday leaf water potential (MPa)" )
d4 <- do.rank(infile = "posterior_output_plasticity/\ avg_predawn_mpa_expt\ .csv", trait.name = "Predawn leaf water potential (MPa)" )
d5 <- do.rank(infile = "posterior_output_plasticity/\ max_height\ .csv", trait.name = "Maximum height (cm)" )
d6 <- do.rank(infile = "posterior_output_plasticity/\ flwr_avg_ind_mass\ .csv", trait.name = "Average flower mass (mg)" )
d7 <- do.rank(infile = "posterior_output_plasticity/\ flwr_avg_ind_len\ .csv", trait.name = "Average flower length (mm)" )
d8 <- do.rank(infile = "posterior_output_plasticity/\ flwr_count_1.2\ .csv", trait.name = "Flower count" )
d9 <- do.rank(infile = "posterior_output_plasticity/\ flwr_mass_lifetime\ .csv", trait.name = "Lifetime flowering mass (g)" )
d10 <- do.rank(infile = "posterior_output_plasticity/\ biomass_rhizome\ .csv", trait.name = "Rhizome biomass (g)" )
d11 <- do.rank(infile = "posterior_output_plasticity/\ biomass_belowground\ .csv", trait.name = "Belowground biomass (g)" )
d12 <- do.rank(infile = "posterior_output_plasticity/\ biomass_aboveground\ .csv", trait.name = "Aboveground biomass (g)" )

bigplot <- grid.arrange(d12,d11,d10,d1 + theme(legend.position = "none"),
                        d2,d5,d4,d3,
                        d9,d8,d6,d7,
                        nrow=3)
plot.3 <- grid.arrange(bigplot, mylegend, nrow=1,widths=c(10, 1))
ggsave(plot.3, file="posterior_output_plasticity/Trait_plasticity.jpg",height=8,width=13)



## With plasticity variance
do.rank <- function(infile,trait.name){
  setwd(wd)
  dat <- read.csv(infile)
  trait.dat <- dat[grep("sigma_pop", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
  site.dat <- read.csv("data/SITE_DATA.csv")
  site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
  full.dat <- cbind(trait.dat,site.dat.traits[,"pop"]) ; names(full.dat)[6] <- "pop" ; full.dat$trait <- rep(trait.name,nrow(full.dat))
  names(full.dat)[6] <- "abbv"
  full.dat <- merge(full.dat,col.pal)
  gg <- ggplot(data=full.dat, aes(x=rank(mean),y=mean)) +
    facet_wrap(~trait, scale = "free_y") +
    geom_errorbar(aes(ymin=`X2.5.`,ymax=`X97.5.`,col=legend.order), width=0) + 
    scale_color_manual(values = col.pal.colors, labels = col.pal.names) +  
    theme_classic() + xlab(NULL) + 
    theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
    geom_point(aes(col=legend.order), size=3) + ylab(NULL) + 
    labs(colour = "Site") + theme( legend.position = "none"  )
  return(gg)
}
do.rank.wlegend <- function(infile,trait.name){
  setwd(wd)
  dat <- read.csv(infile)
  trait.dat <- dat[grep("sigma_pop", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
  site.dat <- read.csv("data/SITE_DATA.csv")
  site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
  full.dat <- cbind(trait.dat,site.dat.traits[,"pop"]) ; names(full.dat)[6] <- "pop" ; full.dat$trait <- rep(trait.name,nrow(full.dat))
  names(full.dat)[6] <- "abbv"
  full.dat <- merge(full.dat,col.pal)
  gg <- ggplot(data=full.dat, aes(x=rank(mean),y=mean)) +
    facet_wrap(~trait, scale = "free_y") +
    geom_errorbar(aes(ymin=`X2.5.`,ymax=`X97.5.`,col=legend.order), width=0) + 
    scale_color_manual(values = col.pal.colors, labels = col.pal.names) +  
    theme_classic() + xlab(NULL) +
    theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
    geom_point(aes(col=legend.order), size=3) + ylab(NULL) + 
    labs(colour = "Site")
  return(gg)
}
d1 <- do.rank.wlegend(infile = "posterior_output_plasticity/\ Total\ Biomass\ .csv", trait.name = "Total Biomass (g)" )
d2 <- do.rank(infile = "posterior_output_plasticity/\ Root\ to\ shoot\ biomass\ ratio\ .csv", trait.name = "Root:Shoot" )
d3 <- do.rank(infile = "posterior_output_plasticity/\ avg_midday_mpa_expt\ .csv", trait.name = "Midday leaf water potential (MPa)" )
d4 <- do.rank(infile = "posterior_output_plasticity/\ avg_predawn_mpa_expt\ .csv", trait.name = "Predawn leaf water potential (MPa)" )
d5 <- do.rank(infile = "posterior_output_plasticity/\ max_height\ .csv", trait.name = "Maximum height (cm)" )
d6 <- do.rank(infile = "posterior_output_plasticity/\ flwr_avg_ind_mass\ .csv", trait.name = "Average flower mass (mg)" )
d7 <- do.rank(infile = "posterior_output_plasticity/\ flwr_avg_ind_len\ .csv", trait.name = "Average flower length (mm)" )
d8 <- do.rank(infile = "posterior_output_plasticity/\ flwr_count_1.2\ .csv", trait.name = "Flower count" )
d9 <- do.rank(infile = "posterior_output_plasticity/\ flwr_mass_lifetime\ .csv", trait.name = "Lifetime flowering mass (g)" )
d10 <- do.rank(infile = "posterior_output_plasticity/\ biomass_rhizome\ .csv", trait.name = "Rhizome biomass (g)" )
d11 <- do.rank(infile = "posterior_output_plasticity/\ biomass_belowground\ .csv", trait.name = "Belowground biomass (g)" )
d12 <- do.rank(infile = "posterior_output_plasticity/\ biomass_aboveground\ .csv", trait.name = "Aboveground biomass (g)" )

bigplot <- grid.arrange(d12,d11,d10,d1 + theme(legend.position = "none"),
                        d2,d5,d4,d3,
                        d9,d8,d6,d7,
                        nrow=3)
plot.4 <- grid.arrange(bigplot, mylegend, nrow=1,widths=c(10, 1))
ggsave(plot.4, file="posterior_output_plasticity/Trait_plasticity_variance.jpg",height=8,width=13)
