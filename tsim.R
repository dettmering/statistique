library(ggplot2)

tsim <- function(rpt, n, mean1, sd1, mean2, sd2) {
  x <- 0
  ppool <- NULL
  while (x <= rpt) {
    ppool <- c(ppool, t.test(rnorm(n,mean1,sd1), y = rnorm(n,mean2,sd2))$p.value)
    x <- x + 1
  }
  return(ppool)
}

y <- 2
num <- 50
res <- NULL

while (y <= num) {
  sim <- tsim(1000, y, 1, 0.2, 1.1, 0.22)
  res <- rbind(res, cbind(y, median(sim), sd(sim)))
  y <- y + 1
}

res <- as.data.frame(res)

ggplot(res, aes(x=y, y=-log10(V2))) +
  geom_line() +
  geom_ribbon(aes(ymin=-log10(V2)-log10(V3), ymax=-log10(V2)+log10(V3)), alpha = 0.2) +
  annotate("segment", x = 6, xend = num, y = -log10(0.05), yend = -log10(0.05), colour = "red", linetype = "dashed") +
  annotate("text",  x = 0, y=-log10(0.05), label= "p = 0.05", hjust=0, size=3) +
  annotate("segment", x = 6, xend = num, y = -log10(0.01), yend = -log10(0.01), colour = "red", linetype = "dashed") +
  annotate("text",  x = 0, y=-log10(0.01), label= "p = 0.01", hjust=0, size=3) +
  annotate("segment", x = 6, xend = num, y = -log10(0.001), yend = -log10(0.001), colour = "red", linetype = "dashed") +
  annotate("text",  x = 0, y=-log10(0.001), label= "p = 0.001", hjust=0, size=3) +
  xlab("Number of replicates") +
  ylab("-log10(p-value)") +
  theme_bw()