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

## trait mean and variance model
##
## see http://mc-stan.org/users/documentation/case-studies/radon.html for tips on model
## https://datascienceplus.com/bayesian-regression-with-stan-beyond-normality/ 
## These models report (a) mean trait value while correcting for %VWC
## (trait) then provides (a) at the mean value for %VWC
## (sigma_pop) population variance in the trait value correcting for %VWC
## (b) a slope parameter indicating how susceptible a trait was to %VWC, which can be considered a covariate

###########################################################################################
## open data
bogr.data <- read.csv("data/BOGR_DATA_master.csv")
names(bogr.data)
clim.data <- read.csv("data/SITE_DATA.csv")
names(clim.data)

## stan won't be able to handle these NAs. replace them w/ NA so that they can be removed later 
bogr.data[bogr.data == "no pot"] <- NA # any unknown or unid'd loci have a 'NA'
bogr.data[bogr.data == "met"] <- NA # any unknown or unid'd loci have a 'NA'
bogr.data[bogr.data == "tr"] <- NA # any unknown or unid'd loci have a 'NA'
## then these need to be numeric..
bogr.data$biomass_aboveground <- as.numeric(as.character(bogr.data$biomass_aboveground))
bogr.data$biomass_belowground <- as.numeric(as.character(bogr.data$biomass_belowground))
bogr.data$biomass_rhizome <- as.numeric(as.character(bogr.data$biomass_rhizome))
bogr.data$flwr_mass_4 <- as.numeric(as.character(bogr.data$flwr_mass_4))
bogr.data$flwr_mass_final <- as.numeric(as.character(bogr.data$flwr_mass_final))
## merge with climate data
bogr.clim.data <- merge(bogr.data, clim.data)
names(bogr.clim.data)

###########################################################################################
## load libs
library(rstan) ## Bayesian model compiler and sampler
options(mc.cores = parallel::detectCores()) ## option to make Stan parallelize 
library(bayesplot)

###########################################################################################
## models

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
comp.gamma <- stan_model(model_code = varying_intercept_slope_model_gamma, model_name = 'varing.int.slope.model.gamma')
#save(comp.gamma, file="varying_intercept_slope_model_gamma.R")

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
comp.gamma.zero.adjust <- stan_model(model_code = varying_intercept_slope_model_gamma_zero_adjust, model_name = 'varing.int.slope.model.gamma.zero.adjust')
save(comp.gamma.zero.adjust, file="varying_intercept_slope_model_gamma_zero_adjust.R")


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
comp.gamma.mpas <- stan_model(model_code = varying_intercept_slope_model_gamma_mpas, model_name = 'varing.int.slope.model.gamma.mpas')
save(comp.gamma.mpas, file="varying_intercept_slope_model_gamma_mpas.R")


###########################################################################################
## MCMC functions

Run.vism.gamma <- function(responsevar,outputname,adapt_delta = 0.8,max_treedepth = 10,iter=50000){
  temp.data <- as.data.frame(cbind(bogr.clim.data$pop,responsevar,bogr.clim.data$vwc_adj))
  temp.data <- na.omit(temp.data)
  ## setup data
  varying_intercept_slope_data = list(
    'N' = nrow(temp.data),
    'J' = 15, ## 15 populations for traits
    'y' = temp.data$responsevar,
    'county' = temp.data$V1,
    'x' = temp.data$V3,
    'm_x' = mean(temp.data$V3)
  )
  iter = iter
  ## sampling
  fit1 = sampling(
    comp.gamma,
    data = varying_intercept_slope_data,
    iter = iter,
    warmup = iter / 2,
    thin = 1,
    chains = 2,
    control = list(adapt_delta = adapt_delta, max_treedepth = max_treedepth)
  )
  summary_fit <- summary(fit1)
  #save(fit1,file=paste("MCMC_posterior_output.",outputname,".R"))
  
  ## gather 95% CIs
  print("Writing 95% CIs")
  model_stats1 <-
    cbind(summary_fit$summary[, 4, drop = F],
          summary_fit$summary[, 8, drop = F],
          summary_fit$summary[, 1, drop = F],
          summary_fit$summary[, 10, drop = F])
  print(fit1, probs=c(.025,.975))
  write.csv(model_stats1,file=paste("posterior_output/",outputname,".csv"))
  
  ## plot posteriors of key vars
  draws <- as.array(fit1)
  bogr.pops <- unique(bogr.clim.data$pop)
  post.1 <- mcmc_intervals(draws, prob = 0.90, prob_outer = 0.95, point_est = "mean",
                           pars = rev(c("trait[1]","trait[2]","trait[3]","trait[4]","trait[5]","trait[6]","trait[7]","trait[8]","trait[9]","trait[10]","trait[11]","trait[12]","trait[13]","trait[14]","trait[15]"))) +
    xlab(paste(outputname,"mean 95% CI"))+
    scale_y_discrete(labels=rev(bogr.pops))
  ggsave(post.1, file=paste("posterior_output/figures/",outputname,"means.pdf"),height=4,width=4)
  post.2 <- mcmc_intervals(draws, prob = 0.90, prob_outer = 0.95, point_est = "mean",
                           pars = rev(c("sigma_pop[1]","sigma_pop[2]","sigma_pop[3]","sigma_pop[4]","sigma_pop[5]","sigma_pop[6]","sigma_pop[7]","sigma_pop[8]","sigma_pop[9]","sigma_pop[10]","sigma_pop[11]","sigma_pop[12]","sigma_pop[13]","sigma_pop[14]","sigma_pop[15]"))) +
    xlab(paste(outputname,"variance 95% CI")) +
    scale_y_discrete(labels=rev(bogr.pops))
  ggsave(post.2, file=paste("posterior_output/figures/",outputname,"variances.pdf"),height=4,width=4)
  post.3 <- mcmc_intervals(draws, prob = 0.90, prob_outer = 0.95, point_est = "mean",
                           pars = rev(c("b[1]","b[2]","b[3]","b[4]","b[5]","b[6]","b[7]","b[8]","b[9]","b[10]","b[11]","b[12]","b[13]","b[14]","b[15]"))) +
    xlab(paste(outputname,"plasticity 95% CI")) +
    scale_y_discrete(labels=rev(bogr.pops))
  ggsave(post.3, file=paste("posterior_output/figures/",outputname,"plasticity.pdf"),height=4,width=4)
  
  ## posterior pred. checks
  print("Plotting posterior predictive checks")
  list_of_draws <- extract(fit1)
  yrep <- list_of_draws$draws1
  np1 <- ppc_dens_overlay(temp.data$responsevar, yrep[1:500, ]) + 
    theme_minimal(base_size = 20) +
    xlab(outputname)
  ggsave(np1, file=paste("posterior_output/predictive_checks/",outputname,"normalityplot1.pdf"),height=8,width=8)
  pdf(file=paste("posterior_output/predictive_checks/",outputname,"normalityplot2.pdf"))
  hist(temp.data$responsevar,
       prob = T,
       breaks = 20,
       main = outputname)
  lines(density(list_of_draws$draws1), col = "red")
  dev.off()
  print(np1)
}

Run.vism.gamma.zero.adjust <- function(responsevar,outputname,adapt_delta = 0.8,max_treedepth = 10,iter=50000){
  temp.data <- as.data.frame(cbind(bogr.clim.data$pop,responsevar,bogr.clim.data$vwc_adj))
  temp.data <- na.omit(temp.data)
  ## setup data
  varying_intercept_slope_data = list(
    'N' = nrow(temp.data),
    'J' = 15, ## 15 populations for traits
    'y' = temp.data$responsevar,
    'county' = temp.data$V1,
    'x' = temp.data$V3,
    'm_x' = mean(temp.data$V3)
  )
  iter = iter
  ## sampling
  fit1 = sampling(
    comp.gamma.zero.adjust,
    data = varying_intercept_slope_data,
    iter = iter,
    warmup = iter / 2,
    thin = 1,
    chains = 2,
    control = list(adapt_delta = adapt_delta, max_treedepth = max_treedepth)
  )
  summary_fit <- summary(fit1)
  #save(fit1,file=paste("MCMC_posterior_output.",outputname,".R"))
  
  ## gather 95% CIs
  print("Writing 95% CIs")
  model_stats1 <-
    cbind(summary_fit$summary[, 4, drop = F],
          summary_fit$summary[, 8, drop = F],
          summary_fit$summary[, 1, drop = F],
          summary_fit$summary[, 10, drop = F])
  print(fit1, probs=c(.025,.975))
  write.csv(model_stats1,file=paste("posterior_output/",outputname,".csv"))
  
  ## plot posteriors of key vars
  draws <- as.array(fit1)
  bogr.pops <- unique(bogr.clim.data$pop)
  post.1 <- mcmc_intervals(draws, prob = 0.90, prob_outer = 0.95, point_est = "mean",
                           pars = rev(c("trait[1]","trait[2]","trait[3]","trait[4]","trait[5]","trait[6]","trait[7]","trait[8]","trait[9]","trait[10]","trait[11]","trait[12]","trait[13]","trait[14]","trait[15]"))) +
    xlab(paste(outputname,"mean 95% CI"))+
    scale_y_discrete(labels=rev(bogr.pops))
  ggsave(post.1, file=paste("posterior_output/figures/",outputname,"means.pdf"),height=4,width=4)
  post.2 <- mcmc_intervals(draws, prob = 0.90, prob_outer = 0.95, point_est = "mean",
                           pars = rev(c("sigma_pop[1]","sigma_pop[2]","sigma_pop[3]","sigma_pop[4]","sigma_pop[5]","sigma_pop[6]","sigma_pop[7]","sigma_pop[8]","sigma_pop[9]","sigma_pop[10]","sigma_pop[11]","sigma_pop[12]","sigma_pop[13]","sigma_pop[14]","sigma_pop[15]"))) +
    xlab(paste(outputname,"variance 95% CI")) +
    scale_y_discrete(labels=rev(bogr.pops))
  ggsave(post.2, file=paste("posterior_output/figures/",outputname,"variances.pdf"),height=4,width=4)
  post.3 <- mcmc_intervals(draws, prob = 0.90, prob_outer = 0.95, point_est = "mean",
                           pars = rev(c("b[1]","b[2]","b[3]","b[4]","b[5]","b[6]","b[7]","b[8]","b[9]","b[10]","b[11]","b[12]","b[13]","b[14]","b[15]"))) +
    xlab(paste(outputname,"plasticity 95% CI")) +
    scale_y_discrete(labels=rev(bogr.pops))
  ggsave(post.3, file=paste("posterior_output/figures/",outputname,"plasticity.pdf"),height=4,width=4)
  
  ## posterior pred. checks
  print("Plotting posterior predictive checks")
  list_of_draws <- extract(fit1)
  yrep <- list_of_draws$draws1
  np1 <- ppc_dens_overlay(temp.data$responsevar, yrep[1:500, ]) + 
    theme_minimal(base_size = 20) +
    xlab(outputname)
  ggsave(np1, file=paste("posterior_output/predictive_checks/",outputname,"normalityplot1.pdf"),height=8,width=8)
  pdf(file=paste("posterior_output/predictive_checks/",outputname,"normalityplot2.pdf"))
  hist(temp.data$responsevar,
       prob = T,
       breaks = 20,
       main = outputname)
  lines(density(list_of_draws$draws1), col = "red")
  dev.off()
  print(np1)
}

Run.vism.gamma.mpas <- function(responsevar,outputname,adapt_delta = 0.8,max_treedepth = 10,iter=50000){
  temp.data <- as.data.frame(cbind(bogr.clim.data$pop,responsevar,bogr.clim.data$vwc_adj))
  temp.data <- na.omit(temp.data)
  ## setup data
  varying_intercept_slope_data = list(
    'N' = nrow(temp.data),
    'J' = 15, ## 15 populations for traits
    'y' = temp.data$responsevar,
    'county' = temp.data$V1,
    'x' = temp.data$V3,
    'm_x' = mean(temp.data$V3)
  )
  iter = iter
  ## sampling
  fit1 = sampling(
    comp.gamma.mpas,
    data = varying_intercept_slope_data,
    iter = iter,
    warmup = iter / 2,
    thin = 1,
    chains = 2,
    control = list(adapt_delta = adapt_delta, max_treedepth = max_treedepth)
  )
  summary_fit <- summary(fit1)
  #save(fit1,file=paste("MCMC_posterior_output.",outputname,".R"))
  
  ## gather 95% CIs
  print("Writing 95% CIs")
  model_stats1 <-
    cbind(summary_fit$summary[, 4, drop = F],
          summary_fit$summary[, 8, drop = F],
          summary_fit$summary[, 1, drop = F],
          summary_fit$summary[, 10, drop = F])
  print(fit1, probs=c(.025,.975))
  write.csv(model_stats1,file=paste("posterior_output/",outputname,".csv"))
  
  ## plot posteriors of key vars
  draws <- as.array(fit1)
  bogr.pops <- unique(bogr.clim.data$pop)
  post.1 <- mcmc_intervals(draws, prob = 0.90, prob_outer = 0.95, point_est = "mean",
                           pars = rev(c("trait[1]","trait[2]","trait[3]","trait[4]","trait[5]","trait[6]","trait[7]","trait[8]","trait[9]","trait[10]","trait[11]","trait[12]","trait[13]","trait[14]","trait[15]"))) +
    xlab(paste(outputname,"mean 95% CI"))+
    scale_y_discrete(labels=rev(bogr.pops))
  ggsave(post.1, file=paste("posterior_output/figures/",outputname,"means.pdf"),height=4,width=4)
  post.2 <- mcmc_intervals(draws, prob = 0.90, prob_outer = 0.95, point_est = "mean",
                           pars = rev(c("sigma_pop[1]","sigma_pop[2]","sigma_pop[3]","sigma_pop[4]","sigma_pop[5]","sigma_pop[6]","sigma_pop[7]","sigma_pop[8]","sigma_pop[9]","sigma_pop[10]","sigma_pop[11]","sigma_pop[12]","sigma_pop[13]","sigma_pop[14]","sigma_pop[15]"))) +
    xlab(paste(outputname,"variance 95% CI")) +
    scale_y_discrete(labels=rev(bogr.pops))
  ggsave(post.2, file=paste("posterior_output/figures/",outputname,"variances.pdf"),height=4,width=4)
  post.3 <- mcmc_intervals(draws, prob = 0.90, prob_outer = 0.95, point_est = "mean",
                           pars = rev(c("b[1]","b[2]","b[3]","b[4]","b[5]","b[6]","b[7]","b[8]","b[9]","b[10]","b[11]","b[12]","b[13]","b[14]","b[15]"))) +
    xlab(paste(outputname,"plasticity 95% CI")) +
    scale_y_discrete(labels=rev(bogr.pops))
  ggsave(post.3, file=paste("posterior_output/figures/",outputname,"plasticity.pdf"),height=4,width=4)
  
  ## posterior pred. checks
  print("Plotting posterior predictive checks")
  list_of_draws <- extract(fit1)
  yrep <- list_of_draws$draws1
  np1 <- ppc_dens_overlay(temp.data$responsevar, yrep[1:500, ]) + 
    theme_minimal(base_size = 20) +
    xlab(outputname)
  ggsave(np1, file=paste("posterior_output/predictive_checks/",outputname,"normalityplot1.pdf"),height=8,width=8)
  pdf(file=paste("posterior_output/predictive_checks/",outputname,"normalityplot2.pdf"))
  hist(temp.data$responsevar,
       prob = T,
       breaks = 20,
       main = outputname)
  lines(density(list_of_draws$draws1), col = "red")
  dev.off()
  print(np1)
}


###########################################################################################
## run for all relevant traits

Run.vism.gamma(responsevar = bogr.clim.data$biomass_aboveground,
               outputname = "biomass_aboveground")
Run.vism.gamma(responsevar = bogr.clim.data$biomass_belowground,
               outputname = "biomass_belowground")
Run.vism.gamma(responsevar = bogr.clim.data$biomass_rhizome,
               outputname = "biomass_rhizome",
               adapt_delta = 0.9)

## flower mass won't converge due to lots of zeros
Run.vism.gamma.zero.adjust(responsevar = bogr.clim.data$flwr_mass_lifetime + 1,
                           outputname = "flwr_mass_lifetime",
                           adapt_delta = 0.90)

Run.vism.gamma(responsevar = bogr.clim.data$flwr_count_1.2,
               outputname = "flwr_count_1.2",
               adapt_delta = 0.90)
Run.vism.gamma(responsevar = bogr.clim.data$flwr_avg_ind_len,
               outputname = "flwr_avg_ind_len",
               adapt_delta = 0.90)
Run.vism.gamma(responsevar = bogr.clim.data$flwr_avg_ind_mass,
               outputname = "flwr_avg_ind_mass",
               adapt_delta = 0.90)

## had some zero height plants / never grew
bogr.clim.data$max_height[bogr.clim.data$max_height < 20] <- NA # any unknown or unid'd loci have a 'NA'
Run.vism.gamma(responsevar = bogr.clim.data$max_height,
               outputname = "max_height",
               adapt_delta = 0.9)

## water potentials (mpas) are all negative but gamma distributed
Run.vism.gamma.mpas(responsevar = bogr.clim.data$avg_predawn_mpa_expt * -1,
                    outputname = "avg_predawn_mpa_expt")
Run.vism.gamma.mpas(responsevar = bogr.clim.data$avg_midday_mpa_expt * -1,
                    outputname = "avg_midday_mpa_expt")

Run.vism.gamma(responsevar = (bogr.clim.data$biomass_belowground + bogr.clim.data$biomass_rhizome) / bogr.clim.data$biomass_aboveground,
               outputname = "Root:shoot biomass ratio")
Run.vism.gamma(responsevar = bogr.clim.data$biomass_belowground + bogr.clim.data$biomass_rhizome + bogr.clim.data$biomass_aboveground + bogr.clim.data$flwr_mass_lifetime,
               outputname = "Total Biomass",
               adapt_delta = 0.9)
