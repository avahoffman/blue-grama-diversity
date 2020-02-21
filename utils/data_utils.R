##########################################################################################
##
## Functions used for generating gathering data
##
##########################################################################################

get_bogr_data <- 
  function(script = "phenotype"){
    ## open data
    if (script == "phenotype") {
      bogr_data <- read.csv("data/BOGR_DATA_master.csv")
    } else if (script = "plasticity") {
      bogr_data <- read.csv("data/BOGR_DATA_plasticity_master.csv")
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
    bogr_data$flwr_mass_4 <-
      as.numeric(as.character(bogr_data$flwr_mass_4))
    bogr_data$flwr_mass_final <-
      as.numeric(as.character(bogr_data$flwr_mass_final))
    
    ## merge with climate data
    bogr_clim_data <- merge(bogr_data, clim_data)
    return(bogr_clim_data)
  }
