normalizeData <- function(mean1, sd1, mean2, sd2) {
	normalmean <- mean1 / mean2
	normalsd <- normalmean * sqrt((sd2/mean2)^2 + (sd1/mean1)^2)

	return(cbind(normalmean, normalsd))
}

normalizeRaw <- function(data, ctrl) {
  normalmean <- mean(data) / mean(ctrl)
  normalsd <- normalmean * sqrt((sd(data)/mean(data))^2 + (sd(ctrl)/mean(ctrl))^2)
  
  return(cbind(normalmean, normalsd))
}
