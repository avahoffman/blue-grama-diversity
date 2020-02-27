###########################################################################################
##
## Calculate genetic diversity measures
##
###########################################################################################
# Load libraries
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
library(codyn)

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
## clone validation
## https://cran.r-project.org/web/packages/poppr/vignettes/mlg.html

run_clone_validation <-
  function() {
    load("src/genomics_prep/genind_byclone.R")
    indNames(genind.data1)
    
    genind.clones <-
      genind.data1[c(4:64)] ## don't want cultivar outgroup either
    
    genind.clones <-
      # These two samples exhibited strange behavior in the tree
      genind.clones[!(indNames(genind.clones) %in% c('Bgedge_9_1_2', 
                                                     'Bgedge_9_5_1')),]
    
    genind.clones$tab <- tab(genind.clones, NA.method = "mean")
    indNames(genind.clones)
    gen.clones <- as.genclone(genind.clones)
    
    xdis <- diss.dist(genind.clones, percent = FALSE, mat = FALSE)
    pdf(file = "genomics_output/figures/clones.pdf",
        height = 11,
        width = 7)
    
    plot.phylo(upgma(xdis))
    ggtree(upgma(xdis))
    
    dev.off()
    mlg.filter(gen.clones, 
               distance = xdis, 
               algorithm = "average_neighbor") <-
      354 #32
    gen.clones
    ## this looks correct, notice that at this cutoff, *** all clones are lumped together ***
    mlg.table(gen.clones)
  }


#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

calculate_genotype_diversity <- 
  function(){
    genind.1clone.only <- get_genind_data(impute_mean = F)
    
    ## MLG and Nei's Heterozygosity
    genind.1clone.only$tab <-
      tab(genind.1clone.only, NA.method = "mean")
    bg.gen <- as.genclone(genind.1clone.only)
    sample.matrix <- diss.dist(bg.gen, percent = FALSE, mat = FALSE)
    mlg.filter(bg.gen, 
               distance = sample.matrix, 
               algorithm = "farthest_neighbor") <-
      2500 #32
    pdf(file = "genomics_output/figures/genotypes.pdf")
    bg.gen
    mlg.table(bg.gen)
    dev.off()
    
    ## sum genotypes across sites for total
    mlgenotypes <- mlg.table(bg.gen)
    mlgenotypes <-
      rbind(mlgenotypes, rep(0, ncol(mlgenotypes))) # append dummy line for totals
    for (i in 1:ncol(mlgenotypes)) {
      mlgenotypes[18, i] <- sum(mlgenotypes[, i]) #append sum to 18th row
    }
    mlgenotypes.sorted <- mlgenotypes[, order(-mlgenotypes[18, ])]
    rownames(mlgenotypes.sorted)[18] <- "Total"
    write.csv(mlgenotypes.sorted, file = "genomics_output/Poppr_multilocus_genos.csv")
    
    #calculate EQ
    mlgenotypes.melted <- melt(mlgenotypes.sorted)
    mlg.evenness <-
      community_structure(
        mlgenotypes.melted,
        abundance.var = 'value',
        metric = "Evar",
        replicate.var = "Var1"
      )
    write.csv(mlg.evenness, file = "genomics_output/Multilocus_genos_evenness.csv")
    
    bg_diversity <- poppr(bg.gen, method = 4)
    save(bg_diversity, file = "genomics_output/Poppr_genetic_diversity.R")
    write.csv(bg_diversity, file = "genomics_output/Poppr_genetic_diversity.csv")
  }
