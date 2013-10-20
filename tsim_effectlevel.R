# This script outputs the required number of replicates as the function of the expected effect (given as times control).
# Certain assumptions have to be entered into the variables specified below.

# Function that repeats t-test a number of times (rpt) with given sample size, means and sds.
# Returns a list of p-values from the test

tsim <- function(rpt, n, mean1, sd1, mean2, sd2) {
  pvals <- NULL
  pvals <- replicate(rpt, t.test(rnorm(n,mean1,sd1), y = rnorm(n,mean2,sd2))$p.value)

  return(pvals)
}

# Iterate through mean values and sample sizes, and run the tsim function
# Returns data frame with list of required number of replicates over the expected change (times control)
# in order to reach the probability that the sample size yields p < alpha (80%)

n.range <- 2:100 # Range of sample sizes

ctrl.mean <- 1 # Mean of untreated sample, usually 1
ctrl.cv <- 0.3842015 # Mean CV of untreated samples
treated.range <- seq(1.1, 2, .05) # Range of effects to be expected from treated sample
treated.cv <- 0.4156424 # Mean CV of treated samples

alpha <- 0.05 # Significance level alpha
pi <- 0.8 # Level of adequacy (probability that alpha is reached), 0.8 by convention

res <- NULL

for (j in treated.range) { # Iterate through range of treated samples
  res_n <- NULL
  for (i in n.range) { # Iterate through range of sample sizes
    sim <- tsim(1000, i, ctrl.mean, ctrl.mean * ctrl.cv, j, j * treated.cv)
    res_n <- rbind(res_n, cbind(i, mean(sim < alpha)))
  }
  res_n <- as.data.frame(res_n)
  res <- rbind(res, cbind(j, subset(res_n, V2 > pi)[1,1]))
}

res <- as.data.frame(res)

# Plot the result

library(ggplot2)

ggplot(res, aes(x=j, y=V2)) +
  geom_line() +
  xlab("Expected effect (times control)") +
  ylab("Required sample size") +
  theme_bw()