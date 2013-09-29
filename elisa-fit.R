### ELISA fitting of standard curves: compare linear model with 4PL model

library(ggplot2)
library(drc)

linmod <- lm(a$V2 ~ a$V1)

linmod.m <- linmod$coef[2]
linmod.b <- linmod$coef[1]

a$linmod <- (a$V2 - linmod.b) / linmod.m
a$linmod.dev <- a$linmod - a$V1
a$linmod.percentdev <- ((a$linmod / a$V1) * 100) - 100

logmod <- drm(formula = a$V2 ~ a$V1, fct = LL.4())

logmod.b <- logmod$coef[1]
logmod.c <- logmod$coef[2]
logmod.d <- logmod$coef[3]
logmod.e <- logmod$coef[4]

a$logmod <- exp(log((logmod.d-logmod.c)/(a$V2-logmod.c) - 1) / logmod.b + log(logmod.e))
a$logmod.dev <- a$logmod - a$V1
a$logmod.percentdev <- ((a$logmod / a$V1) * 100) - 100

ggplot(a, aes(x=V1)) +
  geom_line(aes(y = linmod.dev, colour = "linear model")) +
  geom_point(aes(y = linmod.dev, colour = "linear model")) +
  geom_point(aes(y = logmod.dev, colour = "4PL model")) +
  geom_line(aes(y = logmod.dev, colour = "4PL model")) +
  annotate("segment", x = min(a$V1), xend = max(a$V1), y = 0, yend = 0, colour = "blue") +
  xlab("Concentration") +
  ylab("Deviation from fit") +
  scale_colour_manual("", breaks = c("linear model", "4PL model"), values = c("black", "red"))

ggplot(a, aes(x=V1)) +
    geom_line(aes(y = linmod.percentdev, colour = "linear model")) +
    geom_point(aes(y = linmod.percentdev, colour = "linear model")) +
    geom_point(aes(y = logmod.percentdev, colour = "4PL model")) +
    geom_line(aes(y = logmod.percentdev, colour = "4PL model")) +
    annotate("segment", x = min(a$V1), xend = max(a$V1), y = 0, yend = 0, colour = "blue") +
    xlab("Concentration") +
    ylab("Percent deviation from fit") +
    scale_colour_manual("", breaks = c("linear model", "4PL model"), values = c("black", "red"))