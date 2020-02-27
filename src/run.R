###########################################################################################

# Execution script for project pipeline.

###########################################################################################
# Set working directory for the repository (should be the git repo):
wd <- "/Users/hoffman ava/blue-grama-diversity/"
 #"/Users/avahoffman/Dropbox/Research/Bouteloua_diversity/blue-grama-diversity/"

setwd(wd)

# General functions and configuration
source("utils/data_utils.R")
source("src/config.R")
source("utils/partial_corr.R")

# Specific functions
source("utils/mcmc_output.R")
source("src/Trait_models.R")
source("src/Plasticity_models.R")
source("src/LDA.R")
source("src/local_genome_diversity.R")
source("src/regional_genome_diversity.R")
source("src/Total_genome_diversity.R")
source("src/partial_corr_matrices.R")
source("src/Interval_plots.R")

###########################################################################################

## Main text ----

# Generate posterior samples for phenotypes
run_mcmc_phenotypes()

# Generate posterior samples for phenotypic plasticity
run_mcmc_plasticity()

# Run genomics analysis (posteriors, DAPC, structure) and make plots
run_regional_genomics()
run_Local_genomics()

# Create LDAs and posterior plots
make_regional_lda_trait_plots()
make_local_lda_trait_plots()

# Run climate correlations
run_phenotype_corrs()
run_plasticity_corrs()

## Supplemental ----

# Run genomics analysis for all populations together
run_total_genomics()

# Make 95% CI plots for phenotypes and phenotypic plasticity
render_phenotype_intervals()
render_phenotype_variance_intervals()
render_plasticity_intervals()
render_plasticity_variance_intervals()