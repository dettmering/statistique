# Nonlinear regression
# Model: f(x) = 1 / (1 + exp(-k*(x-d50)))

raw <- read.table("D:/test.dat")
data <- data.frame(raw[,1],raw[,2])
colnames(data) <- c("X","Y")

nls("Y ~ 1/(exp(-k*(X - d50)))", data=data, start=list(k=1,d50=11))