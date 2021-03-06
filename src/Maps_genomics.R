###########################################################################################

# Create geographic "pies" of genetic diversity on maps.

###########################################################################################
# Load libraries
library(maps)
library(scatterpie)
library(ggplot2)
library(ggsn)

###########################################################################################
## http://eriqande.github.io/rep-res-web/lectures/making-maps-with-R.html


plot_map_pie_genomics <-
  function(pie.data,
           col.pies,
           states = T,
           xlim = c(-110,-94),
           ylim = c(30, 46),
           r = 0.88,
           col_indexes = 2:8) {
    if (states) {
      map_region <- map_data("state")
    } else if (!(states)) {
      map_region <- map_data("county")
    }
    co_county <- county[(county$subregion == "boulder"), ]
    
    gg <-
      ggplot(data = map_region) +
      geom_polygon(aes(x = long,
                       y = lat,
                       group = group),
                   color = "gray80",
                   fill = "gray90") +
      geom_polygon(
        aes(x = long,
            y = lat,
            group = group),
        data = co_county,
        color = "gray80",
        fill = "gray90"
      ) +
      coord_fixed(xlim = xlim,
                  ylim = ylim,
                  ratio = 1.1) + ## set limits on map size
      theme_cowplot() +
      guides(fill = FALSE) + # do this to leave off the color legend
      geom_scatterpie(
        aes(x = long,
            y = lat,
            r = r),
        data = pie.data,
        cols = colnames(pie.data)[col_indexes],
        color = NA,
        alpha = .8
      ) +
      scale_fill_manual(values = col.pies) +
      xlab(NULL) +
      ylab(NULL)
    if (states){
      gg <- 
        gg +
        ggsn::scalebar(
          dist = 300,
          dist_unit = "km",
          transform = TRUE,
          model = "WGS84",
          st.size = 3,
          st.dist = 0.04,
          y.min = 30.5,
          y.max = 46,
          x.min = -110,
          x.max = -94.6
        )
    } else if (!(states)){
      gg <- 
        gg +
        ggsn::scalebar(
          dist = 10,
          dist_unit = "km",
          transform = TRUE,
          model = "WGS84",
          st.size = 3,
          location = "bottomleft",
          st.dist = 0.04,
          y.min = 39.87,
          y.max = 40.3,
          x.min = -105.69,
          x.max = -105
        )
    }
    
    print(gg)
  }


make_regional_pie_map <-
  function() {
    clim.data <- read.csv("data/SITE_DATA.csv")
    
    struct.data <-
      read.csv("genomics_output/Structure_plot_data_regional_wide.csv")
    BG.pie <-
      subset(struct.data, grepl(c("BG"), X))
    BG.pie <- colSums(BG.pie[, 2:8])
    CI.pie <-
      subset(struct.data, grepl(c("CI"), X))
    CI.pie <- colSums(CI.pie[, 2:8])
    CP.pie <-
      subset(struct.data, grepl(c("CP"), X))
    CP.pie <- colSums(CP.pie[, 2:8])
    CO.pie <-
      subset(struct.data, grepl(c("CO"), X))
    CO.pie <- colSums(CO.pie[, 2:8])
    KNZ.pie <-
      subset(struct.data, grepl(c("KNZ"), X))
    KNZ.pie <- colSums(KNZ.pie[, 2:8])
    SEV.pie <-
      subset(struct.data, grepl(c("SEV"), X))
    SEV.pie <- colSums(SEV.pie[, 2:8])
    SGS.pie <-
      subset(struct.data, grepl(c("SGS"), X))
    SGS.pie <- colSums(SGS.pie[, 2:8])
    pie.data <-
      as.data.frame(rbind(BG.pie, CI.pie, CP.pie, CO.pie, KNZ.pie, SEV.pie, SGS.pie))
    pie.data$pop <- c("BG", "CIB", "CP", "CO", "KNZ", "SEV", "SGS")
    pie.data <- merge(pie.data, clim.data)
    pie.data <- pie.data[, 1:10]
    # dodging Cibola slightly
    pie.data$lat[2] <- 35
    pie.data$long[2] <- -105.5
    
    col.pies <- 
      as.vector(col.pal[, 3])[c(2, 6, 4, 5, 10, 13, 14)]
    
    # Plot and save
    plot_map_pie_genomics(pie.data = pie.data,
                          col.pies = col.pies)
    ggsave(file = "genomics_output/figures/Map_regional.jpg",
           h = 3,
           w = 4)
  }


make_local_pie_map <- 
  function(){
    clim.data <- read.csv("data/SITE_DATA.csv")
    
    struct.data <-
      read.csv("genomics_output/Structure_plot_data_local_wide.csv")
    A.pie <-
      subset(struct.data, grepl(c("A0|A1"), X))
    A.pie <- colSums(A.pie[, 2:11])
    BT.pie <-
      subset(struct.data, grepl(c("BT"), X))
    BT.pie <- colSums(BT.pie[, 2:11])
    DM.pie <-
      subset(struct.data, grepl(c("DM"), X))
    DM.pie <- colSums(DM.pie[, 2:11])
    HV.pie <-
      subset(struct.data, grepl(c("HV"), X))
    HV.pie <- colSums(HV.pie[, 2:11])
    K.pie <-
      subset(struct.data, grepl(c("K0|K1"), X))
    K.pie <- colSums(K.pie[, 2:11])
    RC.pie <-
      subset(struct.data, grepl(c("RC"), X))
    RC.pie <- colSums(RC.pie[, 2:11])
    RM.pie <-
      subset(struct.data, grepl(c("RM"), X))
    RM.pie <- colSums(RM.pie[, 2:11])
    ST.pie <-
      subset(struct.data, grepl(c("ST"), X))
    ST.pie <- colSums(ST.pie[, 2:11])
    W.pie <-
      subset(struct.data, grepl(c("W0|W1"), X))
    W.pie <- colSums(W.pie[, 2:11])
    WR.pie <-
      subset(struct.data, grepl(c("WR"), X))
    WR.pie <- colSums(WR.pie[, 2:11])
    pie.data <-
      as.data.frame(rbind(
        A.pie,
        BT.pie,
        DM.pie,
        HV.pie,
        K.pie,
        RC.pie,
        RM.pie,
        ST.pie,
        W.pie,
        WR.pie
      ))
    pie.data$pop <-
      c("A", "BT", "DM", "HV", "K", "RC", "RM", "ST", "W", "WR")
    pie.data <- merge(pie.data, clim.data)
    pie.data <- pie.data[, 1:13]
    
    ## have to go a bit out of order because of alphabetical order of abbrevs. versus full names
    col.pies <-
      as.vector(col.pal[, 3])[c(1, 3, 7, 8, 9, 12, 11, 15, 17, 16)]
    
    # Plot and save
    plot_map_pie_genomics(pie.data = pie.data,
                          col.pies = col.pies,
                          states = F,
                          xlim = c(-105.7,-105),
                          ylim = c(39.85, 40.3),
                          r = 0.03,
                          col_indexes = 2:11)
    ggsave(file = "genomics_output/figures/Map_local.jpg", 
           h = 3, 
           w = 4)
  }
