###########################################################################################
##
## R source code to accompany Hoffman et al. (2018), last updated 3 July 2018.
## Please contact Ava Hoffman (avamariehoffman@gmail.com) with questions.
##
## If you found this code useful, please use the citation below:
## 
## 
## 
##
###########################################################################################

## set working directory
wd <- "/Users/avahoffman/Dropbox/Research/Bouteloua_diversity"
setwd(wd)
###########################################################################################
## open data
bogr.data <- read.csv("Analysis/BOGR_DATA_master.csv")
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

## open plasticity data
plas.data <- read.csv("Analysis/BOGR_DATA_plasticity_master.csv")
names(plas.data)
clim.data <- read.csv("data/SITE_DATA.csv")
names(clim.data)

## stan won't be able to handle these NAs. replace them w/ NA so that they can be removed later 
plas.data[plas.data == "no pot"] <- NA # any unknown or unid'd loci have a 'NA'
plas.data[plas.data == "met"] <- NA # any unknown or unid'd loci have a 'NA'
plas.data[plas.data == "tr"] <- NA # any unknown or unid'd loci have a 'NA'
## merge with climate data
plas.clim.data <- merge(plas.data, clim.data)
names(plas.clim.data)

###########################################################################################
## Which analyses to run? Change "no" to "yes" to run.

## Trait mean and variance model
run.1.1 <- "no"

## Plasticity
run.1.2 <- "no"

## Hydroscape
run.1.3 <- "no"

## Genomics analyses
run.2.1 <- "no"

## Association with climate variables using all subsets regression
run.3.1 <- "no"

## Plotting!
run.4.1 <- "no"

## Plotting!
run.4.1 <- "no"

###########################################################################################
###########################################################################################

## run.1.1
## trait mean and variance model
##
## see http://mc-stan.org/users/documentation/case-studies/radon.html for tips on model
## https://datascienceplus.com/bayesian-regression-with-stan-beyond-normality/ 
## These models report (a) mean trait value while correcting for %VWC
## (trait) then provides (a) at the mean value for %VWC
## (sigma_pop) population variance in the trait value correcting for %VWC
## (b) a slope parameter indicating how susceptible a trait was to %VWC, which can be considered a covariate

###########################################################################################
###########################################################################################

if(run.1.1 == "yes")
{
  
###########################################################################################
## load libs
library(rstan) ## Bayesian model compiler and sampler
options(mc.cores = parallel::detectCores()) ## option to make Stan parallelize 
library(bayesplot)
  
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
if (file.exists("Analysis/R_output/varying_intercept_slope_model_gamma.R")){
  load("Analysis/R_output/varying_intercept_slope_model_gamma.R")
} else {
  comp.gamma <- stan_model(model_code = varying_intercept_slope_model_gamma, model_name = 'varing.int.slope.model.gamma')
  save(comp.gamma, file="Analysis/R_output/varying_intercept_slope_model_gamma.R")
}

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
if (file.exists("Analysis/R_output/varying_intercept_slope_model_gamma_zero_adjust.R")){
  load("Analysis/R_output/varying_intercept_slope_model_gamma_zero_adjust.R")
} else {
  comp.gamma.zero.adjust <- stan_model(model_code = varying_intercept_slope_model_gamma_zero_adjust, model_name = 'varing.int.slope.model.gamma.zero.adjust')
  save(comp.gamma.zero.adjust, file="Analysis/R_output/varying_intercept_slope_model_gamma_zero_adjust.R")
}

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
if (file.exists("Analysis/R_output/varying_intercept_slope_model_gamma_mpas.R")){
  load("Analysis/R_output/varying_intercept_slope_model_gamma_mpas.R")
} else {
  comp.gamma.mpas <- stan_model(model_code = varying_intercept_slope_model_gamma_mpas, model_name = 'varing.int.slope.model.gamma.mpas')
  save(comp.gamma.mpas, file="Analysis/R_output/varying_intercept_slope_model_gamma_mpas.R")
}


## run MCMC

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
  save(fit1,file=paste("Analysis/R_output/MCMC_posterior_output.",outputname,".R"))
  
  ## gather 95% CIs
  print("Writing 95% CIs")
  model_stats1 <-
    cbind(summary_fit$summary[, 4, drop = F],
          summary_fit$summary[, 8, drop = F],
          summary_fit$summary[, 1, drop = F],
          summary_fit$summary[, 10, drop = F])
  print(fit1, probs=c(.025,.975))
  write.csv(model_stats1,file=paste("Analysis/posterior_output/",outputname,".csv"))
  
  ## plot posteriors of key vars
  draws <- as.array(fit1)
  bogr.pops <- unique(bogr.clim.data$pop)
  post.1 <- mcmc_intervals(draws, prob = 0.90, prob_outer = 0.95, point_est = "mean",
                           pars = rev(c("trait[1]","trait[2]","trait[3]","trait[4]","trait[5]","trait[6]","trait[7]","trait[8]","trait[9]","trait[10]","trait[11]","trait[12]","trait[13]","trait[14]","trait[15]"))) +
    xlab(paste(outputname,"mean 95% CI"))+
    scale_y_discrete(labels=rev(bogr.pops))
  ggsave(post.1, file=paste("Analysis/posterior_output/figures/",outputname,"means.pdf"),height=4,width=4)
  post.2 <- mcmc_intervals(draws, prob = 0.90, prob_outer = 0.95, point_est = "mean",
                           pars = rev(c("sigma_pop[1]","sigma_pop[2]","sigma_pop[3]","sigma_pop[4]","sigma_pop[5]","sigma_pop[6]","sigma_pop[7]","sigma_pop[8]","sigma_pop[9]","sigma_pop[10]","sigma_pop[11]","sigma_pop[12]","sigma_pop[13]","sigma_pop[14]","sigma_pop[15]"))) +
    xlab(paste(outputname,"variance 95% CI")) +
    scale_y_discrete(labels=rev(bogr.pops))
  ggsave(post.2, file=paste("Analysis/posterior_output/figures/",outputname,"variances.pdf"),height=4,width=4)
  post.3 <- mcmc_intervals(draws, prob = 0.90, prob_outer = 0.95, point_est = "mean",
                           pars = rev(c("b[1]","b[2]","b[3]","b[4]","b[5]","b[6]","b[7]","b[8]","b[9]","b[10]","b[11]","b[12]","b[13]","b[14]","b[15]"))) +
    xlab(paste(outputname,"plasticity 95% CI")) +
    scale_y_discrete(labels=rev(bogr.pops))
  ggsave(post.3, file=paste("Analysis/posterior_output/figures/",outputname,"plasticity.pdf"),height=4,width=4)
  
  ## posterior pred. checks
  print("Plotting posterior predictive checks")
  list_of_draws <- extract(fit1)
  yrep <- list_of_draws$draws1
  np1 <- ppc_dens_overlay(temp.data$responsevar, yrep[1:500, ]) + 
    theme_minimal(base_size = 20) +
    xlab(outputname)
  ggsave(np1, file=paste("Analysis/posterior_output/predictive_checks/",outputname,"normalityplot1.pdf"),height=8,width=8)
  pdf(file=paste("Analysis/posterior_output/predictive_checks/",outputname,"normalityplot2.pdf"))
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
  save(fit1,file=paste("Analysis/R_output/MCMC_posterior_output.",outputname,".R"))
  
  ## gather 95% CIs
  print("Writing 95% CIs")
  model_stats1 <-
    cbind(summary_fit$summary[, 4, drop = F],
          summary_fit$summary[, 8, drop = F],
          summary_fit$summary[, 1, drop = F],
          summary_fit$summary[, 10, drop = F])
  print(fit1, probs=c(.025,.975))
  write.csv(model_stats1,file=paste("Analysis/posterior_output/",outputname,".csv"))
  
  ## plot posteriors of key vars
  draws <- as.array(fit1)
  bogr.pops <- unique(bogr.clim.data$pop)
  post.1 <- mcmc_intervals(draws, prob = 0.90, prob_outer = 0.95, point_est = "mean",
                           pars = rev(c("trait[1]","trait[2]","trait[3]","trait[4]","trait[5]","trait[6]","trait[7]","trait[8]","trait[9]","trait[10]","trait[11]","trait[12]","trait[13]","trait[14]","trait[15]"))) +
    xlab(paste(outputname,"mean 95% CI"))+
    scale_y_discrete(labels=rev(bogr.pops))
  ggsave(post.1, file=paste("Analysis/posterior_output/figures/",outputname,"means.pdf"),height=4,width=4)
  post.2 <- mcmc_intervals(draws, prob = 0.90, prob_outer = 0.95, point_est = "mean",
                           pars = rev(c("sigma_pop[1]","sigma_pop[2]","sigma_pop[3]","sigma_pop[4]","sigma_pop[5]","sigma_pop[6]","sigma_pop[7]","sigma_pop[8]","sigma_pop[9]","sigma_pop[10]","sigma_pop[11]","sigma_pop[12]","sigma_pop[13]","sigma_pop[14]","sigma_pop[15]"))) +
    xlab(paste(outputname,"variance 95% CI")) +
    scale_y_discrete(labels=rev(bogr.pops))
  ggsave(post.2, file=paste("Analysis/posterior_output/figures/",outputname,"variances.pdf"),height=4,width=4)
  post.3 <- mcmc_intervals(draws, prob = 0.90, prob_outer = 0.95, point_est = "mean",
                           pars = rev(c("b[1]","b[2]","b[3]","b[4]","b[5]","b[6]","b[7]","b[8]","b[9]","b[10]","b[11]","b[12]","b[13]","b[14]","b[15]"))) +
    xlab(paste(outputname,"plasticity 95% CI")) +
    scale_y_discrete(labels=rev(bogr.pops))
  ggsave(post.3, file=paste("Analysis/posterior_output/figures/",outputname,"plasticity.pdf"),height=4,width=4)
  
  ## posterior pred. checks
  print("Plotting posterior predictive checks")
  list_of_draws <- extract(fit1)
  yrep <- list_of_draws$draws1
  np1 <- ppc_dens_overlay(temp.data$responsevar, yrep[1:500, ]) + 
    theme_minimal(base_size = 20) +
    xlab(outputname)
  ggsave(np1, file=paste("Analysis/posterior_output/predictive_checks/",outputname,"normalityplot1.pdf"),height=8,width=8)
  pdf(file=paste("Analysis/posterior_output/predictive_checks/",outputname,"normalityplot2.pdf"))
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
  save(fit1,file=paste("Analysis/R_output/MCMC_posterior_output.",outputname,".R"))
  
  ## gather 95% CIs
  print("Writing 95% CIs")
  model_stats1 <-
    cbind(summary_fit$summary[, 4, drop = F],
          summary_fit$summary[, 8, drop = F],
          summary_fit$summary[, 1, drop = F],
          summary_fit$summary[, 10, drop = F])
  print(fit1, probs=c(.025,.975))
  write.csv(model_stats1,file=paste("Analysis/posterior_output/",outputname,".csv"))
  
  ## plot posteriors of key vars
  draws <- as.array(fit1)
  bogr.pops <- unique(bogr.clim.data$pop)
  post.1 <- mcmc_intervals(draws, prob = 0.90, prob_outer = 0.95, point_est = "mean",
                           pars = rev(c("trait[1]","trait[2]","trait[3]","trait[4]","trait[5]","trait[6]","trait[7]","trait[8]","trait[9]","trait[10]","trait[11]","trait[12]","trait[13]","trait[14]","trait[15]"))) +
    xlab(paste(outputname,"mean 95% CI"))+
    scale_y_discrete(labels=rev(bogr.pops))
  ggsave(post.1, file=paste("Analysis/posterior_output/figures/",outputname,"means.pdf"),height=4,width=4)
  post.2 <- mcmc_intervals(draws, prob = 0.90, prob_outer = 0.95, point_est = "mean",
                           pars = rev(c("sigma_pop[1]","sigma_pop[2]","sigma_pop[3]","sigma_pop[4]","sigma_pop[5]","sigma_pop[6]","sigma_pop[7]","sigma_pop[8]","sigma_pop[9]","sigma_pop[10]","sigma_pop[11]","sigma_pop[12]","sigma_pop[13]","sigma_pop[14]","sigma_pop[15]"))) +
    xlab(paste(outputname,"variance 95% CI")) +
    scale_y_discrete(labels=rev(bogr.pops))
  ggsave(post.2, file=paste("Analysis/posterior_output/figures/",outputname,"variances.pdf"),height=4,width=4)
  post.3 <- mcmc_intervals(draws, prob = 0.90, prob_outer = 0.95, point_est = "mean",
                           pars = rev(c("b[1]","b[2]","b[3]","b[4]","b[5]","b[6]","b[7]","b[8]","b[9]","b[10]","b[11]","b[12]","b[13]","b[14]","b[15]"))) +
    xlab(paste(outputname,"plasticity 95% CI")) +
    scale_y_discrete(labels=rev(bogr.pops))
  ggsave(post.3, file=paste("Analysis/posterior_output/figures/",outputname,"plasticity.pdf"),height=4,width=4)
  
  ## posterior pred. checks
  print("Plotting posterior predictive checks")
  list_of_draws <- extract(fit1)
  yrep <- list_of_draws$draws1
  np1 <- ppc_dens_overlay(temp.data$responsevar, yrep[1:500, ]) + 
    theme_minimal(base_size = 20) +
    xlab(outputname)
  ggsave(np1, file=paste("Analysis/posterior_output/predictive_checks/",outputname,"normalityplot1.pdf"),height=8,width=8)
  pdf(file=paste("Analysis/posterior_output/predictive_checks/",outputname,"normalityplot2.pdf"))
  hist(temp.data$responsevar,
       prob = T,
       breaks = 20,
       main = outputname)
  lines(density(list_of_draws$draws1), col = "red")
  dev.off()
  print(np1)
}




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
# Run.vism.gamma.mpas(responsevar = bogr.clim.data$avg_predawn_mpa_drydown * -1,
#          outputname = "avg_predawn_mpa_drydown")
# Run.vism.gamma.mpas(responsevar = bogr.clim.data$avg_midday_mpa_drydown * -1,
#          outputname = "avg_midday_mpa_drydown")
Run.vism.gamma(responsevar = (bogr.clim.data$biomass_belowground + bogr.clim.data$biomass_rhizome) / bogr.clim.data$biomass_aboveground,
               outputname = "Root:shoot biomass ratio")
Run.vism.gamma(responsevar = bogr.clim.data$biomass_belowground + bogr.clim.data$biomass_rhizome + bogr.clim.data$biomass_aboveground + bogr.clim.data$flwr_mass_lifetime,
               outputname = "Total Biomass",
               adapt_delta = 0.9)
## difference between predawn and midday
bogr.clim.data$mpa_diff <- bogr.clim.data$avg_predawn_mpa_expt - bogr.clim.data$avg_midday_mpa_expt  ## should be a positive number
bogr.clim.data$mpa_diff[bogr.clim.data$mpa_diff < 0] <- 0 # if predawn was actually lower, then set equal
Run.vism.gamma.zero.adjust(responsevar = bogr.clim.data$mpa_diff +1,
                    outputname = "avg_mpa_difference",
                    adapt_delta = 0.9)



## if you want to check that posteriors by population are close to data means..
v <- bogr.clim.data$flwr_mass_lifetime
part.data <- as.data.frame(cbind(bogr.clim.data$pop,v,bogr.clim.data$vwc_adj))
ag1 <- aggregate(. ~ V1, data = part.data, var); ag1$V1 <- unique(bogr.clim.data$pop) ; ag1
ag2 <- aggregate(. ~ V1, data = part.data, var); ag2$V1 <- unique(bogr.clim.data$pop) ; ag2

}

###########################################################################################
###########################################################################################
## run.1.2
## plasticity
## 
## see http://mc-stan.org/users/documentation/case-studies/radon.html for tips on model
## https://datascienceplus.com/bayesian-regression-with-stan-beyond-normality/ 
## These models report (a) mean trait value DIFFERENCE (ie, plasticity) while correcting for 
## small variation in %VWC betwen treatments
## (trait) then provides (a) at the mean %VWC DIFFERENCE 
## (sigma_pop) population variance
## (b) a slope parameter correcting for VWC
## (mu_a) is a hyperparameter, could be considered mean overall plasticity for all blue grama we sampled
###########################################################################################
###########################################################################################

if(run.1.2 == "yes")
{
  v
  ###########################################################################################
  ## load libs
  library(rstan) ## Bayesian model compiler and sampler
  options(mc.cores = parallel::detectCores()) ## option to make Stan parallelize 
  library(bayesplot)
  
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
if (file.exists("Analysis/R_output/plasticity_model_normal.R")){
  load("Analysis/R_output/plasticity_model_normal.R")
} else {
  comp.plasticity.normal <- stan_model(model_code = plasticity_model_normal, model_name = 'plasticity_model_normal')
  save(comp.plasticity.normal, file="Analysis/R_output/plasticity_model_normal.R")
}

Run.vism.plasticity <- function(responsevar,outputname,adapt_delta = 0.8,max_treedepth = 10,iter=10000){
  temp.data <- as.data.frame(cbind(plas.clim.data$pop,responsevar,plas.clim.data$vwc_adj))
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
    comp.plasticity.normal,
    data = varying_intercept_slope_data,
    iter = iter,
    warmup = iter / 2,
    thin = 1,
    chains = 2,
    control = list(adapt_delta = adapt_delta, max_treedepth = max_treedepth)
  )
  summary_fit <- summary(fit1)
  save(fit1,file=paste("Analysis/R_output/MCMC_posterior_output.plasticity.",outputname,".R"))
  
  ## gather 95% CIs
  print("Writing 95% CIs")
  model_stats1 <-
    cbind(summary_fit$summary[, 4, drop = F],
          summary_fit$summary[, 8, drop = F],
          summary_fit$summary[, 1, drop = F],
          summary_fit$summary[, 10, drop = F])
  print(fit1, probs=c(.025,.975))
  write.csv(model_stats1,file=paste("Analysis/posterior_output_plasticity/",outputname,".csv"))
  
  ## plot posteriors of key vars
  draws <- as.array(fit1)
  bogr.pops <- unique(bogr.clim.data$pop)
  post.1 <- mcmc_intervals(draws, prob = 0.90, prob_outer = 0.95, point_est = "mean",
                           pars = rev(c("trait[1]","trait[2]","trait[3]","trait[4]","trait[5]","trait[6]","trait[7]","trait[8]","trait[9]","trait[10]","trait[11]","trait[12]","trait[13]","trait[14]","trait[15]"))) +
    xlab(paste(outputname,"plasticity 95% CI"))+
    scale_y_discrete(labels=rev(bogr.pops))
  ggsave(post.1, file=paste("Analysis/posterior_output_plasticity/figures/",outputname,"mean_plasticity.pdf"),height=4,width=4)
  post.2 <- mcmc_intervals(draws, prob = 0.90, prob_outer = 0.95, point_est = "mean",
                           pars = rev(c("sigma_pop[1]","sigma_pop[2]","sigma_pop[3]","sigma_pop[4]","sigma_pop[5]","sigma_pop[6]","sigma_pop[7]","sigma_pop[8]","sigma_pop[9]","sigma_pop[10]","sigma_pop[11]","sigma_pop[12]","sigma_pop[13]","sigma_pop[14]","sigma_pop[15]"))) +
    xlab(paste(outputname,"plasticity variance 95% CI")) +
    scale_y_discrete(labels=rev(bogr.pops))
  ggsave(post.2, file=paste("Analysis/posterior_output_plasticity/figures/",outputname,"variance_plasticity.pdf"),height=4,width=4)
  # post.3 <- mcmc_intervals(draws, prob = 0.90, prob_outer = 0.95, point_est = "mean",
  #                          pars = rev(c("b[1]","b[2]","b[3]","b[4]","b[5]","b[6]","b[7]","b[8]","b[9]","b[10]","b[11]","b[12]","b[13]","b[14]","b[15]"))) +
  #   xlab(paste(outputname,"vwc effect 95% CI")) +
  #   scale_y_discrete(labels=rev(bogr.pops))
  # ggsave(post.3, file=paste("Analysis/posterior_output_plasticity/figures/",outputname,"plasticity.pdf"),height=4,width=4)
  
  ## posterior pred. checks
  print("Plotting posterior predictive checks")
  list_of_draws <- extract(fit1)
  yrep <- list_of_draws$draws1
  np1 <- ppc_dens_overlay(temp.data$responsevar, yrep[1:500, ]) + 
    theme_minimal(base_size = 20) +
    xlab(outputname)
  ggsave(np1, file=paste("Analysis/posterior_output_plasticity/predictive_checks/",outputname,"plasticity_normalityplot1.pdf"),height=8,width=8)
  pdf(file=paste("Analysis/posterior_output_plasticity/predictive_checks/",outputname,"plasticity_normalityplot2.pdf"))
  hist(temp.data$responsevar,
       prob = T,
       breaks = 20,
       main = outputname)
  lines(density(list_of_draws$draws1), col = "red")
  dev.off()
  print(np1)
}

Run.vism.plasticity(responsevar = plas.clim.data$biomass_aboveground,
               outputname = "biomass_aboveground", iter = 50000)
Run.vism.plasticity(responsevar = plas.clim.data$biomass_belowground,
               outputname = "biomass_belowground", iter = 50000)
Run.vism.plasticity(responsevar = plas.clim.data$biomass_rhizome,
               outputname = "biomass_rhizome", iter = 50000)
Run.vism.plasticity(responsevar = plas.clim.data$flwr_mass_lifetime,
               outputname = "flwr_mass_lifetime", iter = 50000)

## different dist for discrete data?
# plas.clim.data$flwr_count_1.2[plas.clim.data$flwr_count_1.2 > 30] <- NA
Run.vism.plasticity(responsevar = plas.clim.data$flwr_count_1.2,
               outputname = "flwr_count_1.2", iter = 50000, adapt_delta = 0.9)

Run.vism.plasticity(responsevar = plas.clim.data$flwr_avg_ind_len,
               outputname = "flwr_avg_ind_len", iter = 50000, adapt_delta = 0.99, max_treedepth = 15)
Run.vism.plasticity(responsevar = plas.clim.data$flwr_avg_ind_mass,
               outputname = "flwr_avg_ind_mass", iter = 50000, adapt_delta = 0.99, max_treedepth = 15)
Run.vism.plasticity(responsevar = plas.clim.data$max_height,
               outputname = "max_height", iter = 50000)
Run.vism.plasticity(responsevar = plas.clim.data$avg_predawn_mpa_expt,
                    outputname = "avg_predawn_mpa_expt", iter = 50000, adapt_delta = 0.99, max_treedepth = 15)
Run.vism.plasticity(responsevar = plas.clim.data$avg_midday_mpa_expt,
                    outputname = "avg_midday_mpa_expt", iter = 50000)
Run.vism.plasticity(responsevar = plas.clim.data$roottoshoot,
               outputname = "Root to shoot biomass ratio", iter = 50000, adapt_delta = 0.99, max_treedepth = 15)
Run.vism.plasticity(responsevar = plas.clim.data$biomass_total,
               outputname = "Total Biomass", iter = 50000)

v <- plas.clim.data$flwr_count_1.2
part.data <- as.data.frame(cbind(as.factor(plas.clim.data$pop),v,plas.clim.data$vwc_adj))
ag1 <- aggregate(. ~ V1, data = part.data, mean); ag1$V1 <- unique(plas.clim.data$pop) ; ag1
ag2 <- aggregate(. ~ V1, data = part.data, var); ag2$V1 <- unique(plas.clim.data$pop) ; ag2


}

###########################################################################################
###########################################################################################
## run.1.3
## Calculate hydroscape area
## 
## Following Meinzer et al. (http://doi.wiley.com/10.1111/ele.12670)
###########################################################################################
###########################################################################################

if(run.1.3 == "yes")
{
  
  library(ggplot2)
  
  hydro.dat <- read.table("/Users/avahoffman/Dropbox/Research/Bouteloua_diversity/Analysis/hydroscape/water_potential.txt",header=T)
  # plot(hydro.dat$pre,hydro.dat$mid)
  # ## all samples
  # slope.all <- summary(lm(pre~mid,data = hydro.dat)) ; slope.all
  # setwd(paste(wd,"/Analysis/hydroscape/plots",sep=""))
  # plot.hydro <- function(pop.use){
  # df <- na.omit(hydro.dat)
  # find_hull <- function(df) df[chull(df$pre, df$mid), ]
  # hulls <- ddply(df, "pop", find_hull)
  # ggplot(data=subset(hydro.dat, hydro.dat$pop == pop.use ), 
  #        aes(x=pre,y=mid)) + 
  #   geom_abline(intercept = 0, slope = 1, linetype = 2) +
  #   geom_point() + theme_classic() + stat_smooth(se=F, method="lm") +
  #   facet_grid(.~pop) +
  #   geom_polygon(data = subset(hulls, hulls$pop == pop.use), alpha = 0.5)
  # ggsave(file=paste(pop.use,"_raw.pdf",sep=""),height=4,width=4)
  # }
  # plot.hydro("A") ; plot.hydro("BG") ; plot.hydro("BT") ; plot.hydro("CIB") ; plot.hydro("CO")
  # plot.hydro("DM") ; plot.hydro("HV") ; plot.hydro("K") ; plot.hydro("RC") ; plot.hydro("RM") 
  # plot.hydro("SEV") ; plot.hydro("SGS") ; plot.hydro("ST") ; plot.hydro("W") ; plot.hydro("WR")  
  # 
  #hydro.dat$pre <- ifelse(hydro.dat$pre < hydro.dat$mid, hydro.dat$mid, hydro.dat$pre) ## IF PRE WAS MORE NEGATIVE, SET PRE TO EQUAL MIDDay
  hydro.dat$pre <- ifelse(hydro.dat$pre < hydro.dat$mid, NA, hydro.dat$pre) ## IF PRE WAS MORE NEGATIVE, remove
  hydro.dat <- subset(hydro.dat, hydro.dat$remove =="NO")
  plot.hydro <- function(pop.use){
    subdata <- subset(hydro.dat, hydro.dat$pop == pop.use )
    lmodel <- (lm(mid~pre,subdata))
    intercept <- lmodel$coefficients[1]
    slope <- lmodel$coefficients[2]
    one2oneint=( (intercept) / (1 - slope) ) ## where does the line intercept the 1:1 line?
    hydroscapearea = ( ((one2oneint)^2) - ( (one2oneint) * (one2oneint - intercept)/2) - (((one2oneint)^2)/2) ) ## calc hydroscape
    hydroscapearea = round(hydroscapearea,3)
    top.point <- c(0,0) ; int.point <- c(0,intercept) ; line.point <- c(one2oneint,one2oneint) ## make hulls 
    hulls <- rbind(top.point, int.point, line.point); colnames(hulls) <- c("pre","mid")
    ggplot(data=subdata, 
           aes(x=pre,y=mid)) + 
      geom_abline(intercept = 0, slope = 1, linetype = 2) +
      geom_point() + theme_classic() + stat_smooth(se=F, method="lm") +
      facet_grid(.~pop) + xlim(-10,0) + ylim(-10,0) +
      geom_polygon(data = as.data.frame(hulls), alpha = 0.5) + 
      annotate("text", x = -7, y = -2, label = hydroscapearea, size=10)
    ggsave(file=paste(pop.use,"_above_rm.pdf",sep=""),height=4,width=4)
  }
  plot.hydro("A") ; plot.hydro("BG") ; plot.hydro("BT") ; plot.hydro("CIB") ; plot.hydro("CO")
  plot.hydro("DM") ; plot.hydro("HV") ; plot.hydro("K") ; plot.hydro("RC") ; plot.hydro("RM") 
  plot.hydro("SEV") ; plot.hydro("SGS") ; plot.hydro("ST") ; plot.hydro("W") ; plot.hydro("WR")  
  
}

###########################################################################################
###########################################################################################
## run.2.1
## Genomics analyses
##
## https://grunwaldlab.github.io/Population_Genetics_in_R/Pop_Structure.html 
## Goal: (1) find heirarchical relationship among populations
## (2) plot above findings to show differences in NMD space
## (3) calculate mean pairwise differences among populations
###########################################################################################
###########################################################################################

if(run.2.1 == "yes")
{
## ###########################################################################################
## load libs
library(adegenet) ## deal with genind objects
library(ade4)
library(ape)
library(ggtree)
library(phytools)
library(poppr)
library(ggplot2)
library(reshape2)
library(gridExtra)
library(ggrepel)
library(phangorn)
  
  
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
## clone validation
## https://cran.r-project.org/web/packages/poppr/vignettes/mlg.html
## 
load("/Users/avahoffman/Dropbox/Research/Bouteloua_diversity/Genomics/Bouteloua_genomics/04-genotyping/R_output/genind.348.40.filt.clonesonly.byclone.R")
indNames(genind.data1)
genind.clones <- genind.data1[c(4:64)] ## don't want cultivar outgroup either
#genind.clones$tab <- tab(genind.clones, NA.method = "mean")
indNames(genind.clones)
## very important! Need to figure out where the clone threshold cutoff is.
gen.clones <- as.genclone(genind.clones)
xdis <- diss.dist(genind.clones, percent = FALSE, mat = FALSE)
#pdf(file="Analysis/Genomics/clones.pdf",height = 11,width=7)
plot.phylo(upgma(xdis))
#dev.off()
mlg.filter(gen.clones, distance = xdis, algorithm = "average_neighbor") <- 500 #32
gen.clones; mlg.table(gen.clones) ## this looks correct, notice that at this cutoff, all clones are lumped together.
bg_clone_diversity_4 <- poppr(gen.clones,method=4)  ## tried different methods, with little effect
save(bg_clone_diversity_4,file="Analysis/Genomics/Poppr_clone_diversity.R")
write.csv(bg_clone_diversity_4, file="Analysis/Genomics/Poppr_clone_diversity.csv")

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
## several options depending on what samples desired..
load("/Users/avahoffman/Dropbox/Research/Bouteloua_diversity/Genomics/Bouteloua_genomics/04-genotyping/R_output/genind.348.40.filt.R")
## color palette for plots
col.pal <- read.csv("Analysis/color_key.csv",header=T)
col.pal.v <- as.vector(col.pal[,3]) ; names(col.pal.v) <- col.pal[,2]
col.pal.names <- as.vector(col.pal[,2]) ; names(col.pal.names) <- col.pal[,6]
col.pal.colors <- as.vector(col.pal[,3]) ; names(col.pal.colors) <- col.pal[,6]

## remove all but one of each clone 
indNames(genind.data1)
genind.1clone.only <- genind.data1[c(5,12,18,21,27,33,41,44,48,50,55,58,65:335)]
indNames(genind.1clone.only) <- gsub("Bgedge","SGS",indNames(genind.1clone.only))
indNames(genind.1clone.only) <- gsub("BgHq","SGS",indNames(genind.1clone.only))
indNames(genind.1clone.only)

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
## calculate measures of genetic diversity
## https://grunwaldlab.github.io/Population_Genetics_in_R/Genotypic_EvenRichDiv.html
## https://cran.r-project.org/web/packages/poppr/vignettes/poppr_manual.html

## very important! Use threshold of clones above..

## MLG and Nei's Heterozygosity
genind.1clone.only$tab <- tab(genind.1clone.only, NA.method = "mean")
bg.gen <- as.genclone(genind.1clone.only)
sample.matrix <- diss.dist(bg.gen, percent = FALSE, mat = FALSE)
mlg.filter(bg.gen, distance = sample.matrix, algorithm = "average_neighbor") <- 2400#32
bg.gen; mlg.table(bg.gen)


bg_diversity <- poppr(bg.gen, method = 4)
bg_diversity_3 <- poppr(bg.gen, method = 3)
save(bg_diversity,file="Analysis/Genomics/Poppr_genetic_diversity.R")
write.csv(bg_diversity, file="Analysis/Genomics/Poppr_genetic_diversity.csv")
write.csv(mlg.table(bg.gen), file = "Analysis/Genomics/Poppr_multilocus_genos.csv")


## calculate pairwise differences (within population)
sample.matrix.2 <- diss.dist(bg.gen, percent = FALSE, mat = TRUE)
sample.matrix.2[lower.tri(sample.matrix.2, diag = T)] <- NA
msm <- melt(sample.matrix.2) ; msm <- na.omit(msm)
msm$group <- NA
SGS.dist <- msm[(grepl("SGS",msm$Var1) & grepl("SGS",msm$Var2)),] ; SGS.dist$group <- "SGS"
A.dist <- msm[(grepl("A",msm$Var1) & grepl("A",msm$Var2)),] ; A.dist$group <- "Andrus"
BT.dist <- msm[(grepl("BT",msm$Var1) & grepl("BT",msm$Var2)),] ; BT.dist$group <- "Beech Trail"
BG.dist <- msm[(grepl("BG",msm$Var1) & grepl("BG",msm$Var2)),] ; BG.dist$group <- "Buffalo Gap"
CP.dist <- msm[(grepl("CP",msm$Var1) & grepl("CP",msm$Var2)),] ; CP.dist$group <- "Cedar Point"
CIB.dist <- msm[(grepl("CI",msm$Var1) & grepl("CI",msm$Var2)),] ; CIB.dist$group <- "Cibola"
CO.dist <- msm[(grepl("CO",msm$Var1) & grepl("CO",msm$Var2)),] ; CO.dist$group <- "Comanche"
DM.dist <- msm[(grepl("DM",msm$Var1) & grepl("DM",msm$Var2)),] ; DM.dist$group <- "Davidson Mesa"
HV.dist <- msm[(grepl("HV",msm$Var1) & grepl("HV",msm$Var2)),] ; HV.dist$group <- "Heil Valley"
K.dist <- msm[(grepl("K",msm$Var1) & grepl("K",msm$Var2)),] ; K.dist <- K.dist[!(grepl("KNZ",K.dist$Var1) | grepl("KNZ",K.dist$Var2)),] ; K.dist$group <- "Kelsall"
KNZ.dist <- msm[(grepl("KNZ",msm$Var1) & grepl("KNZ",msm$Var2)),] ; KNZ.dist$group <- "Konza"
RC.dist <- msm[(grepl("RC",msm$Var1) & grepl("RC",msm$Var2)),] ; RC.dist$group <- "Rock Creek"
RM.dist <- msm[(grepl("RM",msm$Var1) & grepl("RM",msm$Var2)),] ; RM.dist$group <- "Rabbit Mountain"
SEV.dist <- msm[(grepl("SEV",msm$Var1) & grepl("SEV",msm$Var2)),] ; SEV.dist$group <- "Sevilleta"
ST.dist <- msm[(grepl("ST",msm$Var1) & grepl("ST",msm$Var2)),] ; ST.dist$group <- "Steele"
W.dist <- msm[(grepl("W",msm$Var1) & grepl("W",msm$Var2)),] ; W.dist <- W.dist[!(grepl("WR",W.dist$Var1) | grepl("WR",W.dist$Var2)),] ; W.dist$group <- "Wonderland"
WR.dist <- msm[(grepl("WR",msm$Var1) & grepl("WR",msm$Var2)),] ; WR.dist$group <- "Walker Ranch"
combined.df <- rbind(SGS.dist,A.dist,BT.dist,BG.dist,CP.dist,CIB.dist,CO.dist,DM.dist,HV.dist,K.dist,KNZ.dist,RC.dist,RM.dist,SEV.dist,ST.dist,W.dist,WR.dist)

ggplot(combined.df, aes(x=reorder(group, value, FUN=median, color=group), y=value, fill=group) ) +
  geom_boxplot() + coord_flip() + guides(fill=FALSE) + labs(x="",y="Pairwise distance within site (SNPs)") + scale_fill_manual(values=col.pal.v) + theme_classic()
ggsave(file = "Analysis/Key_figures/Pairwise_distances.jpg",height = 6,width=7.5)

summary(aov(value~group, data=combined.df)) ## groups differ in distance
T.test.results <- pairwise.t.test(combined.df$value, combined.df$group, p.adj = "bonf", pool.sd = F, var.equal = F)
write.csv(T.test.results$p.value, file="Analysis/Genomics/Pairwise_distance_results.csv")

## adegenet method
## not run
## 
# pairwise.means <- pairDist(genind.1clone.only)
# pairwise.means$violin
# ## ordered
# ggplot(pairwise.means$data, aes(x=reorder(groups, distance, FUN=median), y=distance, fill=groups) ) +
#   geom_violin() + coord_flip() + guides(fill=FALSE) + labs(x="",y="Pairwise distances")
# 
# ## mean pairwise distances within groups
# p.df <- as.data.frame(pairwise.means$data )
# p.df$groups <- as.character(p.df$groups)
# s <- strsplit(p.df$groups, split = "-")
# long.df <- data.frame(distance = rep(p.df$distance, sapply(s, length)), groups = unlist(s))
# long.df$region <- rep(NA, nrow(long.df))
# long.df[long.df$groups == "Andrus", ][, "region"] <- "Boulder"
# long.df[long.df$groups == "Wonderland", ][, "region"] <- "Boulder"
# long.df[long.df$groups == "Konza", ][, "region"] <- "Kansas"
# long.df[long.df$groups == "Cedar Point", ][, "region"] <- "Nebraska"
# long.df[long.df$groups == "Rabbit Mountain", ][, "region"] <- "Boulder"
# long.df[long.df$groups == "SGS", ][, "region"] <- "Colorado"
# long.df[long.df$groups == "Kelsall", ][, "region"] <- "Boulder"
# long.df[long.df$groups == "Sevilleta", ][, "region"] <- "New Mexico"
# long.df[long.df$groups == "Cibola", ][, "region"] <- "New Mexico"
# long.df[long.df$groups == "Walker Ranch", ][, "region"] <- "Boulder"
# long.df[long.df$groups == "Steele", ][, "region"] <- "Boulder"
# long.df[long.df$groups == "Beech Trail", ][, "region"] <- "Boulder"
# long.df[long.df$groups == "Heil Valley", ][, "region"] <- "Boulder"
# long.df[long.df$groups == "Davidson Mesa", ][, "region"] <- "Boulder"
# long.df[long.df$groups == "Rock Creek", ][, "region"] <- "Boulder"
# long.df[long.df$groups == "Comanche", ][, "region"] <- "Colorado"
# long.df[long.df$groups == "Buffalo Gap", ][, "region"] <- "South Dakota"
# ## Boulder, Colorado, Kansas, Nebraska, NM, SD
# col.pal <- c("#66A61E","#D95F02","#6495ED","#1B9E77","#8B0000","#008B8B")
# ggplot(long.df, aes(x=reorder(groups, distance, FUN=median, color=region), y=distance, fill=region) ) +
#   geom_boxplot() + coord_flip() + guides(fill=FALSE) + labs(x="",y="Pairwise distances") + scale_fill_manual(values=col.pal) + theme_classic()
# ggsave(file = "Analysis/Genomics/Figures/Pairwise_distances.pdf",height = 6,width=7.5)

# #-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
## generate neighbor joining trees
## http://bioconductor.org/packages/3.7/bioc/vignettes/ggtree/inst/doc/treeManipulation.html#group-clades

genind.1clone.only$tab <- tab(genind.1clone.only, NA.method = "mean")
strata(genind.1clone.only) <- data.frame(pop(genind.1clone.only))
nameStrata(genind.1clone.only) <- ~Pop
# Analysis
set.seed(999)
poptree <- genind.1clone.only %>%
  genind2genpop(pop = ~Pop) %>%
  aboot(sample = 10000,
        distance = provesti.dist,
        cutoff = 0,
        quiet = F,
        missing = "zero")
write.tree(poptree,file = "Analysis/Genomics/Pop_tree.nexus")
## run Nexus files with java -jar /Applications/FigTree/FigTree\ v1.4.3.app/Contents/Resources/Java/figtree.jar
save(poptree,file="Analysis/Genomics/pop_phylo_file.R")

load("Analysis/Genomics/pop_phylo_file.R")
col.pal <- c("#1B9E77","#66A61E","#D95F02","#6495ED","#8B0000","#008B8B")
col.pal <- as.vector(col.pal.v)

col.pal <- c("black","#FDB35A","#859D59","#CBB0CE","#A2D48E","#F88A89","#E19B78","#A889C1","#6BAD9E","#3F8CBF","#72ADD1","#795199","#8ECD70","#399F2F","#E73233","#5EB54C","#3386AE","#A6CEE3")
## group by region
cls <- list(c2=c("Andrus", "Beech Trail","Davidson Mesa", "Heil Valley", "Kelsall","Rabbit Mountain","Rock Creek","Steele","Wonderland","Walker Ranch"),
            c3=c("SGS","Comanche"),
            c1="Cedar Point",
            c4="Konza",
            c6="Buffalo Gap",
            c5=c("Sevilleta","Cibola"))
## each pop individual
cls <- as.list(unique(genind.1clone.only$pop))
tree <- groupOTU(poptree, cls)
write.tree(tree,file = "Analysis/Genomics/Pop_tree_population_level.nexus")
ggtree(tree, aes(color=group), layout="rectangular") +
  geom_label_repel(aes(label=label), force=0,nudge_x = -0.00025, nudge_y = 0.4) +
  theme_tree() +
  scale_color_manual(values = c(col.pal,"black")) 
ggsave(file="Analysis/Key_figures/Phylognetic_tree_population.jpg",height = 7,width=9)

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
## Discriminant Analysis of Principal Components (DAPC)
## https://github.com/thibautjombart/adegenet/raw/master/tutorials/tutorial-dapc.pdf 

genind.1clone.only$tab <- tab(genind.1clone.only, NA.method = "mean")
## how many components most appropriate given our population groupings? Want to avoid overfitting.
grp <- pop(genind.1clone.only)
pdf("Analysis/Genomics/Figures/Xval_plot.pdf",height=6,width=6)
xval <- xvalDapc(genind.1clone.only$tab, grp, n.pca.max = 160, training.set = 0.9,
                 result = "groupMean", center = TRUE, scale = FALSE,
                 n.pca = NULL, n.rep = 1000, xval.plot = TRUE, parallel = "multicore")
dev.off()
save(xval, file="Analysis/Genomics/xval.R")
## DAPC knows to use populations as prior groups
## Can only plot the first two discriminant functions..
load(file="Analysis/Genomics/xval.R")
DAPC <- xval$DAPC
#DAPC <- dapc(genind.1clone.only$tab, grp, n.pca = 100, n.da = 16)
## how much variance retained?
DAPC$var
DAPC

## plot as groups
plot.dat <- as.data.frame(DAPC$ind.coord)
plot.dat <- cbind(plot.dat,DAPC$grp) ; names(plot.dat)[17] <- "pop"
plot.dat <- merge(plot.dat,col.pal)
write.csv(plot.dat,file="Analysis/Genomics/BOGR_dapc_dat.csv")
gg1 <- ggplot(data=plot.dat, aes(x=LD1,y=LD2)) +  
  scale_color_manual(values = col.pal.colors, labels = col.pal.names) + 
  theme_classic() +
  ## ellipses for visual aide
  stat_ellipse(data=subset(plot.dat, `abbv`=="CIB"),color="#F88A89") +
  stat_ellipse(data=subset(plot.dat, `abbv`=="SEV"), color="#E73233") +
  stat_ellipse(data=subset(plot.dat, `abbv`=="WR"), color="#A6CEE3") +
  stat_ellipse(data=subset(plot.dat, `abbv`=="HV"), color="#426081") +
  stat_ellipse(data=subset(plot.dat, `abbv`=="BG"), color="#CBB0CE") +
  # stat_ellipse(data=subset(plot.dat, grp!="Cibola" | grp!="Sevilleta" | grp!="Walker Ranch"),aes(x=LD1,y=LD2)) +
  #stat_ellipse(data=subset(plot.dat, grp=="Cibola"),aes(x=LD1,y=LD2), color="white") +
  #stat_ellipse(data=subset(plot.dat, grp=="Sevilleta"),aes(x=LD1,y=LD2), color="white") +
  #stat_ellipse(data=subset(plot.dat, grp=="Walker Ranch"),aes(x=LD1,y=LD2), color="white") +
  #stat_ellipse(data=subset(plot.dat, grp!="Cibola" | grp!="Sevilleta" | grp!="Walker Ranch"),aes(x=LD1,y=LD2), color="white") +
  geom_vline(xintercept = 0) + geom_hline(yintercept = 0) +
  geom_point(aes(color=legend.order),
             size=2.5) +
  labs(colour = "Site")
  #theme(legend.position = "none")
ggsave(file="Analysis/Genomics/Figures/BOGR_dapc.pdf",height = 6,width=8)

## proportions of successful reassignment (based on the discriminant functions) of individuals to their original clusters.
## Large values indicate clear-cut clusters, while low values suggest admixed groups.
summ.dapc <- summary(DAPC)
summ.dapc.assign <- summ.dapc$assign.per.pop
summ.dapc.assign
write.csv(summ.dapc.assign, file="Analysis/Genomics/Prop_pop_assignment.csv")

## indicate loci that differentiate the groups
rownames(DAPC$var.contr) <- gsub("denovoLocus","",rownames(DAPC$var.contr))
rownames(DAPC$var.contr) <- gsub(".A","",rownames(DAPC$var.contr))
rownames(DAPC$var.contr) <- gsub(".C","",rownames(DAPC$var.contr))
rownames(DAPC$var.contr) <- gsub(".T","",rownames(DAPC$var.contr))
rownames(DAPC$var.contr) <- gsub(".G","",rownames(DAPC$var.contr))
loci.loadings <- DAPC$var.contr
pdf(file="Analysis/Genomics/Figures/Loci_loadings.pdf",width=20,height=4)
loadingplot(loci.loadings, axis=2, thres=.004,main=NULL,xlab="Locus")
dev.off()
write.csv(loci.loadings, file="Analysis/Genomics/Loci_loadings.csv")

## "Structure"-like plot
## retain the first 16 discriminant functions (see DAPC above)
long.dat <- melt(DAPC$posterior); names(long.dat)[2] <- "pop"
write.csv(long.dat,"Analysis/Genomics/Structure.plot.data.csv")
long.dat <- read.csv("Analysis/Genomics/Structure.plot.data.ordered.csv",header=T)
gg2 <- 
  ggplot(data=long.dat, aes(x=as.factor(as.character(order)),y=value, fill=pop, group=column)) +
  geom_col(size=2) +  
  theme_classic() + scale_fill_manual(values = col.pal.v) +
  labs(fill = "Population") + xlab("Individual") + ylab("Membership probability") +
  theme(axis.line=element_blank(),
        axis.text.x=element_blank(),
        #axis.text.y=element_blank(),
        axis.ticks=element_blank())+
  theme_void() +
  theme(legend.position = "none")
ggsave(file="Analysis/Genomics/Figures/BOGR_membership_probabilities_wide.pdf",height = 1.5,width=10)


finalplot <- grid.arrange(gg1, gg2, nrow=2,heights=c(10, 2))
ggsave(finalplot,file="Analysis/Key_figures/DAPC_and_structure.jpg",height = 8,width=10)

dat <- as.data.frame(cbind(seq(1,40,1),seq(1,40,1)))
ggplot(data=dat, aes(x=V1,y=V2,fill=as.factor(V1))) +
  geom_tile() + scale_fill_manual(values=funky(40))



###
###
###
###
###
## repeat for just regions (for Nate analysis)
##
###
###
###
###
###
###

library(plyr)
col.pal <- read.csv("Analysis/color_key_alt.csv",header=T)
col.pal.v <- as.vector(col.pal[,3]) ; names(col.pal.v) <- col.pal[,2]
col.pal.names <- as.vector(col.pal[,2]) ; names(col.pal.names) <- col.pal[,6]
col.pal.colors <- as.vector(col.pal[,3]) ; names(col.pal.colors) <- col.pal[,6]

#get rid of walker ranch cause it is restored
genind.1clone.only$tab <- tab(genind.1clone.only, NA.method = "mean")
genind.nate <- genind.1clone.only[c(1:267)]
revalue(pop(genind.nate), c( "Wonderland"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Konza"="Kansas"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Cedar Point"="Nebraska"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Rabbit Mountain"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "SGS"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Kelsall"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Sevilleta"="New Mexico"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Cibola"="New Mexico"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Steele"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Beech Trail"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Andrus"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Heil Valley"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Davidson Mesa"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Rock Creek"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Comanche"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Buffalo Gap"="S. Dakota"))-> pop(genind.nate)

pdf("Analysis/Nate_genomics/Xval_plot_1.pdf",height=6,width=6)
xval <- xvalDapc(genind.nate$tab, pop(genind.nate), n.pca.max = 160, training.set = 0.9,
                 result = "groupMean", center = TRUE, scale = FALSE,
                 n.pca = NULL, n.rep = 300, xval.plot = TRUE, parallel = "multicore")
dev.off()
save(xval, file="Analysis/Nate_genomics/xval_1.R")
load(file="Analysis/Nate_genomics/xval_1.R")
DAPC <- xval$DAPC
DAPC$var
DAPC

## plot as groups
plot.dat <- as.data.frame(DAPC$ind.coord)
plot.dat <- cbind(plot.dat,DAPC$grp)
names(plot.dat)[5] <- "pop"
plot.dat <- merge(plot.dat,col.pal)
write.csv(plot.dat,file="Analysis/Nate_genomics/BOGR_dapc_dat_1.csv")
gg1 <- 
  ggplot(data=plot.dat, aes(x=LD1,y=LD2)) +  
  scale_color_manual(values = col.pal.colors, labels = col.pal.names) + 
  theme_classic() +
  geom_vline(xintercept = 0) + geom_hline(yintercept = 0) +
  geom_point(aes(color=legend.order),
             size=2.5) +
  labs(colour = "Site")
ggsave(file="Analysis/Nate_genomics/BOGR_dapc_1.pdf",height = 6,width=8)
summ.dapc <- summary(DAPC)
summ.dapc.assign <- summ.dapc$assign.per.pop
summ.dapc.assign
write.csv(summ.dapc.assign, file="Analysis/Nate_genomics/Prop_pop_assignment_1.csv")
long.dat <- melt(DAPC$posterior); names(long.dat)[2] <- "pop"
write.csv(long.dat,"Analysis/Nate_genomics/Structure.plot.data_1.csv")
long.dat <- read.csv("Analysis/Nate_genomics/Structure.plot.data_1.csv",header=T)
gg2 <- 
  ggplot(data=long.dat, aes(x=Var1,y=value, fill=pop)) +
  geom_col(size=2) +  
  theme_classic() + scale_fill_manual(values = col.pal.v) +
  labs(fill = "Population") + xlab("Individual") + ylab("Membership probability") +
  theme(axis.line=element_blank(),
        axis.text.x=element_blank(),
        #axis.text.y=element_blank(),
        axis.ticks=element_blank())+
  theme_void() +
  theme(legend.position = "none")
ggsave(file="Analysis/Nate_genomics/BOGR_membership_probabilities_wide_1.pdf",height = 1.5,width=10)
finalplot <- grid.arrange(gg1, gg2, nrow=2,heights=c(10, 2))
ggsave(finalplot,file="Analysis/Nate_genomics/DAPC_and_structure_1.jpg",height = 8,width=10)



# seperate out comanche
genind.1clone.only$tab <- tab(genind.1clone.only, NA.method = "mean")
genind.nate <- genind.1clone.only[c(1:267)]
revalue(pop(genind.nate), c( "Wonderland"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Konza"="Kansas"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Cedar Point"="Nebraska"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Rabbit Mountain"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "SGS"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Kelsall"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Sevilleta"="New Mexico"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Cibola"="New Mexico"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Steele"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Beech Trail"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Andrus"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Heil Valley"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Davidson Mesa"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Rock Creek"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Comanche"="S. Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Buffalo Gap"="S. Dakota"))-> pop(genind.nate)

pdf("Analysis/Nate_genomics/Xval_plot_2.pdf",height=6,width=6)
xval <- xvalDapc(genind.nate$tab, pop(genind.nate), n.pca.max = 160, training.set = 0.9,
                 result = "groupMean", center = TRUE, scale = FALSE,
                 n.pca = NULL, n.rep = 300, xval.plot = TRUE, parallel = "multicore")
dev.off()
save(xval, file="Analysis/Nate_genomics/xval_2.R")
load(file="Analysis/Nate_genomics/xval_2.R")
DAPC <- xval$DAPC
DAPC$var
DAPC

## plot as groups
plot.dat <- as.data.frame(DAPC$ind.coord)
plot.dat <- cbind(plot.dat,DAPC$grp)
names(plot.dat)[6] <- "pop"
plot.dat <- merge(plot.dat,col.pal)
write.csv(plot.dat,file="Analysis/Nate_genomics/BOGR_dapc_dat_2.csv")
gg1 <- 
  ggplot(data=plot.dat, aes(x=LD1,y=LD2)) +  
  scale_color_manual(values = col.pal.colors, labels = col.pal.names) + 
  theme_classic() +
  geom_vline(xintercept = 0) + geom_hline(yintercept = 0) +
  geom_point(aes(color=legend.order),
             size=2.5) +
  labs(colour = "Site")
ggsave(file="Analysis/Nate_genomics/BOGR_dapc_2.pdf",height = 6,width=8)
summ.dapc <- summary(DAPC)
summ.dapc.assign <- summ.dapc$assign.per.pop
summ.dapc.assign
write.csv(summ.dapc.assign, file="Analysis/Nate_genomics/Prop_pop_assignment_2.csv")
long.dat <- melt(DAPC$posterior); names(long.dat)[2] <- "pop"
write.csv(long.dat,"Analysis/Nate_genomics/Structure.plot.data_2.csv")
long.dat <- read.csv("Analysis/Nate_genomics/Structure.plot.data_2.csv",header=T)
gg2 <- 
  ggplot(data=long.dat, aes(x=Var1,y=value, fill=pop)) +
  geom_col(size=2) +  
  theme_classic() + scale_fill_manual(values = col.pal.v) +
  labs(fill = "Population") + xlab("Individual") + ylab("Membership probability") +
  theme(axis.line=element_blank(),
        axis.text.x=element_blank(),
        #axis.text.y=element_blank(),
        axis.ticks=element_blank())+
  theme_void() +
  theme(legend.position = "none")
ggsave(file="Analysis/Nate_genomics/BOGR_membership_probabilities_wide_2.pdf",height = 1.5,width=10)
finalplot <- grid.arrange(gg1, gg2, nrow=2,heights=c(10, 2))
ggsave(finalplot,file="Analysis/Nate_genomics/DAPC_and_structure_2.jpg",height = 8,width=10)



# Just colorado and NM
genind.1clone.only$tab <- tab(genind.1clone.only, NA.method = "mean")
genind.nate <- genind.1clone.only[c(1:29,46:96,113:157,174:267)]
revalue(pop(genind.nate), c( "Wonderland"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Rabbit Mountain"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "SGS"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Kelsall"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Sevilleta"="New Mexico"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Cibola"="New Mexico"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Steele"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Beech Trail"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Andrus"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Heil Valley"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Davidson Mesa"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Rock Creek"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Comanche"="S. Colorado"))-> pop(genind.nate)

pdf("Analysis/Nate_genomics/Xval_plot_3.pdf",height=6,width=6)
xval <- xvalDapc(genind.nate$tab, pop(genind.nate), n.pca.max = 160, training.set = 0.9,
                 result = "groupMean", center = TRUE, scale = FALSE,
                 n.pca = NULL, n.rep = 300, xval.plot = TRUE, parallel = "multicore")
dev.off()
save(xval, file="Analysis/Nate_genomics/xval_3.R")
load(file="Analysis/Nate_genomics/xval_3.R")
DAPC <- xval$DAPC
DAPC$var
DAPC


## plot as groups
plot.dat <- as.data.frame(DAPC$ind.coord)
plot.dat <- cbind(plot.dat,DAPC$grp)
names(plot.dat)[3] <- "pop"
plot.dat <- merge(plot.dat,col.pal)
write.csv(plot.dat,file="Analysis/Nate_genomics/BOGR_dapc_dat_3.csv")
gg1 <- 
  ggplot(data=plot.dat, aes(x=LD1,y=LD2)) +  
  scale_color_manual(values = col.pal.colors, labels = col.pal.names) + 
  theme_classic() +
  geom_vline(xintercept = 0) + geom_hline(yintercept = 0) +
  geom_point(aes(color=legend.order),
             size=2.5) +
  labs(colour = "Site")
ggsave(file="Analysis/Nate_genomics/BOGR_dapc_3.pdf",height = 6,width=8)
summ.dapc <- summary(DAPC)
summ.dapc.assign <- summ.dapc$assign.per.pop
summ.dapc.assign
write.csv(summ.dapc.assign, file="Analysis/Nate_genomics/Prop_pop_assignment_3.csv")
long.dat <- melt(DAPC$posterior); names(long.dat)[2] <- "pop"
write.csv(long.dat,"Analysis/Nate_genomics/Structure.plot.data_3.csv")
long.dat <- read.csv("Analysis/Nate_genomics/Structure.plot.data_3.csv",header=T)
gg2 <- 
  ggplot(data=long.dat, aes(x=Var1,y=value, fill=pop)) +
  geom_col(size=2) +  
  theme_classic() + scale_fill_manual(values = col.pal.v) +
  labs(fill = "Population") + xlab("Individual") + ylab("Membership probability") +
  theme(axis.line=element_blank(),
        axis.text.x=element_blank(),
        #axis.text.y=element_blank(),
        axis.ticks=element_blank())+
  theme_void() +
  theme(legend.position = "none")
ggsave(file="Analysis/Nate_genomics/BOGR_membership_probabilities_wide_3.pdf",height = 1.5,width=10)
finalplot <- grid.arrange(gg1, gg2, nrow=2,heights=c(10, 2))
ggsave(finalplot,file="Analysis/Nate_genomics/DAPC_and_structure_3.jpg",height = 8,width=10)

# Just colorado and NM
genind.1clone.only$tab <- tab(genind.1clone.only, NA.method = "mean")
genind.nate <- genind.1clone.only[c(1:29,46:96,113:157,174:267)]
revalue(pop(genind.nate), c( "Wonderland"="Boulder"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Rabbit Mountain"="Boulder"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "SGS"=" "))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Kelsall"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Sevilleta"="New Mexico"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Cibola"="New Mexico"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Steele"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Beech Trail"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Andrus"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Heil Valley"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Davidson Mesa"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Rock Creek"="Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Comanche"="S. Colorado"))-> pop(genind.nate)
revalue(pop(genind.nate), c( "Buffalo Gap"="S. Dakota"))-> pop(genind.nate)

pdf("Analysis/Nate_genomics/Xval_plot_4.pdf",height=6,width=6)
xval <- xvalDapc(genind.nate$tab, pop(genind.nate), n.pca.max = 160, training.set = 0.9,
                 result = "groupMean", center = TRUE, scale = FALSE,
                 n.pca = NULL, n.rep = 300, xval.plot = TRUE, parallel = "multicore")
dev.off()
save(xval, file="Analysis/Nate_genomics/xval_4.R")
load(file="Analysis/Nate_genomics/xval_4.R")
DAPC <- xval$DAPC
DAPC$var
DAPC


## plot as groups
plot.dat <- as.data.frame(DAPC$ind.coord)
plot.dat <- cbind(plot.dat,DAPC$grp)
names(plot.dat)[3] <- "pop"
plot.dat <- merge(plot.dat,col.pal)
write.csv(plot.dat,file="Analysis/Nate_genomics/BOGR_dapc_dat_4.csv")
gg1 <- 
  ggplot(data=plot.dat, aes(x=LD1,y=LD2)) +  
  scale_color_manual(values = col.pal.colors, labels = col.pal.names) + 
  theme_classic() +
  geom_vline(xintercept = 0) + geom_hline(yintercept = 0) +
  geom_point(aes(color=legend.order),
             size=2.5) +
  labs(colour = "Site")
ggsave(file="Analysis/Nate_genomics/BOGR_dapc_4.pdf",height = 6,width=8)
summ.dapc <- summary(DAPC)
summ.dapc.assign <- summ.dapc$assign.per.pop
summ.dapc.assign
write.csv(summ.dapc.assign, file="Analysis/Nate_genomics/Prop_pop_assignment_4.csv")
long.dat <- melt(DAPC$posterior); names(long.dat)[2] <- "pop"
write.csv(long.dat,"Analysis/Nate_genomics/Structure.plot.data_4.csv")
long.dat <- read.csv("Analysis/Nate_genomics/Structure.plot.data_4.csv",header=T)
gg2 <- 
  ggplot(data=long.dat, aes(x=Var1,y=value, fill=pop)) +
  geom_col(size=2) +  
  theme_classic() + scale_fill_manual(values = col.pal.v) +
  labs(fill = "Population") + xlab("Individual") + ylab("Membership probability") +
  theme(axis.line=element_blank(),
        axis.text.x=element_blank(),
        #axis.text.y=element_blank(),
        axis.ticks=element_blank())+
  theme_void() +
  theme(legend.position = "none")
ggsave(file="Analysis/Nate_genomics/BOGR_membership_probabilities_wide_4.pdf",height = 1.5,width=10)
finalplot <- grid.arrange(gg1, gg2, nrow=2,heights=c(10, 2))
ggsave(finalplot,file="Analysis/Nate_genomics/DAPC_and_structure_4.jpg",height = 8,width=10)

###
###
###
###
## repeat for just Boulder and some regional (SEV, CIB, WR excluded)
##
###
###
###
###
###
###

library(plyr)
col.pal <- read.csv("Analysis/color_key.csv",header=T)
col.pal.v <- as.vector(col.pal[,3]) ; names(col.pal.v) <- col.pal[,2]
col.pal.names <- as.vector(col.pal[,2]) ; names(col.pal.names) <- col.pal[,6]
col.pal.colors <- as.vector(col.pal[,3]) ; names(col.pal.colors) <- col.pal[,6]

#get rid of walker ranch cause it is restored
genind.1clone.only$tab <- tab(genind.1clone.only, NA.method = "mean")
#genind.boulder <- genind.1clone.only[c(13:29,46:62,113:157,174:203,237:267)]
genind.boulder <- genind.1clone.only[c(1:62,80:203,221:267)]


pop(genind.boulder)

pdf("Analysis/Boulder_genomics/Xval_plot_1.pdf",height=6,width=6)
xval <- xvalDapc(genind.boulder$tab, pop(genind.boulder), n.pca.max = 160, training.set = 0.9,
                 result = "groupMean", center = TRUE, scale = FALSE,
                 n.pca = NULL, n.rep = 300, xval.plot = TRUE, parallel = "multicore")
dev.off()
save(xval, file="Analysis/Boulder_genomics/xval_1.R")
load(file="Analysis/Boulder_genomics/xval_1.R")
DAPC <- xval$DAPC
DAPC$var
DAPC

## plot as groups
plot.dat <- as.data.frame(DAPC$ind.coord)
plot.dat <- cbind(plot.dat,DAPC$grp)
names(plot.dat)[14] <- "pop"
plot.dat <- merge(plot.dat,col.pal)
write.csv(plot.dat,file="Analysis/Boulder_genomics/BOGR_dapc_dat_1.csv")
gg1 <- 
  ggplot(data=plot.dat, aes(x=LD1,y=LD2)) +  
  scale_color_manual(values = col.pal.colors, labels = col.pal.names) + 
  theme_classic() +
  geom_vline(xintercept = 0) + geom_hline(yintercept = 0) +
  geom_point(aes(color=legend.order),
             size=2.5) +
  labs(colour = "Site")
ggsave(file="Analysis/Boulder_genomics/BOGR_dapc_1.pdf",height = 6,width=8)
summ.dapc <- summary(DAPC)
summ.dapc.assign <- summ.dapc$assign.per.pop
summ.dapc.assign
write.csv(summ.dapc.assign, file="Analysis/Boulder_genomics/Prop_pop_assignment_1.csv")
long.dat <- melt(DAPC$posterior); names(long.dat)[2] <- "pop"
write.csv(long.dat,"Analysis/Boulder_genomics/Structure.plot.data_1.csv")
long.dat <- read.csv("Analysis/Boulder_genomics/Structure.plot.data_1.ordered.csv",header=T)
gg2 <- 
  ggplot(data=long.dat, aes(x=Var1,y=value, fill=pop)) +
  #ggplot(data=long.dat, aes(x=as.factor(as.character(order)),y=value, fill=pop, group=column)) +
  geom_col(size=2) +  
  theme_classic() + scale_fill_manual(values = col.pal.v) +
  labs(fill = "Population") + xlab("Individual") + ylab("Membership probability") +
  theme(axis.line=element_blank(),
        axis.text.x=element_blank(),
        #axis.text.y=element_blank(),
        axis.ticks=element_blank())+
  theme_void() +
  theme(legend.position = "none")
ggsave(file="Analysis/Boulder_genomics/BOGR_membership_probabilities_wide_1.pdf",height = 1.5,width=10)
finalplot <- grid.arrange(gg1, gg2, nrow=2,heights=c(10, 2))
ggsave(finalplot,file="Analysis/Boulder_genomics/DAPC_and_structure_1.jpg",height = 8,width=10)

###
###
###
###
## repeat with Boulder pooled
##
###
###
###
###
###
###

library(plyr)
col.pal <- read.csv("Analysis/color_key_alt.csv",header=T)
col.pal.v <- as.vector(col.pal[,3]) ; names(col.pal.v) <- col.pal[,2]
col.pal.names <- as.vector(col.pal[,2]) ; names(col.pal.names) <- col.pal[,6]
col.pal.colors <- as.vector(col.pal[,3]) ; names(col.pal.colors) <- col.pal[,6]

genind.1clone.only$tab <- tab(genind.1clone.only, NA.method = "mean")
genind.boulderpooled <- genind.1clone.only
revalue(pop(genind.boulderpooled), c( "Wonderland"="Boulder"))-> pop(genind.boulderpooled)
revalue(pop(genind.boulderpooled), c( "Rabbit Mountain"="Boulder"))-> pop(genind.boulderpooled)
revalue(pop(genind.boulderpooled), c( "Kelsall"="Boulder"))-> pop(genind.boulderpooled)
revalue(pop(genind.boulderpooled), c( "Steele"="Boulder"))-> pop(genind.boulderpooled)
revalue(pop(genind.boulderpooled), c( "Beech Trail"="Boulder"))-> pop(genind.boulderpooled)
revalue(pop(genind.boulderpooled), c( "Andrus"="Boulder"))-> pop(genind.boulderpooled)
revalue(pop(genind.boulderpooled), c( "Heil Valley"="Boulder"))-> pop(genind.boulderpooled)
revalue(pop(genind.boulderpooled), c( "Davidson Mesa"="Boulder"))-> pop(genind.boulderpooled)
revalue(pop(genind.boulderpooled), c( "Rock Creek"="Boulder"))-> pop(genind.boulderpooled)
pop(genind.boulderpooled)

pdf("Analysis/Genomics/Xval_plot_boulderpooled.pdf",height=6,width=6)
xval <- xvalDapc(genind.boulderpooled$tab, pop(genind.boulderpooled), n.pca.max = 160, training.set = 0.9,
                 result = "groupMean", center = TRUE, scale = FALSE,
                 n.pca = NULL, n.rep = 100, xval.plot = TRUE, parallel = "multicore")
dev.off()
save(xval, file="Analysis/Genomics/xval_boulderpooled.R")
load(file="Analysis/Genomics/xval_boulderpooled.R")
DAPC <- xval$DAPC
DAPC$var
DAPC

## plot as groups
plot.dat <- as.data.frame(DAPC$ind.coord)
plot.dat <- cbind(plot.dat,DAPC$grp)
names(plot.dat)[9] <- "pop"
plot.dat <- merge(plot.dat,col.pal)
write.csv(plot.dat,file="Analysis/Genomics/BOGR_dapc_dat_boulderpooled.csv")
gg1 <- 
  ggplot(data=plot.dat, aes(x=LD1,y=LD2)) +  
  scale_color_manual(values = col.pal.colors, labels = col.pal.names) + 
  theme_classic() +
  geom_vline(xintercept = 0) + geom_hline(yintercept = 0) +
  geom_point(aes(color=legend.order),
             size=2.5) +
  labs(colour = "Site")
ggsave(file="Analysis/Genomics/BOGR_dapc_boulderpooled.pdf",height = 6,width=8)
summ.dapc <- summary(DAPC)
summ.dapc.assign <- summ.dapc$assign.per.pop
summ.dapc.assign
write.csv(summ.dapc.assign, file="Analysis/Genomics/Prop_pop_assignment_boulderpooled.csv")
long.dat <- melt(DAPC$posterior); names(long.dat)[2] <- "pop"
write.csv(long.dat,"Analysis/Genomics/Structure.plot.data_boulderpooled.csv")
long.dat <- read.csv("Analysis/Genomics/Structure.plot.data_boulderpooled.csv",header=T)
gg2 <- 
  ggplot(data=long.dat, aes(x=Var1,y=value, fill=pop)) +
  geom_col(size=2) +  
  theme_classic() + scale_fill_manual(values = col.pal.v) +
  labs(fill = "Population") + xlab("Individual") + ylab("Membership probability") +
  theme(axis.line=element_blank(),
        axis.text.x=element_blank(),
        #axis.text.y=element_blank(),
        axis.ticks=element_blank())+
  theme_void() +
  theme(legend.position = "none")
ggsave(file="Analysis/Genomics/BOGR_membership_probabilities_wide_boulderpooled.pdf",height = 1.5,width=10)
finalplot <- grid.arrange(gg1, gg2, nrow=2,heights=c(10, 2))
ggsave(finalplot,file="Analysis/Genomics/DAPC_and_structure_boulderpooled.jpg",height = 8,width=10)







}

###########################################################################################
###########################################################################################
## run.3.1
## 
## Determine which climate vars are important for determining trait differences, using
## ALL SUBSETS LINEAR REGRESSION
## http://www.stat.columbia.edu/~madigan/W2025/notes/linear.pdf
###########################################################################################
###########################################################################################

if(run.3.1 == "yes")
  {
#############################################################################################
## load libs
library(ggplot2)
library(adegenet)  
library(reshape2)
library(leaps)
  
  
  ## Long term drought severity
  ###########################################################################################
  #-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
  ## https://www.ncdc.noaa.gov/monitoring-references/maps/images/us-climate-divisions-names.jpg
  ## https://www1.ncdc.noaa.gov/pub/data/cirs/climdiv/
  #-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
  long.clim.dat <- read.csv("data/long_term_climate/PDHI.csv")
  long.clim.dat <- long.clim.dat[!(long.clim.dat$year == 2018),] ## year 2018 incomplete and needs to be removed
  long.clim.dat <- long.clim.dat[!(long.clim.dat$year == 2017),] ## year 2017 post data collection
  long.clim.dat <- long.clim.dat[!(long.clim.dat$year == 2016),] ## year 2016 post data collection
  long.clim.dat <- long.clim.dat[!(long.clim.dat$year > 1976),]
  melted <- melt(long.clim.dat, id.vars = c(1:5))
  
  plot.dat <- subset(melted, pop == "A" | pop == "BG" | pop == "CIB" | pop == "CO" | pop == "CP" | pop == "KNZ")
  aggregate(.~pop,data=plot.dat, FUN=median)
  plot.dat <- subset(plot.dat, variable == "may" | variable == "jun" | variable == "jul" | variable == "aug" | variable == "sep")
 plot.dat <- subset(plot.dat, value <= -4)
  
  nrow(subset(plot.dat, pop == "A"))
  nrow(subset(plot.dat, pop == "BG"))
  nrow(subset(plot.dat, pop == "CIB"))
  nrow(subset(plot.dat, pop == "CO"))
  nrow(subset(plot.dat, pop == "CP"))
  nrow(subset(plot.dat, pop == "KNZ"))
  
  ggplot(data = plot.dat) +
    geom_density(aes(x=value,fill=variable), alpha = 0.5) +
    facet_grid(.~pop)
  ###########################################################################################
  #-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#


  
## traits and plasticity  
    
do.regsubsets <- function(infile,trait.name){
  setwd(wd)
  dat <- read.csv(infile)
  trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
  site.dat <- read.csv("Analysis/SITE_DATA.csv")
  site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
  full.dat <- cbind(trait.dat,site.dat.traits)
  part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                          "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
  leaps.dat <- regsubsets(mean~.,data=part.dat)
  sum.leaps <- summary(leaps.dat)
  write.csv(sum.leaps$adjr2, file=paste("Analysis/climate/traits/",trait.name,"adjr2.csv",sep="") )
  pdf(file=paste("Analysis/climate/traits/",trait.name,"all-subsets-regression.pdf",sep=""), height=4, width=4)
  par(cex.axis=0.5)
  plot(leaps.dat)
  dev.off()
  par(cex.axis=1)
}

do.regsubsets(infile = "Analysis/posterior_output/\ Total\ Biomass\ .csv", trait.name = "Total_Biomass_" )
do.regsubsets(infile = "Analysis/posterior_output/\ Root\ to\ shoot\ biomass\ ratio\ .csv", trait.name = "Root_to_Shoot_Ratio_" )
do.regsubsets(infile = "Analysis/posterior_output/\ avg_midday_mpa_expt\ .csv", trait.name = "Midday water potential_" )
do.regsubsets(infile = "Analysis/posterior_output/\ avg_predawn_mpa_expt\ .csv", trait.name = "Predawn water potential_" )
do.regsubsets(infile = "Analysis/posterior_output/\ max_height\ .csv", trait.name = "Maximum Height_" )
do.regsubsets(infile = "Analysis/posterior_output/\ flwr_avg_ind_mass\ .csv", trait.name = "Average Individual Flower Mass_" )
do.regsubsets(infile = "Analysis/posterior_output/\ flwr_avg_ind_len\ .csv", trait.name = "Average Individual Flower Length_" )
do.regsubsets(infile = "Analysis/posterior_output/\ flwr_count_1.2\ .csv", trait.name = "Flower Count_" )
do.regsubsets(infile = "Analysis/posterior_output/\ flwr_mass_lifetime\ .csv", trait.name = "Lifetime Flowering Mass_" )
do.regsubsets(infile = "Analysis/posterior_output/\ biomass_rhizome\ .csv", trait.name = "Rhizome Biomass_" )
do.regsubsets(infile = "Analysis/posterior_output/\ biomass_belowground\ .csv", trait.name = "Belowground Biomass_" )
do.regsubsets(infile = "Analysis/posterior_output/\ biomass_aboveground\ .csv", trait.name = "Aboveground Biomass_" )

## test for p values for all best subsets
{
infile = "Analysis/posterior_output/\ Total\ Biomass\ .csv"
dat <- read.csv(infile)
trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
site.dat <- read.csv("Analysis/SITE_DATA.csv")
site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
full.dat <- cbind(trait.dat,site.dat.traits)
part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                        "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
summary(lm(mean~
             annual_mean_temp+
             #mean_diurnal_temp_range+
             #temperature_seasonality+
             #max_temp_warmest_month+
             #min_temp_coldest_month+
             mean_temp_driest_quarter+
             annual_precip+
             precip_seasonality+
             annual_AI_CGIAR+
             #PDHI_exep_drt_months_year+
             median_year_PDHI
           ,data=part.dat))

infile = "Analysis/posterior_output/\ Root\ to\ shoot\ biomass\ ratio\ .csv"
dat <- read.csv(infile)
trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
site.dat <- read.csv("Analysis/SITE_DATA.csv")
site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
full.dat <- cbind(trait.dat,site.dat.traits)
part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                        "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
summary(lm(mean~
             #annual_mean_temp+
             mean_diurnal_temp_range+
             #temperature_seasonality+
             max_temp_warmest_month+
             #min_temp_coldest_month+
             mean_temp_driest_quarter+
             annual_precip+
             precip_seasonality+
             annual_AI_CGIAR+
             PDHI_exep_drt_months_year+
             median_year_PDHI
           ,data=part.dat))

infile = "Analysis/posterior_output/\ avg_midday_mpa_expt\ .csv"
dat <- read.csv(infile)
trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
site.dat <- read.csv("Analysis/SITE_DATA.csv")
site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
full.dat <- cbind(trait.dat,site.dat.traits)
part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                        "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
summary(lm(mean~
             annual_mean_temp+
             #mean_diurnal_temp_range+
             temperature_seasonality+
             max_temp_warmest_month+
             #min_temp_coldest_month+
             #mean_temp_driest_quarter+
             #annual_precip+
             #precip_seasonality+
             #annual_AI_CGIAR+
             PDHI_exep_drt_months_year
             #median_year_PDHI
           ,data=part.dat))

infile = "Analysis/posterior_output/\ avg_predawn_mpa_expt\ .csv"
dat <- read.csv(infile)
trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
site.dat <- read.csv("Analysis/SITE_DATA.csv")
site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
full.dat <- cbind(trait.dat,site.dat.traits)
part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                        "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
summary(lm(mean~
             #annual_mean_temp+
             mean_diurnal_temp_range+
             #temperature_seasonality+
             #max_temp_warmest_month+
             #min_temp_coldest_month+
             mean_temp_driest_quarter
             #annual_precip+
             #precip_seasonality+
             #annual_AI_CGIAR+
             #PDHI_exep_drt_months_year+
             #median_year_PDHI
           ,data=part.dat))

infile = "Analysis/posterior_output/\ max_height\ .csv"
dat <- read.csv(infile)
trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
site.dat <- read.csv("Analysis/SITE_DATA.csv")
site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
full.dat <- cbind(trait.dat,site.dat.traits)
part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                        "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
summary(lm(mean~
             annual_mean_temp+
             #mean_diurnal_temp_range+
             #temperature_seasonality+
             #max_temp_warmest_month+
             min_temp_coldest_month+
             #mean_temp_driest_quarter+
             #annual_precip+
             precip_seasonality
             #annual_AI_CGIAR
             #PDHI_exep_drt_months_year+
             #median_year_PDHI
           ,data=part.dat))

infile = "Analysis/posterior_output/\ flwr_avg_ind_mass\ .csv"
dat <- read.csv(infile)
trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
site.dat <- read.csv("Analysis/SITE_DATA.csv")
site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
full.dat <- cbind(trait.dat,site.dat.traits)
part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                        "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
summary(lm(mean~
             #annual_mean_temp+
             #mean_diurnal_temp_range+
             #temperature_seasonality+
             #max_temp_warmest_month+
             #min_temp_coldest_month+
             #mean_temp_driest_quarter+
             #annual_precip+
             precip_seasonality
             #annual_AI_CGIAR+
             #PDHI_exep_drt_months_year+
             #median_year_PDHI
           ,data=part.dat))

infile = "Analysis/posterior_output/\ flwr_avg_ind_len\ .csv"
dat <- read.csv(infile)
trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
site.dat <- read.csv("Analysis/SITE_DATA.csv")
site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
full.dat <- cbind(trait.dat,site.dat.traits)
part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                        "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
summary(lm(mean~
             #annual_mean_temp+
             #mean_diurnal_temp_range+
             temperature_seasonality
             #max_temp_warmest_month+
             #min_temp_coldest_month+
             #mean_temp_driest_quarter+
             #annual_precip+
             #precip_seasonality
           #annual_AI_CGIAR+
           #PDHI_exep_drt_months_year+
           #median_year_PDHI
           ,data=part.dat))

infile = "Analysis/posterior_output/\ flwr_count_1.2\ .csv"
dat <- read.csv(infile)
trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
site.dat <- read.csv("Analysis/SITE_DATA.csv")
site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
full.dat <- cbind(trait.dat,site.dat.traits)
part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                        "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
summary(lm(mean~
             #annual_mean_temp+
             #mean_diurnal_temp_range+
             #temperature_seasonality
             max_temp_warmest_month+
           #min_temp_coldest_month+
           #mean_temp_driest_quarter+
           annual_precip
           #precip_seasonality
           #annual_AI_CGIAR+
           #PDHI_exep_drt_months_year+
           #median_year_PDHI
           ,data=part.dat))

infile = "Analysis/posterior_output/\ flwr_mass_lifetime\ .csv"
dat <- read.csv(infile)
trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
site.dat <- read.csv("Analysis/SITE_DATA.csv")
site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
full.dat <- cbind(trait.dat,site.dat.traits)
part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                        "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
summary(lm(mean~
             annual_mean_temp+
             mean_diurnal_temp_range+
             #temperature_seasonality
             max_temp_warmest_month+
             #min_temp_coldest_month+
             mean_temp_driest_quarter+
             annual_precip+
           #precip_seasonality
           annual_AI_CGIAR+
           PDHI_exep_drt_months_year+
           median_year_PDHI
           ,data=part.dat))

infile = "Analysis/posterior_output/\ biomass_rhizome\ .csv"
dat <- read.csv(infile)
trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
site.dat <- read.csv("Analysis/SITE_DATA.csv")
site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
full.dat <- cbind(trait.dat,site.dat.traits)
part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                        "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
summary(lm(mean~
             annual_mean_temp+
             #mean_diurnal_temp_range+
             #temperature_seasonality
             #max_temp_warmest_month+
             #min_temp_coldest_month+
             #mean_temp_driest_quarter+
             annual_precip+
             #precip_seasonality
             annual_AI_CGIAR
             #PDHI_exep_drt_months_year+
             #median_year_PDHI
           ,data=part.dat))

infile = "Analysis/posterior_output/\ biomass_aboveground\ .csv"
dat <- read.csv(infile)
trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
site.dat <- read.csv("Analysis/SITE_DATA.csv")
site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
full.dat <- cbind(trait.dat,site.dat.traits)
part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                        "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
summary(lm(mean~
             annual_mean_temp+
             #mean_diurnal_temp_range+
             #temperature_seasonality
             max_temp_warmest_month+
             min_temp_coldest_month+
             mean_temp_driest_quarter+
             annual_precip+
             #precip_seasonality
             annual_AI_CGIAR
           #PDHI_exep_drt_months_year+
           #median_year_PDHI
           ,data=part.dat))

infile = "Analysis/posterior_output/\ biomass_belowground\ .csv"
dat <- read.csv(infile)
trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
site.dat <- read.csv("Analysis/SITE_DATA.csv")
site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
full.dat <- cbind(trait.dat,site.dat.traits)
part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                        "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
summary(lm(mean~
             annual_mean_temp+
             #mean_diurnal_temp_range+
             #temperature_seasonality
             #max_temp_warmest_month+
             #min_temp_coldest_month+
             mean_temp_driest_quarter+
             annual_precip+
             precip_seasonality+
             annual_AI_CGIAR+
           #PDHI_exep_drt_months_year+
           median_year_PDHI
           ,data=part.dat))
}


do.regsubsets.plasticity <- function(infile,trait.name){
  setwd(wd)
  dat <- read.csv(infile)
  trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
  site.dat <- read.csv("Analysis/SITE_DATA.csv")
  site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
  full.dat <- cbind(trait.dat,site.dat.traits)
  part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                          "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
  leaps.dat <- regsubsets(mean~.,data=part.dat)
  sum.leaps <- summary(leaps.dat)
  write.csv(sum.leaps$adjr2, file=paste("Analysis/climate/plasticity/",trait.name,"adjr2.csv",sep="") )
  pdf(file=paste("Analysis/climate/plasticity/",trait.name,"all-subsets-regression.pdf",sep=""), height=4, width=4)
  par(cex.axis=0.5)
  plot(leaps.dat)
  dev.off()
  par(cex.axis=1)
}

do.regsubsets.plasticity(infile = "Analysis/posterior_output_plasticity/\ Total\ Biomass\ .csv", trait.name = "Total_Biomass_" )
do.regsubsets.plasticity(infile = "Analysis/posterior_output_plasticity/\ Root\ to\ shoot\ biomass\ ratio\ .csv", trait.name = "Root_to_Shoot_Ratio_" )
do.regsubsets.plasticity(infile = "Analysis/posterior_output_plasticity/\ avg_midday_mpa_expt\ .csv", trait.name = "Midday water potential_" )
do.regsubsets.plasticity(infile = "Analysis/posterior_output_plasticity/\ avg_predawn_mpa_expt\ .csv", trait.name = "Predawn water potential_" )
do.regsubsets.plasticity(infile = "Analysis/posterior_output_plasticity/\ max_height\ .csv", trait.name = "Maximum Height_" )
do.regsubsets.plasticity(infile = "Analysis/posterior_output_plasticity/\ flwr_avg_ind_mass\ .csv", trait.name = "Average Individual Flower Mass_" )
do.regsubsets.plasticity(infile = "Analysis/posterior_output_plasticity/\ flwr_avg_ind_len\ .csv", trait.name = "Average Individual Flower Length_" )
do.regsubsets.plasticity(infile = "Analysis/posterior_output_plasticity/\ flwr_count_1.2\ .csv", trait.name = "Flower Count_" )
do.regsubsets.plasticity(infile = "Analysis/posterior_output_plasticity/\ flwr_mass_lifetime\ .csv", trait.name = "Lifetime Flowering Mass_" )
do.regsubsets.plasticity(infile = "Analysis/posterior_output_plasticity/\ biomass_rhizome\ .csv", trait.name = "Rhizome Biomass_" )
do.regsubsets.plasticity(infile = "Analysis/posterior_output_plasticity/\ biomass_belowground\ .csv", trait.name = "Belowground Biomass_" )
do.regsubsets.plasticity(infile = "Analysis/posterior_output_plasticity/\ biomass_aboveground\ .csv", trait.name = "Aboveground Biomass_" )
do.regsubsets.plasticity(infile = "Analysis/posterior_output_plasticity/\ avg_mpa_difference\ .csv", trait.name = "Water Potential difference_" )

## test for p values for all best subsets, plasticity
{
  infile = "Analysis/posterior_output_plasticity/\ Total\ Biomass\ .csv"
  dat <- read.csv(infile)
  trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
  site.dat <- read.csv("Analysis/SITE_DATA.csv")
  site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
  full.dat <- cbind(trait.dat,site.dat.traits)
  part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                          "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
  summary(lm(mean~
               annual_mean_temp+
               #mean_diurnal_temp_range+
               temperature_seasonality+
               #max_temp_warmest_month+
               #min_temp_coldest_month+
               mean_temp_driest_quarter+
               annual_precip+
               #precip_seasonality+
               annual_AI_CGIAR+
             #PDHI_exep_drt_months_year+
             median_year_PDHI
             ,data=part.dat))
  
  infile = "Analysis/posterior_output_plasticity/\ Root\ to\ shoot\ biomass\ ratio\ .csv"
  dat <- read.csv(infile)
  trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
  site.dat <- read.csv("Analysis/SITE_DATA.csv")
  site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
  full.dat <- cbind(trait.dat,site.dat.traits)
  part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                          "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
  summary(lm(mean~
               #annual_mean_temp+
               mean_diurnal_temp_range+
               temperature_seasonality+
               #max_temp_warmest_month+
               #min_temp_coldest_month+
               #mean_temp_driest_quarter+
               annual_precip+
               precip_seasonality+
               #annual_AI_CGIAR+
               PDHI_exep_drt_months_year+
               median_year_PDHI
             ,data=part.dat))
  
  infile = "Analysis/posterior_output_plasticity/\ avg_midday_mpa_expt\ .csv"
  dat <- read.csv(infile)
  trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
  site.dat <- read.csv("Analysis/SITE_DATA.csv")
  site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
  full.dat <- cbind(trait.dat,site.dat.traits)
  part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                          "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
  summary(lm(mean~
               annual_mean_temp+
               mean_diurnal_temp_range+
               temperature_seasonality+
               #max_temp_warmest_month+
               min_temp_coldest_month+
               mean_temp_driest_quarter+
               #annual_precip+
               precip_seasonality+
               #annual_AI_CGIAR+
               PDHI_exep_drt_months_year+
             median_year_PDHI
             ,data=part.dat))
  
  infile = "Analysis/posterior_output_plasticity/\ avg_predawn_mpa_expt\ .csv"
  dat <- read.csv(infile)
  trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
  site.dat <- read.csv("Analysis/SITE_DATA.csv")
  site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
  full.dat <- cbind(trait.dat,site.dat.traits)
  part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                          "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
  summary(lm(mean~
               annual_mean_temp+
               mean_diurnal_temp_range+
               temperature_seasonality+
               #max_temp_warmest_month+
               min_temp_coldest_month+
               #mean_temp_driest_quarter
             #annual_precip+
             precip_seasonality+
             #annual_AI_CGIAR+
             PDHI_exep_drt_months_year+
             median_year_PDHI
             ,data=part.dat))
  
  infile = "Analysis/posterior_output_plasticity/\ max_height\ .csv"
  dat <- read.csv(infile)
  trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
  site.dat <- read.csv("Analysis/SITE_DATA.csv")
  site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
  full.dat <- cbind(trait.dat,site.dat.traits)
  part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                          "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
  summary(lm(mean~
               annual_mean_temp
             ,data=part.dat))
  
  infile = "Analysis/posterior_output_plasticity/\ flwr_avg_ind_mass\ .csv"
  dat <- read.csv(infile)
  trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
  site.dat <- read.csv("Analysis/SITE_DATA.csv")
  site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
  full.dat <- cbind(trait.dat,site.dat.traits)
  part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                          "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
  summary(lm(mean~
               #annual_mean_temp+
               #mean_diurnal_temp_range+
               #temperature_seasonality+
               #max_temp_warmest_month+
               #min_temp_coldest_month+
               #mean_temp_driest_quarter+
               annual_precip+
               #precip_seasonality
             annual_AI_CGIAR
             #PDHI_exep_drt_months_year+
             #median_year_PDHI
             ,data=part.dat))
  
  infile = "Analysis/posterior_output_plasticity/\ flwr_avg_ind_len\ .csv"
  dat <- read.csv(infile)
  trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
  site.dat <- read.csv("Analysis/SITE_DATA.csv")
  site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
  full.dat <- cbind(trait.dat,site.dat.traits)
  part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                          "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
  summary(lm(mean~
               #annual_mean_temp+
               #mean_diurnal_temp_range+
               temperature_seasonality+
             #max_temp_warmest_month+
             min_temp_coldest_month+
             #mean_temp_driest_quarter+
             annual_precip+
             #precip_seasonality
             annual_AI_CGIAR
             #PDHI_exep_drt_months_year+
             #median_year_PDHI
             ,data=part.dat))
  
  infile = "Analysis/posterior_output_plasticity/\ flwr_count_1.2\ .csv"
  dat <- read.csv(infile)
  trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
  site.dat <- read.csv("Analysis/SITE_DATA.csv")
  site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
  full.dat <- cbind(trait.dat,site.dat.traits)
  part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                          "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
  summary(lm(mean~
               #annual_mean_temp+
               #mean_diurnal_temp_range+
               #temperature_seasonality
               max_temp_warmest_month+
               #min_temp_coldest_month+
               #mean_temp_driest_quarter+
               annual_precip+
             #precip_seasonality+
             annual_AI_CGIAR+
             PDHI_exep_drt_months_year
             #median_year_PDHI
             ,data=part.dat))
  
  infile = "Analysis/posterior_output_plasticity/\ flwr_mass_lifetime\ .csv"
  dat <- read.csv(infile)
  trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
  site.dat <- read.csv("Analysis/SITE_DATA.csv")
  site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
  full.dat <- cbind(trait.dat,site.dat.traits)
  part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                          "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
  summary(lm(mean~
               #annual_mean_temp+
               #mean_diurnal_temp_range+
               temperature_seasonality+
               #max_temp_warmest_month+
               #min_temp_coldest_month+
               #mean_temp_driest_quarter+
               #annual_precip+
               precip_seasonality+
               #annual_AI_CGIAR+
               #PDHI_exep_drt_months_year+
               median_year_PDHI
             ,data=part.dat))
  
  infile = "Analysis/posterior_output_plasticity/\ biomass_rhizome\ .csv"
  dat <- read.csv(infile)
  trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
  site.dat <- read.csv("Analysis/SITE_DATA.csv")
  site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
  full.dat <- cbind(trait.dat,site.dat.traits)
  part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                          "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
  summary(lm(mean~
               #annual_mean_temp+
               mean_diurnal_temp_range
               #temperature_seasonality
               #max_temp_warmest_month+
               #min_temp_coldest_month
               #mean_temp_driest_quarter+
               #annual_precip+
               #precip_seasonality
               #annual_AI_CGIAR+
               #PDHI_exep_drt_months_year+
               #median_year_PDHI
             ,data=part.dat))
  
  infile = "Analysis/posterior_output_plasticity/\ biomass_aboveground\ .csv"
  dat <- read.csv(infile)
  trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
  site.dat <- read.csv("Analysis/SITE_DATA.csv")
  site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
  full.dat <- cbind(trait.dat,site.dat.traits)
  part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                          "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
  summary(lm(mean~
               #annual_mean_temp+
               #mean_diurnal_temp_range+
               temperature_seasonality+
               #max_temp_warmest_month+
               #min_temp_coldest_month
               #mean_temp_driest_quarter+
               annual_precip+
               precip_seasonality+
               #annual_AI_CGIAR
             #PDHI_exep_drt_months_year+
             median_year_PDHI
             ,data=part.dat))
  
  infile = "Analysis/posterior_output_plasticity/\ biomass_belowground\ .csv"
  dat <- read.csv(infile)
  trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
  site.dat <- read.csv("Analysis/SITE_DATA.csv")
  site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
  full.dat <- cbind(trait.dat,site.dat.traits)
  part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                          "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
  summary(lm(mean~
               #annual_mean_temp+
               mean_diurnal_temp_range+
               temperature_seasonality+
               #max_temp_warmest_month+
               #min_temp_coldest_month+
               #mean_temp_driest_quarter+
               #annual_precip+
               #precip_seasonality+
               #annual_AI_CGIAR+
               PDHI_exep_drt_months_year
               #median_year_PDHI
             ,data=part.dat))
}


#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
## repeat for single variables..

## hydroscape
dat <- read.csv("Analysis/hydroscape/hydroscape.csv")
site.dat <- read.csv("Analysis/SITE_DATA.csv")
full.dat <- cbind(dat,site.dat)
part.dat <- full.dat[,c("area","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                        "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
leaps.dat <- regsubsets(area~.,data=part.dat)
sum.leaps <- summary(leaps.dat)
write.csv(sum.leaps$adjr2, file="Analysis/climate/hydroscape/hydroscape_adjr2.csv")
pdf(file="Analysis/climate/hydroscape/hydroscape_all-subsets-regression.pdf", height=4, width=4)
par(cex.axis=0.5)
plot(leaps.dat)
dev.off()
par(cex.axis=1)

## genomics
dat <- read.csv("Analysis/Genomics/GENOMICS_BYSITE.CSV")
site.dat <- read.csv("Analysis/SITE_DATA.csv")
full.dat <- cbind(dat,site.dat)
part.dat <- full.dat[,c("eMLG","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                        "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
leaps.dat <- regsubsets(eMLG~.,data=part.dat)
sum.leaps <- summary(leaps.dat)
write.csv(sum.leaps$adjr2, file="Analysis/climate/genome/MLG_adjr2.csv")
pdf(file="Analysis/climate/genome/MLG_all-subsets-regression.pdf", height=4, width=4)
par(cex.axis=0.5)
plot(leaps.dat)
dev.off()
par(cex.axis=1)
## heterozygosity
part.dat <- full.dat[,c("Hexp","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                        "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
leaps.dat <- regsubsets(Hexp~.,data=part.dat)
sum.leaps <- summary(leaps.dat)
write.csv(sum.leaps$adjr2, file="Analysis/climate/genome/Hexp_adjr2.csv")
pdf(file="Analysis/climate/genome/Hexp_all-subsets-regression.pdf", height=4, width=4)
par(cex.axis=0.5)
plot(leaps.dat)
dev.off()
par(cex.axis=1)


{
  dat <- read.csv("Analysis/hydroscape/hydroscape.csv")
  site.dat <- read.csv("Analysis/SITE_DATA.csv")
  full.dat <- cbind(dat,site.dat)
  part.dat <- full.dat[,c("area","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                          "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
  summary(lm(area~
               #annual_mean_temp+
               mean_diurnal_temp_range+
               temperature_seasonality+
               max_temp_warmest_month+
               min_temp_coldest_month+
               #mean_temp_driest_quarter+
               annual_precip+
               #precip_seasonality+
               #annual_AI_CGIAR+
             PDHI_exep_drt_months_year+
             median_year_PDHI
             ,data=part.dat))
  dat <- read.csv("Analysis/Genomics/GENOMICS_BYSITE.CSV")
  site.dat <- read.csv("Analysis/SITE_DATA.csv")
  full.dat <- cbind(dat,site.dat)
  part.dat <- full.dat[,c("eMLG","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                          "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
  summary(lm(eMLG~
               annual_mean_temp ,data=part.dat))
  
  part.dat <- full.dat[,c("Hexp","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                          "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
  summary(lm(Hexp~
               #annual_mean_temp+
               #mean_diurnal_temp_range+
               #temperature_seasonality+
               #max_temp_warmest_month+
               #min_temp_coldest_month+
               mean_temp_driest_quarter+
               #annual_precip+
               precip_seasonality
               #annual_AI_CGIAR+
               #PDHI_exep_drt_months_year
             #median_year_PDHI
             ,data=part.dat))
}


}

###########################################################################################
###########################################################################################
## run.3.2
## 
## REGIONAL
## ALL SUBSETS LINEAR REGRESSION
## http://www.stat.columbia.edu/~madigan/W2025/notes/linear.pdf
###########################################################################################
###########################################################################################

if(run.3.2 == "yes")
{
  #############################################################################################
  ## load libs
  library(ggplot2)
  library(adegenet)  
  library(reshape2)
  library(leaps)
  
  
  ## Long term drought severity
  ###########################################################################################
  #-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
  ## https://www.ncdc.noaa.gov/monitoring-references/maps/images/us-climate-divisions-names.jpg
  ## https://www1.ncdc.noaa.gov/pub/data/cirs/climdiv/
  #-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
  
  ## traits and plasticity  

  bogr.data <- read.csv("Analysis/BOGR_DATA_master.csv",header=T)
  bogr.data[bogr.data == "no pot"] <- NA # any unknown or unid'd locihttps://gist.github.com/thigm85/8424654 have a 'NA'
  bogr.data[bogr.data == "met"] <- NA # any unknown or unid'd loci have a 'NA'
  bogr.data[bogr.data == "tr"] <- NA # any unknown or unid'd loci have a 'NA'
  ## then these need to be numeric..
  bogr.data$biomass_aboveground <- as.numeric(as.character(bogr.data$biomass_aboveground))
  bogr.data$biomass_belowground <- as.numeric(as.character(bogr.data$biomass_belowground))
  bogr.data$biomass_rhizome <- as.numeric(as.character(bogr.data$biomass_rhizome))
  # derived vars
  bogr.data$root_shoot <- (bogr.data$biomass_belowground + bogr.data$biomass_rhizome) / bogr.data$biomass_aboveground
  bogr.data$biomass_total <- bogr.data$biomass_belowground + bogr.data$biomass_rhizome + bogr.data$biomass_aboveground + bogr.data$flwr_mass_lifetime
  
  ## 
  
  dosubsets <- function(trait){
  site.dat <- read.csv("Analysis/SITE_DATA.csv")
  full.dat <- merge(bogr.data,site.dat)
  full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
  part.dat <- full.dat[,c(trait,"trt","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                          "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
  names(part.dat)[1] <- "trait_noquotes"
  leaps.dat <- regsubsets(trait_noquotes~.,data=part.dat)
  sum.leaps <- summary(leaps.dat)
  write.csv(sum.leaps$adjr2, file=paste("Analysis/climate/traits/regional/",trait,"adjr2.csv",sep="") )
  pdf(file=paste("Analysis/climate/traits/regional/",trait,"all-subsets-regression.pdf",sep=""), height=4, width=4)
  par(cex.axis=0.5)
  plot(leaps.dat)
  dev.off()
  par(cex.axis=1)
  }
  
  dosubsets("biomass_total")
  dosubsets("root_shoot")
  dosubsets("biomass_aboveground")
  dosubsets("biomass_belowground")
  dosubsets("biomass_rhizome")
  dosubsets("flwr_mass_lifetime")
  dosubsets("flwr_count_1.2")
  dosubsets("flwr_avg_ind_len")
  dosubsets("flwr_avg_ind_mass")
  dosubsets("max_height")
  dosubsets("avg_predawn_mpa_expt")
  dosubsets("avg_midday_mpa_expt")
  
  
  ## test for p values for all best subsets
  {
    trait <- "biomass_total"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"trt","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 trt+
                 #annual_mean_temp+
                 #mean_diurnal_temp_range+
                 #temperature_seasonality+
                 #max_temp_warmest_month+
                 #min_temp_coldest_month+
                 #mean_temp_driest_quarter+
                 #annual_precip+
                 #precip_seasonality+
                 #annual_AI_CGIAR+
                 #PDHI_exep_drt_months_year+
                 median_year_PDHI
               ,data=part.dat))
    
    trait <- "biomass_aboveground"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"trt","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 trt+
                 #annual_mean_temp+
                 #mean_diurnal_temp_range+
                 #temperature_seasonality+
                 #max_temp_warmest_month+
                 #min_temp_coldest_month+
                 #mean_temp_driest_quarter+
                 #annual_precip+
                 #precip_seasonality+
                 #annual_AI_CGIAR+
                 #PDHI_exep_drt_months_year+
                 median_year_PDHI
               ,data=part.dat))
    
    trait <- "biomass_belowground"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"trt","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 trt+
                 annual_mean_temp
                 #mean_diurnal_temp_range+
                 #temperature_seasonality+
                 #max_temp_warmest_month+
                 #min_temp_coldest_month+
                 #mean_temp_driest_quarter+
                 #annual_precip+
                 #precip_seasonality+
                 #annual_AI_CGIAR+
                 #PDHI_exep_drt_months_year+
                 #median_year_PDHI
               ,data=part.dat))
    
    trait <- "biomass_rhizome"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"trt","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 trt+
                 #annual_mean_temp
               #mean_diurnal_temp_range+
               #temperature_seasonality+
               #max_temp_warmest_month+
               #min_temp_coldest_month+
               #mean_temp_driest_quarter+
               #annual_precip+
               #precip_seasonality+
               #annual_AI_CGIAR+
               #PDHI_exep_drt_months_year+
               median_year_PDHI
               ,data=part.dat))
    
    trait <- "root_shoot"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"trt","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 trt+
                 #annual_mean_temp+
               #mean_diurnal_temp_range+
               #temperature_seasonality+
               #max_temp_warmest_month+
               #min_temp_coldest_month+
               #mean_temp_driest_quarter+
               #annual_precip+
               #precip_seasonality+
               #annual_AI_CGIAR+
               #PDHI_exep_drt_months_year+
               median_year_PDHI
               ,data=part.dat))
    
    trait <- "max_height"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"trt","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 trt+
                 #annual_mean_temp
               #mean_diurnal_temp_range+
               #temperature_seasonality+
               #max_temp_warmest_month+
               #min_temp_coldest_month+
               mean_temp_driest_quarter
               #annual_precip+
               #precip_seasonality+
               #annual_AI_CGIAR+
               #PDHI_exep_drt_months_year+
               #median_year_PDHI
               ,data=part.dat))
    
    trait <- "avg_predawn_mpa_expt"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"trt","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 trt+
                 #annual_mean_temp
               #mean_diurnal_temp_range+
               temperature_seasonality+
               #max_temp_warmest_month+
               #min_temp_coldest_month+
               #mean_temp_driest_quarter+
               #annual_precip+
               precip_seasonality
               #annual_AI_CGIAR+
               #PDHI_exep_drt_months_year+
               #median_year_PDHI
               ,data=part.dat))
    
    trait <- "avg_midday_mpa_expt"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"trt","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 trt+
                 #annual_mean_temp
               #mean_diurnal_temp_range+
               #temperature_seasonality+
               #max_temp_warmest_month+
               #min_temp_coldest_month+
               mean_temp_driest_quarter+
               annual_precip
               #precip_seasonality+
               #annual_AI_CGIAR+
               #PDHI_exep_drt_months_year+
               #median_year_PDHI
               ,data=part.dat))
    
    trait <- "flwr_mass_lifetime"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"trt","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 trt+
                 #annual_mean_temp
               #mean_diurnal_temp_range+
               #temperature_seasonality+
               #max_temp_warmest_month+
               min_temp_coldest_month+
               #mean_temp_driest_quarter+
               annual_precip
               #precip_seasonality+
               #annual_AI_CGIAR+
               #PDHI_exep_drt_months_year+
               #median_year_PDHI
               ,data=part.dat))
    
    trait <- "flwr_count_1.2"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"trt","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 trt+
                 #annual_mean_temp
               #mean_diurnal_temp_range+
                temperature_seasonality
               #max_temp_warmest_month+
               #min_temp_coldest_month+
               #mean_temp_driest_quarter+
               #annual_precip+
               #precip_seasonality+
               #annual_AI_CGIAR+
               #PDHI_exep_drt_months_year+
               #median_year_PDHI
               ,data=part.dat))
    
    trait <- "flwr_avg_ind_mass"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"trt","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 #trt+
                 #annual_mean_temp+
               #mean_diurnal_temp_range+
               #temperature_seasonality+
               #max_temp_warmest_month+
               #min_temp_coldest_month+
               #mean_temp_driest_quarter+
               #annual_precip+
               #precip_seasonality+
               #annual_AI_CGIAR+
               PDHI_exep_drt_months_year
               #median_year_PDHI
               ,data=part.dat))
    
    trait <- "flwr_avg_ind_len"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"trt","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 trt+
                 #annual_mean_temp
               #mean_diurnal_temp_range+
               temperature_seasonality
               #max_temp_warmest_month+
               #min_temp_coldest_month+
               #mean_temp_driest_quarter+
               #annual_precip+
               #precip_seasonality+
               #annual_AI_CGIAR+
               #PDHI_exep_drt_months_year+
               #median_year_PDHI
               ,data=part.dat))
  }
  
  
  do.regsubsets.plasticity <- function(infile,trait.name){
    setwd(wd)
    dat <- read.csv(infile)
    trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
    full.dat <- cbind(trait.dat,site.dat.traits)
    part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    leaps.dat <- regsubsets(mean~.,data=part.dat)
    sum.leaps <- summary(leaps.dat)
    write.csv(sum.leaps$adjr2, file=paste("Analysis/climate/plasticity/",trait.name,"adjr2.csv",sep="") )
    pdf(file=paste("Analysis/climate/plasticity/",trait.name,"all-subsets-regression.pdf",sep=""), height=4, width=4)
    par(cex.axis=0.5)
    plot(leaps.dat)
    dev.off()
    par(cex.axis=1)
  }
  
  do.regsubsets.plasticity(infile = "Analysis/posterior_output_plasticity/\ Total\ Biomass\ .csv", trait.name = "Total_Biomass_" )
  do.regsubsets.plasticity(infile = "Analysis/posterior_output_plasticity/\ Root\ to\ shoot\ biomass\ ratio\ .csv", trait.name = "Root_to_Shoot_Ratio_" )
  do.regsubsets.plasticity(infile = "Analysis/posterior_output_plasticity/\ avg_midday_mpa_expt\ .csv", trait.name = "Midday water potential_" )
  do.regsubsets.plasticity(infile = "Analysis/posterior_output_plasticity/\ avg_predawn_mpa_expt\ .csv", trait.name = "Predawn water potential_" )
  do.regsubsets.plasticity(infile = "Analysis/posterior_output_plasticity/\ max_height\ .csv", trait.name = "Maximum Height_" )
  do.regsubsets.plasticity(infile = "Analysis/posterior_output_plasticity/\ flwr_avg_ind_mass\ .csv", trait.name = "Average Individual Flower Mass_" )
  do.regsubsets.plasticity(infile = "Analysis/posterior_output_plasticity/\ flwr_avg_ind_len\ .csv", trait.name = "Average Individual Flower Length_" )
  do.regsubsets.plasticity(infile = "Analysis/posterior_output_plasticity/\ flwr_count_1.2\ .csv", trait.name = "Flower Count_" )
  do.regsubsets.plasticity(infile = "Analysis/posterior_output_plasticity/\ flwr_mass_lifetime\ .csv", trait.name = "Lifetime Flowering Mass_" )
  do.regsubsets.plasticity(infile = "Analysis/posterior_output_plasticity/\ biomass_rhizome\ .csv", trait.name = "Rhizome Biomass_" )
  do.regsubsets.plasticity(infile = "Analysis/posterior_output_plasticity/\ biomass_belowground\ .csv", trait.name = "Belowground Biomass_" )
  do.regsubsets.plasticity(infile = "Analysis/posterior_output_plasticity/\ biomass_aboveground\ .csv", trait.name = "Aboveground Biomass_" )
  do.regsubsets.plasticity(infile = "Analysis/posterior_output_plasticity/\ avg_mpa_difference\ .csv", trait.name = "Water Potential difference_" )
  
  ## test for p values for all best subsets, plasticity
  {
    infile = "Analysis/posterior_output_plasticity/\ Total\ Biomass\ .csv"
    dat <- read.csv(infile)
    trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
    full.dat <- cbind(trait.dat,site.dat.traits)
    part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    summary(lm(mean~
                 annual_mean_temp+
                 #mean_diurnal_temp_range+
                 temperature_seasonality+
                 #max_temp_warmest_month+
                 #min_temp_coldest_month+
                 mean_temp_driest_quarter+
                 annual_precip+
                 #precip_seasonality+
                 annual_AI_CGIAR+
                 #PDHI_exep_drt_months_year+
                 median_year_PDHI
               ,data=part.dat))
    
    infile = "Analysis/posterior_output_plasticity/\ Root\ to\ shoot\ biomass\ ratio\ .csv"
    dat <- read.csv(infile)
    trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
    full.dat <- cbind(trait.dat,site.dat.traits)
    part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    summary(lm(mean~
                 #annual_mean_temp+
                 mean_diurnal_temp_range+
                 temperature_seasonality+
                 #max_temp_warmest_month+
                 #min_temp_coldest_month+
                 #mean_temp_driest_quarter+
                 annual_precip+
                 precip_seasonality+
                 #annual_AI_CGIAR+
                 PDHI_exep_drt_months_year+
                 median_year_PDHI
               ,data=part.dat))
    
    infile = "Analysis/posterior_output_plasticity/\ avg_midday_mpa_expt\ .csv"
    dat <- read.csv(infile)
    trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
    full.dat <- cbind(trait.dat,site.dat.traits)
    part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    summary(lm(mean~
                 annual_mean_temp+
                 mean_diurnal_temp_range+
                 temperature_seasonality+
                 #max_temp_warmest_month+
                 min_temp_coldest_month+
                 mean_temp_driest_quarter+
                 #annual_precip+
                 precip_seasonality+
                 #annual_AI_CGIAR+
                 PDHI_exep_drt_months_year+
                 median_year_PDHI
               ,data=part.dat))
    
    infile = "Analysis/posterior_output_plasticity/\ avg_predawn_mpa_expt\ .csv"
    dat <- read.csv(infile)
    trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
    full.dat <- cbind(trait.dat,site.dat.traits)
    part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    summary(lm(mean~
                 annual_mean_temp+
                 mean_diurnal_temp_range+
                 temperature_seasonality+
                 #max_temp_warmest_month+
                 min_temp_coldest_month+
                 #mean_temp_driest_quarter
                 #annual_precip+
                 precip_seasonality+
                 #annual_AI_CGIAR+
                 PDHI_exep_drt_months_year+
                 median_year_PDHI
               ,data=part.dat))
    
    infile = "Analysis/posterior_output_plasticity/\ max_height\ .csv"
    dat <- read.csv(infile)
    trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
    full.dat <- cbind(trait.dat,site.dat.traits)
    part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    summary(lm(mean~
                 annual_mean_temp
               ,data=part.dat))
    
    infile = "Analysis/posterior_output_plasticity/\ flwr_avg_ind_mass\ .csv"
    dat <- read.csv(infile)
    trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
    full.dat <- cbind(trait.dat,site.dat.traits)
    part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    summary(lm(mean~
                 #annual_mean_temp+
                 #mean_diurnal_temp_range+
                 #temperature_seasonality+
                 #max_temp_warmest_month+
                 #min_temp_coldest_month+
                 #mean_temp_driest_quarter+
                 annual_precip+
                 #precip_seasonality
                 annual_AI_CGIAR
               #PDHI_exep_drt_months_year+
               #median_year_PDHI
               ,data=part.dat))
    
    infile = "Analysis/posterior_output_plasticity/\ flwr_avg_ind_len\ .csv"
    dat <- read.csv(infile)
    trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
    full.dat <- cbind(trait.dat,site.dat.traits)
    part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    summary(lm(mean~
                 #annual_mean_temp+
                 #mean_diurnal_temp_range+
                 temperature_seasonality+
                 #max_temp_warmest_month+
                 min_temp_coldest_month+
                 #mean_temp_driest_quarter+
                 annual_precip+
                 #precip_seasonality
                 annual_AI_CGIAR
               #PDHI_exep_drt_months_year+
               #median_year_PDHI
               ,data=part.dat))
    
    infile = "Analysis/posterior_output_plasticity/\ flwr_count_1.2\ .csv"
    dat <- read.csv(infile)
    trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
    full.dat <- cbind(trait.dat,site.dat.traits)
    part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    summary(lm(mean~
                 #annual_mean_temp+
                 #mean_diurnal_temp_range+
                 #temperature_seasonality
                 max_temp_warmest_month+
                 #min_temp_coldest_month+
                 #mean_temp_driest_quarter+
                 annual_precip+
                 #precip_seasonality+
                 annual_AI_CGIAR+
                 PDHI_exep_drt_months_year
               #median_year_PDHI
               ,data=part.dat))
    
    infile = "Analysis/posterior_output_plasticity/\ flwr_mass_lifetime\ .csv"
    dat <- read.csv(infile)
    trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
    full.dat <- cbind(trait.dat,site.dat.traits)
    part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    summary(lm(mean~
                 #annual_mean_temp+
                 #mean_diurnal_temp_range+
                 temperature_seasonality+
                 #max_temp_warmest_month+
                 #min_temp_coldest_month+
                 #mean_temp_driest_quarter+
                 #annual_precip+
                 precip_seasonality+
                 #annual_AI_CGIAR+
                 #PDHI_exep_drt_months_year+
                 median_year_PDHI
               ,data=part.dat))
    
    infile = "Analysis/posterior_output_plasticity/\ biomass_rhizome\ .csv"
    dat <- read.csv(infile)
    trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
    full.dat <- cbind(trait.dat,site.dat.traits)
    part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    summary(lm(mean~
                 #annual_mean_temp+
                 mean_diurnal_temp_range
               #temperature_seasonality
               #max_temp_warmest_month+
               #min_temp_coldest_month
               #mean_temp_driest_quarter+
               #annual_precip+
               #precip_seasonality
               #annual_AI_CGIAR+
               #PDHI_exep_drt_months_year+
               #median_year_PDHI
               ,data=part.dat))
    
    infile = "Analysis/posterior_output_plasticity/\ biomass_aboveground\ .csv"
    dat <- read.csv(infile)
    trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
    full.dat <- cbind(trait.dat,site.dat.traits)
    part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    summary(lm(mean~
                 #annual_mean_temp+
                 #mean_diurnal_temp_range+
                 temperature_seasonality+
                 #max_temp_warmest_month+
                 #min_temp_coldest_month
                 #mean_temp_driest_quarter+
                 annual_precip+
                 precip_seasonality+
                 #annual_AI_CGIAR
                 #PDHI_exep_drt_months_year+
                 median_year_PDHI
               ,data=part.dat))
    
    infile = "Analysis/posterior_output_plasticity/\ biomass_belowground\ .csv"
    dat <- read.csv(infile)
    trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
    full.dat <- cbind(trait.dat,site.dat.traits)
    part.dat <- full.dat[,c("mean","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    summary(lm(mean~
                 #annual_mean_temp+
                 mean_diurnal_temp_range+
                 temperature_seasonality+
                 #max_temp_warmest_month+
                 #min_temp_coldest_month+
                 #mean_temp_driest_quarter+
                 #annual_precip+
                 #precip_seasonality+
                 #annual_AI_CGIAR+
                 PDHI_exep_drt_months_year
               #median_year_PDHI
               ,data=part.dat))
  }
  
  
  #-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
  ## repeat for single variables..
  
  ## hydroscape
  ## 
  site.dat <- read.csv("Analysis/SITE_DATA.csv")
  dat <- read.csv("Analysis/hydroscape/hydroscape.csv")
  trait <- "area"
  full.dat <- merge(dat,site.dat)
  full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
  part.dat <- full.dat[,c(trait,"annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                          "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
  names(part.dat)[1] <- "trait_noquotes"
  leaps.dat <- regsubsets(trait_noquotes~.,data=part.dat,nvmax=2)
  sum.leaps <- summary(leaps.dat)
  write.csv(sum.leaps$adjr2, file=paste("Analysis/climate/hydroscape/",trait,"adjr2.csv",sep="") )
  pdf(file=paste("Analysis/climate/hydroscape/",trait,"all-subsets-regression.pdf",sep=""), height=4, width=4)
  par(cex.axis=0.5)
  plot(leaps.dat)
  dev.off()
  par(cex.axis=1)
  
  
  ## genomics
  ## 
  dat <- read.csv("Analysis/Genomics/GENOMICS_BYSITE.CSV")
  site.dat <- read.csv("Analysis/SITE_DATA.csv")
  trait <- "eMLG"
  full.dat <- merge(dat,site.dat,by.x = 'lab', by.y = 'pop')
  full.dat <- subset(full.dat, lab == "BG" | lab == "SGS" | lab == "CO" | lab == "SEV" | lab == "CIB" | lab == "CP" | lab == "KNZ" )
  part.dat <- full.dat[,c(trait,"annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                          "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
  leaps.dat <- regsubsets(eMLG~.,data=part.dat,nvmax=2)
  sum.leaps <- summary(leaps.dat)
  write.csv(sum.leaps$adjr2, file="Analysis/climate/genome/regional/MLG_adjr2.csv")
  pdf(file="Analysis/climate/genome/regional/MLG_all-subsets-regression.pdf", height=4, width=4)
  par(cex.axis=0.5)
  plot(leaps.dat)
  dev.off()
  par(cex.axis=1)
  
  ## heterozygosity
  dat <- read.csv("Analysis/Genomics/GENOMICS_BYSITE.CSV")
  site.dat <- read.csv("Analysis/SITE_DATA.csv")
  trait <- "Hexp"
  full.dat <- merge(dat,site.dat,by.x = 'lab', by.y = 'pop')
  full.dat <- subset(full.dat, lab == "BG" | lab == "SGS" | lab == "CO" | lab == "SEV" | lab == "CIB" | lab == "CP" | lab == "KNZ" )
  part.dat <- full.dat[,c(trait,"annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                          "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
  leaps.dat <- regsubsets(Hexp~.,data=part.dat,nvmax=2)
  sum.leaps <- summary(leaps.dat)
  write.csv(sum.leaps$adjr2, file="Analysis/climate/genome/regional/Hexp_adjr2.csv")
  pdf(file="Analysis/climate/genome/regional/Hexp_all-subsets-regression.pdf", height=4, width=4)
  par(cex.axis=0.5)
  plot(leaps.dat)
  dev.off()
  par(cex.axis=1)
  
  
  
  {
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    dat <- read.csv("Analysis/hydroscape/hydroscape.csv")
    trait <- "area"
    full.dat <- merge(dat,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    summary(lm(area~
                 #annual_mean_temp+
                 #mean_diurnal_temp_range+
                 temperature_seasonality
                 #max_temp_warmest_month+
                 #min_temp_coldest_month+
                 #mean_temp_driest_quarter+
                # annual_precip+
                 #precip_seasonality+
                 #annual_AI_CGIAR+
                 #PDHI_exep_drt_months_year+
                # median_year_PDHI
               ,data=part.dat))
    
    dat <- read.csv("Analysis/Genomics/GENOMICS_BYSITE.CSV")
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    trait <- "eMLG"
    full.dat <- merge(dat,site.dat,by.x = 'lab', by.y = 'pop')
    full.dat <- subset(full.dat, lab == "BG" | lab == "SGS" | lab == "CO" | lab == "SEV" | lab == "CIB" | lab == "CP" | lab == "KNZ" )
    part.dat <- full.dat[,c(trait,"annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    summary(lm(eMLG~
                 precip_seasonality+
                 PDHI_exep_drt_months_year ,data=part.dat))
    
    part.dat <- full.dat[,c("Hexp","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    summary(lm(Hexp~
                 #annual_mean_temp+
                 #mean_diurnal_temp_range+
                 #temperature_seasonality+
                 #max_temp_warmest_month
                 #min_temp_coldest_month+
                 mean_temp_driest_quarter
                 #annual_precip+
                 #precip_seasonality+
               #annual_AI_CGIAR+
              # PDHI_exep_drt_months_year
               #median_year_PDHI
               ,data=part.dat))
  }
  
  ## plasticity
  ## 
  ##   ## traits and plasticity  
  
  bogr.data <- read.csv("Analysis/BOGR_DATA_plasticity_master.csv",header=T)
  bogr.data[bogr.data == "no pot"] <- NA # any unknown or unid'd locihttps://gist.github.com/thigm85/8424654 have a 'NA'
  bogr.data[bogr.data == "met"] <- NA # any unknown or unid'd loci have a 'NA'
  bogr.data[bogr.data == "tr"] <- NA # any unknown or unid'd loci have a 'NA'
  ## then these need to be numeric..
  bogr.data$biomass_aboveground <- as.numeric(as.character(bogr.data$biomass_aboveground))
  bogr.data$biomass_belowground <- as.numeric(as.character(bogr.data$biomass_belowground))
  bogr.data$biomass_rhizome <- as.numeric(as.character(bogr.data$biomass_rhizome))
  # derived vars
  bogr.data$root_shoot <- (bogr.data$biomass_belowground + bogr.data$biomass_rhizome) / bogr.data$biomass_aboveground
  bogr.data$biomass_total <- bogr.data$biomass_belowground + bogr.data$biomass_rhizome + bogr.data$biomass_aboveground + bogr.data$flwr_mass_lifetime
  
  ## 
  
  dosubsets <- function(trait){
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"
    leaps.dat <- regsubsets(trait_noquotes~.,data=part.dat)
    sum.leaps <- summary(leaps.dat)
    write.csv(sum.leaps$adjr2, file=paste("Analysis/climate/plasticity/regional/",trait,"adjr2.csv",sep="") )
    pdf(file=paste("Analysis/climate/plasticity/regional/",trait,"all-subsets-regression.pdf",sep=""), height=4, width=4)
    par(cex.axis=0.5)
    plot(leaps.dat)
    dev.off()
    par(cex.axis=1)
  }
  
  dosubsets("biomass_total")
  dosubsets("root_shoot")
  dosubsets("biomass_aboveground")
  dosubsets("biomass_belowground")
  dosubsets("biomass_rhizome")
  dosubsets("flwr_mass_lifetime")
  dosubsets("flwr_count_1.2")
  dosubsets("flwr_avg_ind_len")
  dosubsets("flwr_avg_ind_mass")
  dosubsets("max_height")
  dosubsets("avg_predawn_mpa_expt")
  dosubsets("avg_midday_mpa_expt")
  
  
  ## test for p values for all best subsets
  {
    trait <- "biomass_total"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 annual_mean_temp+
                 mean_diurnal_temp_range+
                 #temperature_seasonality+
                 #max_temp_warmest_month+
                 #min_temp_coldest_month
                 #mean_temp_driest_quarter+
                 #annual_precip+
                 precip_seasonality
                 #annual_AI_CGIAR+
                 #PDHI_exep_drt_months_year+
                 #median_year_PDHI
               ,data=part.dat))
    
    trait <- "biomass_aboveground"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 #annual_mean_temp+
                 #mean_diurnal_temp_range+
                 #temperature_seasonality+
                 #max_temp_warmest_month+
                 #min_temp_coldest_month
                 #mean_temp_driest_quarter+
                 annual_precip+
                 #precip_seasonality+
                 annual_AI_CGIAR
                 #PDHI_exep_drt_months_year+
                 #median_year_PDHI
               ,data=part.dat))
    
    trait <- "biomass_belowground"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 #annual_mean_temp
               #mean_diurnal_temp_range+
               temperature_seasonality+
               #max_temp_warmest_month+
               #min_temp_coldest_month+
               #mean_temp_driest_quarter+
               #annual_precip+
               #precip_seasonality+
               #annual_AI_CGIAR+
               PDHI_exep_drt_months_year
               #median_year_PDHI
               ,data=part.dat))
    
    trait <- "biomass_rhizome"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 #annual_mean_temp+
                 #mean_diurnal_temp_range+
                 #temperature_seasonality+
                 #max_temp_warmest_month+
                 #min_temp_coldest_month+
                 #mean_temp_driest_quarter+
                 #annual_precip+
                 precip_seasonality+
                 annual_AI_CGIAR
                 #PDHI_exep_drt_months_year+
                 #median_year_PDHI
               ,data=part.dat))
    
    trait <- "root_shoot"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 #annual_mean_temp+
                 #mean_diurnal_temp_range+
                 #temperature_seasonality+
                 #max_temp_warmest_month+
                 #min_temp_coldest_month+
                 #mean_temp_driest_quarter+
                 annual_precip+
                 precip_seasonality
                 #annual_AI_CGIAR+
                 #PDHI_exep_drt_months_year+
                 #median_year_PDHI
               ,data=part.dat))
    
    trait <- "max_height"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 annual_mean_temp
                 #mean_diurnal_temp_range+
                 #temperature_seasonality+
                 #max_temp_warmest_month+
                 #min_temp_coldest_month+
                 #mean_temp_driest_quarter
               #annual_precip+
               #precip_seasonality+
               #annual_AI_CGIAR+
               #PDHI_exep_drt_months_year+
               #median_year_PDHI
               ,data=part.dat))
    
    trait <- "avg_predawn_mpa_expt"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 #annual_mean_temp
                 #mean_diurnal_temp_range+
                 #temperature_seasonality+
                 #max_temp_warmest_month+
                 #min_temp_coldest_month+
                 mean_temp_driest_quarter+
                 #annual_precip+
                 #precip_seasonality
               annual_AI_CGIAR
               #PDHI_exep_drt_months_year
               #median_year_PDHI
               ,data=part.dat))
    
    trait <- "avg_midday_mpa_expt"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 #annual_mean_temp
                 #mean_diurnal_temp_range+
                 #temperature_seasonality+
                 #max_temp_warmest_month+
                 #min_temp_coldest_month+
                 #mean_temp_driest_quarter+
                 #annual_precip
               precip_seasonality
               #annual_AI_CGIAR+
               #PDHI_exep_drt_months_year+
               #median_year_PDHI
               ,data=part.dat))
    
    trait <- "flwr_mass_lifetime"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 #annual_mean_temp
                 #mean_diurnal_temp_range+
                 #temperature_seasonality+
                 #max_temp_warmest_month+
                 #min_temp_coldest_month+
                 #mean_temp_driest_quarter+
                 #annual_precip
               #precip_seasonality+
               #annual_AI_CGIAR+
               PDHI_exep_drt_months_year+
               median_year_PDHI
               ,data=part.dat))
    
    trait <- "flwr_count_1.2"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 #annual_mean_temp
                 #mean_diurnal_temp_range+
                 #temperature_seasonality
               #max_temp_warmest_month+
               #min_temp_coldest_month+
               #mean_temp_driest_quarter+
               #annual_precip+
               #precip_seasonality+
               #annual_AI_CGIAR+
               PDHI_exep_drt_months_year
               #median_year_PDHI
               ,data=part.dat))
    
    trait <- "flwr_avg_ind_mass"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 #trt+
                 annual_mean_temp
                 #mean_diurnal_temp_range+
                 #temperature_seasonality+
                 #max_temp_warmest_month+
                 #min_temp_coldest_month+
                 #mean_temp_driest_quarter+
                 #annual_precip+
                 #precip_seasonality+
                 #annual_AI_CGIAR+
                 #PDHI_exep_drt_months_year
               #median_year_PDHI
               ,data=part.dat))
    
    trait <- "flwr_avg_ind_len"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 #annual_mean_temp
                 #mean_diurnal_temp_range+
                 #temperature_seasonality
               #max_temp_warmest_month+
               #min_temp_coldest_month+
               #mean_temp_driest_quarter+
               #annual_precip+
               #precip_seasonality+
               #annual_AI_CGIAR+
               #PDHI_exep_drt_months_year+
               median_year_PDHI
               ,data=part.dat))
  }
  

}

###########################################################################################
## run.3.3
## 
## LOCAL
## ALL SUBSETS LINEAR REGRESSION
## http://www.stat.columbia.edu/~madigan/W2025/notes/linear.pdf
###########################################################################################
###########################################################################################

if(run.3.3 == "yes")
{
  #############################################################################################
  ## load libs
  library(ggplot2)
  library(adegenet)  
  library(reshape2)
  library(leaps)
  
  
  ## Long term drought severity
  ###########################################################################################
  #-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
  ## https://www.ncdc.noaa.gov/monitoring-references/maps/images/us-climate-divisions-names.jpg
  ## https://www1.ncdc.noaa.gov/pub/data/cirs/climdiv/
  #-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
  
  ## traits and plasticity  
  
  bogr.data <- read.csv("Analysis/BOGR_DATA_master.csv",header=T)
  bogr.data[bogr.data == "no pot"] <- NA # any unknown or unid'd locihttps://gist.github.com/thigm85/8424654 have a 'NA'
  bogr.data[bogr.data == "met"] <- NA # any unknown or unid'd loci have a 'NA'
  bogr.data[bogr.data == "tr"] <- NA # any unknown or unid'd loci have a 'NA'
  ## then these need to be numeric..
  bogr.data$biomass_aboveground <- as.numeric(as.character(bogr.data$biomass_aboveground))
  bogr.data$biomass_belowground <- as.numeric(as.character(bogr.data$biomass_belowground))
  bogr.data$biomass_rhizome <- as.numeric(as.character(bogr.data$biomass_rhizome))
  # derived vars
  bogr.data$root_shoot <- (bogr.data$biomass_belowground + bogr.data$biomass_rhizome) / bogr.data$biomass_aboveground
  bogr.data$biomass_total <- bogr.data$biomass_belowground + bogr.data$biomass_rhizome + bogr.data$biomass_aboveground + bogr.data$flwr_mass_lifetime
  
  ## 
  
  dosubsets <- function(trait){
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop = "A" | pop == "RC" | pop == "ST" | pop == "RM" | pop == "BT" | pop == "DM" | pop == "W" | pop == "HV" | pop == "K" | pop == "WR")
    part.dat <- full.dat[,c(trait,"trt","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR")]
    names(part.dat)[1] <- "trait_noquotes"
    leaps.dat <- regsubsets(trait_noquotes~.,data=part.dat)
    sum.leaps <- summary(leaps.dat)
    write.csv(sum.leaps$adjr2, file=paste("Analysis/climate/traits/local/",trait,"adjr2.csv",sep="") )
    pdf(file=paste("Analysis/climate/traits/local/",trait,"all-subsets-regression.pdf",sep=""), height=4, width=4)
    par(cex.axis=0.5)
    plot(leaps.dat)
    dev.off()
    par(cex.axis=1)
  }
  
  dosubsets("biomass_total")
  dosubsets("root_shoot")
  dosubsets("biomass_aboveground")
  dosubsets("biomass_belowground")
  dosubsets("biomass_rhizome")
  dosubsets("flwr_mass_lifetime")
  dosubsets("flwr_count_1.2")
  dosubsets("flwr_avg_ind_len")
  dosubsets("flwr_avg_ind_mass")
  dosubsets("max_height")
  dosubsets("avg_predawn_mpa_expt")
  dosubsets("avg_midday_mpa_expt")
  
  
  ## test for p values for all best subsets
  {
    trait <- "biomass_total"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop = "A" | pop == "RC" | pop == "ST" | pop == "RM" | pop == "BT" | pop == "DM" | pop == "W" | pop == "HV" | pop == "K" | pop == "WR")
    part.dat <- full.dat[,c(trait,"trt","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 trt+
                 annual_mean_temp+
                 #mean_diurnal_temp_range+
                 #temperature_seasonality+
                 #max_temp_warmest_month+
                 min_temp_coldest_month+
                 #mean_temp_driest_quarter+
                 #annual_precip+
                 precip_seasonality
                 #annual_AI_CGIAR+
                 #PDHI_exep_drt_months_year+
                 #median_year_PDHI
               ,data=part.dat))
    
    trait <- "biomass_aboveground"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop = "A" | pop == "RC" | pop == "ST" | pop == "RM" | pop == "BT" | pop == "DM" | pop == "W" | pop == "HV" | pop == "K" | pop == "WR")
    part.dat <- full.dat[,c(trait,"trt","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 trt+
                 annual_mean_temp+
                 #mean_diurnal_temp_range+
                 #temperature_seasonality+
                 max_temp_warmest_month+
                 #min_temp_coldest_month+
                 #mean_temp_driest_quarter+
                 #annual_precip+
                 precip_seasonality
                 #annual_AI_CGIAR+
                 #PDHI_exep_drt_months_year+
                 #median_year_PDHI
               ,data=part.dat))
    
    trait <- "biomass_belowground"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop = "A" | pop == "RC" | pop == "ST" | pop == "RM" | pop == "BT" | pop == "DM" | pop == "W" | pop == "HV" | pop == "K" | pop == "WR")
    part.dat <- full.dat[,c(trait,"trt","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 trt+
                 #annual_mean_temp
               #mean_diurnal_temp_range+
               #temperature_seasonality+
               #max_temp_warmest_month+
               #min_temp_coldest_month+
               #mean_temp_driest_quarter+
               annual_precip
               #precip_seasonality+
               #annual_AI_CGIAR+
               #PDHI_exep_drt_months_year+
               #median_year_PDHI
               ,data=part.dat))
    
    trait <- "biomass_rhizome"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop = "A" | pop == "RC" | pop == "ST" | pop == "RM" | pop == "BT" | pop == "DM" | pop == "W" | pop == "HV" | pop == "K" | pop == "WR")
    part.dat <- full.dat[,c(trait,"trt","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 trt+
                 annual_mean_temp+
                 #mean_diurnal_temp_range+
                 #temperature_seasonality+
                 #max_temp_warmest_month+
                 #min_temp_coldest_month+
                 #mean_temp_driest_quarter+
                 annual_precip+
                 #precip_seasonality+
                 annual_AI_CGIAR
                 #PDHI_exep_drt_months_year+
                 #median_year_PDHI
               ,data=part.dat))
    
    trait <- "root_shoot"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop = "A" | pop == "RC" | pop == "ST" | pop == "RM" | pop == "BT" | pop == "DM" | pop == "W" | pop == "HV" | pop == "K" | pop == "WR")
    part.dat <- full.dat[,c(trait,"trt","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 trt+
                 #annual_mean_temp+
                 #mean_diurnal_temp_range+
                 #temperature_seasonality+
                 max_temp_warmest_month+
                 #min_temp_coldest_month+
                 #mean_temp_driest_quarter+
                 #annual_precip+
                 #precip_seasonality+
                 annual_AI_CGIAR
                 #PDHI_exep_drt_months_year+
                 #median_year_PDHI
               ,data=part.dat))
    
    trait <- "max_height"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop = "A" | pop == "RC" | pop == "ST" | pop == "RM" | pop == "BT" | pop == "DM" | pop == "W" | pop == "HV" | pop == "K" | pop == "WR")
    part.dat <- full.dat[,c(trait,"trt","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 trt+
                 #annual_mean_temp
                 #mean_diurnal_temp_range+
                 #temperature_seasonality+
                 #max_temp_warmest_month+
                 min_temp_coldest_month+
                 #mean_temp_driest_quarter
               #annual_precip+
               precip_seasonality+
               annual_AI_CGIAR
               #PDHI_exep_drt_months_year+
               #median_year_PDHI
               ,data=part.dat))
    
    trait <- "avg_predawn_mpa_expt"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop = "A" | pop == "RC" | pop == "ST" | pop == "RM" | pop == "BT" | pop == "DM" | pop == "W" | pop == "HV" | pop == "K" | pop == "WR")
    part.dat <- full.dat[,c(trait,"trt","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 trt+
                 #annual_mean_temp
                 #mean_diurnal_temp_range+
                 #temperature_seasonality+
                 #max_temp_warmest_month+
                 #min_temp_coldest_month+
                 mean_temp_driest_quarter
                 #annual_precip+
                 #precip_seasonality
               #annual_AI_CGIAR+
               #PDHI_exep_drt_months_year+
              # median_year_PDHI
               ,data=part.dat))
    
    trait <- "avg_midday_mpa_expt"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop = "A" | pop == "RC" | pop == "ST" | pop == "RM" | pop == "BT" | pop == "DM" | pop == "W" | pop == "HV" | pop == "K" | pop == "WR")
    part.dat <- full.dat[,c(trait,"trt","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 trt+
                 #annual_mean_temp+
                 mean_diurnal_temp_range+
                 #temperature_seasonality+
                 #max_temp_warmest_month+
                 #min_temp_coldest_month+
                 mean_temp_driest_quarter
                 #annual_precip
               #precip_seasonality+
               #annual_AI_CGIAR+
               #PDHI_exep_drt_months_year
               #median_year_PDHI
               ,data=part.dat))
    
    trait <- "flwr_mass_lifetime"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop = "A" | pop == "RC" | pop == "ST" | pop == "RM" | pop == "BT" | pop == "DM" | pop == "W" | pop == "HV" | pop == "K" | pop == "WR")
    part.dat <- full.dat[,c(trait,"trt","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 trt+
                 annual_mean_temp+
                 mean_diurnal_temp_range+
                 #temperature_seasonality+
                 max_temp_warmest_month+
                 #min_temp_coldest_month+
                 mean_temp_driest_quarter+
                 #annual_precip
               precip_seasonality
               #annual_AI_CGIAR+
               #PDHI_exep_drt_months_year+
               #median_year_PDHI
               ,data=part.dat))
    
    trait <- "flwr_count_1.2"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop = "A" | pop == "RC" | pop == "ST" | pop == "RM" | pop == "BT" | pop == "DM" | pop == "W" | pop == "HV" | pop == "K" | pop == "WR")
    part.dat <- full.dat[,c(trait,"trt","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 trt+
                 #annual_mean_temp
                 #mean_diurnal_temp_range+
                 #temperature_seasonality
               max_temp_warmest_month+
               #min_temp_coldest_month+
               #mean_temp_driest_quarter+
               annual_precip
               #precip_seasonality+
               #annual_AI_CGIAR+
               #PDHI_exep_drt_months_year+
               #median_year_PDHI
               ,data=part.dat))
    
    trait <- "flwr_avg_ind_mass"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop = "A" | pop == "RC" | pop == "ST" | pop == "RM" | pop == "BT" | pop == "DM" | pop == "W" | pop == "HV" | pop == "K" | pop == "WR")
    part.dat <- full.dat[,c(trait,"trt","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 #trt+
                 #annual_mean_temp+
                 #mean_diurnal_temp_range+
                 #temperature_seasonality+
                 #max_temp_warmest_month+
                  min_temp_coldest_month+
                 #mean_temp_driest_quarter+
                 annual_precip
                 #precip_seasonality+
                 #annual_AI_CGIAR+
                 #PDHI_exep_drt_months_year
               #median_year_PDHI
               ,data=part.dat))
    
    trait <- "flwr_avg_ind_len"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop = "A" | pop == "RC" | pop == "ST" | pop == "RM" | pop == "BT" | pop == "DM" | pop == "W" | pop == "HV" | pop == "K" | pop == "WR")
    part.dat <- full.dat[,c(trait,"trt","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 #trt+
                 #annual_mean_temp
                 #mean_diurnal_temp_range+
                 temperature_seasonality
               #max_temp_warmest_month+
               #min_temp_coldest_month+
               #mean_temp_driest_quarter+
               #annual_precip+
               #precip_seasonality+
               #annual_AI_CGIAR+
               #PDHI_exep_drt_months_year+
               #median_year_PDHI
               ,data=part.dat))
  }
  
  

  
  #-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
  ## repeat for single variables..
  
  ## hydroscape
  ## 
  site.dat <- read.csv("Analysis/SITE_DATA.csv")
  dat <- read.csv("Analysis/hydroscape/hydroscape.csv")
  trait <- "area"
  full.dat <- merge(dat,site.dat)
  full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
  part.dat <- full.dat[,c(trait,"annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                          "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
  names(part.dat)[1] <- "trait_noquotes"
  leaps.dat <- regsubsets(trait_noquotes~.,data=part.dat,nvmax=2)
  sum.leaps <- summary(leaps.dat)
  write.csv(sum.leaps$adjr2, file=paste("Analysis/climate/hydroscape/",trait,"adjr2.csv",sep="") )
  pdf(file=paste("Analysis/climate/hydroscape/",trait,"all-subsets-regression.pdf",sep=""), height=4, width=4)
  par(cex.axis=0.5)
  plot(leaps.dat)
  dev.off()
  par(cex.axis=1)
  
  
  ## genomics
  ## 
  dat <- read.csv("Analysis/Genomics/GENOMICS_BYSITE.CSV")
  site.dat <- read.csv("Analysis/SITE_DATA.csv")
  trait <- "eMLG"
  full.dat <- merge(dat,site.dat,by.x = 'lab', by.y = 'pop')
  full.dat <- subset(full.dat, lab == "BG" | lab == "SGS" | lab == "CO" | lab == "SEV" | lab == "CIB" | lab == "CP" | lab == "KNZ" )
  part.dat <- full.dat[,c(trait,"annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                          "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
  leaps.dat <- regsubsets(eMLG~.,data=part.dat,nvmax=2)
  sum.leaps <- summary(leaps.dat)
  write.csv(sum.leaps$adjr2, file="Analysis/climate/genome/regional/MLG_adjr2.csv")
  pdf(file="Analysis/climate/genome/regional/MLG_all-subsets-regression.pdf", height=4, width=4)
  par(cex.axis=0.5)
  plot(leaps.dat)
  dev.off()
  par(cex.axis=1)
  
  ## heterozygosity
  dat <- read.csv("Analysis/Genomics/GENOMICS_BYSITE.CSV")
  site.dat <- read.csv("Analysis/SITE_DATA.csv")
  trait <- "Hexp"
  full.dat <- merge(dat,site.dat,by.x = 'lab', by.y = 'pop')
  full.dat <- subset(full.dat, lab == "BG" | lab == "SGS" | lab == "CO" | lab == "SEV" | lab == "CIB" | lab == "CP" | lab == "KNZ" )
  part.dat <- full.dat[,c(trait,"annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                          "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
  leaps.dat <- regsubsets(Hexp~.,data=part.dat,nvmax=2)
  sum.leaps <- summary(leaps.dat)
  write.csv(sum.leaps$adjr2, file="Analysis/climate/genome/regional/Hexp_adjr2.csv")
  pdf(file="Analysis/climate/genome/regional/Hexp_all-subsets-regression.pdf", height=4, width=4)
  par(cex.axis=0.5)
  plot(leaps.dat)
  dev.off()
  par(cex.axis=1)
  
  
  
  {
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    dat <- read.csv("Analysis/hydroscape/hydroscape.csv")
    trait <- "area"
    full.dat <- merge(dat,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    summary(lm(area~
                 #annual_mean_temp+
                 #mean_diurnal_temp_range+
                 temperature_seasonality
               #max_temp_warmest_month+
               #min_temp_coldest_month+
               #mean_temp_driest_quarter+
               # annual_precip+
               #precip_seasonality+
               #annual_AI_CGIAR+
               #PDHI_exep_drt_months_year+
               # median_year_PDHI
               ,data=part.dat))
    
    dat <- read.csv("Analysis/Genomics/GENOMICS_BYSITE.CSV")
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    trait <- "eMLG"
    full.dat <- merge(dat,site.dat,by.x = 'lab', by.y = 'pop')
    full.dat <- subset(full.dat, lab == "BG" | lab == "SGS" | lab == "CO" | lab == "SEV" | lab == "CIB" | lab == "CP" | lab == "KNZ" )
    part.dat <- full.dat[,c(trait,"annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    summary(lm(eMLG~
                 precip_seasonality+
                 PDHI_exep_drt_months_year ,data=part.dat))
    
    part.dat <- full.dat[,c("Hexp","annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    summary(lm(Hexp~
                 #annual_mean_temp+
                 #mean_diurnal_temp_range+
                 #temperature_seasonality+
                 #max_temp_warmest_month
                 #min_temp_coldest_month+
                 mean_temp_driest_quarter
               #annual_precip+
               #precip_seasonality+
               #annual_AI_CGIAR+
               # PDHI_exep_drt_months_year
               #median_year_PDHI
               ,data=part.dat))
  }
  
  ## plasticity
  ## 
  ##   ## traits and plasticity  
  
  bogr.data <- read.csv("Analysis/BOGR_DATA_plasticity_master.csv",header=T)
  bogr.data[bogr.data == "no pot"] <- NA # any unknown or unid'd locihttps://gist.github.com/thigm85/8424654 have a 'NA'
  bogr.data[bogr.data == "met"] <- NA # any unknown or unid'd loci have a 'NA'
  bogr.data[bogr.data == "tr"] <- NA # any unknown or unid'd loci have a 'NA'
  ## then these need to be numeric..
  bogr.data$biomass_aboveground <- as.numeric(as.character(bogr.data$biomass_aboveground))
  bogr.data$biomass_belowground <- as.numeric(as.character(bogr.data$biomass_belowground))
  bogr.data$biomass_rhizome <- as.numeric(as.character(bogr.data$biomass_rhizome))
  # derived vars
  bogr.data$root_shoot <- (bogr.data$biomass_belowground + bogr.data$biomass_rhizome) / bogr.data$biomass_aboveground
  bogr.data$biomass_total <- bogr.data$biomass_belowground + bogr.data$biomass_rhizome + bogr.data$biomass_aboveground + bogr.data$flwr_mass_lifetime
  
  ## 
  
  dosubsets <- function(trait){
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"
    leaps.dat <- regsubsets(trait_noquotes~.,data=part.dat)
    sum.leaps <- summary(leaps.dat)
    write.csv(sum.leaps$adjr2, file=paste("Analysis/climate/plasticity/regional/",trait,"adjr2.csv",sep="") )
    pdf(file=paste("Analysis/climate/plasticity/regional/",trait,"all-subsets-regression.pdf",sep=""), height=4, width=4)
    par(cex.axis=0.5)
    plot(leaps.dat)
    dev.off()
    par(cex.axis=1)
  }
  
  dosubsets("biomass_total")
  dosubsets("root_shoot")
  dosubsets("biomass_aboveground")
  dosubsets("biomass_belowground")
  dosubsets("biomass_rhizome")
  dosubsets("flwr_mass_lifetime")
  dosubsets("flwr_count_1.2")
  dosubsets("flwr_avg_ind_len")
  dosubsets("flwr_avg_ind_mass")
  dosubsets("max_height")
  dosubsets("avg_predawn_mpa_expt")
  dosubsets("avg_midday_mpa_expt")
  
  
  ## test for p values for all best subsets
  {
    trait <- "biomass_total"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 annual_mean_temp+
                 mean_diurnal_temp_range+
                 #temperature_seasonality+
                 #max_temp_warmest_month+
                 #min_temp_coldest_month
                 #mean_temp_driest_quarter+
                 #annual_precip+
                 precip_seasonality
               #annual_AI_CGIAR+
               #PDHI_exep_drt_months_year+
               #median_year_PDHI
               ,data=part.dat))
    
    trait <- "biomass_aboveground"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 #annual_mean_temp+
                 #mean_diurnal_temp_range+
                 #temperature_seasonality+
                 #max_temp_warmest_month+
                 #min_temp_coldest_month
                 #mean_temp_driest_quarter+
                 annual_precip+
                 #precip_seasonality+
                 annual_AI_CGIAR
               #PDHI_exep_drt_months_year+
               #median_year_PDHI
               ,data=part.dat))
    
    trait <- "biomass_belowground"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 #annual_mean_temp
                 #mean_diurnal_temp_range+
                 temperature_seasonality+
                 #max_temp_warmest_month+
                 #min_temp_coldest_month+
                 #mean_temp_driest_quarter+
                 #annual_precip+
                 #precip_seasonality+
                 #annual_AI_CGIAR+
                 PDHI_exep_drt_months_year
               #median_year_PDHI
               ,data=part.dat))
    
    trait <- "biomass_rhizome"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 #annual_mean_temp+
                 #mean_diurnal_temp_range+
                 #temperature_seasonality+
                 #max_temp_warmest_month+
                 #min_temp_coldest_month+
                 #mean_temp_driest_quarter+
                 #annual_precip+
                 precip_seasonality+
                 annual_AI_CGIAR
               #PDHI_exep_drt_months_year+
               #median_year_PDHI
               ,data=part.dat))
    
    trait <- "root_shoot"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 #annual_mean_temp+
                 #mean_diurnal_temp_range+
                 #temperature_seasonality+
                 #max_temp_warmest_month+
                 #min_temp_coldest_month+
                 #mean_temp_driest_quarter+
                 annual_precip+
                 precip_seasonality
               #annual_AI_CGIAR+
               #PDHI_exep_drt_months_year+
               #median_year_PDHI
               ,data=part.dat))
    
    trait <- "max_height"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 annual_mean_temp
               #mean_diurnal_temp_range+
               #temperature_seasonality+
               #max_temp_warmest_month+
               #min_temp_coldest_month+
               #mean_temp_driest_quarter
               #annual_precip+
               #precip_seasonality+
               #annual_AI_CGIAR+
               #PDHI_exep_drt_months_year+
               #median_year_PDHI
               ,data=part.dat))
    
    trait <- "avg_predawn_mpa_expt"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 #annual_mean_temp
                 #mean_diurnal_temp_range+
                 #temperature_seasonality+
                 #max_temp_warmest_month+
                 #min_temp_coldest_month+
                 mean_temp_driest_quarter+
                 #annual_precip+
                 #precip_seasonality
                 annual_AI_CGIAR
               #PDHI_exep_drt_months_year
               #median_year_PDHI
               ,data=part.dat))
    
    trait <- "avg_midday_mpa_expt"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 #annual_mean_temp
                 #mean_diurnal_temp_range+
                 #temperature_seasonality+
                 #max_temp_warmest_month+
                 #min_temp_coldest_month+
                 #mean_temp_driest_quarter+
                 #annual_precip
                 precip_seasonality
               #annual_AI_CGIAR+
               #PDHI_exep_drt_months_year+
               #median_year_PDHI
               ,data=part.dat))
    
    trait <- "flwr_mass_lifetime"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 #annual_mean_temp
                 #mean_diurnal_temp_range+
                 #temperature_seasonality+
                 #max_temp_warmest_month+
                 #min_temp_coldest_month+
                 #mean_temp_driest_quarter+
                 #annual_precip
                 #precip_seasonality+
                 #annual_AI_CGIAR+
                 PDHI_exep_drt_months_year+
                 median_year_PDHI
               ,data=part.dat))
    
    trait <- "flwr_count_1.2"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 #annual_mean_temp
                 #mean_diurnal_temp_range+
                 #temperature_seasonality
                 #max_temp_warmest_month+
                 #min_temp_coldest_month+
                 #mean_temp_driest_quarter+
                 #annual_precip+
                 #precip_seasonality+
                 #annual_AI_CGIAR+
                 PDHI_exep_drt_months_year
               #median_year_PDHI
               ,data=part.dat))
    
    trait <- "flwr_avg_ind_mass"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 #trt+
                 annual_mean_temp
               #mean_diurnal_temp_range+
               #temperature_seasonality+
               #max_temp_warmest_month+
               #min_temp_coldest_month+
               #mean_temp_driest_quarter+
               #annual_precip+
               #precip_seasonality+
               #annual_AI_CGIAR+
               #PDHI_exep_drt_months_year
               #median_year_PDHI
               ,data=part.dat))
    
    trait <- "flwr_avg_ind_len"
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    full.dat <- merge(bogr.data,site.dat)
    full.dat <- subset(full.dat, pop == "BG" | pop == "SGS" | pop == "CO" | pop == "SEV" | pop == "CIB")
    part.dat <- full.dat[,c(trait,"annual_mean_temp","mean_diurnal_temp_range","temperature_seasonality","max_temp_warmest_month","min_temp_coldest_month",
                            "mean_temp_driest_quarter","annual_precip","precip_seasonality","annual_AI_CGIAR","PDHI_exep_drt_months_year","median_year_PDHI")]
    names(part.dat)[1] <- "trait_noquotes"    
    summary(lm(trait_noquotes~
                 #annual_mean_temp
                 #mean_diurnal_temp_range+
                 #temperature_seasonality
                 #max_temp_warmest_month+
                 #min_temp_coldest_month+
                 #mean_temp_driest_quarter+
                 #annual_precip+
                 #precip_seasonality+
                 #annual_AI_CGIAR+
                 #PDHI_exep_drt_months_year+
                 median_year_PDHI
               ,data=part.dat))
  }
  
  
}



###########################################################################################
###########################################################################################
## run.4.1
## 
## Plotting key figures
###########################################################################################
###########################################################################################

if(run.4.1 == "yes")
{
library(ggplot2)
library(gridExtra)

col.pal <- read.csv("Analysis/color_key.csv",header=T)
col.pal.names <- as.vector(col.pal[,2]) ; names(col.pal.names) <- col.pal[,6]
col.pal.colors <- as.vector(col.pal[,3]) ; names(col.pal.colors) <- col.pal[,6]
col.pal.v <- as.vector(col.pal[,3]) ; names(col.pal.v) <- col.pal[,2]

do.rank <- function(infile,trait.name){
  setwd(wd)
  dat <- read.csv(infile)
  trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
  site.dat <- read.csv("Analysis/SITE_DATA.csv")
  site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
  full.dat <- cbind(trait.dat,site.dat.traits[,"pop"]) ; names(full.dat)[6] <- "pop" ; full.dat$trait <- rep(trait.name,nrow(full.dat))
  names(full.dat)[6] <- "abbv"
  full.dat <- merge(full.dat,col.pal)
  gg <- ggplot(data=full.dat, aes(x=rank(mean),y=mean)) +
    facet_wrap(~trait, scale = "free_y") +
    geom_errorbar(aes(ymin=`X2.5.`,ymax=`X97.5.`,col=legend.order), width=0) + 
    scale_color_manual(values = col.pal.colors, labels = col.pal.names) +  
    theme_classic() + xlab(NULL) + 
    theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
    geom_point(aes(col=legend.order), size=3) + ylab(NULL) + 
    labs(colour = "Site") + theme( legend.position = "none"  )
  return(gg)
}
do.rank.wlegend <- function(infile,trait.name){
  setwd(wd)
  dat <- read.csv(infile)
  trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
  site.dat <- read.csv("Analysis/SITE_DATA.csv")
  site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
  full.dat <- cbind(trait.dat,site.dat.traits[,"pop"]) ; names(full.dat)[6] <- "pop" ; full.dat$trait <- rep(trait.name,nrow(full.dat))
  names(full.dat)[6] <- "abbv"
  full.dat <- merge(full.dat,col.pal)
  gg <- ggplot(data=full.dat, aes(x=rank(mean),y=mean)) +
    facet_wrap(~trait, scale = "free_y") +
    geom_errorbar(aes(ymin=`X2.5.`,ymax=`X97.5.`,col=legend.order), width=0) + 
    scale_color_manual(values = col.pal.colors, labels = col.pal.names) +  
    theme_classic() + xlab(NULL) + 
    theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
    geom_point(aes(col=legend.order), size=3) + ylab(NULL) + 
    labs(colour = "Site")
  return(gg)
}


d1 <- do.rank.wlegend(infile = "Analysis/posterior_output/\ Total\ Biomass\ .csv", trait.name = "Total Biomass (g)" )
d2 <- do.rank(infile = "Analysis/posterior_output/\ Root\ to\ shoot\ biomass\ ratio\ .csv", trait.name = "Root:Shoot" )
d3 <- do.rank(infile = "Analysis/posterior_output/\ avg_midday_mpa_expt\ .csv", trait.name = "Midday leaf water potential (MPa)" )
d4 <- do.rank(infile = "Analysis/posterior_output/\ avg_predawn_mpa_expt\ .csv", trait.name = "Predawn leaf water potential (MPa)" )
d5 <- do.rank(infile = "Analysis/posterior_output/\ max_height\ .csv", trait.name = "Maximum height (cm)" )
d6 <- do.rank(infile = "Analysis/posterior_output/\ flwr_avg_ind_mass\ .csv", trait.name = "Average flower mass (mg)" )
d7 <- do.rank(infile = "Analysis/posterior_output/\ flwr_avg_ind_len\ .csv", trait.name = "Average flower length (mm)" )
d8 <- do.rank(infile = "Analysis/posterior_output/\ flwr_count_1.2\ .csv", trait.name = "Flower count" )
d9 <- do.rank(infile = "Analysis/posterior_output/\ flwr_mass_lifetime\ .csv", trait.name = "Lifetime flowering mass (g)" )
d10 <- do.rank(infile = "Analysis/posterior_output/\ biomass_rhizome\ .csv", trait.name = "Rhizome biomass (g)" )
d11 <- do.rank(infile = "Analysis/posterior_output/\ biomass_belowground\ .csv", trait.name = "Belowground biomass (g)" )
d12 <- do.rank(infile = "Analysis/posterior_output/\ biomass_aboveground\ .csv", trait.name = "Aboveground biomass (g)" )

bigplot <- grid.arrange(d12,d11,d10,d1 + theme(legend.position = "none"),
                        d2,d5,d4,d3,
                        d9,d8,d6,d7,
                        nrow=3)

g_legend<-function(a.gplot){
  tmp <- ggplot_gtable(ggplot_build(a.gplot))
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  return(legend)}

mylegend<-g_legend(d1)

plot.1 <- grid.arrange(bigplot, mylegend, nrow=1,widths=c(10, 1))
plot.1
ggsave(plot.1,file="Analysis/Key_figures/Trait_means.jpg",height=8,width=13)



## now with variance accounting for water treatment
do.rank <- function(infile,trait.name){
  setwd(wd)
  dat <- read.csv(infile)
  trait.dat <- dat[grep("sigma_pop", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
  site.dat <- read.csv("Analysis/SITE_DATA.csv")
  site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
  full.dat <- cbind(trait.dat,site.dat.traits[,"pop"]) ; names(full.dat)[6] <- "pop" ; full.dat$trait <- rep(trait.name,nrow(full.dat))
  names(full.dat)[6] <- "abbv"
  full.dat <- merge(full.dat,col.pal)
  gg <- ggplot(data=full.dat, aes(x=rank(mean),y=mean)) +
    facet_wrap(~trait, scale = "free_y") +
    geom_errorbar(aes(ymin=`X2.5.`,ymax=`X97.5.`,col=legend.order), width=0) + 
    scale_color_manual(values = col.pal.colors, labels = col.pal.names) +  
    theme_classic() + xlab(NULL) + 
    theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
    geom_point(aes(col=legend.order), size=3) + ylab(NULL) + 
    labs(colour = "Site") + theme( legend.position = "none"  )
  return(gg)
}
do.rank.wlegend <- function(infile,trait.name){
  setwd(wd)
  dat <- read.csv(infile)
  trait.dat <- dat[grep("sigma_pop", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
  site.dat <- read.csv("Analysis/SITE_DATA.csv")
  site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
  full.dat <- cbind(trait.dat,site.dat.traits[,"pop"]) ; names(full.dat)[6] <- "pop" ; full.dat$trait <- rep(trait.name,nrow(full.dat))
  names(full.dat)[6] <- "abbv"
  full.dat <- merge(full.dat,col.pal)
  gg <- ggplot(data=full.dat, aes(x=rank(mean),y=mean)) +
    facet_wrap(~trait, scale = "free_y") +
    geom_errorbar(aes(ymin=`X2.5.`,ymax=`X97.5.`,col=legend.order), width=0) + 
    scale_color_manual(values = col.pal.colors, labels = col.pal.names) +  
    theme_classic() + xlab(NULL) + 
    theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
    geom_point(aes(col=legend.order), size=3) + ylab(NULL) + 
    labs(colour = "Site")
  return(gg)
}
d1 <- do.rank.wlegend(infile = "Analysis/posterior_output/\ Total\ Biomass\ .csv", trait.name = "Total Biomass (g)" )
d2 <- do.rank(infile = "Analysis/posterior_output/\ Root\ to\ shoot\ biomass\ ratio\ .csv", trait.name = "Root:Shoot" )
d3 <- do.rank(infile = "Analysis/posterior_output/\ avg_midday_mpa_expt\ .csv", trait.name = "Midday leaf water potential (MPa)" )
d4 <- do.rank(infile = "Analysis/posterior_output/\ avg_predawn_mpa_expt\ .csv", trait.name = "Predawn leaf water potential (MPa)" )
d5 <- do.rank(infile = "Analysis/posterior_output/\ max_height\ .csv", trait.name = "Maximum height (cm)" )
d6 <- do.rank(infile = "Analysis/posterior_output/\ flwr_avg_ind_mass\ .csv", trait.name = "Average flower mass (mg)" )
d7 <- do.rank(infile = "Analysis/posterior_output/\ flwr_avg_ind_len\ .csv", trait.name = "Average flower length (mm)" )
d8 <- do.rank(infile = "Analysis/posterior_output/\ flwr_count_1.2\ .csv", trait.name = "Flower count" )
d9 <- do.rank(infile = "Analysis/posterior_output/\ flwr_mass_lifetime\ .csv", trait.name = "Lifetime flowering mass (g)" )
d10 <- do.rank(infile = "Analysis/posterior_output/\ biomass_rhizome\ .csv", trait.name = "Rhizome biomass (g)" )
d11 <- do.rank(infile = "Analysis/posterior_output/\ biomass_belowground\ .csv", trait.name = "Belowground biomass (g)" )
d12 <- do.rank(infile = "Analysis/posterior_output/\ biomass_aboveground\ .csv", trait.name = "Aboveground biomass (g)" )

bigplot <- grid.arrange(d12,d11,d10,d1 + theme(legend.position = "none"),
                        d2,d5,d4,d3,
                        d9,d8,d6,d7,
                        nrow=3)
plot.2 <- grid.arrange(bigplot, mylegend, nrow=1,widths=c(10, 1))
ggsave(plot.2, file="Analysis/Key_figures/Trait_variance.jpg",height=8,width=13)



## With plasticity
do.rank <- function(infile,trait.name){
  setwd(wd)
  dat <- read.csv(infile)
  trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
  site.dat <- read.csv("Analysis/SITE_DATA.csv")
  site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
  full.dat <- cbind(trait.dat,site.dat.traits[,"pop"]) ; names(full.dat)[6] <- "pop" ; full.dat$trait <- rep(trait.name,nrow(full.dat))
  names(full.dat)[6] <- "abbv"
  full.dat <- merge(full.dat,col.pal)
  gg <- ggplot(data=full.dat, aes(x=rank(mean),y=mean)) +
    facet_wrap(~trait, scale = "free_y") +
    geom_errorbar(aes(ymin=`X2.5.`,ymax=`X97.5.`,col=legend.order), width=0) + 
    scale_color_manual(values = col.pal.colors, labels = col.pal.names) +  
    theme_classic() + xlab(NULL) + geom_hline(yintercept=0, lty=3) +
    theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
    geom_point(aes(col=legend.order), size=3) + ylab(NULL) + 
    labs(colour = "Site") + theme( legend.position = "none"  )
  return(gg)
}
do.rank.wlegend <- function(infile,trait.name){
  setwd(wd)
  dat <- read.csv(infile)
  trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
  site.dat <- read.csv("Analysis/SITE_DATA.csv")
  site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
  full.dat <- cbind(trait.dat,site.dat.traits[,"pop"]) ; names(full.dat)[6] <- "pop" ; full.dat$trait <- rep(trait.name,nrow(full.dat))
  names(full.dat)[6] <- "abbv"
  full.dat <- merge(full.dat,col.pal)
  gg <- ggplot(data=full.dat, aes(x=rank(mean),y=mean)) +
    facet_wrap(~trait, scale = "free_y") +
    geom_errorbar(aes(ymin=`X2.5.`,ymax=`X97.5.`,col=legend.order), width=0) + 
    scale_color_manual(values = col.pal.colors, labels = col.pal.names) +  
    theme_classic() + xlab(NULL) + geom_hline(yintercept=0, lty=3) +
    theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
    geom_point(aes(col=legend.order), size=3) + ylab(NULL) + 
    labs(colour = "Site")
  return(gg)
}
d1 <- do.rank.wlegend(infile = "Analysis/posterior_output_plasticity/\ Total\ Biomass\ .csv", trait.name = "Total Biomass (g)" )
d2 <- do.rank(infile = "Analysis/posterior_output_plasticity/\ Root\ to\ shoot\ biomass\ ratio\ .csv", trait.name = "Root:Shoot" )
d3 <- do.rank(infile = "Analysis/posterior_output_plasticity/\ avg_midday_mpa_expt\ .csv", trait.name = "Midday leaf water potential (MPa)" )
d4 <- do.rank(infile = "Analysis/posterior_output_plasticity/\ avg_predawn_mpa_expt\ .csv", trait.name = "Predawn leaf water potential (MPa)" )
d5 <- do.rank(infile = "Analysis/posterior_output_plasticity/\ max_height\ .csv", trait.name = "Maximum height (cm)" )
d6 <- do.rank(infile = "Analysis/posterior_output_plasticity/\ flwr_avg_ind_mass\ .csv", trait.name = "Average flower mass (mg)" )
d7 <- do.rank(infile = "Analysis/posterior_output_plasticity/\ flwr_avg_ind_len\ .csv", trait.name = "Average flower length (mm)" )
d8 <- do.rank(infile = "Analysis/posterior_output_plasticity/\ flwr_count_1.2\ .csv", trait.name = "Flower count" )
d9 <- do.rank(infile = "Analysis/posterior_output_plasticity/\ flwr_mass_lifetime\ .csv", trait.name = "Lifetime flowering mass (g)" )
d10 <- do.rank(infile = "Analysis/posterior_output_plasticity/\ biomass_rhizome\ .csv", trait.name = "Rhizome biomass (g)" )
d11 <- do.rank(infile = "Analysis/posterior_output_plasticity/\ biomass_belowground\ .csv", trait.name = "Belowground biomass (g)" )
d12 <- do.rank(infile = "Analysis/posterior_output_plasticity/\ biomass_aboveground\ .csv", trait.name = "Aboveground biomass (g)" )

bigplot <- grid.arrange(d12,d11,d10,d1 + theme(legend.position = "none"),
                        d2,d5,d4,d3,
                        d9,d8,d6,d7,
                        nrow=3)
plot.3 <- grid.arrange(bigplot, mylegend, nrow=1,widths=c(10, 1))
ggsave(plot.3, file="Analysis/Key_figures/Trait_plasticity.jpg",height=8,width=13)



## With plasticity variance
do.rank <- function(infile,trait.name){
  setwd(wd)
  dat <- read.csv(infile)
  trait.dat <- dat[grep("sigma_pop", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
  site.dat <- read.csv("Analysis/SITE_DATA.csv")
  site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
  full.dat <- cbind(trait.dat,site.dat.traits[,"pop"]) ; names(full.dat)[6] <- "pop" ; full.dat$trait <- rep(trait.name,nrow(full.dat))
  names(full.dat)[6] <- "abbv"
  full.dat <- merge(full.dat,col.pal)
  gg <- ggplot(data=full.dat, aes(x=rank(mean),y=mean)) +
    facet_wrap(~trait, scale = "free_y") +
    geom_errorbar(aes(ymin=`X2.5.`,ymax=`X97.5.`,col=legend.order), width=0) + 
    scale_color_manual(values = col.pal.colors, labels = col.pal.names) +  
    theme_classic() + xlab(NULL) + 
    theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
    geom_point(aes(col=legend.order), size=3) + ylab(NULL) + 
    labs(colour = "Site") + theme( legend.position = "none"  )
  return(gg)
}
do.rank.wlegend <- function(infile,trait.name){
  setwd(wd)
  dat <- read.csv(infile)
  trait.dat <- dat[grep("sigma_pop", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
  site.dat <- read.csv("Analysis/SITE_DATA.csv")
  site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
  full.dat <- cbind(trait.dat,site.dat.traits[,"pop"]) ; names(full.dat)[6] <- "pop" ; full.dat$trait <- rep(trait.name,nrow(full.dat))
  names(full.dat)[6] <- "abbv"
  full.dat <- merge(full.dat,col.pal)
  gg <- ggplot(data=full.dat, aes(x=rank(mean),y=mean)) +
    facet_wrap(~trait, scale = "free_y") +
    geom_errorbar(aes(ymin=`X2.5.`,ymax=`X97.5.`,col=legend.order), width=0) + 
    scale_color_manual(values = col.pal.colors, labels = col.pal.names) +  
    theme_classic() + xlab(NULL) +
    theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
    geom_point(aes(col=legend.order), size=3) + ylab(NULL) + 
    labs(colour = "Site")
  return(gg)
}
d1 <- do.rank.wlegend(infile = "Analysis/posterior_output_plasticity/\ Total\ Biomass\ .csv", trait.name = "Total Biomass (g)" )
d2 <- do.rank(infile = "Analysis/posterior_output_plasticity/\ Root\ to\ shoot\ biomass\ ratio\ .csv", trait.name = "Root:Shoot" )
d3 <- do.rank(infile = "Analysis/posterior_output_plasticity/\ avg_midday_mpa_expt\ .csv", trait.name = "Midday leaf water potential (MPa)" )
d4 <- do.rank(infile = "Analysis/posterior_output_plasticity/\ avg_predawn_mpa_expt\ .csv", trait.name = "Predawn leaf water potential (MPa)" )
d5 <- do.rank(infile = "Analysis/posterior_output_plasticity/\ max_height\ .csv", trait.name = "Maximum height (cm)" )
d6 <- do.rank(infile = "Analysis/posterior_output_plasticity/\ flwr_avg_ind_mass\ .csv", trait.name = "Average flower mass (mg)" )
d7 <- do.rank(infile = "Analysis/posterior_output_plasticity/\ flwr_avg_ind_len\ .csv", trait.name = "Average flower length (mm)" )
d8 <- do.rank(infile = "Analysis/posterior_output_plasticity/\ flwr_count_1.2\ .csv", trait.name = "Flower count" )
d9 <- do.rank(infile = "Analysis/posterior_output_plasticity/\ flwr_mass_lifetime\ .csv", trait.name = "Lifetime flowering mass (g)" )
d10 <- do.rank(infile = "Analysis/posterior_output_plasticity/\ biomass_rhizome\ .csv", trait.name = "Rhizome biomass (g)" )
d11 <- do.rank(infile = "Analysis/posterior_output_plasticity/\ biomass_belowground\ .csv", trait.name = "Belowground biomass (g)" )
d12 <- do.rank(infile = "Analysis/posterior_output_plasticity/\ biomass_aboveground\ .csv", trait.name = "Aboveground biomass (g)" )

bigplot <- grid.arrange(d12,d11,d10,d1 + theme(legend.position = "none"),
                        d2,d5,d4,d3,
                        d9,d8,d6,d7,
                        nrow=3)
plot.4 <- grid.arrange(bigplot, mylegend, nrow=1,widths=c(10, 1))
ggsave(plot.4, file="Analysis/Key_figures/Trait_plasticity_variance.jpg",height=8,width=13)





}


###########################################################################################
###########################################################################################
## run.5.1
## 
## PCA / LDA
## https://www.r-bloggers.com/computing-and-visualizing-lda-in-r/
## https://gist.github.com/thigm85/8424654
###########################################################################################
###########################################################################################

if(run.5.1 == "yes")
{
  library(ggplot2)
  library(gridExtra)
  library(missMDA)
  library(MASS)
  require(scales)

  ###########################################################################################
  ## open data
  bogr.data <- read.csv("Analysis/BOGR_DATA_unsupervised_PCA_LDA.csv")
  names(bogr.data)
  col.pal <- read.csv("Analysis/color_key.csv",header=T)
  col.pal.v <- as.vector(col.pal[,3]) ; names(col.pal.v) <- col.pal[,2]
  col.pal.names <- as.vector(col.pal[,2]) ; names(col.pal.names) <- col.pal[,6]
  col.pal.colors <- as.vector(col.pal[,3]) ; names(col.pal.colors) <- col.pal[,6]
  
  ## stan won't be able to handle these NAs. replace them w/ NA so that they can be removed later 
  bogr.data[bogr.data == "no pot"] <- NA # any unknown or unid'd locihttps://gist.github.com/thigm85/8424654 have a 'NA'
  bogr.data[bogr.data == "met"] <- NA # any unknown or unid'd loci have a 'NA'
  bogr.data[bogr.data == "tr"] <- NA # any unknown or unid'd loci have a 'NA'
  ## then these need to be numeric..
  bogr.data$biomass_aboveground <- as.numeric(as.character(bogr.data$biomass_aboveground))
  bogr.data$biomass_belowground <- as.numeric(as.character(bogr.data$biomass_belowground))
  bogr.data$biomass_rhizome <- as.numeric(as.character(bogr.data$biomass_rhizome))
  # derived vars
  bogr.data$root_shoot <- (bogr.data$biomass_belowground + bogr.data$biomass_rhizome) / bogr.data$biomass_aboveground
  bogr.data$biomass_total <- bogr.data$biomass_belowground + bogr.data$biomass_rhizome + bogr.data$biomass_aboveground + bogr.data$flwr_mass_lifetime
  
  
  makeLDA <- function(restrictions = bogr.data[(bogr.data$region != 'Boulder'),],
                      radlength=2,
                      regionlab){
  # REMOVE ANY ROWS WITH TONS OF NA
  bogr.data <- bogr.data[rowSums(is.na(bogr.data)) < 7, ]
  # replace flower NA with zero
  bogr.data[,16:17][is.na(bogr.data[,16:17])] <- 0
  bogr.data.small <- restrictions
  feats <- bogr.data.small[,11:22]
  #Iterativa PCA
  imputed <- imputePCA(feats, ncp=2, scale=TRUE)
  newfeats <- imputed$completeObs
  newfeats_scaled <- scale(newfeats)
  
  ldadat <- cbind(bogr.data.small[,c('pop')],as.data.frame(newfeats_scaled)) ; colnames(ldadat)[1] <- "pop"
  lda_res_extended <- lda(pop ~ ., data = ldadat, CV=TRUE)
  lda_res_extended$class
  head(lda_res_extended$posterior)
  
  lda_results <- lda(pop ~ ., data = ldadat)
  prop.lda = lda_results$svd^2/sum(lda_results$svd^2) ; prop.lda
  plda <- predict(object = lda_results, newdata = ldadat)
  
  ## PCA
  # prcomp_analysis <- prcomp(newfeats, center = T)
  # plot(prcomp_analysis)
  # summary_PCA <- summary(prcomp_analysis)
  # summary_PCA
  # propvariance <- summary_PCA$importance
  # components <- prcomp_analysis$x
  # prcomp_analysis$rotation
  
  # want to draw loadings
  load_dat <- data.frame(varnames=rownames(coef(lda_results)), coef(lda_results))
  rad <- radlength # This sets the length of your lines.
  load_dat$length <- with(load_dat, sqrt(LD1^2+LD2^2))
  load_dat$angle <- atan2(load_dat$LD1, load_dat$LD2)
  load_dat$x_start <- load_dat$y_start <- 0
  load_dat$x_end <- cos(load_dat$angle) * rad
  load_dat$y_end <- sin(load_dat$angle) * rad
  
  #replace some names
  loads <- c( 'belowground\nbiomass', 'rhizome\nbiomass', 'aboveground\nbiomass', 'lifetime\nflower\nmass', 'flower\ncount', 'flower\nlength', 'flower\nmass', 'maximum\nheight', 'predawn\nMPa', 'midday\nMPa', 'root:shoot', 'total\nbiomass')
  load_dat <- cbind(load_dat,loads)
  # save only top loadings in LD1 and LD2
  load_dat <- load_dat[(abs(load_dat$LD1) %in% tail(sort(abs(load_dat$LD1)),2) | abs(load_dat$LD2) %in% tail(sort(abs(load_dat$LD2)),1)),]

   plotdat <-  data.frame(pop = bogr.data.small[,"pop"], plda$x) ; colnames(plotdat)[1] <- "pop"
    colnames(col.pal)[2] <- "full" ; colnames(col.pal)[1] <- "pop"
    plotdat <-  merge(plotdat,col.pal)
    plotdat$regionlab <- regionlab
  
  plot_1 <- ggplot(plotdat, aes(LD1, LD2)) + 
    geom_point(aes(color=legend.order), size = 2.5) + 
    #geom_point(aes(color=pop),size=2.5) +
    facet_wrap(~regionlab, scale = "free_y") +
    scale_color_manual(values = col.pal.colors, labels = col.pal.names) + 
    theme_classic() +
    labs(x = paste("LD1 (", percent(prop.lda[1]), ")", sep=""),
         y = paste("LD2 (", percent(prop.lda[2]), ")", sep="")) +
    labs(colour = "Site") +
    geom_spoke(aes(x_start, y_start, angle = angle), load_dat, 
               color = "black", radius = rad, size = 0.5,show.legend = FALSE) +
    geom_label(aes(y = y_end, x = x_end, label = loads), #can change alpha=length within aes
              load_dat, alpha=0.6, size = 3, vjust = .5, hjust = 0, colour = "black",show.legend = FALSE) +
    guides(text=FALSE,spoke=FALSE,length=FALSE) 
  
  return(plot_1)
  }

  ldaregional <- makeLDA(restrictions = bogr.data[(bogr.data$region != 'Boulder'),],
                radlength=2,regionlab = 'Regional: trait means')
  ldalocal <- makeLDA(restrictions = bogr.data[(bogr.data$region == 'Boulder'),],
                radlength=2,regionlab = 'Local: trait means')
  
  bogr.data <- read.csv("Analysis/BOGR_DATA_plasticity_PCA_LDA.csv")
  names(bogr.data)
  bogr.data[bogr.data == "no pot"] <- NA # any unknown or unid'd locihttps://gist.github.com/thigm85/8424654 have a 'NA'
  bogr.data[bogr.data == "met"] <- NA # any unknown or unid'd loci have a 'NA'
  bogr.data[bogr.data == "tr"] <- NA # any unknown or unid'd loci have a 'NA'
  bogr.data$biomass_aboveground <- as.numeric(as.character(bogr.data$biomass_aboveground))
  bogr.data$biomass_belowground <- as.numeric(as.character(bogr.data$biomass_belowground))
  bogr.data$biomass_rhizome <- as.numeric(as.character(bogr.data$biomass_rhizome))
  bogr.data$root_shoot <- as.numeric(as.character(bogr.data$roottoshoot))
  bogr.data$biomass_total <- as.numeric(as.character(bogr.data$biomass_total))
  
  makeLDA <- function(restrictions = bogr.data[(bogr.data$region != 'Boulder'),],
                      radlength=2,
                      regionlab){
    # REMOVE ANY ROWS WITH TONS OF NA
    bogr.data <- bogr.data[rowSums(is.na(bogr.data)) < 7, ]
    # replace flower NA with zero
    bogr.data[,12:13][is.na(bogr.data[,12:13])] <- 0
    bogr.data.small <- restrictions
    feats <- bogr.data.small[,c(7:16,18,19)]
    #Iterativa PCA
    imputed <- imputePCA(feats, ncp=2, scale=TRUE)
    newfeats <- imputed$completeObs
    newfeats_scaled <- scale(newfeats)
    
    ldadat <- cbind(bogr.data.small[,c('pop')],as.data.frame(newfeats_scaled)) ; colnames(ldadat)[1] <- "pop"
    lda_res_extended <- lda(pop ~ ., data = ldadat, CV=TRUE)
    lda_res_extended$class
    head(lda_res_extended$posterior)
    
    lda_results <- lda(pop ~ ., data = ldadat)
    prop.lda = lda_results$svd^2/sum(lda_results$svd^2) ; prop.lda
    plda <- predict(object = lda_results, newdata = ldadat)
    
    ## PCA
    # prcomp_analysis <- prcomp(newfeats, center = T)
    # plot(prcomp_analysis)
    # summary_PCA <- summary(prcomp_analysis)
    # summary_PCA
    # propvariance <- summary_PCA$importance
    # components <- prcomp_analysis$x
    # prcomp_analysis$rotation
    
    # want to draw loadings
    load_dat <- data.frame(varnames=rownames(coef(lda_results)), coef(lda_results))
    rad <- radlength # This sets the length of your lines.
    load_dat$length <- with(load_dat, sqrt(LD1^2+LD2^2))
    load_dat$angle <- atan2(load_dat$LD1, load_dat$LD2)
    load_dat$x_start <- load_dat$y_start <- 0
    load_dat$x_end <- cos(load_dat$angle) * rad
    load_dat$y_end <- sin(load_dat$angle) * rad
    
    #replace some names
    loads <- c( 'belowground\nbiomass', 'rhizome\nbiomass', 'aboveground\nbiomass', 'lifetime\nflower\nmass', 'flower\ncount', 'flower\nlength', 'flower\nmass', 'maximum\nheight', 'predawn\nMPa', 'midday\nMPa', 'root:shoot', 'total\nbiomass')
    load_dat <- cbind(load_dat,loads)
    # save only top loadings in LD1 and LD2
    load_dat <- load_dat[(abs(load_dat$LD1) %in% tail(sort(abs(load_dat$LD1)),2) | abs(load_dat$LD2) %in% tail(sort(abs(load_dat$LD2)),1)),]
    
    plotdat <-  data.frame(pop = bogr.data.small[,"pop"], plda$x) ; colnames(plotdat)[1] <- "pop"
    colnames(col.pal)[2] <- "full" ; colnames(col.pal)[1] <- "pop"
    plotdat <-  merge(plotdat,col.pal)
    plotdat$regionlab <- regionlab
    
    plot_1 <- ggplot(plotdat, aes(LD1, LD2)) + 
      geom_point(aes(color=legend.order), size = 2.5) + 
      #geom_point(aes(color=pop),size=2.5) +
      facet_wrap(~regionlab, scale = "free_y") +
      scale_color_manual(values = col.pal.colors, labels = col.pal.names) + 
      theme_classic() +
      labs(x = paste("LD1 (", percent(prop.lda[1]), ")", sep=""),
           y = paste("LD2 (", percent(prop.lda[2]), ")", sep="")) +
      labs(colour = "Site") +
      geom_spoke(aes(x_start, y_start, angle = angle), load_dat, 
                 color = "black", radius = rad, size = 0.5,show.legend = FALSE) +
      geom_label(aes(y = y_end, x = x_end, label = loads), #can change alpha=length within aes
                 load_dat, alpha=0.6, size = 3, vjust = .5, hjust = 0, colour = "black",show.legend = FALSE) +
      guides(text=FALSE,spoke=FALSE,length=FALSE) 
    
    return(plot_1)
  }
  
  ldaregionalplast <- makeLDA(restrictions = bogr.data[(bogr.data$region != 'Boulder'),],
                  radlength=1.5,regionlab = 'Regional: trait plasticity')
  ldalocalplast <- makeLDA(restrictions = bogr.data[(bogr.data$region == 'Boulder'),],
                  radlength=2,regionlab = 'Local: trait plasticity')
  
  do.rank.wlegend <- function(infile,trait.name,restrictions){
    setwd(wd)
    dat <- read.csv(infile)
    trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
    full.dat <- cbind(trait.dat,site.dat.traits[,"pop"]) ; names(full.dat)[6] <- "pop" ; full.dat$trait <- rep(trait.name,nrow(full.dat))
    names(full.dat)[6] <- "abbv"
    full.dat <- merge(full.dat,col.pal)
    full.dat <- full.dat[(restrictions),]
    gg <- ggplot(data=full.dat, aes(x=rank(mean),y=mean)) +
      facet_wrap(~trait, scale = "free_y") +
      geom_errorbar(aes(ymin=`X2.5.`,ymax=`X97.5.`,col=legend.order), width=0) + 
      scale_color_manual(values = col.pal.colors, labels = col.pal.names) +  
      theme_classic() + xlab(NULL) + 
      theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
      geom_point(aes(col=legend.order), size=3) + ylab(NULL) + 
      labs(colour = "Site")
    return(gg)
  }

  regionaltrait <- do.rank.wlegend(infile = "Analysis/posterior_output/\ Total\ Biomass\ .csv", trait.name = "Total Biomass (g)" ,
                        restrictions = c(2,4,5,11,12))
  
  localtrait <- do.rank.wlegend(infile = "Analysis/posterior_output/\ Total\ Biomass\ .csv", trait.name = "Total Biomass (g)" ,
                        restrictions = -c(2,4,5,11,12))
  
  
  do.rank.wlegend <- function(infile,trait.name,restrictions){
    setwd(wd)
    dat <- read.csv(infile)
    trait.dat <- dat[grep("trait", dat$X),]; rownames(trait.dat) <- seq(1,15,1)
    site.dat <- read.csv("Analysis/SITE_DATA.csv")
    site.dat.traits <- site.dat[-c(6,10),]; rownames(site.dat.traits) <- seq(1,15,1)
    full.dat <- cbind(trait.dat,site.dat.traits[,"pop"]) ; names(full.dat)[6] <- "pop" ; full.dat$trait <- rep(trait.name,nrow(full.dat))
    names(full.dat)[6] <- "abbv"
    full.dat <- merge(full.dat,col.pal)
    full.dat <- full.dat[(restrictions),]
    gg <- ggplot(data=full.dat, aes(x=rank(mean),y=mean)) +
      facet_wrap(~trait, scale = "free_y") +
      geom_errorbar(aes(ymin=`X2.5.`,ymax=`X97.5.`,col=legend.order), width=0) + 
      scale_color_manual(values = col.pal.colors, labels = col.pal.names) +  
      theme_classic() + xlab(NULL) + geom_hline(yintercept=0, lty=3) +
      theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
      geom_point(aes(col=legend.order), size=3) + ylab(NULL) + 
      labs(colour = "Site")
    return(gg)
  }
  regionalplast <- do.rank.wlegend(infile = "Analysis/posterior_output_plasticity/\ biomass_aboveground\ .csv", 
                                   trait.name = "Aboveground biomass plasticity",
                         restrictions = c(2,4,5,11,12) )
  localplast <- do.rank.wlegend(infile = "Analysis/posterior_output_plasticity/\ biomass_aboveground\ .csv", 
                                trait.name = "Aboveground biomass plasticity",
                         restrictions = -c(2,4,5,11,12) )
  
  g_legend<-function(a.gplot){
    tmp <- ggplot_gtable(ggplot_build(a.gplot))
    leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
    legend <- tmp$grobs[[leg]]
    return(legend)}
  
  mylegend1<-g_legend(regionalplast)
  mylegend2<-g_legend(localplast) 
  
fig1 <- plot_grid(ldaregional + theme(legend.position = "none"), regionaltrait  + theme(legend.position = "none"),
           ldaregionalplast + theme(legend.position = "none"), regionalplast + theme(legend.position = "none"), 
           align='vh',nrow=2,labels = c("(a)", "(b)", "(c)", "(d)"))
fig1plot <- grid.arrange(fig1, mylegend1, nrow=1,widths=c(10, 2))
fig2 <- plot_grid(ldalocal + theme(legend.position = "none"), localtrait + theme(legend.position = "none"),
           ldalocalplast + theme(legend.position = "none"), localplast + theme(legend.position = "none"), 
           align='vh',nrow=2,labels = c("(a)", "(b)", "(c)", "(d)"))
fig2plot <- grid.arrange(fig2, mylegend2, nrow=1,widths=c(10, 2))

ggsave(fig1plot, file="Analysis/Key_figures/LDA_regional.jpg",height=6,width=8)
ggsave(fig2plot, file="Analysis/Key_figures/LDA_local.jpg",height=6,width=8)

  
 }






