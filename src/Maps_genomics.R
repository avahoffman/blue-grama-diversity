## set working directory
source("config.R")
setwd(wd)

library(maps)
library(mapdata)
library(scatterpie)
library(ggplot2)
library(ggsn)

###########################################################################################
## http://eriqande.github.io/rep-res-web/lectures/making-maps-with-R.html

clim.data <- read.csv("data/SITE_DATA.csv")
names(clim.data)
col.pal <- read.csv("utils/color_key.csv", header = T)
col.pal.v <-
  as.vector(col.pal[, 3])
names(col.pal.v) <- col.pal[, 2]
col.pal.names <-
  as.vector(col.pal[, 2])
names(col.pal.names) <- col.pal[, 6]
col.pal.colors <-
  as.vector(col.pal[, 3])
names(col.pal.colors) <- col.pal[, 2]


states <- map_data("state")
county <- map_data("county")
co_county <- county[(county$subregion == "boulder"), ]

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


col.pies <- as.vector(col.pal[, 3])[c(2, 6, 4, 5, 10, 13, 14)]

ggplot(data = states) +
  geom_polygon(aes(x = long, y = lat, group = group),
               color = "gray80",
               fill = "gray90") +
  geom_polygon(
    aes(x = long, y = lat, group = group),
    data = co_county,
    color = "gray80",
    fill = "gray90"
  ) +
  coord_fixed(1.1) +
  coord_fixed(xlim = c(-110, -94),
              ylim = c(30, 46),
              ratio = 1.1) + ## set limits on map size
  #theme_void()+
  #geom_point(data=clim.data, aes(x=long,y=lat),color="darkgrey",size=0.01) +
  guides(fill = FALSE) + # do this to leave off the color legend
  geom_scatterpie(
    aes(x = long, y = lat, r = 0.88),
    data = pie.data,
    cols = colnames(pie.data)[2:8],
    color = NA,
    alpha = .8
  ) +
  scale_fill_manual(values = col.pies) +
  xlab(NULL) +
  ylab(NULL) +
  ggsn::scalebar(
    dist = 300,
    dd2km = TRUE,
    model = "WGS84",
    st.size = 3,
    st.dist = 0.04,
    y.min = 30.5,
    y.max = 46,
    x.min = -110,
    x.max = -94.6
  )
ggsave(file = "genomics_output/figures/Map_regional.jpg", h = 3, w = 4)

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
pie.data$pop <- c("A", "BT", "DM", "HV", "K", "RC", "RM", "ST", "W", "WR")
pie.data <- merge(pie.data, clim.data)
pie.data <- pie.data[, 1:13]

## have to go a bit out of order because of alphabetical order of abbrevs. versus full names
col.pies <- as.vector(col.pal[, 3])[c(1, 3, 7, 8, 9, 12, 11, 15, 17, 16)]

ggplot(data = county) +
  geom_polygon(aes(x = long, y = lat, group = group),
               color = "gray80",
               fill = "gray90") +
  coord_fixed(1.1) +
  coord_fixed(
    xlim = c(-105.7, -105),
    ylim = c(39.85, 40.3),
    ratio = 1.1
  ) + ## set limits on map size
  #geom_point(data=clim.data, aes(x=long,y=lat),color="darkgrey",size=0.1) +
  #theme_void()+
  guides(fill = FALSE) +  # do this to leave off the color legend
  geom_scatterpie(
    aes(x = long, y = lat, r = 0.03),
    data = pie.data,
    cols = colnames(pie.data)[2:11],
    color = NA,
    alpha = .8
  ) +
  scale_fill_manual(values = col.pies) +
  xlab(NULL) +
  ylab(NULL) +
  ggsn::scalebar(
    dist = 10,
    dd2km = TRUE,
    model = "WGS84",
    st.size = 3,
    location = "bottomleft",
    st.dist = 0.04,
    y.min = 39.87,
    y.max = 40.3,
    x.min = -105.69,
    x.max = -105
  )
ggsave(file = "genomics_output/figures/Map_local.jpg", h = 3, w = 4)
