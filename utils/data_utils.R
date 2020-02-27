##########################################################################################
##
## Functions used for generating gathering data
##
##########################################################################################
library(dplyr)


create_plasticity_data <-
  function() {
    bogr_data <- read.csv("data/BOGR_DATA_master.csv")
    bogr_data[bogr_data == "no pot"] <-
      NA # any unknown or unid'd loci have a 'NA'
    bogr_data[bogr_data == "met"] <-
      NA # any unknown or unid'd loci have a 'NA'
    bogr_data[bogr_data == "tr"] <-
      NA # any unknown or unid'd loci have a 'NA'
    
    selected_phenos <- c(
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
    
    for (i in 1:length(selected_phenos)) {
      bogr_data[[selected_phenos[i]]] <-
        as.numeric(as.character(bogr_data[[selected_phenos[i]]]))
    }
    
    drt_trts <-
      bogr_data %>% arrange(pop, trt, geno) %>% filter(trt == "D")
    nondrt_trts <-
      bogr_data %>% arrange(pop, trt, geno) %>% filter(trt == "ND")
    drt_trts_sel <- drt_trts %>% select("vwc_adj",
                                        selected_phenos)
    nondrt_trts_sel <- nondrt_trts %>% select("vwc_adj",
                                              selected_phenos)
    plasticity_matrix <- nondrt_trts_sel - drt_trts_sel
    
    plasticity_descr <-
      drt_trts %>% select(region, pop, geno) %>% mutate(trt = "ND - D")
    
    plasticity_data <- cbind(plasticity_descr, plasticity_matrix)
    
    write.csv(plasticity_data, "data/BOGR_DATA_plasticity_master.csv")
  }


get_bogr_data <-
  function(script = "phenotype") {
    ## open data
    if (script == "phenotype") {
      bogr_data <- read.csv("data/BOGR_DATA_master.csv")
    } else if (script == "plasticity") {
      bogr_data <- read.csv("data/BOGR_DATA_plasticity_master.csv")
    } else if (script == "LDA") {
      bogr_data <- read.csv("data/BOGR_DATA_unsupervised_PCA_LDA.csv")
    } else if (script == "LDA_plasticity") {
      bogr_data <- read.csv("data/BOGR_DATA_plasticity_PCA_LDA.csv")
    }
    clim_data <- read.csv("data/SITE_DATA.csv")
    
    ## stan won't be able to handle these NAs. replace them w/ NA so that they can be removed
    bogr_data[bogr_data == "no pot"] <-
      NA # any unknown or unid'd loci have a 'NA'
    bogr_data[bogr_data == "met"] <-
      NA # any unknown or unid'd loci have a 'NA'
    bogr_data[bogr_data == "tr"] <-
      NA # any unknown or unid'd loci have a 'NA'
    
    ## the following variables need to be numeric
    bogr_data$biomass_aboveground <-
      as.numeric(as.character(bogr_data$biomass_aboveground))
    bogr_data$biomass_belowground <-
      as.numeric(as.character(bogr_data$biomass_belowground))
    bogr_data$biomass_rhizome <-
      as.numeric(as.character(bogr_data$biomass_rhizome))
    
    if (script == "phenotype") {
      bogr_data$flwr_mass_4 <-
        as.numeric(as.character(bogr_data$flwr_mass_4))
      bogr_data$flwr_mass_final <-
        as.numeric(as.character(bogr_data$flwr_mass_final))
      
    } else if (script == "phenotype" | script == "plasticity") {
      ## merge with climate data
      bogr_clim_data <- merge(bogr_data, clim_data)
      return(bogr_clim_data)
      
    } else if (script == "LDA") {
      # derived vars
      bogr_data$root_shoot <-
        (bogr_data$biomass_belowground + bogr_data$biomass_rhizome) / bogr_data$biomass_aboveground
      bogr_data$biomass_total <-
        bogr_data$biomass_belowground + bogr_data$biomass_rhizome + bogr_data$biomass_aboveground + bogr_data$flwr_mass_lifetime
      
      return(bogr_data)
    } else if (script == "LDA_plasticity") {
      bogr_data$root_shoot <-
        as.numeric(as.character(bogr_data$root_shoot))
      bogr_data$biomass_total <-
        as.numeric(as.character(bogr_data$biomass_total))
      
      return(bogr_data)
    }
  }


col_pal <-
  function() {
    col.pal <- read.csv("utils/color_key.csv", header = T)
    col.pal.v <-
      as.vector(col.pal[, 3])
    names(col.pal.v) <- col.pal[, 2]
    col.pal.names <-
      as.vector(col.pal[, 2])
    names(col.pal.names) <- col.pal[, 6]
    col.pal.colors <-
      as.vector(col.pal[, 3])
    names(col.pal.colors) <- col.pal[, 6]
    
    return(list(col.pal.v,
                col.pal.names,
                col.pal.colors,
                col.pal))
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


get_genind_data <-
  function(impute_mean = T) {
    ## several options depending on what samples desired..
    load("src/genomics_prep/genind_all.R")
    
    ## remove all but one of each clone
    indNames(genind.data1)
    genind.1clone.only <-
      genind.data1[c(5, 12, 18, 21, 27, 33, 41, 44, 48, 50, 55, 58, 65:335)]
    indNames(genind.1clone.only) <-
      gsub("Bgedge", "SGS", indNames(genind.1clone.only))
    indNames(genind.1clone.only) <-
      gsub("BgHq", "SGS", indNames(genind.1clone.only))
    indNames(genind.1clone.only)
    
    ## impute mean for missing data
    if (impute_mean){
      genind.1clone.only$tab <-
        tab(genind.1clone.only, NA.method = "mean")
    }

    return(genind.1clone.only)
  }
