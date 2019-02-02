###########################################################################################
##
## R source code to accompany Hoffman et al. (2019), last updated 2 Feb 2019.
## Please contact Ava Hoffman (avamariehoffman@gmail.com) with questions.
##
## If you found this code useful, please use the citation below:
## 
## 
## 
##
###########################################################################################

## set working directory
wd <- "/Users/avahoffman/Dropbox/Research/Bouteloua_diversity/blue-grama-diversity"
setwd(wd)

library(ppcor)

# Partial correlation is the correlation of two variables while controlling for a third variable. 
# When the determinant of variance-covariance matrix is numerically zero, Moore-Penrose generalized 
# matrix inverse is used. In this case, no p-value and statistic will be provided if the number of 
# variables are greater than or equal to the sample size.

###########################################################################################
# trait means
# have to get rid of CP and KNZ since they don't have trait data
corrdat <- read.csv(file="partial_climate_correlation/correlation_vars.csv")
corrdat <- corrdat[!(corrdat$pop == "Konza" | corrdat$pop == "Cedar Point"),]

# resp <- "annual_AI_CGIAR"
# resp_ <- corrdat$annual_AI_CGIAR
# resp <- "precip_seasonality"
# resp_ <- corrdat$precip_seasonality

partial_cor_bogr <- function(resp,resp_,p.value=F){
t1 <- pcor(corrdat[,c(resp,"biomass_aboveground")])
t2 <- pcor.test( resp_ , corrdat$biomass_belowground, z = corrdat$biomass_aboveground )
t3 <- pcor.test( resp_ , corrdat$biomass_rhizome, z = corrdat[,c("biomass_aboveground","biomass_belowground")])
t4 <- pcor.test( resp_ , corrdat$biomass_total, z = corrdat[,c("biomass_aboveground","biomass_belowground","biomass_rhizome")])
t5 <- pcor.test( resp_ , corrdat$root_shoot, z = corrdat[,c("biomass_aboveground","biomass_belowground","biomass_rhizome","biomass_total")])
t6 <- pcor.test( resp_ , corrdat$max_height, z = corrdat[,c("biomass_aboveground","biomass_belowground","biomass_rhizome","biomass_total","root_shoot")])
t7 <- pcor.test( resp_ , corrdat$avg_predawn_mpa_expt, z = corrdat[,c("biomass_aboveground","biomass_belowground","biomass_rhizome","biomass_total","root_shoot","max_height")])
t8 <- pcor.test( resp_ , corrdat$avg_midday_mpa_expt, z = corrdat[,c("biomass_aboveground","biomass_belowground","biomass_rhizome","biomass_total","root_shoot","max_height","avg_predawn_mpa_expt")])
t9 <- pcor.test( resp_ , corrdat$flwr_mass_lifetime, z = corrdat[,c("biomass_aboveground","biomass_belowground","biomass_rhizome","biomass_total","root_shoot","max_height","avg_predawn_mpa_expt","avg_midday_mpa_expt")])
t10 <- pcor.test( resp_ , corrdat$flwr_count, z = corrdat[,c("biomass_aboveground","biomass_belowground","biomass_rhizome","biomass_total","root_shoot","max_height","avg_predawn_mpa_expt","avg_midday_mpa_expt","flwr_mass_lifetime")])
t11 <- pcor.test( resp_ , corrdat$avg_flwr_mass, z = corrdat[,c("biomass_aboveground","biomass_belowground","biomass_rhizome","biomass_total","root_shoot","max_height","avg_predawn_mpa_expt","avg_midday_mpa_expt","flwr_mass_lifetime","flwr_count")])
t12 <- pcor.test( resp_ , corrdat$avg_flwr_len, z = corrdat[,c("biomass_aboveground","biomass_belowground","biomass_rhizome","biomass_total","root_shoot","max_height","avg_predawn_mpa_expt","avg_midday_mpa_expt","flwr_mass_lifetime","flwr_count","avg_flwr_mass")])
t13 <- pcor.test( resp_ , corrdat$hydroscape_area, z = corrdat[,c("biomass_aboveground","biomass_belowground","biomass_rhizome","biomass_total","root_shoot","max_height","avg_predawn_mpa_expt","avg_midday_mpa_expt","flwr_mass_lifetime","flwr_count","avg_flwr_mass","avg_flwr_len")])
if (p.value == T){
  return(
    p.adjust(
    c( t1$p.value[1,2],t2[1,2],t3[1,2],t4[1,2],t5[1,2],t6[1,2],t7[1,2],t8[1,2],t9[1,2],t10[1,2],t11[1,2],t12[1,2],t13[1,2]),
    method = "fdr") )
} else{
  return(c( t1$estimate[1,2],t2[1,1],t3[1,1],t4[1,1],t5[1,1],t6[1,1],t7[1,1],t8[1,1],t9[1,1],t10[1,1],t11[1,1],t12[1,1],t13[1,1]))
} }

r1 <- partial_cor_bogr("annual_mean_temp",corrdat$annual_mean_temp)
r2 <- partial_cor_bogr("mean_diurnal_temp_range",corrdat$mean_diurnal_temp_range)
r3 <- partial_cor_bogr("temperature_seasonality",corrdat$temperature_seasonality)
r4 <- partial_cor_bogr("max_temp_warmest_month",corrdat$max_temp_warmest_month)
r5 <- partial_cor_bogr("min_temp_coldest_month",corrdat$min_temp_coldest_month)
r6 <- partial_cor_bogr("mean_temp_driest_quarter",corrdat$mean_temp_driest_quarter)
r7 <- partial_cor_bogr("annual_precip",corrdat$annual_precip)
r8 <- partial_cor_bogr("precip_seasonality",corrdat$precip_seasonality)
r9 <- partial_cor_bogr("annual_AI_CGIAR",corrdat$annual_AI_CGIAR)
r10 <- partial_cor_bogr("PDHI_exep_drt_months_year",corrdat$PDHI_exep_drt_months_year)
r11 <- partial_cor_bogr("median_year_PDHI",corrdat$median_year_PDHI)

ests <- as.data.frame(cbind(r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11))
rownames(ests) <- colnames(corrdat)[14:26]
colnames(ests) <- colnames(corrdat)[3:13]
ests <- round(ests,3)
write.csv(ests,file="partial_climate_correlation/Trait_ests.csv")

r1 <- partial_cor_bogr("annual_mean_temp",corrdat$annual_mean_temp, p.value=T)
r2 <- partial_cor_bogr("mean_diurnal_temp_range",corrdat$mean_diurnal_temp_range, p.value=T)
r3 <- partial_cor_bogr("temperature_seasonality",corrdat$temperature_seasonality, p.value=T)
r4 <- partial_cor_bogr("max_temp_warmest_month",corrdat$max_temp_warmest_month, p.value=T)
r5 <- partial_cor_bogr("min_temp_coldest_month",corrdat$min_temp_coldest_month, p.value=T)
r6 <- partial_cor_bogr("mean_temp_driest_quarter",corrdat$mean_temp_driest_quarter, p.value=T)
r7 <- partial_cor_bogr("annual_precip",corrdat$annual_precip, p.value=T)
r8 <- partial_cor_bogr("precip_seasonality",corrdat$precip_seasonality, p.value=T)
r9 <- partial_cor_bogr("annual_AI_CGIAR",corrdat$annual_AI_CGIAR, p.value=T)
r10 <- partial_cor_bogr("PDHI_exep_drt_months_year",corrdat$PDHI_exep_drt_months_year, p.value=T)
r11 <- partial_cor_bogr("median_year_PDHI",corrdat$median_year_PDHI, p.value=T)

pvalues_out <- as.data.frame(cbind(r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11))
rownames(pvalues_out) <- colnames(corrdat)[14:26]
colnames(pvalues_out) <- colnames(corrdat)[3:13]
pvalues_out <- round(pvalues_out,3)
write.csv(pvalues_out,file="partial_climate_correlation/Trait_pvals.csv")

###########################################################################################
# genomics

corrdat <- read.csv(file="partial_climate_correlation/correlation_vars.csv")

partial_cor_bogr <- function(resp,resp_,p.value=F){
  t1 <- pcor(corrdat[,c(resp,"eMLG")])
  t2 <- pcor.test( resp_ , corrdat$Evar, z = corrdat$eMLG )
  t3 <- pcor.test( resp_ , corrdat$Hexp, z = corrdat[,c("eMLG","Evar")])
  if (p.value == T){
    return(
      p.adjust(
        c( t1$p.value[1,2],t2[1,2],t3[1,2]),
        method = "fdr") )
  } else{
    return(c( t1$estimate[1,2],t2[1,1],t3[1,1]))
  } }

r1 <- partial_cor_bogr("annual_mean_temp",corrdat$annual_mean_temp)
r2 <- partial_cor_bogr("mean_diurnal_temp_range",corrdat$mean_diurnal_temp_range)
r3 <- partial_cor_bogr("temperature_seasonality",corrdat$temperature_seasonality)
r4 <- partial_cor_bogr("max_temp_warmest_month",corrdat$max_temp_warmest_month)
r5 <- partial_cor_bogr("min_temp_coldest_month",corrdat$min_temp_coldest_month)
r6 <- partial_cor_bogr("mean_temp_driest_quarter",corrdat$mean_temp_driest_quarter)
r7 <- partial_cor_bogr("annual_precip",corrdat$annual_precip)
r8 <- partial_cor_bogr("precip_seasonality",corrdat$precip_seasonality)
r9 <- partial_cor_bogr("annual_AI_CGIAR",corrdat$annual_AI_CGIAR)
r10 <- partial_cor_bogr("PDHI_exep_drt_months_year",corrdat$PDHI_exep_drt_months_year)
r11 <- partial_cor_bogr("median_year_PDHI",corrdat$median_year_PDHI)

ests <- as.data.frame(cbind(r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11))
rownames(ests) <- colnames(corrdat)[27:29]
colnames(ests) <- colnames(corrdat)[3:13]
ests <- round(ests,3)
write.csv(ests,file="partial_climate_correlation/Genomics_ests.csv")

r1 <- partial_cor_bogr("annual_mean_temp",corrdat$annual_mean_temp, p.value=T)
r2 <- partial_cor_bogr("mean_diurnal_temp_range",corrdat$mean_diurnal_temp_range, p.value=T)
r3 <- partial_cor_bogr("temperature_seasonality",corrdat$temperature_seasonality, p.value=T)
r4 <- partial_cor_bogr("max_temp_warmest_month",corrdat$max_temp_warmest_month, p.value=T)
r5 <- partial_cor_bogr("min_temp_coldest_month",corrdat$min_temp_coldest_month, p.value=T)
r6 <- partial_cor_bogr("mean_temp_driest_quarter",corrdat$mean_temp_driest_quarter, p.value=T)
r7 <- partial_cor_bogr("annual_precip",corrdat$annual_precip, p.value=T)
r8 <- partial_cor_bogr("precip_seasonality",corrdat$precip_seasonality, p.value=T)
r9 <- partial_cor_bogr("annual_AI_CGIAR",corrdat$annual_AI_CGIAR, p.value=T)
r10 <- partial_cor_bogr("PDHI_exep_drt_months_year",corrdat$PDHI_exep_drt_months_year, p.value=T)
r11 <- partial_cor_bogr("median_year_PDHI",corrdat$median_year_PDHI, p.value=T)

pvalues_out <- as.data.frame(cbind(r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11))
rownames(pvalues_out) <- colnames(corrdat)[27:29]
colnames(pvalues_out) <- colnames(corrdat)[3:13]
pvalues_out <- round(pvalues_out,3)
write.csv(pvalues_out,file="partial_climate_correlation/Genomics_pvals.csv")

###########################################################################################
# trait means
# have to get rid of CP and KNZ since they don't have trait data
corrdat <- read.csv(file="partial_climate_correlation/correlation_vars.csv")
corrdat <- corrdat[!(corrdat$pop == "Konza" | corrdat$pop == "Cedar Point"),]

resp <- "annual_AI_CGIAR"
resp_ <- corrdat$annual_AI_CGIAR
# resp <- "precip_seasonality"
# resp_ <- corrdat$precip_seasonality

partial_cor_bogr <- function(resp,resp_,p.value=F){
  t1 <- pcor(corrdat[,c(resp,"p_biomass_aboveground")])
  t2 <- pcor.test( resp_ , corrdat$p_biomass_belowground, z = corrdat$p_biomass_aboveground )
  t3 <- pcor.test( resp_ , corrdat$p_biomass_rhizome, z = corrdat[,c("p_biomass_aboveground","p_biomass_belowground")])
  t4 <- pcor.test( resp_ , corrdat$p_biomass_total, z = corrdat[,c("p_biomass_aboveground","p_biomass_belowground","p_biomass_rhizome")])
  t5 <- pcor.test( resp_ , corrdat$p_root_shoot, z = corrdat[,c("p_biomass_aboveground","p_biomass_belowground","p_biomass_rhizome","p_biomass_total")])
  t6 <- pcor.test( resp_ , corrdat$p_max_height, z = corrdat[,c("p_biomass_aboveground","p_biomass_belowground","p_biomass_rhizome","p_biomass_total","p_root_shoot")])
  t7 <- pcor.test( resp_ , corrdat$p_avg_predawn_mpa_expt, z = corrdat[,c("p_biomass_aboveground","p_biomass_belowground","p_biomass_rhizome","p_biomass_total","p_root_shoot","p_max_height")])
  t8 <- pcor.test( resp_ , corrdat$p_avg_midday_mpa_expt, z = corrdat[,c("p_biomass_aboveground","p_biomass_belowground","p_biomass_rhizome","p_biomass_total","p_root_shoot","p_max_height","p_avg_predawn_mpa_expt")])
  t9 <- pcor.test( resp_ , corrdat$p_flwr_mass_lifetime, z = corrdat[,c("p_biomass_aboveground","p_biomass_belowground","p_biomass_rhizome","p_biomass_total","p_root_shoot","p_max_height","p_avg_predawn_mpa_expt","p_avg_midday_mpa_expt")])
  t10 <- pcor.test( resp_ , corrdat$p_flwr_count, z = corrdat[,c("p_biomass_aboveground","p_biomass_belowground","p_biomass_rhizome","p_biomass_total","p_root_shoot","p_max_height","p_avg_predawn_mpa_expt","p_avg_midday_mpa_expt","p_flwr_mass_lifetime")])
  t11 <- pcor.test( resp_ , corrdat$p_avg_flwr_mass, z = corrdat[,c("p_biomass_aboveground","p_biomass_belowground","p_biomass_rhizome","p_biomass_total","p_root_shoot","p_max_height","p_avg_predawn_mpa_expt","p_avg_midday_mpa_expt","p_flwr_mass_lifetime","p_flwr_count")])
  t12 <- pcor.test( resp_ , corrdat$p_avg_flwr_len, z = corrdat[,c("p_biomass_aboveground","p_biomass_belowground","p_biomass_rhizome","p_biomass_total","p_root_shoot","p_max_height","p_avg_predawn_mpa_expt","p_avg_midday_mpa_expt","p_flwr_mass_lifetime","p_flwr_count","p_avg_flwr_mass")])
  if (p.value == T){
    return(
      p.adjust(
        c( t1$p.value[1,2],t2[1,2],t3[1,2],t4[1,2],t5[1,2],t6[1,2],t7[1,2],t8[1,2],t9[1,2],t10[1,2],t11[1,2],t12[1,2]),
        method = "fdr") )
  } else{
    return(c( t1$estimate[1,2],t2[1,1],t3[1,1],t4[1,1],t5[1,1],t6[1,1],t7[1,1],t8[1,1],t9[1,1],t10[1,1],t11[1,1],t12[1,1]))
  } }

r1 <- partial_cor_bogr("annual_mean_temp",corrdat$annual_mean_temp)
r2 <- partial_cor_bogr("mean_diurnal_temp_range",corrdat$mean_diurnal_temp_range)
r3 <- partial_cor_bogr("temperature_seasonality",corrdat$temperature_seasonality)
r4 <- partial_cor_bogr("max_temp_warmest_month",corrdat$max_temp_warmest_month)
r5 <- partial_cor_bogr("min_temp_coldest_month",corrdat$min_temp_coldest_month)
r6 <- partial_cor_bogr("mean_temp_driest_quarter",corrdat$mean_temp_driest_quarter)
r7 <- partial_cor_bogr("annual_precip",corrdat$annual_precip)
r8 <- partial_cor_bogr("precip_seasonality",corrdat$precip_seasonality)
r9 <- partial_cor_bogr("annual_AI_CGIAR",corrdat$annual_AI_CGIAR)
r10 <- partial_cor_bogr("PDHI_exep_drt_months_year",corrdat$PDHI_exep_drt_months_year)
r11 <- partial_cor_bogr("median_year_PDHI",corrdat$median_year_PDHI)

ests <- as.data.frame(cbind(r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11))
rownames(ests) <- colnames(corrdat)[30:41]
colnames(ests) <- colnames(corrdat)[3:13]
ests <- round(ests,3)
write.csv(ests,file="partial_climate_correlation/Plasticity_ests.csv")

r1 <- partial_cor_bogr("annual_mean_temp",corrdat$annual_mean_temp, p.value=T)
r2 <- partial_cor_bogr("mean_diurnal_temp_range",corrdat$mean_diurnal_temp_range, p.value=T)
r3 <- partial_cor_bogr("temperature_seasonality",corrdat$temperature_seasonality, p.value=T)
r4 <- partial_cor_bogr("max_temp_warmest_month",corrdat$max_temp_warmest_month, p.value=T)
r5 <- partial_cor_bogr("min_temp_coldest_month",corrdat$min_temp_coldest_month, p.value=T)
r6 <- partial_cor_bogr("mean_temp_driest_quarter",corrdat$mean_temp_driest_quarter, p.value=T)
r7 <- partial_cor_bogr("annual_precip",corrdat$annual_precip, p.value=T)
r8 <- partial_cor_bogr("precip_seasonality",corrdat$precip_seasonality, p.value=T)
r9 <- partial_cor_bogr("annual_AI_CGIAR",corrdat$annual_AI_CGIAR, p.value=T)
r10 <- partial_cor_bogr("PDHI_exep_drt_months_year",corrdat$PDHI_exep_drt_months_year, p.value=T)
r11 <- partial_cor_bogr("median_year_PDHI",corrdat$median_year_PDHI, p.value=T)

pvalues_out <- as.data.frame(cbind(r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11))
rownames(pvalues_out) <- colnames(corrdat)[30:41]
colnames(pvalues_out) <- colnames(corrdat)[3:13]
pvalues_out <- round(pvalues_out,3)
write.csv(pvalues_out,file="partial_climate_correlation/Plasticity_pvals.csv")
