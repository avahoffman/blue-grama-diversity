# blue-grama-diversity

### Code and data from the publication *Genetic and functional variation across regional and local scales is associated with climate in a foundational prairie grass*

### Contents

```
├── app.R
```
This code produces the Shiny app dashboard for visualizing genetic diversity in blue grama grass. Several options can be set, including:
1. Number of principal components - this is a parameter for DAPC fitting. One must avoid overfitting with too many principal components. Around 60 is typically the optimal number for Regional or State level groupings. However, it is important to cross validate to determine the exact optimal number for final analysis.
2. Populations to include
3. Level of grouping across which to detect variance (i.e., Site level, Regional level, or State level)
```
├── data
│   ├── BOGR_DATA_master.csv
│   ├── BOGR_DATA_master_metadata.docx
│   ├── BOGR_DATA_plasticity_PCA_LDA.csv
│   ├── BOGR_DATA_plasticity_master.csv
│   ├── BOGR_DATA_unsupervised_PCA_LDA.csv
│   ├── Bouteloua_genome_reference.fasta
│   ├── SITE_DATA.csv
│   └── hydroscape
```
```
├── genomics_output
```
```
├── genomics_variance
```
```
├── partial_climate_correlation
```
This directory contains `correlation_vars.csv`, which is used by `partial_corr_matrices.R` to check for partial correlations of all measures against all climate variables. Estimates and corresponding p-values for each climate variable for both phenotypic measures and phenotypic plasticity measures are produced. Correlations begin with aboveground biomass versus the climate variable; subsequent measures are added to account for remaining variance.
```
├── posterior_output
```
This directory contains posterior output, predictive checks, and plots of distributions of phenotypic measures as they are produced from `src/Trait_models.R`. 
```
├── posterior_output_plasticity
```
This directory contains posterior output, predictive checks, and plots of distributions of phenotypic plasticity measures as they are produced from `src/Plasticity_models.R`. 
```
├── resources
```
This directory contains several useful references for packages and theory used in this project.
```
├── src
│   ├── Hydroscape_area.R
│   ├── Interval_plots.R
│   ├── LDA.R
│   ├── Maps_genomics.R
│   ├── Pairwise_distance.R
│   ├── Plasticity_models.R
│   ├── Poppr_genetic_diversity.R
│   ├── Site_tree_hierarchical.R
│   ├── Total_genome_diversity.R
│   ├── Trait_models.R
│   ├── config.R
│   ├── genomics_prep
│   ├── genomics_variance.R
│   ├── local_genome_diversity.R
│   ├── partial_corr_matrices.R
│   └── regional_genome_diversity.R
└── utils
    ├── color_key.csv
    ├── color_key_alt.csv
    ├── mcmc_output.R
    └── partial_corr.R
```