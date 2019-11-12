# blue-grama-diversity

## Genetic and functional variation across regional and local scales is associated with climate in a foundational prairie grass

## Contents

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
├── genomics_output
│   ├── DAPC_local.csv
│   ├── DAPC_regional.csv
│   ├── DAPC_total.csv
│   ├── Loci_loadings_local.csv
│   ├── Loci_loadings_regional.csv
│   ├── Loci_loadings_total.csv
│   ├── Multilocus_genos_evenness.csv
│   ├── Pairwise_distance_results.csv
│   ├── Poppr_clone_diversity.R
│   ├── Poppr_clone_diversity.csv
│   ├── Poppr_genetic_diversity.R
│   ├── Poppr_genetic_diversity.csv
│   ├── Poppr_multilocus_genos.csv
│   ├── Population_probability_local.csv
│   ├── Population_probability_regional.csv
│   ├── Population_probability_total.csv
│   ├── Site_hierarchy.R
│   ├── Site_hierarchy.nexus
│   ├── Site_hierarchy_regional.R
│   ├── Site_hierarchy_regional.nexus
│   ├── Structure_plot_data_local.csv
│   ├── Structure_plot_data_local_wide.csv
│   ├── Structure_plot_data_regional.csv
│   ├── Structure_plot_data_regional_wide.csv
│   ├── Structure_plot_data_total.csv
│   ├── Structure_plot_data_total_wide.csv
│   ├── figures
│   ├── xval_local.R
│   ├── xval_regional.R
│   └── xval_total.R
├── genomics_variance
│   ├── genomics_variance.csv
│   ├── genomics_variance_coefficients.csv
│   └── genomics_variance_coefficients_labels.csv
├── partial_climate_correlation
│   ├── Genomics_ests.csv
│   ├── Genomics_pvals.csv
│   ├── Plasticity_ests.csv
│   ├── Plasticity_pvals.csv
│   ├── Trait_ests.csv
│   ├── Trait_pvals.csv
│   └── correlation_vars.csv
├── posterior_output
│   ├── \ Root\ to\ shoot\ biomass\ ratio\ .csv
│   ├── \ Total\ Biomass\ .csv
│   ├── \ avg_midday_mpa_drydown\ .csv
│   ├── \ avg_midday_mpa_expt\ .csv
│   ├── \ avg_mpa_difference\ .csv
│   ├── \ avg_predawn_mpa_drydown\ .csv
│   ├── \ avg_predawn_mpa_expt\ .csv
│   ├── \ biomass_aboveground\ .csv
│   ├── \ biomass_belowground\ .csv
│   ├── \ biomass_rhizome\ .csv
│   ├── \ flwr_avg_ind_len\ .csv
│   ├── \ flwr_avg_ind_mass\ .csv
│   ├── \ flwr_count_1.2\ .csv
│   ├── \ flwr_mass_lifetime\ .csv
│   ├── \ max_height\ .csv
│   ├── Trait_means.jpg
│   ├── Trait_variance.jpg
│   ├── figures
│   ├── predictive_checks
│   └── summary.xlsx
├── posterior_output_plasticity
│   ├── \ Root\ to\ shoot\ biomass\ ratio\ .csv
│   ├── \ Total\ Biomass\ .csv
│   ├── \ avg_midday_mpa_expt\ .csv
│   ├── \ avg_predawn_mpa_expt\ .csv
│   ├── \ biomass_aboveground\ .csv
│   ├── \ biomass_belowground\ .csv
│   ├── \ biomass_rhizome\ .csv
│   ├── \ flwr_avg_ind_len\ .csv
│   ├── \ flwr_avg_ind_mass\ .csv
│   ├── \ flwr_count_1.2\ .csv
│   ├── \ flwr_mass_lifetime\ .csv
│   ├── \ max_height\ .csv
│   ├── Trait_plasticity.jpg
│   ├── Trait_plasticity_variance.jpg
│   ├── figures
│   └── predictive_checks
├── resources
│   ├── tutorial-basics.pdf
│   ├── tutorial-dapc.pdf
│   └── tutorial-genomics.pdf
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