###########################################################################################
#
# This code plots the posterior intervals of all phenotypes by site
#
###########################################################################################
# Set working directory
source("config.R")
setwd(wd)
library(cowplot)
library(ggplot2)
library(grid)
library(gridExtra)

###########################################################################################

col.pal <- read.csv("utils/color_key.csv",header=T)
col.pal.names <- as.vector(col.pal[,2]) ; names(col.pal.names) <- col.pal[,6]
col.pal.colors <- as.vector(col.pal[,3]) ; names(col.pal.colors) <- col.pal[,6]
col.pal.v <- as.vector(col.pal[,3]) ; names(col.pal.v) <- col.pal[,2]

###########################################################################################


do.rank <- function(infile, trait.name, mcmc_ref = "trait"){
  
  # Read in data and build data frame for plotting
  setwd(wd)
  dat <- read.csv(infile)
  trait.dat <- dat[grep(mcmc_ref, dat$X),]
  rownames(trait.dat) <- seq(1,15,1)
  site.dat <- read.csv("data/SITE_DATA.csv")
  site.dat.traits <- site.dat[-c(6,10),]
  rownames(site.dat.traits) <- seq(1,15,1)
  full.dat <- cbind(trait.dat,site.dat.traits[,"pop"])
  names(full.dat)[6] <- "pop"
  names(full.dat)[6] <- "abbv"
  full.dat <- merge(full.dat,col.pal)
  
  # Make plot
  # Originally wanted ranked by mean, e.g., aes(x=rank(mean),y=mean))
  # Have switched to by rough aridity (aka, order determined in legend)
  gg <- 
    ggplot(
      data = full.dat,
      aes(x = rank(legend.order),
          y = mean)
    ) +
    theme_cowplot() +
    geom_errorbar(
      aes(ymin = `X2.5.`,
          ymax = `X97.5.`,
          col = legend.order),
      width = 0
    ) + 
    geom_point(
      aes(col = legend.order),
      size = 3
    ) + 
    scale_color_manual(
      values = col.pal.colors,
      labels = col.pal.names
    ) + 
    ylab(trait.name) +
    xlab(NULL) +
    labs(colour = "Site")
  
  return(gg)
}


g_legend <- function(a.gplot) {
  tmp <-
    ggplot_gtable(ggplot_build(a.gplot))
  leg <-
    which(sapply(tmp$grobs,
                 function(x)
                   x$name) == "guide-box")
  legend <-
    tmp$grobs[[leg]]
  
  return(legend)
}


render_interval_plot <-
  function(data_sources,
           trait_names,
           plot_title,
           filename,
           mcmc_ref = "trait",
           zero_line = F) {
    
    # Initiate blank list to store plots
    plots <- list()
    
    for (i in 1:length(data_sources)) {
      p <- do.rank(
        infile = as.character(data_sources[i]),
        trait.name = as.character(trait.names[i]),
        mcmc_ref = as.character(mcmc_ref)
      )
      # Save legend
      if (i == 1) {
        overall_legend <- g_legend(p)
        p <-
          p +
          theme(legend.position = "none")
      } else {
        p <-
          p +
          theme(legend.position = "none")
      }
      if (i >= 9) {
        p <- p + xlab("Site")
      }
      if (zero_line){
        p <- p + geom_hline(yintercept=0, lty=3) 
      }
      plots[[i]] <- p
    }
    
    bigplot <-
      plot_grid(
        plots[[1]],
        plots[[2]],
        plots[[3]],
        plots[[4]],
        plots[[5]],
        plots[[6]],
        plots[[7]],
        plots[[8]],
        plots[[9]],
        plots[[10]],
        plots[[11]],
        plots[[12]],
        align = "vh",
        axis = "bl",
        nrow = 3
      )
    
    title <-
      textGrob(plot_title, gp = gpar(fontsize = 20))
    
    plot.1 <-
      grid.arrange(bigplot,
                   overall_legend,
                   nrow = 1,
                   widths = c(8, 1))
    
    plot.1.with.title <-
      grid.arrange(title,
                   plot.1,
                   ncol = 1,
                   heights = c(1, 16))
    
    ggsave(plot.1.with.title,
           file = filename,
           height = 9,
           width = 15)
}


###########################################################################################
# Phenotype means

render_interval_plot(
  data_sources =
    list(
      "posterior_output/\ biomass_aboveground\ .csv",
      "posterior_output/\ biomass_belowground\ .csv",
      "posterior_output/\ biomass_rhizome\ .csv",
      "posterior_output/\ Total\ Biomass\ .csv",
      "posterior_output/\ Root\ to\ shoot\ biomass\ ratio\ .csv",
      "posterior_output/\ max_height\ .csv",
      "posterior_output/\ avg_midday_mpa_expt\ .csv",
      "posterior_output/\ avg_predawn_mpa_expt\ .csv",
      "posterior_output/\ flwr_mass_lifetime\ .csv",
      "posterior_output/\ flwr_count_1.2\ .csv",
      "posterior_output/\ flwr_avg_ind_mass\ .csv",
      "posterior_output/\ flwr_avg_ind_len\ .csv"
    ),
  trait_names =
    list(
      "Aboveground biomass (g)",
      "Belowground biomass (g)",
      "Rhizome biomass (g)",
      "Total Biomass (g)",
      "Root:Shoot ratio",
      "Maximum height (cm)",
      "Midday leaf water potential (MPa)",
      "Predawn leaf water potential (MPa)",
      "Lifetime flowering mass (g)",
      "Flower count",
      "Average flower mass (mg)",
      "Average flower length (mm)"
    ),
  plot_title = "Phenotype means",
  filename = "posterior_output/Trait_means.jpg",
  mcmc_ref = "trait"
)


###########################################################################################
# Phenotype variance

render_interval_plot(
  data_sources =
    list(
      "posterior_output/\ biomass_aboveground\ .csv",
      "posterior_output/\ biomass_belowground\ .csv",
      "posterior_output/\ biomass_rhizome\ .csv",
      "posterior_output/\ Total\ Biomass\ .csv",
      "posterior_output/\ Root\ to\ shoot\ biomass\ ratio\ .csv",
      "posterior_output/\ max_height\ .csv",
      "posterior_output/\ avg_midday_mpa_expt\ .csv",
      "posterior_output/\ avg_predawn_mpa_expt\ .csv",
      "posterior_output/\ flwr_mass_lifetime\ .csv",
      "posterior_output/\ flwr_count_1.2\ .csv",
      "posterior_output/\ flwr_avg_ind_mass\ .csv",
      "posterior_output/\ flwr_avg_ind_len\ .csv"
    ),
  trait_names =
    list(
      "Aboveground biomass (g)",
      "Belowground biomass (g)",
      "Rhizome biomass (g)",
      "Total Biomass (g)",
      "Root:Shoot ratio",
      "Maximum height (cm)",
      "Midday leaf water potential (MPa)",
      "Predawn leaf water potential (MPa)",
      "Lifetime flowering mass (g)",
      "Flower count",
      "Average flower mass (mg)",
      "Average flower length (mm)"
    ),
  plot_title = "Phenotype variances",
  filename = "posterior_output/Trait_variance.jpg",
  mcmc_ref = "sigma_pop"
)


###########################################################################################
# Phenotypic plsticity means

render_interval_plot(
  data_sources =
    list(
      "posterior_output_plasticity/\ biomass_aboveground\ .csv",
      "posterior_output_plasticity/\ biomass_belowground\ .csv",
      "posterior_output_plasticity/\ biomass_rhizome\ .csv",
      "posterior_output_plasticity/\ Total\ Biomass\ .csv",
      "posterior_output_plasticity/\ Root\ to\ shoot\ biomass\ ratio\ .csv",
      "posterior_output_plasticity/\ max_height\ .csv",
      "posterior_output_plasticity/\ avg_midday_mpa_expt\ .csv",
      "posterior_output_plasticity/\ avg_predawn_mpa_expt\ .csv",
      "posterior_output_plasticity/\ flwr_mass_lifetime\ .csv",
      "posterior_output_plasticity/\ flwr_count_1.2\ .csv",
      "posterior_output_plasticity/\ flwr_avg_ind_mass\ .csv",
      "posterior_output_plasticity/\ flwr_avg_ind_len\ .csv"
    ),
  trait_names =
    list(
      "Aboveground biomass (g)",
      "Belowground biomass (g)",
      "Rhizome biomass (g)",
      "Total Biomass (g)",
      "Root:Shoot ratio",
      "Maximum height (cm)",
      "Midday leaf water potential (MPa)",
      "Predawn leaf water potential (MPa)",
      "Lifetime flowering mass (g)",
      "Flower count",
      "Average flower mass (mg)",
      "Average flower length (mm)"
    ),
  plot_title = "Phenotypic plasticity means",
  filename = "posterior_output_plasticity/Trait_plasticity.jpg",
  mcmc_ref = "trait",
  zero_line = T
)


###########################################################################################
# Phenotypic plasticity variance

render_interval_plot(
  data_sources =
    list(
      "posterior_output_plasticity/\ biomass_aboveground\ .csv",
      "posterior_output_plasticity/\ biomass_belowground\ .csv",
      "posterior_output_plasticity/\ biomass_rhizome\ .csv",
      "posterior_output_plasticity/\ Total\ Biomass\ .csv",
      "posterior_output_plasticity/\ Root\ to\ shoot\ biomass\ ratio\ .csv",
      "posterior_output_plasticity/\ max_height\ .csv",
      "posterior_output_plasticity/\ avg_midday_mpa_expt\ .csv",
      "posterior_output_plasticity/\ avg_predawn_mpa_expt\ .csv",
      "posterior_output_plasticity/\ flwr_mass_lifetime\ .csv",
      "posterior_output_plasticity/\ flwr_count_1.2\ .csv",
      "posterior_output_plasticity/\ flwr_avg_ind_mass\ .csv",
      "posterior_output_plasticity/\ flwr_avg_ind_len\ .csv"
    ),
  trait_names =
    list(
      "Aboveground biomass (g)",
      "Belowground biomass (g)",
      "Rhizome biomass (g)",
      "Total Biomass (g)",
      "Root:Shoot ratio",
      "Maximum height (cm)",
      "Midday leaf water potential (MPa)",
      "Predawn leaf water potential (MPa)",
      "Lifetime flowering mass (g)",
      "Flower count",
      "Average flower mass (mg)",
      "Average flower length (mm)"
    ),
  plot_title = "Phenotypic plasticity variances",
  filename = "posterior_output_plasticity/Trait_plasticity_variance.jpg",
  mcmc_ref = "sigma_pop"
)

