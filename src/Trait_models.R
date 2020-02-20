##########################################################################################
##
## phenotypic mean and variance models
##
## see http://mc-stan.org/users/documentation/case-studies/radon.html for tips on model
## https://datascienceplus.com/bayesian-regression-with-stan-beyond-normality/
## These models report (a) mean phenotype value while correcting for %VWC
## (trait) then provides (a) at the mean value for %VWC
## (sigma_pop) population variance in the phenotypic value correcting for %VWC
## (b) a slope parameter indicating how susceptible a phenotype was to %VWC, which can be
## considered a covariate.
##
##########################################################################################
## load libs
library(rstan) ## Bayesian model compiler and sampler
options(mc.cores = parallel::detectCores()) ## option to make Stan parallelize
library(bayesplot)

##########################################################################################

get_bogr_data <- 
  function(){
    ## open data
    bogr_data <- read.csv("data/BOGR_DATA_master.csv")
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


## models

comp_gamma <-
  function() {
    varying_intercept_slope_model_gamma <- "
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
      vector[N] alpha;
      vector[N] beta;
      mu = exp(a[county] + b[county].*x); //log link
      alpha = mu .* mu ./ sigma_pop[county];
      beta = mu ./ sigma_pop[county];
      }
      model {
      //priors
      //mu_a ~ normal(0, 100);
      //mu_b ~ normal(0, 100);
      sigma_pop ~ cauchy(0,10);
      //model
      //a ~ normal(mu_a, sigma_a);
      //b ~ normal(mu_b, sigma_b);
      a ~ normal(0,100);
      b ~ normal(0,100);
      y ~ gamma(alpha, beta);
      }
      generated quantities{
      vector[N] draws1;
      vector[J] trait;
      for(n in 1:N){
      draws1[n] = gamma_rng(alpha[n], beta[n]); //posterior draws
      }
      for(j in 1:J){
      trait[j] = exp(a[j] + b[j]*m_x);
      }
      }
    "
    comp_gamma <-
      stan_model(model_code = varying_intercept_slope_model_gamma,
                 model_name = 'varing.int.slope.model.gamma')
    if (write.phenotype.models == TRUE) {
      save(comp_gamma,
           file = "varying_intercept_slope_model_gamma.R")
    }
    
    return(comp_gamma)
}


comp_gamma_zero_adjust <- 
  function(){
    varying_intercept_slope_model_gamma_zero_adjust <- "
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
        vector[N] alpha;
        vector[N] beta;
        mu = exp(a[county] + b[county].*x); //log link
        alpha = mu .* mu ./ sigma_pop[county];
        beta = mu ./ sigma_pop[county];
      }
      model {
        //priors
        //mu_a ~ normal(0, 100);
        //mu_b ~ normal(0, 100);
        sigma_pop ~ cauchy(0,10);
        //model
        //a ~ normal(mu_a, sigma_a);
        //b ~ normal(mu_b, sigma_b);
        a ~ normal(0,100);
        b ~ normal(0,100);
        y ~ gamma(alpha, beta);
      }
      generated quantities{
        vector[N] draws1;
        vector[J] trait;
        for(n in 1:N){
          draws1[n] = gamma_rng(alpha[n], beta[n]); //posterior draws
        }
        for(j in 1:J){
          trait[j] = exp(a[j] + b[j]*m_x) - 1;
        }
      }
    "
    comp_gamma_zero_adjust <-
      stan_model(model_code = varying_intercept_slope_model_gamma_zero_adjust,
                 model_name = 'varing.int.slope.model.gamma.zero.adjust')
    if (write.phenotype.models == TRUE) {
      save(comp_gamma_zero_adjust,
           file = "varying_intercept_slope_model_gamma_zero_adjust.R")
    }
    
    return(comp_gamma_zero_adjust)
  }


comp_gamma_mpas <- 
  function(){
    varying_intercept_slope_model_gamma_mpas <- "
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
        vector[N] alpha;
        vector[N] beta;
        mu = exp(a[county] + b[county].*x); //log link
        alpha = mu .* mu ./ sigma_pop[county];
        beta = mu ./ sigma_pop[county];
      }
      model {
        //priors
        //mu_a ~ normal(0, 100);
        //mu_b ~ normal(0, 100);
        sigma_pop ~ cauchy(0,10);
        //model
        //a ~ normal(mu_a, sigma_a);
        //b ~ normal(mu_b, sigma_b);
        a ~ normal(0,100);
        b ~ normal(0,100);
        y ~ gamma(alpha, beta);
      }
      generated quantities{
        vector[N] draws1;
        vector[J] trait;
        for(n in 1:N){
          draws1[n] = gamma_rng(alpha[n], beta[n]); //posterior draws
        }
        for(j in 1:J){
          trait[j] = exp(a[j] + b[j]*m_x) * -1;
        }
      }
    "
    comp_gamma_mpas <-
      stan_model(model_code = varying_intercept_slope_model_gamma_mpas,
                 model_name = 'varing.int.slope.model.gamma.mpas')
    if (write.phenotype.models == TRUE) {
      save(comp_gamma_mpas,
           file = "varying_intercept_slope_model_gamma_mpas.R")
    }
    
    return(comp_gamma_mpas)
  }


###########################################################################################
## MCMC posterior generation and checks

run_vism <-
  function(responsevar,
           outputname,
           compiled_model,
           adapt_delta = 0.8,
           max_treedepth = 10,
           iter = 50000) {
    #, Purpose of this function is to:
    #, 1) Generate the posterior distribution of a specific response variable given
    #, specified params
    #, 2) Plot the posterior distribution of same response variable
    #, 3) plot the predictive checks of the posterior draws to ensure a good fit
    temp.data <-
      as.data.frame(cbind(get_bogr_data()$pop, responsevar, get_bogr_data()$vwc_adj))
    `temp.data <- na.omit(temp.data)`
    
    ## run the MCMC sampler to generate the posterior distribution
    fit1 <- run_mcmc(
      temp_data = temp.data,
      responsevar = responsevar,
      compiled_model = compiled_model,
      iter = iter,
      adapt_delta = adapt_delta,
      max_treedepth = max_treedepth,
      outfile = paste("posterior_output/", outputname, ".csv")
    )
    
    ## plot posterior distributions
    draws <- as.array(fit1)
    bogr.pops <- unique(get_bogr_data()$pop)
    get_posterior_intervals(
      bogr_pops = bogr.pops,
      draws_data = draws,
      mean_xlab = xlab(paste(outputname, "mean 95% CI")),
      mean_file = paste("posterior_output/figures/", outputname, "means.pdf"),
      sigma_xlab = xlab(paste(outputname, "variance 95% CI")),
      sigma_file = paste("posterior_output/figures/", outputname, "variances.pdf"),
      b_xlab = xlab(paste(outputname, "plasticity 95% CI")),
      b_file = paste("posterior_output/figures/", outputname, "plasticity.pdf")
    )
    
    ## plot posterior predictive checks
    plot_posterior_predictive_checks(
      temp_data = temp.data,
      responsevar = responsevar,
      outputname = outputname,
      fit_data = fit1,
      file1_name = paste(
        "posterior_output/predictive_checks/",
        outputname,
        "normalityplot1.pdf"
      ),
      file2_name = paste(
        "posterior_output/predictive_checks/",
        outputname,
        "normalityplot2.pdf"
      )
    )
  }


###########################################################################################
## run for all relevant traits

run_mcmc_phenotypes <-
  function() {
    run_vism(
      responsevar = get_bogr_data()$biomass_aboveground,
      outputname = "biomass_aboveground",
      compiled_model = comp_gamma()
    )
    run_vism(
      responsevar = get_bogr_data()$biomass_belowground,
      outputname = "biomass_belowground",
      compiled_model = comp_gamma()
    )
    run_vism(
      responsevar = get_bogr_data()$biomass_rhizome,
      outputname = "biomass_rhizome",
      compiled_model = comp_gamma(),
      adapt_delta = 0.9
    )
    
    ## flower mass won't converge due to lots of zeros
    run_vism(
      responsevar = get_bogr_data()$flwr_mass_lifetime + 1,
      outputname = "flwr_mass_lifetime",
      compiled_model = comp_gamma_zero_adjust(),
      adapt_delta = 0.90
    )
    
    run_vism(
      responsevar = get_bogr_data()$flwr_count_1.2,
      outputname = "flwr_count_1.2",
      compiled_model = comp_gamma(),
      adapt_delta = 0.90
    )
    run_vism(
      responsevar = get_bogr_data()$flwr_avg_ind_len,
      outputname = "flwr_avg_ind_len",
      compiled_model = comp_gamma(),
      adapt_delta = 0.90
    )
    run_vism(
      responsevar = get_bogr_data()$flwr_avg_ind_mass,
      outputname = "flwr_avg_ind_mass",
      compiled_model = comp_gamma(),
      adapt_delta = 0.90
    )
    
    ## had some zero height plants / never grew
    get_bogr_data()$max_height[get_bogr_data()$max_height < 20] <-
      NA # any unknown or unid'd loci have a 'NA'
    run_vism(
      responsevar = get_bogr_data()$max_height,
      outputname = "max_height",
      compiled_model = comp_gamma(),
      adapt_delta = 0.9
    )
    
    ## water potentials (mpas) are all negative but gamma distributed
    run_vism(
      responsevar = get_bogr_data()$avg_predawn_mpa_expt * -1,
      outputname = "avg_predawn_mpa_expt",
      compiled_model = comp_gamma_mpas()
    )
    run_vism(
      responsevar = get_bogr_data()$avg_midday_mpa_expt * -1,
      outputname = "avg_midday_mpa_expt",
      compiled_model = comp_gamma_mpas()
    )
    
    run_vism(
      responsevar = (
        get_bogr_data()$biomass_belowground + get_bogr_data()$biomass_rhizome
      ) / get_bogr_data()$biomass_aboveground,
      compiled_model = comp_gamma(),
      outputname = "Root:shoot biomass ratio"
    )
    run_vism(
      responsevar = get_bogr_data()$biomass_belowground +
        get_bogr_data()$biomass_rhizome +
        get_bogr_data()$biomass_aboveground +
        get_bogr_data()$flwr_mass_lifetime,
      outputname = "Total Biomass",
      compiled_model = comp_gamma(),
      adapt_delta = 0.9
    )
  }

