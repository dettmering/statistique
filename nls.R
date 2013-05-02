# Nonlinear regression
# Model: f(x) = 1 / (1 + exp(-k*(x-d50)))

fitDoseresponse <- function(raw) {
	data <- data.frame(raw[,1],raw[,2],raw[,3],raw[,4])
	colnames(data) <- c("X","Y","R","N")
	
	model <- nls("Y ~ 1/(1+exp(-k*(X - d50)))", data=data, start=list(k=2,d50=11), weigths=data[,"N"])
	
	ck <- summary(model)$coefficients[1]
	cd50 <- summary(model)$coefficients[2]
	ck_err <- summary(model)$coefficients[3]
	cd50_err <- summary(model)$coefficients[4]
	
	plot(data[,"X"],data[,"Y"], type ="p", main = "Y vs. X", xlim=c(1,20), ylim=c(0,1))
	curve(1/(1+exp(-ck*(x-cd50))), add=TRUE)

	return(c(cd50, cd50_err, ck, ck_err))
}
