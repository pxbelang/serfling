fluseason <- subset(serfling, WofY > 18 & WofY < 40)
serfreg <- lm(pctRespFeverILI ~ Week + I(Week*Week) + cos(2*pi*Week/52) + sin(2*pi*Week/52), data=fluseason)
serfconf  <- predict(serfreg, newdata = serfling, interval="confidence", level=0.95)
serffinal <- cbind(serfling, serfconf)

plot(serffinal$pctRespFeverILI, type='l',col="black", ylab="RESP/Fever/ILI as a Proportion of All Visits", main="Excess Respiratory/Fever/ILI Cases, Ontario, 2004-2013", xlab="Week, January 2004 - November, 2013")
lines(serffinal$fit, type='l',col="blue", lwd="2")
lines(serffinal$upr, type='l',col="red")


x <- data.frame(c(1:600))
colnames(x) <- c("Week")
serftmp <- predict(serfreg, newdata = x, interval="confidence", level=0.95)
write.csv(serftmp, file="c:\\temp\\serfling.csv")

