## set working directory
source("config.R")
setwd(wd)
library(ppcor)
## load some functions
source("utils/partial_corr.R")

# Partial correlation is the correlation of two variables while controlling for a third variable.
# When the determinant of variance-covariance matrix is numerically zero, Moore-Penrose generalized
# matrix inverse is used. In this case, no p-value and statistic will be provided if the number of
# variables are greater than or equal to the sample size.

###########################################################################################
# have to get rid of CP and KNZ since they don't have trait data
corrdat <-
  read.csv(file = "partial_climate_correlation/correlation_vars.csv")
corrdat <-
  corrdat[!(corrdat$pop == "Konza" | corrdat$pop == "Cedar Point"), ]

###########################################################################################
## Phenotypes

ests <- cbind(
  partial_cor_bogr("annual_mean_temp", corrdat$annual_mean_temp),
  partial_cor_bogr("mean_diurnal_temp_range", corrdat$mean_diurnal_temp_range),
  partial_cor_bogr("temperature_seasonality", corrdat$temperature_seasonality),
  partial_cor_bogr("max_temp_warmest_month", corrdat$max_temp_warmest_month),
  partial_cor_bogr("min_temp_coldest_month", corrdat$min_temp_coldest_month),
  partial_cor_bogr(
    "mean_temp_driest_quarter",
    corrdat$mean_temp_driest_quarter
  ),
  partial_cor_bogr("annual_precip", corrdat$annual_precip),
  partial_cor_bogr("precip_seasonality", corrdat$precip_seasonality),
  partial_cor_bogr("annual_AI_CGIAR", corrdat$annual_AI_CGIAR),
  partial_cor_bogr(
    "PDHI_exep_drt_months_year",
    corrdat$PDHI_exep_drt_months_year
  ),
  partial_cor_bogr("median_year_PDHI", corrdat$median_year_PDHI)
)

## select phenotype measure names
rownames(ests) <- colnames(corrdat)[14:26]
## climate variables tested names
colnames(ests) <- colnames(corrdat)[3:13]
ests <- round(ests, 3)
write.csv(ests, file = "partial_climate_correlation/Trait_ests.csv")

pvalues_out <- cbind(
  partial_cor_bogr("annual_mean_temp", corrdat$annual_mean_temp, p.value =
                     T),
  partial_cor_bogr(
    "mean_diurnal_temp_range",
    corrdat$mean_diurnal_temp_range,
    p.value = T
  ),
  partial_cor_bogr(
    "temperature_seasonality",
    corrdat$temperature_seasonality,
    p.value = T
  ),
  partial_cor_bogr(
    "max_temp_warmest_month",
    corrdat$max_temp_warmest_month,
    p.value = T
  ),
  partial_cor_bogr(
    "min_temp_coldest_month",
    corrdat$min_temp_coldest_month,
    p.value = T
  ),
  partial_cor_bogr(
    "mean_temp_driest_quarter",
    corrdat$mean_temp_driest_quarter,
    p.value = T
  ),
  partial_cor_bogr("annual_precip", corrdat$annual_precip, p.value = T),
  partial_cor_bogr("precip_seasonality", corrdat$precip_seasonality, p.value =
                     T),
  partial_cor_bogr("annual_AI_CGIAR", corrdat$annual_AI_CGIAR, p.value =
                     T),
  partial_cor_bogr(
    "PDHI_exep_drt_months_year",
    corrdat$PDHI_exep_drt_months_year,
    p.value = T
  ),
  partial_cor_bogr("median_year_PDHI", corrdat$median_year_PDHI, p.value =
                     T)
)

## select phenotype measure names
rownames(pvalues_out) <- colnames(corrdat)[14:26]
## climate variables tested names
colnames(pvalues_out) <- colnames(corrdat)[3:13]
pvalues_out <- round(pvalues_out, 3)
write.csv(pvalues_out, file = "partial_climate_correlation/Trait_pvals.csv")

###########################################################################################
# Plasticity

ests <- cbind(
  partial_cor_bogr_plasticity("annual_mean_temp", corrdat$annual_mean_temp),
  partial_cor_bogr_plasticity("mean_diurnal_temp_range", corrdat$mean_diurnal_temp_range),
  partial_cor_bogr_plasticity("temperature_seasonality", corrdat$temperature_seasonality),
  partial_cor_bogr_plasticity("max_temp_warmest_month", corrdat$max_temp_warmest_month),
  partial_cor_bogr_plasticity("min_temp_coldest_month", corrdat$min_temp_coldest_month),
  partial_cor_bogr_plasticity(
    "mean_temp_driest_quarter",
    corrdat$mean_temp_driest_quarter
  ),
  partial_cor_bogr_plasticity("annual_precip", corrdat$annual_precip),
  partial_cor_bogr_plasticity("precip_seasonality", corrdat$precip_seasonality),
  partial_cor_bogr_plasticity("annual_AI_CGIAR", corrdat$annual_AI_CGIAR),
  partial_cor_bogr_plasticity(
    "PDHI_exep_drt_months_year",
    corrdat$PDHI_exep_drt_months_year
  ),
  partial_cor_bogr_plasticity("median_year_PDHI", corrdat$median_year_PDHI)
)

## select plasticity measure names
rownames(ests) <- colnames(corrdat)[30:41]
## climate variables tested names
colnames(ests) <- colnames(corrdat)[3:13]
ests <- round(ests, 3)
write.csv(ests, file = "partial_climate_correlation/Plasticity_ests.csv")

pvalues_out <- cbind(
  partial_cor_bogr_plasticity("annual_mean_temp", corrdat$annual_mean_temp, p.value =
                                T),
  partial_cor_bogr_plasticity(
    "mean_diurnal_temp_range",
    corrdat$mean_diurnal_temp_range,
    p.value = T
  ),
  partial_cor_bogr_plasticity(
    "temperature_seasonality",
    corrdat$temperature_seasonality,
    p.value = T
  ),
  partial_cor_bogr_plasticity(
    "max_temp_warmest_month",
    corrdat$max_temp_warmest_month,
    p.value = T
  ),
  partial_cor_bogr_plasticity(
    "min_temp_coldest_month",
    corrdat$min_temp_coldest_month,
    p.value = T
  ),
  partial_cor_bogr_plasticity(
    "mean_temp_driest_quarter",
    corrdat$mean_temp_driest_quarter,
    p.value = T
  ),
  partial_cor_bogr_plasticity("annual_precip", corrdat$annual_precip, p.value =
                                T),
  partial_cor_bogr_plasticity("precip_seasonality", corrdat$precip_seasonality, p.value =
                                T),
  partial_cor_bogr_plasticity("annual_AI_CGIAR", corrdat$annual_AI_CGIAR, p.value =
                                T),
  partial_cor_bogr_plasticity(
    "PDHI_exep_drt_months_year",
    corrdat$PDHI_exep_drt_months_year,
    p.value = T
  ),
  partial_cor_bogr_plasticity("median_year_PDHI", corrdat$median_year_PDHI, p.value =
                                T)
)

## select plasticity measure names
rownames(pvalues_out) <- colnames(corrdat)[30:41]
## climate variables tested names
colnames(pvalues_out) <- colnames(corrdat)[3:13]
pvalues_out <- round(pvalues_out, 3)
write.csv(pvalues_out, file = "partial_climate_correlation/Plasticity_pvals.csv")
