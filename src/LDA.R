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
  function(df,
           scale_factor,
           drop_threshold = 8,
           n_pca_impute = 2,
           median_impute = F,
           radlength = 1.5,
           lda_1_num = 2,
           v_just = 0.5) {
    # LDA on trait means"
    
    # Subset data
    #replace flower NA with zero
    df$flwr_mass_lifetime <-
      df$flwr_mass_lifetime %>% replace_na(0)
    df$flwr_count_1.2  <-
      df$flwr_count_1.2 %>% replace_na(0)
    
    # REMOVE ANY ROWS WITH TONS OF NA
    df <- df[rowSums(is.na(df)) <= drop_threshold, ]
    
    if (scale_factor == "regional") {
      restrictions <- df %>% filter(region != "Boulder")
      group_var <- "region"
      lda_form <- as.formula(paste("region ~ ."))
    } else if (scale_factor == "local") {
      restrictions <- df %>% filter(region == "Boulder")
      group_var <- "pop"
      lda_form <- as.formula(paste("pop ~ ."))
    }
    
    feats <-
      restrictions %>% dplyr::select(
        group_var,
        "biomass_belowground",
        "biomass_rhizome",
        "biomass_aboveground",
        "flwr_mass_lifetime",
        "flwr_count_1.2",
        "flwr_avg_ind_len",
        "flwr_avg_ind_mass",
        "max_height",
        "avg_predawn_mpa_expt",
        "avg_midday_mpa_expt",
        "root_shoot",
        "biomass_total"
      )
    
    if (median_impute) {
      # Impute medians by group on all missing data
      for (i in 2:length(feats)) {
        temp_median <-
          feats %>%
          group_by(get(group_var)) %>%
          summarize(temp_med = median(get(colnames(feats[i])), na.rm = T))
        colnames(temp_median) <- c(group_var, "temp_median")
        
        feats <-
          feats %>%
          full_join(temp_median, by = group_var) %>%
          mutate(temp_var = ifelse(is.na(!!as.name(
            colnames(feats[i])
          )), temp_median,!!as.name(colnames(feats[i]))))
        
        feats[[colnames(feats[i])]] <- feats$temp_var
        
        feats <- feats %>% select(-c(temp_median, temp_var))
        
      }
      
      feats <- feats %>% dplyr::select(-c(group_var))
    } else {
      # Iterativa PCA to impute for missing values
      feats <- feats %>% dplyr::select(-c(group_var))
      
      imputed <-
        # Run estim_ncpPCA(feats, ncp.min=1, ncp.max = 5) to determine number ncp
        imputePCA(feats, ncp = n_pca_impute, scale = T) 
      
      feats <- imputed$completeObs
    }
    
    # Scale in prep for LDA
    newfeats_scaled <- scale(feats)
    
    ldadat <-
      cbind(restrictions %>% dplyr::select(group_var),
            as.data.frame(newfeats_scaled))
    lda_results <- lda(formula = lda_form, data = ldadat)
    prop.lda = lda_results$svd ^ 2 / sum(lda_results$svd ^ 2)
    prop.lda
    plda <- predict(object = lda_results, newdata = ldadat)
    
    # want to draw loadings
    load_dat <-
      data.frame(varnames = rownames(coef(lda_results)), coef(lda_results))
    load_dat$length <- with(load_dat, sqrt(LD1 ^ 2 + LD2 ^ 2))
    load_dat$angle <- atan2(load_dat$LD1, load_dat$LD2)
    load_dat$x_start <- load_dat$y_start <- 0
    load_dat$x_end <-
      cos(load_dat$angle) * radlength # This sets the length of your lines.
    load_dat$y_end <-
      sin(load_dat$angle) * radlength # This sets the length of your lines.
    
    #replace some names
    loads <- as.data.frame(cbind(
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
        'total\nbiomass',
        'root:shoot'
      ),
      c(
        "biomass_belowground",
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
    ))
    colnames(loads)[1] <- "loads"
    colnames(loads)[2] <- "varnames"
    
    load_dat <- load_dat %>% inner_join(loads, by = "varnames")
    
    print(load_dat)
    
    # save only top loadings in LD1 and LD2
    load_dat <-
      load_dat[(
        abs(load_dat$LD1) %in% tail(sort(abs(load_dat$LD1)), lda_1_num) |
          abs(load_dat$LD2) %in% tail(sort(abs(load_dat$LD2)), 1)
      ),] %>% 
      mutate(h_just = replace(x_end, x_end < 0, 1)) %>% 
      mutate(h_just = replace(h_just, x_end >= 0, 0))
    
    plotdat <-
      data.frame(pop = restrictions %>% 
                   dplyr::select(pop), plda$x)
    col_temp <- col_pal()[[4]]
    colnames(plotdat)[1] <- "pop"
    colnames(col_temp)[2] <- "full"
    colnames(col_temp)[1] <- "pop"
    plotdat <-  merge(plotdat, col_temp)
    
    plot_1 <-
      ggplot(plotdat, aes(LD1, LD2)) +
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
        radius = radlength,
        size = 0.5,
        show.legend = FALSE
      ) +
      geom_label(
        aes(y = y_end, x = x_end, label = loads, hjust = h_just),
        #can change alpha=length within aes
        load_dat,
        alpha = 0.6,
        size = 3,
        vjust = v_just,
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
  if (plasticity) {
    gg <-
      gg +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
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
  function() {
    res <- c(2, 4, 5, 11, 12) # Indicies of regional sites
    xlabs <-
      c("Sevilleta", "Cibola", "Comanche", "SGS", "Buffalo Gap")
    
    fig1 <-
      plot_grid(
        makeLDA(get_bogr_data(script = "LDA"),
                scale_factor = "regional",
                drop_threshold = 7,
                lda_1_num = 2,
                v_just = 0.5) +
          theme(legend.position = "none") +
          theme(plot.margin = unit(c(7, 7, 7, 10), "pt")),
        # Slight misalignment otherwise
        do_rank(
          infile = "posterior_output/\ biomass_aboveground\ .csv",
          trait.name = "Aboveground biomass (g)" ,
          restrictions = res
        ),
        do_rank(
          infile = "posterior_output/\ biomass_belowground\ .csv",
          trait.name = "Belowground biomass (g)" ,
          restrictions = res
        ),
        do_rank(
          infile = "posterior_output/\ Total\ Biomass\ .csv",
          trait.name = "Total biomass (g)" ,
          restrictions = res
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
    
    fig2 <-
      plot_grid(
        makeLDA(
          get_bogr_data(script = "LDA_plasticity"),
          scale_factor = "regional",
          drop_threshold = 7,
          radlength = 0.7,
          lda_1_num = 3,
          n_pca_impute = 2,
          v_just = c(1,0,0.5)
        ) +
          theme(legend.position = "none"),
        do_rank(
          infile = "posterior_output_plasticity/\ biomass_aboveground\ .csv",
          trait.name = "Aboveground biomass plasticity (g)" ,
          restrictions = res,
          xlabs = xlabs,
          plasticity = T
        ),
        do_rank(
          infile = "posterior_output_plasticity/\ biomass_rhizome\ .csv",
          trait.name = "Rhizome biomass plasticity (g)" ,
          restrictions = res,
          xlabs = xlabs,
          plasticity = T
        ),
        do_rank(
          infile = "posterior_output_plasticity/\ biomass_total\ .csv",
          trait.name = "Total biomass plasticity (g)" ,
          restrictions = res,
          xlabs = xlabs,
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
    
    
    fig <-
      plot_grid(fig1,
                fig2,
                nrow = 2,
                rel_heights = c(0.47, 0.53))
    
    leg <-
      g_legend(makeLDA(get_bogr_data(script = "LDA"),
                       scale_factor = "regional"))
    
    final <-
      grid.arrange(leg, fig, ncol = 2, widths = c(0.1, 0.9))
    
    ggsave(final,
           file = "LDA/LDA_regional.jpg",
           height = 7,
           width = 16.5)
  }


make_local_lda_trait_plots <-
  function() {
    res <- -c(2, 4, 5, 11, 12)
    xlabs <- c(
      "Andrus",
      "Rock Creek",
      "Steele",
      "Rabbit Mountain",
      "Beech Trail",
      "Davidson Mesa",
      "Wonderland",
      "Heil Valley",
      "Kelsall",
      "Walker Ranch"
    )
    
    bogr.data <- get_bogr_data(script = "LDA")
    
    fig1 <-
      plot_grid(
        makeLDA(get_bogr_data(script = "LDA"),
                scale_factor = "local",
                lda_1_num = 2) +
          theme(legend.position = "none") +
          theme(plot.margin = unit(c(7, 7, 7, 17), "pt")),
        do_rank(
          infile = "posterior_output/\ biomass_aboveground\ .csv",
          trait.name = "Aboveground biomass (g)" ,
          restrictions = res
        ),
        do_rank(
          infile = "posterior_output/\ Total\ Biomass\ .csv",
          trait.name = "Total biomass (g)" ,
          restrictions = res
        ),
        labels = c("(a)",
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
          makeLDA(
            get_bogr_data(script = "LDA_plasticity"),
            scale_factor = "local",
            drop_threshold = 8,
            n_pca_impute = 3,
            lda_1_num = 2
          ) +
          theme(legend.position = "none"),
        do_rank(
          infile = "posterior_output_plasticity/\ biomass_aboveground\ .csv",
          trait.name = "Aboveground biomass plasticity (g)",
          restrictions = res,
          xlabs = xlabs,
          plasticity = T
        ),
        do_rank(
          infile = "posterior_output_plasticity/\ biomass_total\ .csv",
          trait.name = "Total biomass plasticity (g)",
          restrictions = res,
          xlabs = xlabs,
          plasticity = T
        ),
        labels = c("(d)",
                   "(e)",
                   " (f)"),
        hjust = -3.2,
        vjust = 2,
        nrow = 1,
        axis = "lb",
        align = "vh"
      )
    
    fig <-
      plot_grid(fig1,
                fig2,
                nrow = 2,
                rel_heights = c(0.47, 0.53))
    
    leg <-
      g_legend(makeLDA(get_bogr_data(script = "LDA"),
                       scale_factor = "local"))
    
    final <-
      grid.arrange(leg, fig, ncol = 2, widths = c(0.13, 0.87))
    
    ggsave(final,
           file = "LDA/LDA_local.jpg",
           height = 7,
           width = 14)
  }
