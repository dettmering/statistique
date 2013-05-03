### Aggregate Datasets
### Till Dettmering, dettmering(at)gmx.net

aggregateDataset <- function(a) {
	x <- mean(a[,1])
	k <- length(a[,1])
	n <- sum(a[,3])

	variance <- sum(a[,3] / n * a[,2] * a[,2]) + sum(a[,3] / n * (a[,1] - x) * (a[,1] -x))
	sd <- sqrt(variance)
	sem <- sd / sqrt(k)

	x_weight <- sum(a[,3] / n * a[,1])

	aggr <- cbind(x, x_weight, sd, sem, n, k)
	return(aggr)
}