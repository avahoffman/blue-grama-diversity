###########################################################################################
##
## This code performs LDA and plots results
##
###########################################################################################
library(ggplot2)
library(gridExtra)
library(missMDA)
library(MASS)
require(scales)
library(cowplot)
library(tidyr)
library(dplyr)

## PCA / LDA
## https://www.r-bloggers.com/computing-and-visualizing-lda-in-r/
## https://gist.github.com/thigm85/8424654
###########################################################################################


makeLDA <-
  function(restrictions = bogr.data[(bogr.data$region != 'Boulder'),],
           radlength = 2,
           regionlab
  ) {
    # LDA on trait means
    # REMOVE ANY ROWS WITH TONS OF NA
    bogr.data <- bogr.data[rowSums(is.na(bogr.data)) < 7, ]
    # replace flower NA with zero
    bogr.data$flwr_avg_ind_len <- 
      bogr.data$flwr_avg_ind_len %>% replace_na(0)
    bogr.data$flwr_avg_ind_mass <- 
      bogr.data$flwr_avg_ind_mass %>% replace_na(0)
    # Subset data
    feats <- 
      restrictions %>% dplyr::select("biomass_belowground",
                              "biomass_rhizome",
                              "biomass_aboveground",
                              "flwr_mass_lifetime", 
                              "flwr_count_1.2",
                              "flwr_avg_ind_len",  
                              "flwr_avg_ind_mass",
                              "max_height",     
                              "avg_predawn_mpa_expt",
                              "avg_midday_mpa_expt",
                              "biomass_total",
                              "root_shoot"
      )
    #Iterativa PCA
    imputed <- imputePCA(feats, ncp = 2, scale = TRUE)
    newfeats <- imputed$completeObs
    newfeats_scaled <- scale(newfeats)
    
    ldadat <-
      cbind(restrictions[, c('pop')], as.data.frame(newfeats_scaled))
    colnames(ldadat)[1] <- "pop"
    lda_res_extended <- lda(pop ~ ., data = ldadat, CV = TRUE)
    lda_res_extended$class
    head(lda_res_extended$posterior)
    
    lda_results <- lda(pop ~ ., data = ldadat)
    prop.lda = lda_results$svd ^ 2 / sum(lda_results$svd ^ 2)
    prop.lda
    plda <- predict(object = lda_results, newdata = ldadat)
    
    # want to draw loadings
    load_dat <-
      data.frame(varnames = rownames(coef(lda_results)), coef(lda_results))
    rad <- radlength # This sets the length of your lines.
    load_dat$length <- with(load_dat, sqrt(LD1 ^ 2 + LD2 ^ 2))
    load_dat$angle <- atan2(load_dat$LD1, load_dat$LD2)
    load_dat$x_start <- load_dat$y_start <- 0
    load_dat$x_end <- cos(load_dat$angle) * rad
    load_dat$y_end <- sin(load_dat$angle) * rad
    
    #replace some names
    loads <-
      c(
        'belowground\nbiomass',
        'rhizome\nbiomass',
        'aboveground\nbiomass',
        'lifetime\nflower\nmass',
        'flower\ncount',
        'flower\nlength',
        'flower\nmass',
        'maximum\nheight',
        'predawn\nMPa',
        'midday\nMPa',
        'root:shoot',
        'total\nbiomass'
      )
    load_dat <- cbind(load_dat, loads)
    # save only top loadings in LD1 and LD2
    load_dat <-
      load_dat[(abs(load_dat$LD1) %in% tail(sort(abs(load_dat$LD1)), 2) |
                  abs(load_dat$LD2) %in% tail(sort(abs(load_dat$LD2)), 1)),]
    
    plotdat <-
      data.frame(pop = restrictions[, "pop"], plda$x)
    col.pal <- col_pal()[[4]]
    colnames(plotdat)[1] <- "pop"
    colnames(col.pal)[2] <- "full"
    colnames(col.pal)[1] <- "pop"
    plotdat <-  merge(plotdat, col.pal)
    plotdat$regionlab <- regionlab
    
    plot_1 <- ggplot(plotdat, aes(LD1, LD2)) +
      theme_cowplot() +
      geom_point(aes(color = legend.order), size = 2.5) +
      scale_color_manual(values = col_pal()[[3]], labels = col_pal()[[2]]) +
      labs(
        x = paste("LD1 (", percent(prop.lda[1]), ")", sep = ""),
        y = paste("LD2 (", percent(prop.lda[2]), ")", sep = "")
      ) +
      labs(colour = "Site") +
      geom_spoke(
        aes(x_start, y_start, angle = angle),
        load_dat,
        color = "black",
        radius = rad,
        size = 0.5,
        show.legend = FALSE
      ) +
      geom_label(
        aes(y = y_end, x = x_end, label = loads),
        #can change alpha=length within aes
        load_dat,
        alpha = 0.6,
        size = 3,
        vjust = .5,
        hjust = 0,
        colour = "black",
        show.legend = FALSE
      ) +
      guides(text = FALSE,
             spoke = FALSE,
             length = FALSE)
    
    return(plot_1)
    
  }


do_rank <- function(infile, 
                            trait.name, 
                            restrictions,
                            plasticity = F,
                            xlabs = NULL) {
  ## Interval plots
  if (plasticity){
    breaks <- seq(1, length(xlabs), 1)
  }
  dat <- read.csv(infile)
  trait.dat <-
    dat[grep("trait", dat$X),]
  rownames(trait.dat) <- seq(1, 15, 1)
  site.dat <- read.csv("data/SITE_DATA.csv")
  site.dat.traits <-
    site.dat[-c(6, 10),]
  rownames(site.dat.traits) <- seq(1, 15, 1)
  full.dat <-
    cbind(trait.dat, site.dat.traits[, "pop"])
  names(full.dat)[6] <-
    "pop"
  full.dat$trait <- rep(trait.name, nrow(full.dat))
  names(full.dat)[6] <- "abbv"
  full.dat <- merge(full.dat, col_pal()[[4]])
  full.dat <- full.dat[(restrictions),]
  breaks <- seq(1, nrow(full.dat), 1)
  ## originally wanted ranked by mean, e.g., aes(x=rank(mean),y=mean))
  ## have switched to by rough aridity (aka, order determined in legend)
  gg <-
    ggplot(data = full.dat, 
           aes(x = rank(legend.order), 
               y = mean)) +
    theme_cowplot() +
    geom_errorbar(aes(ymin = `X2.5.`, 
                      ymax = `X97.5.`, 
                      col = legend.order), 
                  width = 0) +
    scale_color_manual(values = col.pal.colors, 
                       labels = col.pal.names) +
    xlab(NULL) +
    geom_point(aes(col = legend.order), 
               size = 3) + 
    ylab(trait.name) +
    labs(colour = "Site") + 
    theme(legend.position = "none")
  if (plasticity){
    gg <- 
      gg +
      theme(axis.text.x = element_text(angle=45, hjust = 1)) +
      geom_hline(yintercept = 0, lty = 3) +
      scale_x_continuous(labels = xlabs,
                         breaks = breaks)
  } else {
    gg <- 
      gg + 
      theme(axis.text.x = element_blank()) +
      scale_x_continuous(breaks = breaks)
  }
  
  return(gg)
}


## Combine all plots

make_regional_lda_trait_plots <- 
  function(){
    
    bogr.data <- get_bogr_data(script = "LDA")
    
    col.pal.colors <- col_pal()[[3]]
    col.pal.names <- col_pal()[[2]]
    col.pal.v  <- col_pal()[[1]]
    
    fig1 <- 
      plot_grid(
        makeLDA(restrictions = bogr.data[(bogr.data$region != 'Boulder'),],
                regionlab = 'Regional: trait means') + 
          theme(legend.position = "none") + 
          theme(plot.margin = unit(c(7, 7, 7, 14), "pt")), # Slight misalignment otherwise
        do_rank(
          infile = "posterior_output/\ biomass_aboveground\ .csv",
          trait.name = "Aboveground biomass (g)" ,
          restrictions = c(2, 4, 5, 11, 12)
        ),
        do_rank(
          infile = "posterior_output/\ biomass_belowground\ .csv",
          trait.name = "Belowground biomass (g)" ,
          restrictions = c(2, 4, 5, 11, 12)
        ),
        do_rank(
          infile = "posterior_output/\ Total\ Biomass\ .csv",
          trait.name = "Total biomass (g)" ,
          restrictions = c(2, 4, 5, 11, 12)
        ),
        labels = c("(a)",
                   "(b)",
                   "(c)",
                   "(d)"),
        hjust = -3.2,
        vjust = 2,
        nrow = 1,
        axis = "lb",
        align = "vh"
      )
    
    bogr.data <- get_bogr_data(script = "LDA_plasticity")
    
    fig2 <- 
      plot_grid(
        makeLDA(restrictions = bogr.data[(bogr.data$region != 'Boulder'),],
                radlength = 1.5,
                regionlab = 'Regional: trait plasticity') + theme(legend.position = "none"),
        do_rank(
          infile = "posterior_output_plasticity/\ biomass_aboveground\ .csv",
          trait.name = "Aboveground biomass plasticity (g)",
          restrictions = c(2, 4, 5, 11, 12),
          xlabs = c("Sevilleta", "Cibola", "Comanche", "SGS", "Buffalo Gap"),
          plasticity = T
        ),
        do_rank(
          infile = "posterior_output_plasticity/\ biomass_belowground\ .csv",
          trait.name = "Belowground biomass plasticity (g)",
          restrictions = c(2, 4, 5, 11, 12),
          xlabs = c("Sevilleta", "Cibola", "Comanche", "SGS", "Buffalo Gap"),
          plasticity = T
        ),
        do_rank(
          infile = "posterior_output_plasticity/\ max_height\ .csv",
          trait.name = "Maximum height plasticity (cm)",
          restrictions = c(2, 4, 5, 11, 12),
          xlabs = c("Sevilleta", "Cibola", "Comanche", "SGS", "Buffalo Gap"),
          plasticity = T
        ),
      labels = c("(e)",
                 " (f)",
                 "(g)",
                 "(h)"),
      hjust = -3.2,
      vjust = 2,
      nrow = 1,
      axis = "lb",
      align = "vh"
    )
    

    fig <- plot_grid(fig1, fig2, nrow =2, rel_heights = c(0.47, 0.53))
    
    leg <-
      g_legend(
        makeLDA(
          restrictions = bogr.data[(bogr.data$region != 'Boulder'), ],
          regionlab = 'Regional: trait means'
        )
      )

    final <- 
      grid.arrange(
      leg, fig, ncol = 2, widths = c(0.1,0.9)
    )

    ggsave(final,
           file = "LDA/LDA_regional.jpg",
           height = 7,
           width = 14.5)
  }


make_local_lda_trait_plots <- 
  function(){
    
    bogr.data <- get_bogr_data(script = "LDA")
    
    col.pal.colors <- col_pal()[[3]]
    col.pal.names <- col_pal()[[2]]
    col.pal.v  <- col_pal()[[1]]
    
    fig1 <- 
      plot_grid(
        makeLDA(restrictions = bogr.data[(bogr.data$region == 'Boulder'),],
                  regionlab = 'Local: trait means') + theme(legend.position = "none"),
        do_rank(
            infile = "posterior_output/\ biomass_aboveground\ .csv",
            trait.name = "Aboveground biomass (g)" ,
            restrictions = -c(2, 4, 5, 11, 12)
          ),
        do_rank(
            infile = "posterior_output/\ Total\ Biomass\ .csv",
            trait.name = "Total biomass (g)" ,
            restrictions = -c(2, 4, 5, 11, 12)
          ),
        labels = c(
          "(a)",
          "(b)",
          "(c)"),
        hjust = -3.2,
        vjust = 2,
        axis = "lb",
        align = "vh",
        nrow = 1
      )
    
    bogr.data <- get_bogr_data(script = "LDA_plasticity")
    
    fig2 <- 
      plot_grid(
        makeLDA(restrictions = bogr.data[(bogr.data$region == 'Boulder'),],
                regionlab = 'Local: trait plasticity') + theme(legend.position = "none"),
        do_rank(
          infile = "posterior_output_plasticity/\ biomass_aboveground\ .csv",
          trait.name = "Aboveground biomass plasticity (g)",
          restrictions = -c(2, 4, 5, 11, 12),
          xlabs = c("Andrus",
                    "Rock Creek",
                    "Steele",
                    "Rabbit Mountain",
                    "Beech Trail",
                    "Davidson Mesa",
                    "Wonderland",
                    "Heil Valley",
                    "Kelsall",
                    "Walker Ranch"),
          plasticity = T
        ),
        do_rank(
            infile = "posterior_output_plasticity/\ flwr_count_1.2\ .csv",
            trait.name = "Flower count plasticity",
            restrictions = -c(2, 4, 5, 11, 12),
            xlabs = c("Andrus",
                      "Rock Creek",
                      "Steele",
                      "Rabbit Mountain",
                      "Beech Trail",
                      "Davidson Mesa",
                      "Wonderland",
                      "Heil Valley",
                      "Kelsall",
                      "Walker Ranch"),
            plasticity = T
          ),
        labels = c(
                   "(d)",
                   "(e)",
                   " (f)"),
        hjust = -3.2,
        vjust = 2,
        nrow = 1,
        axis = "lb",
        align = "vh"
      )
    
    fig <- plot_grid(fig1, fig2, nrow =2, rel_heights = c(0.47, 0.53))
    
    leg <-
      g_legend(makeLDA(
        restrictions = bogr.data[(bogr.data$region == 'Boulder'), ],
        regionlab = 'Local: trait means'
      ))
    
    final <- 
      grid.arrange(
        leg, fig, ncol = 2, widths = c(0.13,0.87)
      )
    
    ggsave(final,
           file = "LDA/LDA_local.jpg",
           height = 7,
           width = 14)
  }
  
