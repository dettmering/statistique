# Logistic regression, use for dose response data with binomial distribution
# RAW data format: Data frame with Dose, Total animals (Total), Responding animals (Resp)

fitDoseresponse <- function(raw) {

#	generates Matrix. First col needs to be number of successes, second col number of failures.

	raw$Mat <- cbind(raw$Resp, raw$Total - raw$Resp)
	
#	Call glm

	result <- glm(Mat ~Dose, family = binomial, data = raw)
	
#	Calculate d50

	findD50 <- function(b) -b[1]/b[2]
	d50 <- findD50(coef(result))

	return(cbind(coef(result), d50))
}
