###########################################################################################
##
## Create phlogenetic trees for genomic data, both total sites and regional
##
###########################################################################################
# Load libraries
library(adegenet) ## deal with genind objects
library(ade4)
library(ape)
library(phytools)
library(poppr)
library(ggplot2)
library(reshape2)
library(gridExtra)
library(ggrepel)
library(phangorn)
# BiocManager::install("ggtree")
library(ggtree)

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

create_total_site_tree <-
  function() {
    ## remove clones altogether, it messes with the sample size
    # Equalize sample sizes
    # genind.obj <- get_genind_data(impute_mean = F)[c(13:283)]
    genind.obj <- get_genind_data(impute_mean = F)[c(
      13:25,
      30:42,
      46:58,
      63:75,
      80:92,
      97:109,
      113:125,
      130:142,
      145:157,
      158:170,
      174:186,
      189:201,
      204:216,
      221:233,
      237:249,
      252:264,
      268:280
    )]
    pop(genind.obj)
    
    
    genind.obj$tab <- tab(genind.obj, NA.method = "mean")
    strata(genind.obj) <- data.frame(pop(genind.obj))
    nameStrata(genind.obj) <- ~ Pop
    
    if (file.exists("genomics_output/Site_hierarchy_2.R")) {
      load("genomics_output/Site_hierarchy_2.R")
    } else {
      set.seed(999)
      poptree <- genind.obj %>%
        genind2genpop(pop = ~ Pop) %>%
        aboot(
          sample = 10000,
          distance = nei.dist,
          cutoff = 0,
          quiet = F,
          tree = "upgma"
        )
      write.tree(poptree, file = "genomics_output/Site_hierarchy_2.nexus")
      save(poptree, file = "genomics_output/Site_hierarchy_2.R")
    }
    
    colz <- c(
      #"black",
      "#859D59",
      "#CBB0CE",
      "#6BAD9E",
      "#F88A89",
      "#E19B78",
      "#A889C1",
      "#217b7e",
      "#426081",
      "#72ADD1",
      "#795199",
      "#399F2F",
      "#A2D48E",
      "#E73233",
      "#FDB35A",
      "#5EB54C",
      "#3386AE",
      "#A6CEE3"
    )
    colz <- as.vector(colz)
    
    ## each pop individual
    cls <- as.list(unique(genind.obj$pop))
    tree <- groupOTU(poptree, cls)
    #tree$node.label[4] <- ""
    ggtree(tree, aes(color = group), layout = "rectangular") +
      geom_label_repel(
        aes(label = label),
        force = 0,
        nudge_x = 0,
        nudge_y = 0
      ) +
      theme_tree() +
      scale_color_manual(values = c(colz)) +
      theme(legend.position = "none")
    ggsave(file = "genomics_output/figures/Site_heirarchy_2.jpg",
           height = 7,
           width = 4)
  }


create_reigonal_site_tree <-
  function() {
    ## remove clones altogether, it messes with the sample size
    genind.obj <- get_genind_data(impute_mean = F)[c(13:283)]
    pop(genind.obj)
    genind.obj <- genind.obj[(
      genind.obj@pop %in%
        c(
          'Cibola',
          'Sevilleta',
          'SGS',
          'Comanche',
          'Konza',
          'Cedar Point',
          'Buffalo Gap'
        )
    ),]
    genind.obj$tab <- tab(genind.obj, NA.method = "mean")
    strata(genind.obj) <- data.frame(pop(genind.obj))
    nameStrata(genind.obj) <- ~ Pop
    # Analysis
    if (file.exists("genomics_output/Site_hierarchy_regional.R")) {
      load("genomics_output/Site_hierarchy_regional.R")
    } else {
      set.seed(999)
      regionaltree <- genind.obj %>%
        genind2genpop(pop = ~ Pop) %>%
        aboot(
          sample = 10000,
          distance = nei.dist,
          cutoff = 0,
          quiet = F,
          tree = 'upgma'
        )
      write.tree(regionaltree, file = "genomics_output/Site_hierarchy_regional.nexus")
      save(regionaltree, file = "genomics_output/Site_hierarchy_regional.R")
    }
    
    # load("genomics_output/Site_hierarchy_regional.R")
    colz <- c(
      'black',
      "#CBB0CE",
      "#F88A89",
      "#E19B78",
      "#A889C1",
      "#795199",
      "#E73233",
      "#FDB35A"
    )
    colz <- as.vector(colz)
    
    ## each pop individual
    localcls <- as.list(unique(genind.obj$pop))
    regionaltree <- groupOTU(regionaltree, localcls)
    #regionaltree$node.label[4] <- ""
    ggtree(regionaltree, aes(color = group), layout = "rectangular") +
      geom_label_repel(
        aes(label = label),
        force = 0,
        nudge_x = 0,
        nudge_y = 0
      ) +
      theme_tree() +
      scale_color_manual(values = c(colz)) +
      theme(legend.position = "none")
    ggsave(file = "genomics_output/figures/Site_heirarchy_regional.jpg",
           height = 7,
           width = 3)
  }
