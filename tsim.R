library(ggplot2)

ctrl.mean <- 1
ctrl.sd <- 0.1
treated.mean <- 1.1
treated.sd <- 0.22

# Function that repeats t-test a number of times (rpt) with given sample size, means and sds.
# Returns a list of p-values from the test

tsim <- function(rpt, n, mean1, sd1, mean2, sd2) {
  pvals <- NULL
  pvals <- replicate(rpt, t.test(rnorm(n,mean1,sd1), y = rnorm(n,mean2,sd2))$p.value)

  return(pvals)
}

# Iterate through sample sizes and run the tsim function
# Returns data frame with list of mean p-values at a given sample size

n_range <- 2:50
res <- NULL

for (i in n_range) {
  sim <- tsim(1000, i, ctrl.mean, ctrl.sd, treated.mean, treated.sd)
  res <- rbind(res, cbind(i, mean(sim), sd(sim)))
}

res <- as.data.frame(res)

# Plot the result

ggplot(res, aes(x=i, y=-log10(V2))) +
  geom_line() +
  geom_ribbon(aes(ymin=-log10(V2)-log10(V3), ymax=-log10(V2)+log10(V3)), alpha = 0.2) +
  annotate("segment", x = 6, xend = max(n_range), y = -log10(0.05), yend = -log10(0.05), colour = "red", linetype = "dashed") +
  annotate("text",  x = 0, y=-log10(0.05), label= "p = 0.05", hjust=0, size=3) +
  annotate("segment", x = 6, xend = max(n_range), y = -log10(0.01), yend = -log10(0.01), colour = "red", linetype = "dashed") +
  annotate("text",  x = 0, y=-log10(0.01), label= "p = 0.01", hjust=0, size=3) +
  annotate("segment", x = 6, xend = max(n_range), y = -log10(0.001), yend = -log10(0.001), colour = "red", linetype = "dashed") +
  annotate("text",  x = 0, y=-log10(0.001), label= "p = 0.001", hjust=0, size=3) +
  xlab("Number of replicates") +
  ylab("-log10(p-value)") +
  theme_bw()