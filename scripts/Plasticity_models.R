##########################################################################################
##
## plasticity models
##
## see http://mc-stan.org/users/documentation/case-studies/radon.html for tips on model
## https://datascienceplus.com/bayesian-regression-with-stan-beyond-normality/
## These models report (a) mean trait value DIFFERENCE (ie, plasticity) while correcting
## for small variation in %VWC betwen treatments
## (trait) then provides (a) at the mean %VWC DIFFERENCE
## (sigma_pop) population variance
## (b) a slope parameter correcting for VWC
## (mu_a) is a hyperparameter, could be considered mean overall plasticity for all blue
## grama we sampled
##
##########################################################################################
## set working directory
source("config.R")
setwd(wd)
## load libs
library(rstan) ## Bayesian model compiler and sampler
options(mc.cores = parallel::detectCores()) ## option to make Stan parallelize
library(bayesplot)

##########################################################################################
## open plasticity data
plas.data <- read.csv("data/BOGR_DATA_plasticity_master.csv")
names(plas.data)
clim.data <- read.csv("data/SITE_DATA.csv")
names(clim.data)

## stan won't be able to handle these NAs. replace them w/ NA so that they can be removed
plas.data[plas.data == "no pot"] <-
  NA # any unknown or unid'd loci have a 'NA'
plas.data[plas.data == "met"] <-
  NA # any unknown or unid'd loci have a 'NA'
plas.data[plas.data == "tr"] <-
  NA # any unknown or unid'd loci have a 'NA'
## merge with climate data
plas.clim.data <- merge(plas.data, clim.data)
names(plas.clim.data)

##########################################################################################
## models

plasticity_model_normal <- "
data {
  int<lower=0> N;
  int<lower=0> J;
  vector[N] y;
  vector[N] x;
  int county[N];
  real m_x;
}
parameters {
  //real<lower=0> sigma_a;
  //real<lower=0> sigma_b;
  vector[J] a;
  vector[J] b;
  vector<lower=0>[J] sigma_pop;
  //real mu_a;
  //real mu_b;
}
transformed parameters{
  vector[N] mu;
  mu = a[county] + b[county].*x;
}
model {
  //priors
  //mu_a ~ normal(0, 10 ); //removed these hyperparameters.. the sites don't seem to come fromthe same distribution
  //mu_b ~ normal(0, 10);
  sigma_pop ~ cauchy(0,10);
  //model
  //a ~ normal(mu_a, sigma_a);
  //b ~ normal(mu_b, sigma_b);
  a ~ normal(0,10);
  b ~ normal(0,10);
  y ~ normal(mu, sigma_pop[county]);
}
generated quantities{
  vector[N] draws1;,
  vector[J] trait;
  for(n in 1:N)
  for(j in 1:J){
    draws1[n] = normal_rng(mu[n], sigma_pop[j]); //posterior draws
  }
  for(j in 1:J){
    trait[j] = a[j] + b[j].*m_x;
  }
}
"
comp.plasticity.normal <-
  stan_model(model_code = plasticity_model_normal, model_name = 'plasticity_model_normal')
if(write.phenotype.models == TRUE){
  save(comp.plasticity.normal, 
       file="plasticity_model_normal.R"
       )
}

###########################################################################################
## MCMC function

Run.vism.plasticity <-
  function(responsevar,
           outputname,
           adapt_delta = 0.8,
           max_treedepth = 10,
           iter = 10000) {
    #, Docstrings
    temp.data <-
      as.data.frame(cbind(plas.clim.data$pop, responsevar, plas.clim.data$vwc_adj))
    temp.data <- na.omit(temp.data)
    ## setup data
    varying_intercept_slope_data = list(
      'N' = nrow(temp.data),
      'J' = 15,
      ## 15 populations for traits
      'y' = temp.data$responsevar,
      'county' = temp.data$V1,
      'x' = temp.data$V3,
      'm_x' = mean(temp.data$V3)
    )
    iter = iter
    ## sampling
    fit1 = sampling(
      comp.plasticity.normal,
      data = varying_intercept_slope_data,
      iter = iter,
      warmup = iter / 2,
      thin = 1,
      chains = 2,
      control = list(adapt_delta = adapt_delta, max_treedepth = max_treedepth)
    )
    summary_fit <- summary(fit1)
    #save(fit1,file=paste("MCMC_posterior_output.plasticity.",outputname,".R"))
    
    ## gather 95% CIs
    print("Writing 95% CIs")
    model_stats1 <-
      cbind(
        summary_fit$summary[, 4, drop = F],
        summary_fit$summary[, 8, drop = F],
        summary_fit$summary[, 1, drop = F],
        summary_fit$summary[, 10, drop = F]
      )
    print(fit1, probs = c(.025, .975))
    write.csv(model_stats1,
              file = paste("posterior_output_plasticity/", outputname, ".csv"))
    
    ## plot posteriors of key vars
    draws <- as.array(fit1)
    bogr.pops <- unique(bogr.clim.data$pop)
    post.1 <-
      mcmc_intervals(
        draws,
        prob = 0.90,
        prob_outer = 0.95,
        point_est = "mean",
        pars = rev(
          c(
            "trait[1]",
            "trait[2]",
            "trait[3]",
            "trait[4]",
            "trait[5]",
            "trait[6]",
            "trait[7]",
            "trait[8]",
            "trait[9]",
            "trait[10]",
            "trait[11]",
            "trait[12]",
            "trait[13]",
            "trait[14]",
            "trait[15]"
          )
        )
      ) +
      xlab(paste(outputname, "plasticity 95% CI")) +
      scale_y_discrete(labels = rev(bogr.pops))
    ggsave(
      post.1,
      file = paste(
        "posterior_output_plasticity/figures/",
        outputname,
        "mean_plasticity.pdf"
      ),
      height = 4,
      width = 4
    )
    post.2 <-
      mcmc_intervals(
        draws,
        prob = 0.90,
        prob_outer = 0.95,
        point_est = "mean",
        pars = rev(
          c(
            "sigma_pop[1]",
            "sigma_pop[2]",
            "sigma_pop[3]",
            "sigma_pop[4]",
            "sigma_pop[5]",
            "sigma_pop[6]",
            "sigma_pop[7]",
            "sigma_pop[8]",
            "sigma_pop[9]",
            "sigma_pop[10]",
            "sigma_pop[11]",
            "sigma_pop[12]",
            "sigma_pop[13]",
            "sigma_pop[14]",
            "sigma_pop[15]"
          )
        )
      ) +
      xlab(paste(outputname, "plasticity variance 95% CI")) +
      scale_y_discrete(labels = rev(bogr.pops))
    ggsave(
      post.2,
      file = paste(
        "posterior_output_plasticity/figures/",
        outputname,
        "variance_plasticity.pdf"
      ),
      height = 4,
      width = 4
    )
    
    ## posterior pred. checks
    print("Plotting posterior predictive checks")
    list_of_draws <- extract(fit1)
    yrep <- list_of_draws$draws1
    np1 <- ppc_dens_overlay(temp.data$responsevar, yrep[1:500,]) +
      theme_minimal(base_size = 20) +
      xlab(outputname)
    ggsave(
      np1,
      file = paste(
        "posterior_output_plasticity/predictive_checks/",
        outputname,
        "plasticity_normalityplot1.pdf"
      ),
      height = 8,
      width = 8
    )
    pdf(
      file = paste(
        "posterior_output_plasticity/predictive_checks/",
        outputname,
        "plasticity_normalityplot2.pdf"
      )
    )
    hist(
      temp.data$responsevar,
      prob = T,
      breaks = 20,
      main = outputname
    )
    lines(density(list_of_draws$draws1), col = "red")
    dev.off()
    print(np1)
  }

###########################################################################################
## run for all traits

Run.vism.plasticity(
  responsevar = plas.clim.data$biomass_aboveground,
  outputname = "biomass_aboveground",
  iter = 50000
)
Run.vism.plasticity(
  responsevar = plas.clim.data$biomass_belowground,
  outputname = "biomass_belowground",
  iter = 50000
)
Run.vism.plasticity(
  responsevar = plas.clim.data$biomass_rhizome,
  outputname = "biomass_rhizome",
  iter = 50000
)
Run.vism.plasticity(
  responsevar = plas.clim.data$flwr_mass_lifetime,
  outputname = "flwr_mass_lifetime",
  iter = 50000
)

## different dist for discrete data?
# plas.clim.data$flwr_count_1.2[plas.clim.data$flwr_count_1.2 > 30] <- NA
Run.vism.plasticity(
  responsevar = plas.clim.data$flwr_count_1.2,
  outputname = "flwr_count_1.2",
  iter = 50000,
  adapt_delta = 0.9
)

Run.vism.plasticity(
  responsevar = plas.clim.data$flwr_avg_ind_len,
  outputname = "flwr_avg_ind_len",
  iter = 50000,
  adapt_delta = 0.99,
  max_treedepth = 15
)
Run.vism.plasticity(
  responsevar = plas.clim.data$flwr_avg_ind_mass,
  outputname = "flwr_avg_ind_mass",
  iter = 50000,
  adapt_delta = 0.99,
  max_treedepth = 15
)
Run.vism.plasticity(
  responsevar = plas.clim.data$max_height,
  outputname = "max_height",
  iter = 50000
)
Run.vism.plasticity(
  responsevar = plas.clim.data$avg_predawn_mpa_expt,
  outputname = "avg_predawn_mpa_expt",
  iter = 50000,
  adapt_delta = 0.99,
  max_treedepth = 15
)
Run.vism.plasticity(
  responsevar = plas.clim.data$avg_midday_mpa_expt,
  outputname = "avg_midday_mpa_expt",
  iter = 50000
)
Run.vism.plasticity(
  responsevar = plas.clim.data$roottoshoot,
  outputname = "Root to shoot biomass ratio",
  iter = 50000,
  adapt_delta = 0.99,
  max_treedepth = 15
)
Run.vism.plasticity(
  responsevar = plas.clim.data$biomass_total,
  outputname = "Total Biomass",
  iter = 50000
)
