#          *** WEEK 3 STAT5140 ***

#Non Stationary process 
# Process with linear trend
x1=c()
a=0.32
for(t in 1:100){
  x1[t]=a*t+rnorm(1)
}
plot(x1,type="b")

# Process with quadratic trend
x2=c()
# quadratic polynomial coefficients
a1=0.2 
a2=0.1
#mean and variance of the random component
mu1=2
sig1=20
for(t in 1:100){
  x2[t]=(a1*t)+(a2*t^2) + rnorm(1,mean=mu1,sd=sig1)
}
plot(x2,type="l")


# Process with Random trend
t <- 0:100  # time
sig2 <- 1   #variance of WN process
# First, simulate a set of random deviates
e <- rnorm(n = length(t) - 1, sd = sqrt(sig2))
## Now compute their cumulative sum
x3 <- c(0, cumsum(e))
plot(x3, type = "l")

# plot the x[t]-x[t-1]
plot(diff(x3,1),type="l")
acf(diff(x3,1))
?ARMAacf
plot(ARMAacf(ma=0.25, lag.max = 10),type='h')
