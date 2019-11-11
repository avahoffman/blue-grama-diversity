##########################################################################################
##
## Functions used for generating partial correlation matrices - part of testing
## for variation in traits explained by climate variables
##
##########################################################################################

partial_cor_bogr <- function(resp, resp_, p.value = F) {
  t1 <- pcor(corrdat[, c(resp, "biomass_aboveground")])
  t2 <-
    pcor.test(resp_ , corrdat$biomass_belowground, z = corrdat$biomass_aboveground)
  t3 <-
    pcor.test(resp_ , corrdat$biomass_rhizome, z = corrdat[, c("biomass_aboveground", "biomass_belowground")])
  t4 <-
    pcor.test(resp_ , corrdat$biomass_total, z = corrdat[, c("biomass_aboveground",
                                                             "biomass_belowground",
                                                             "biomass_rhizome")])
  t5 <-
    pcor.test(resp_ , corrdat$root_shoot, z = corrdat[, c(
      "biomass_aboveground",
      "biomass_belowground",
      "biomass_rhizome",
      "biomass_total"
    )])
  t6 <-
    pcor.test(resp_ , corrdat$max_height, z = corrdat[, c(
      "biomass_aboveground",
      "biomass_belowground",
      "biomass_rhizome",
      "biomass_total",
      "root_shoot"
    )])
  t7 <-
    pcor.test(resp_ , corrdat$avg_predawn_mpa_expt, z = corrdat[, c(
      "biomass_aboveground",
      "biomass_belowground",
      "biomass_rhizome",
      "biomass_total",
      "root_shoot",
      "max_height"
    )])
  t8 <-
    pcor.test(resp_ , corrdat$avg_midday_mpa_expt, z = corrdat[, c(
      "biomass_aboveground",
      "biomass_belowground",
      "biomass_rhizome",
      "biomass_total",
      "root_shoot",
      "max_height",
      "avg_predawn_mpa_expt"
    )])
  t9 <-
    pcor.test(resp_ , corrdat$flwr_mass_lifetime, z = corrdat[, c(
      "biomass_aboveground",
      "biomass_belowground",
      "biomass_rhizome",
      "biomass_total",
      "root_shoot",
      "max_height",
      "avg_predawn_mpa_expt",
      "avg_midday_mpa_expt"
    )])
  t10 <-
    pcor.test(resp_ , corrdat$flwr_count, z = corrdat[, c(
      "biomass_aboveground",
      "biomass_belowground",
      "biomass_rhizome",
      "biomass_total",
      "root_shoot",
      "max_height",
      "avg_predawn_mpa_expt",
      "avg_midday_mpa_expt",
      "flwr_mass_lifetime"
    )])
  t11 <-
    pcor.test(resp_ , corrdat$avg_flwr_mass, z = corrdat[, c(
      "biomass_aboveground",
      "biomass_belowground",
      "biomass_rhizome",
      "biomass_total",
      "root_shoot",
      "max_height",
      "avg_predawn_mpa_expt",
      "avg_midday_mpa_expt",
      "flwr_mass_lifetime",
      "flwr_count"
    )])
  t12 <-
    pcor.test(resp_ , corrdat$avg_flwr_len, z = corrdat[, c(
      "biomass_aboveground",
      "biomass_belowground",
      "biomass_rhizome",
      "biomass_total",
      "root_shoot",
      "max_height",
      "avg_predawn_mpa_expt",
      "avg_midday_mpa_expt",
      "flwr_mass_lifetime",
      "flwr_count",
      "avg_flwr_mass"
    )])
  t13 <-
    pcor.test(resp_ , corrdat$hydroscape_area, z = corrdat[, c(
      "biomass_aboveground",
      "biomass_belowground",
      "biomass_rhizome",
      "biomass_total",
      "root_shoot",
      "max_height",
      "avg_predawn_mpa_expt",
      "avg_midday_mpa_expt",
      "flwr_mass_lifetime",
      "flwr_count",
      "avg_flwr_mass",
      "avg_flwr_len"
    )])
  if (p.value == T) {
    return(p.adjust(
      c(
        t1$p.value[1, 2],
        t2[1, 2],
        t3[1, 2],
        t4[1, 2],
        t5[1, 2],
        t6[1, 2],
        t7[1, 2],
        t8[1, 2],
        t9[1, 2],
        t10[1, 2],
        t11[1, 2],
        t12[1, 2],
        t13[1, 2]
      ),
      method = "fdr"
    ))
  } else{
    return(c(
      t1$estimate[1, 2],
      t2[1, 1],
      t3[1, 1],
      t4[1, 1],
      t5[1, 1],
      t6[1, 1],
      t7[1, 1],
      t8[1, 1],
      t9[1, 1],
      t10[1, 1],
      t11[1, 1],
      t12[1, 1],
      t13[1, 1]
    ))
  }
}

partial_cor_bogr_plasticity <- function(resp, resp_, p.value = F) {
  t1 <- pcor(corrdat[, c(resp, "p_biomass_aboveground")])
  t2 <-
    pcor.test(resp_ ,
              corrdat$p_biomass_belowground,
              z = corrdat$p_biomass_aboveground)
  t3 <-
    pcor.test(resp_ , corrdat$p_biomass_rhizome, z = corrdat[, c("p_biomass_aboveground", "p_biomass_belowground")])
  t4 <-
    pcor.test(resp_ , corrdat$p_biomass_total, z = corrdat[, c("p_biomass_aboveground",
                                                               "p_biomass_belowground",
                                                               "p_biomass_rhizome")])
  t5 <-
    pcor.test(resp_ , corrdat$p_root_shoot, z = corrdat[, c(
      "p_biomass_aboveground",
      "p_biomass_belowground",
      "p_biomass_rhizome",
      "p_biomass_total"
    )])
  t6 <-
    pcor.test(resp_ , corrdat$p_max_height, z = corrdat[, c(
      "p_biomass_aboveground",
      "p_biomass_belowground",
      "p_biomass_rhizome",
      "p_biomass_total",
      "p_root_shoot"
    )])
  t7 <-
    pcor.test(resp_ , corrdat$p_avg_predawn_mpa_expt, z = corrdat[, c(
      "p_biomass_aboveground",
      "p_biomass_belowground",
      "p_biomass_rhizome",
      "p_biomass_total",
      "p_root_shoot",
      "p_max_height"
    )])
  t8 <-
    pcor.test(resp_ , corrdat$p_avg_midday_mpa_expt, z = corrdat[, c(
      "p_biomass_aboveground",
      "p_biomass_belowground",
      "p_biomass_rhizome",
      "p_biomass_total",
      "p_root_shoot",
      "p_max_height",
      "p_avg_predawn_mpa_expt"
    )])
  t9 <-
    pcor.test(resp_ , corrdat$p_flwr_mass_lifetime, z = corrdat[, c(
      "p_biomass_aboveground",
      "p_biomass_belowground",
      "p_biomass_rhizome",
      "p_biomass_total",
      "p_root_shoot",
      "p_max_height",
      "p_avg_predawn_mpa_expt",
      "p_avg_midday_mpa_expt"
    )])
  t10 <-
    pcor.test(resp_ , corrdat$p_flwr_count, z = corrdat[, c(
      "p_biomass_aboveground",
      "p_biomass_belowground",
      "p_biomass_rhizome",
      "p_biomass_total",
      "p_root_shoot",
      "p_max_height",
      "p_avg_predawn_mpa_expt",
      "p_avg_midday_mpa_expt",
      "p_flwr_mass_lifetime"
    )])
  t11 <-
    pcor.test(resp_ , corrdat$p_avg_flwr_mass, z = corrdat[, c(
      "p_biomass_aboveground",
      "p_biomass_belowground",
      "p_biomass_rhizome",
      "p_biomass_total",
      "p_root_shoot",
      "p_max_height",
      "p_avg_predawn_mpa_expt",
      "p_avg_midday_mpa_expt",
      "p_flwr_mass_lifetime",
      "p_flwr_count"
    )])
  t12 <-
    pcor.test(resp_ , corrdat$p_avg_flwr_len, z = corrdat[, c(
      "p_biomass_aboveground",
      "p_biomass_belowground",
      "p_biomass_rhizome",
      "p_biomass_total",
      "p_root_shoot",
      "p_max_height",
      "p_avg_predawn_mpa_expt",
      "p_avg_midday_mpa_expt",
      "p_flwr_mass_lifetime",
      "p_flwr_count",
      "p_avg_flwr_mass"
    )])
  if (p.value == T) {
    return(p.adjust(
      c(
        t1$p.value[1, 2],
        t2[1, 2],
        t3[1, 2],
        t4[1, 2],
        t5[1, 2],
        t6[1, 2],
        t7[1, 2],
        t8[1, 2],
        t9[1, 2],
        t10[1, 2],
        t11[1, 2],
        t12[1, 2]
      ),
      method = "fdr"
    ))
  } else{
    return(c(
      t1$estimate[1, 2],
      t2[1, 1],
      t3[1, 1],
      t4[1, 1],
      t5[1, 1],
      t6[1, 1],
      t7[1, 1],
      t8[1, 1],
      t9[1, 1],
      t10[1, 1],
      t11[1, 1],
      t12[1, 1]
    ))
  }
}