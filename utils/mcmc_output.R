##########################################################################################
##
## Functions used for generating MCMC output, posterior distributions, and running
## posterior predictive checks to ensure model is appropriate
##
##########################################################################################

run_mcmc <-
  function(temp_data,
           responsevar,
           compiled_model,
           iter,
           adapt_delta,
           max_treedepth,
           outfile) {
    varying_intercept_slope_data = list(
      'N' = nrow(temp_data),
      'J' = 15,
      ## 15 populations for traits
      'y' = temp_data$responsevar,
      'county' = temp_data$V1,
      'x' = temp_data$V3,
      'm_x' = mean(temp_data$V3)
    )
    iter = iter
    ## sampling
    fit1 = sampling(
      compiled_model,
      data = varying_intercept_slope_data,
      iter = iter,
      warmup = iter / 2,
      thin = 1,
      chains = 2,
      control = list(adapt_delta = adapt_delta, max_treedepth = max_treedepth)
    )
    summary_fit <- summary(fit1)
    
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
              file = outfile)
    return(fit1)
  }


get_posterior_intervals_plasticity <-
  function(bogr_pops,
           draws_data,
           mean_xlab,
           mean_file,
           sigma_xlab,
           sigma_file) {
    post.1 <-
      mcmc_intervals(
        draws_data,
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
      mean_xlab +
      scale_y_discrete(labels = rev(bogr_pops))
    ggsave(post.1,
           file = mean_file,
           height = 4,
           width = 4)
    
    post.2 <-
      mcmc_intervals(
        draws_data,
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
      sigma_xlab +
      scale_y_discrete(labels = rev(bogr_pops))
    ggsave(post.2,
           file = sigma_file,
           height = 4,
           width = 4)
  }


plot_posterior_predictive_checks <-
  function(temp_data,
           responsevar,
           outputname,
           fit_data,
           file1_name,
           file2_name) {
    print("Plotting posterior predictive checks")
    list_of_draws <- extract(fit_data)
    yrep <- list_of_draws$draws1
    np1 <- ppc_dens_overlay(temp_data$responsevar, yrep[1:500, ]) +
      theme_minimal(base_size = 20) +
      xlab(outputname)
    ggsave(np1,
           file = file1_name,
           height = 8,
           width = 8)
    pdf(file = file2_name)
    hist(
      temp_data$responsevar,
      prob = T,
      breaks = 20,
      main = outputname
    )
    lines(density(list_of_draws$draws1), col = "red")
    dev.off()
    print(np1)
  }