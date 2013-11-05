### Aggregate Datasets
### Till Dettmering, dettmering(at)gmx.net

aggregateDataset <- function(mean, stdev, rpl) {
	a <- cbind(mean, stdev, rpl)

	x <- mean(a[,1])
	sd <- sd(a[,1])
	k <- length(a[,1])
	n <- sum(a[,3])

	variance <- sum(a[,3] / n * a[,2] * a[,2]) + sum(a[,3] / n * (a[,1] - x) * (a[,1] - x))
	sd_weight <- sqrt(variance)
	sem_weight <- sd_weight / sqrt(n)
	sem <- sd / sqrt(n)

	x_weight <- sum(a[,3] / n * a[,1])

	aggr <- cbind(x, sd, sem, x_weight, sd_weight, sem_weight, n, k)
	return(aggr)
}
