normalizeData <- function(a1, a2, b1, b2) {
	normalmean <- a1 / b1
	normalsd <- normalmean * sqrt((b2/b1)^2 + (a2/a1)^2)

	return(cbind(normalmean, normalsd))
}