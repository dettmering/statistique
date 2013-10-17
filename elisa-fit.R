### ELISA fitting of standard curves: compare linear model with 4PL model

library(drc)

getConc <- function(OD, dilution, logmod.a, logmod.b, logmod.c, logmod.d) {
  result <- exp(log((logmod.d-logmod.c)/(OD-logmod.c) - 1) / logmod.b + log(logmod.e))
  return(result)
}

a <- subset(standardkurven, ELISA.No == 19)

logmod <- drm(formula = a$OD ~ a$Conc, fct = LL.4())

logmod.b <- logmod$coef[1]
logmod.c <- logmod$coef[2]
logmod.d <- logmod$coef[3]
logmod.e <- logmod$coef[4]

plot(logmod, main = unique(a$Designation))

data <- read.table("clipboard")
data$conc <- getConc(data$V1, dilution, logmod.a, logmod.b, logmod.c, logmod.d)
points(data$V1 ~ data$conc, col = "red")
data$conc.dilution <- data$conc * dilution
points(data$V1 ~ data$conc, col="red")
# Subtract medium manually!

write.table(data$final,"clipboard", row.names=F, col.names=F)
