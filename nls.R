# Nonlinear regression
# Model: f(x) = 1 / (1 + exp(-k*(x-d50)))

fitDoseresponse <- function(raw) {
	data <- data.frame(raw[,1],raw[,2])
	weight <- raw[,3]
	colnames(data) <- c("X","Y")
	
	nls("Y ~ 1/(1+exp(-k*(X - d50)))", data=data, start=list(k=2,d50=11), weigths=weight)
	
	ck <- summary(model)$coefficients[1]
	cd50 <- summary(model)$coefficients[2]
	
#	plot(data[,"X"],data[,"Y"], type ="p", main = "Y vs. X", xlim=c(1,20), ylim=c(0,1))
#	curve(1/(1+exp(-ck*(x-cd50))), add=TRUE)

	return(c(cd50, ck))
}