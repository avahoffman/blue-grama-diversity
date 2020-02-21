##########################################################################################
##
## plasticity models
##
## see http://mc-stan.org/users/documentation/case-studies/radon.html for tips on model
## https://datascienceplus.com/bayesian-regression-with-stan-beyond-normality/
## These models report (a) mean phenotypic value DIFFERENCE (ie, plasticity) while 
## correcting for small variation in %VWC betwen treatments
## (trait) then provides (a) at the mean %VWC DIFFERENCE
## (sigma_pop) population variance
## (b) a slope parameter correcting for VWC
## (mu_a) is a hyperparameter, could be considered mean overall plasticity for all blue
## grama we sampled - but has been taken out as of most current analysis
##
##########################################################################################
## load libs
library(rstan) ## Bayesian model compiler and sampler
options(mc.cores = parallel::detectCores()) ## option to make Stan parallelize
library(bayesplot)

##########################################################################################

## models

comp_plasticity_normal <- 
  function(){
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
        //mu_a ~ normal(0, 10 ); //removed these hyperparameters.. 
        // the sites don't seem to come from the same distribution
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
        vector[N] draws1;
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
    comp_plasticity_normal <-
      stan_model(model_code = plasticity_model_normal, 
                 model_name = 'plasticity_model_normal')
    if(write.phenotype.models == TRUE){
      save(comp_plasticity_normal, 
           file="plasticity_model_normal.R"
      )
    }
    
    return(comp_plasticity_normal)
  }

###########################################################################################
## MCMC posterior generation and checks

run_vism_plasticity <-
  function(responsevar,
           outputname,
           adapt_delta = 0.8,
           max_treedepth = 10,
           iter = 10000) {
    #, Purpose of this function is to:
    #, 1) Generate the posterior distribution of a specific response variable given 
    #, specified params
    #, 2) Plot the posterior distribution of same response variable
    #, 3) plot the predictive checks of the posterior draws to ensure a good fit
    plas_clim_data <- get_bogr_data(script == "phenotype")
    temp_data <-
      as.data.frame(cbind(plas_clim_data$pop, responsevar, plas_clim_data$vwc_adj))
    temp_data <- na.omit(temp_data)
    
    ## run the MCMC sampler to generate the posterior distribution
    fit1 <- run_mcmc(
      temp_data = temp_data,
      responsevar = responsevar,
      compiled_model = comp_plasticity_normal(),
      iter = iter,
      adapt_delta = adapt_delta,
      max_treedepth = max_treedepth,
      outfile = paste("posterior_output_plasticity/", outputname, ".csv")
    )
    
    ## plot posterior distributions
    draws <- as.array(fit1)
    bogr.pops <- unique(plas_clim_data$pop)
    get_posterior_intervals_plasticity(
      bogr_pops = bogr.pops,
      draws_data = draws,
      mean_xlab = xlab(paste(outputname,
                             "plasticity 95% CI")),
      mean_file = paste(
        "posterior_output_plasticity/figures/",
        outputname,
        "mean_plasticity.pdf"
      ),
      sigma_xlab = xlab(paste(outputname,
                              "plasticity variance 95% CI")),
      sigma_file = paste(
        "posterior_output_plasticity/figures/",
        outputname,
        "variance_plasticity.pdf"
      )
    )
    ## plot posterior predictive checks
    plot_posterior_predictive_checks(
      temp_data = temp_data,
      responsevar = responsevar,
      outputname = outputname,
      fit_data = fit1,
      file1_name = paste(
        "posterior_output_plasticity/predictive_checks/",
        outputname,
        "plasticity_normalityplot1.pdf"
      ),
      file2_name = paste(
        "posterior_output_plasticity/predictive_checks/",
        outputname,
        "plasticity_normalityplot2.pdf"
      )
    )
  }

###########################################################################################
## run for all traits

run_mcmc_plasticity <- 
  function(){
    plas_clim_data <- get_bogr_data(script == "phenotype")
    
    run_vism_plasticity(
      responsevar = plas_clim_data$biomass_aboveground,
      outputname = "biomass_aboveground",
      iter = 50000
    )
    run_vism_plasticity(
      responsevar = plas_clim_data$biomass_belowground,
      outputname = "biomass_belowground",
      iter = 50000
    )
    run_vism_plasticity(
      responsevar = plas_clim_data$biomass_rhizome,
      outputname = "biomass_rhizome",
      iter = 50000
    )
    run_vism_plasticity(
      responsevar = plas_clim_data$flwr_mass_lifetime,
      outputname = "flwr_mass_lifetime",
      iter = 50000
    )
    
    ## different dist for discrete data?
    # plas_clim_data$flwr_count_1.2[plas_clim_data$flwr_count_1.2 > 30] <- NA
    run_vism_plasticity(
      responsevar = plas_clim_data$flwr_count_1.2,
      outputname = "flwr_count_1.2",
      iter = 50000,
      adapt_delta = 0.9
    )
    
    run_vism_plasticity(
      responsevar = plas_clim_data$flwr_avg_ind_len,
      outputname = "flwr_avg_ind_len",
      iter = 50000,
      adapt_delta = 0.99,
      max_treedepth = 15
    )
    run_vism_plasticity(
      responsevar = plas_clim_data$flwr_avg_ind_mass,
      outputname = "flwr_avg_ind_mass",
      iter = 50000,
      adapt_delta = 0.99,
      max_treedepth = 15
    )
    run_vism_plasticity(
      responsevar = plas_clim_data$max_height,
      outputname = "max_height",
      iter = 50000
    )
    run_vism_plasticity(
      responsevar = plas_clim_data$avg_predawn_mpa_expt,
      outputname = "avg_predawn_mpa_expt",
      iter = 50000,
      adapt_delta = 0.99,
      max_treedepth = 15
    )
    run_vism_plasticity(
      responsevar = plas_clim_data$avg_midday_mpa_expt,
      outputname = "avg_midday_mpa_expt",
      iter = 50000
    )
    run_vism_plasticity(
      responsevar = plas_clim_data$roottoshoot,
      outputname = "Root to shoot biomass ratio",
      iter = 50000,
      adapt_delta = 0.99,
      max_treedepth = 15
    )
    run_vism_plasticity(
      responsevar = plas_clim_data$biomass_total,
      outputname = "Total Biomass",
      iter = 50000
    )
}

