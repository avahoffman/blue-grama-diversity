###########################################################################################
##
## This code calculates and plots hydroscape area as a physiological phenotype. See
## details from the original publication below.
##
###########################################################################################
## set working directory
source("config.R")
setwd(wd)
library(ggplot2)

## Calculate hydroscape area
##
## Following Meinzer et al. (http://doi.wiley.com/10.1111/ele.12670)
###########################################################################################

hydro.dat <-
  read.table("data/hydroscape/water_potential.txt", header = T)
plot(hydro.dat$pre, hydro.dat$mid)
## all samples
slope.all <- summary(lm(pre ~ mid, data = hydro.dat))
slope.all

plot.hydro <- function(pop.use) {
  df <- na.omit(hydro.dat)
  find_hull <- function(df)
    df[chull(df$pre, df$mid),]
  hulls <- ddply("data/hydroscape/plots/", df, "pop", find_hull)
  ggplot(data = subset(hydro.dat, hydro.dat$pop == pop.use),
         aes(x = pre, y = mid)) +
    geom_abline(intercept = 0,
                slope = 1,
                linetype = 2) +
    geom_point() + theme_classic() + stat_smooth(se = F, method = "lm") +
    facet_grid(. ~ pop) +
    geom_polygon(data = subset(hulls, hulls$pop == pop.use),
                 alpha = 0.5)
  ggsave(
    file = paste(pop.use, "_raw.pdf", sep = ""),
    height = 4,
    width = 4
  )
}

plot.hydro("A")
plot.hydro("BG")
plot.hydro("BT")
plot.hydro("CIB")
plot.hydro("CO")
plot.hydro("DM")
plot.hydro("HV")
plot.hydro("K")
plot.hydro("RC")
plot.hydro("RM")
plot.hydro("SEV")
plot.hydro("SGS")
plot.hydro("ST")
plot.hydro("W")
plot.hydro("WR")


hydro.dat$pre <-
  ifelse(hydro.dat$pre < hydro.dat$mid, NA, hydro.dat$pre) ## IF PRE WAS MORE NEGATIVE, remove
hydro.dat <- subset(hydro.dat, hydro.dat$remove == "NO")

plot.hydro <- function(pop.use) {
  subdata <- subset(hydro.dat, hydro.dat$pop == pop.use)
  lmodel <- (lm(mid ~ pre, subdata))
  intercept <- lmodel$coefficients[1]
  slope <- lmodel$coefficients[2]
  one2oneint = ((intercept) / (1 - slope)) ## where does the line intercept the 1:1 line?
  hydroscapearea = (((one2oneint) ^ 2) - ((one2oneint) * (one2oneint - intercept) /
                                            2) - (((one2oneint) ^ 2) / 2)) ## calc hydroscape
  hydroscapearea = round(hydroscapearea, 3)
  top.point <-
    c(0, 0)
  int.point <-
    c(0, intercept)
  line.point <- c(one2oneint, one2oneint) ## make hulls
  hulls <-
    rbind(top.point, int.point, line.point)
  colnames(hulls) <- c("pre", "mid")
  ggplot(data = subdata,
         aes(x = pre, y = mid)) +
    geom_abline(intercept = 0,
                slope = 1,
                linetype = 2) +
    geom_point() + theme_classic() + stat_smooth(se = F, method = "lm") +
    facet_grid(. ~ pop) + xlim(-10, 0) + ylim(-10, 0) +
    geom_polygon(data = as.data.frame(hulls), alpha = 0.5) +
    annotate(
      "text",
      x = -7,
      y = -2,
      label = hydroscapearea,
      size = 10
    )
  ggsave(
    file = paste("data/hydroscape/plots/", pop.use, "_above_rm.pdf", sep = ""),
    height = 4,
    width = 4
  )
}

plot.hydro("A")
plot.hydro("BG")
plot.hydro("BT")
plot.hydro("CIB")
plot.hydro("CO")
plot.hydro("DM")
plot.hydro("HV")
plot.hydro("K")
plot.hydro("RC")
plot.hydro("RM")
plot.hydro("SEV")
plot.hydro("SGS")
plot.hydro("ST")
plot.hydro("W")
plot.hydro("WR")
