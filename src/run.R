###########################################################################################

# Execution script for project pipeline.

###########################################################################################
# Set working directory for the repository (should be the git repo):
wd <- #"/Users/hoffman ava/blue-grama-diversity/"
 "/Users/avahoffman/Dropbox/Research/Bouteloua_diversity/blue-grama-diversity/"

setwd(wd)

# General functions and configuration
source("src/config.R")
source("utils/data_utils.R")

# Specific functions
source("utils/mcmc_output.R")
source("src/Trait_models.R")
source("src/Plasticity_models.R")

###########################################################################################

# Generate posterior samples for phenotypes
run_mcmc_phenotypes()

# Generate posterior samples for phenotypic plasticity
run_mcmc_plasticity()
