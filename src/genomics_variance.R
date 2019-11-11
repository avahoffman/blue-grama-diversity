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
source("config.R")
setwd(wd)

###########################################################################################
## open data

dat <- read.csv(file="genomics_variance/genomics_variance.csv")

t1 <- summary(lm(total_bio_var~Evar,data=dat)); p1 <- t1$coefficients[2,4]
t2 <- summary(lm(total_bio_var~eMLG,data=dat)); p2 <- t2$coefficients[2,4]
t3 <- summary(lm(total_bio_var~Hexp,data=dat)); p3 <- t3$coefficients[2,4]

t4 <- summary(lm(above_bio_var~Evar,data=dat)); p4 <- t4$coefficients[2,4]
t5 <- summary(lm(above_bio_var~eMLG,data=dat)); p5 <- t5$coefficients[2,4]
t6 <- summary(lm(above_bio_var~Hexp,data=dat)); p6 <- t6$coefficients[2,4]

t7 <- summary(lm(total_plasticity_var~Evar,data=dat)); p7 <- t7$coefficients[2,4]
t8 <- summary(lm(total_plasticity_var~eMLG,data=dat)); p8 <- t8$coefficients[2,4]
t9 <- summary(lm(total_plasticity_var~Hexp,data=dat)); p9 <- t9$coefficients[2,4]

t10 <- summary(lm(above_plasticity_var~Evar,data=dat)); p10 <- t10$coefficients[2,4]
t11 <- summary(lm(above_plasticity_var~eMLG,data=dat)); p11 <- t11$coefficients[2,4]
t12 <- summary(lm(above_plasticity_var~Hexp,data=dat)); p12 <- t12$coefficients[2,4]

p.list <- c(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12)
p.list <- p.adjust(p.list, method = "bonferroni")

c1 <- t1$coefficients[2,]
c2 <- t2$coefficients[2,]
c3 <- t3$coefficients[2,]
c4 <- t4$coefficients[2,]

c5 <- t5$coefficients[2,]
c6 <- t6$coefficients[2,]
c7 <- t7$coefficients[2,]
c8 <- t8$coefficients[2,]

c9 <- t9$coefficients[2,]
c10 <- t10$coefficients[2,]
c11 <- t11$coefficients[2,]
c12 <- t12$coefficients[2,]


c.list <- rbind(c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12)
c.list <- cbind(c.list,p.list)

write.csv(c.list,file="genomics_variance/genomics_variance_coefficients.csv")

