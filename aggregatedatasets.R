### Aggregate Datasets
### Till Dettmering, tilldettmering(at)gmail.com
### based on http://books.google.de/books?id=cn3JtP5ugQsC&lpg=PA141&ots=YHV9PQJB9v&dq=varianz%20von%20%20zusammengefasste%20gruppen%20formel&hl=de&pg=PA141#v=onepage&q&f=false

aggregateDataset <- function(mean, stdev, rpl) {
	a <- cbind(mean, stdev, rpl)

	x <- mean(a[,1])
	sd <- sd(a[,1])
	k <- length(a[,1])
	n <- sum(a[,3])

	variance <- sum(a[,3] / n * a[,2] * a[,2]) + sum(a[,3] / n * (a[,1] - x) * (a[,1] - x))
	sd_weight <- sqrt(variance)
  
  if (is.na(sd_weight)) {
    sd_weight <- sd
    warning("Weighted SD was replaced with unweighted SD due to occurrence of NA.")
  }
  
	sem_weight <- sd_weight / sqrt(n)
	sem <- sd / sqrt(n)

	x_weight <- sum(a[,3] / n * a[,1])

	aggr <- cbind(x, sd, sem, x_weight, sd_weight, sem_weight, n, k)
	return(aggr)
}
