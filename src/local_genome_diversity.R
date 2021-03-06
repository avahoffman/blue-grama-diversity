###########################################################################################
##
## This code looks at genome diversity locally
##
###########################################################################################
library(adegenet) ## deal with genind objects
library(ade4)
library(ggplot2)
library(cowplot)
library(reshape2)

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
## Discriminant Analysis of Principal Components (DAPC)
## https://github.com/thibautjombart/adegenet/raw/master/tutorials/tutorial-dapc.pdf

run_local_genomics_cross_val <- 
  function() {
    ## keep only regional populations
    genind.local <- get_genind_data()[(
      get_genind_data()@pop %in%
        c(
          'Andrus',
          'Rock Creek',
          'Steele',
          'Rabbit Mountain',
          'Beech Trail',
          'Davidson Mesa',
          'Wonderland',
          'Heil Valley',
          'Kelsall',
          'Walker Ranch'
        )
    ),]
    grp <- pop(genind.local)
    
    # Plot results of cross validation
    pdf(
      "genomics_output/figures/Xval_plot_local.pdf",
      height = 6,
      width = 6
    )
    # Run through iterations
    xval <-
      xvalDapc(
        genind.local$tab,
        grp,
        n.pca.max = 160,
        training.set = 0.75,
        result = "groupMean",
        center = TRUE,
        scale = FALSE,
        n.pca = NULL,
        n.rep = 30,
        xval.plot = TRUE,
        parallel = "multicore"
      )
    dev.off()
    # Summary report of DAPC -- we are very interested in xval$DAPC$n.pca for following steps
    print(xval$DAPC)
    save(xval, file = "genomics_output/xval_local.R")
    ## DAPC knows to use populations as prior groups
    load(file = "genomics_output/xval_local.R")
    DAPC <- xval$DAPC
    
    return(DAPC)
  }


run_local_genomics <-
  function() {
    ## keep only regional populations
    genind.local <- get_genind_data()[(
      get_genind_data()@pop %in%
        c(
          'Andrus',
          'Rock Creek',
          'Steele',
          'Rabbit Mountain',
          'Beech Trail',
          'Davidson Mesa',
          'Wonderland',
          'Heil Valley',
          'Kelsall',
          'Walker Ranch'
        )
    ),]
    
    grp <- pop(genind.local)
    DAPC <- dapc(
      genind.local$tab,
      grp,
      n.pca = 60,
      n.da = 9
    )
    ## how much variance retained?
    print(DAPC$var)
    print(DAPC)
    
    ## plot as groups
    plot.dat <- as.data.frame(DAPC$ind.coord)
    plot.dat <- cbind(plot.dat, DAPC$grp)
    names(plot.dat)[10] <- "pop"
    plot.dat <- merge(plot.dat, col.pal)
    ## save info
    write.csv(plot.dat, file = "genomics_output/DAPC_local.csv")
    ggplot(data = plot.dat, aes(x = LD1, y = LD2)) +
      scale_color_manual(values = col.pal.colors, labels = col.pal.names) +
      theme_cowplot() +
      ## ellipses for visual aide
      stat_ellipse(data = subset(plot.dat, `abbv` == "A"), color = "#859D59") +
      stat_ellipse(data = subset(plot.dat, `abbv` == "BT"), color = "#6BAD9E") +
      stat_ellipse(data = subset(plot.dat, `abbv` == "DM"), color = "#217b7e") +
      stat_ellipse(data = subset(plot.dat, `abbv` == "HV"), color = "#426081") +
      stat_ellipse(data = subset(plot.dat, `abbv` == "RC"), color = "#399F2F") +
      stat_ellipse(data = subset(plot.dat, `abbv` == "RM"), color = "#A2D48E") +
      stat_ellipse(data = subset(plot.dat, `abbv` == "ST"), color = "#5EB54C") +
      stat_ellipse(data = subset(plot.dat, `abbv` == "WR"), color = "#A6CEE3") +
      geom_vline(xintercept = 0) + geom_hline(yintercept = 0) +
      geom_point(aes(color = legend.order),
                 size = 1) +
      labs(colour = "Site")
    #theme(legend.position = "none")
    ggsave(file = "genomics_output/figures/DAPC_local.jpg",
           height = 3,
           width = 4)
    
    
    ## calculate population assignment probability
    summ.dapc <- summary(DAPC)
    summ.dapc.assign <- summ.dapc$assign.per.pop
    summ.dapc.assign
    write.csv(summ.dapc.assign, file = "genomics_output/Population_probability_local.csv")
    
    ## loci that differentiate site
    rownames(DAPC$var.contr) <-
      gsub("denovoLocus", "", rownames(DAPC$var.contr))
    rownames(DAPC$var.contr) <-
      gsub(".A", "", rownames(DAPC$var.contr))
    rownames(DAPC$var.contr) <-
      gsub(".C", "", rownames(DAPC$var.contr))
    rownames(DAPC$var.contr) <-
      gsub(".T", "", rownames(DAPC$var.contr))
    rownames(DAPC$var.contr) <-
      gsub(".G", "", rownames(DAPC$var.contr))
    loci.loadings <- DAPC$var.contr
    pdf(file = "genomics_output/figures/Loci_loadings_local.pdf",
        width = 20,
        height = 4)
    loadingplot(
      loci.loadings,
      axis = 2,
      thres = .004,
      main = NULL,
      xlab = "Locus"
    )
    dev.off()
    write.csv(loci.loadings, file = "genomics_output/Loci_loadings_local.csv")
    
    
    ## "structure" plot
    posts <- DAPC$posterior
    posts <- posts[order(row.names(posts)),]
    long.dat <- melt(posts)
    names(long.dat)[2] <- "pop"
    write.csv(long.dat, "genomics_output/Structure_plot_data_local.csv")
    write.csv(posts,
              "genomics_output/Structure_plot_data_local_wide.csv")
    ggplot(data = long.dat, aes(x = Var1, y = value, fill = pop)) +
      geom_col(size = 2) +
      theme_classic() + scale_fill_manual(values = col.pal.v) +
      labs(fill = "Population") + xlab("Individual") + ylab("Membership probability") +
      theme(
        axis.line = element_blank(),
        axis.text.x = element_blank(),
        #axis.text.y=element_blank(),
        axis.ticks = element_blank()
      ) +
      theme_void() +
      theme(legend.position = "none")
    ggsave(file = "genomics_output/figures/structure_local.jpg",
           height = 1.5,
           width = 10)
  }
