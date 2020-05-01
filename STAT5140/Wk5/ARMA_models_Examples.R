
library(stats)
# Simulate ARMA process
#NOTE: "acf" function in "TSA" package drops acf at lag 0.

#ARMA(1,1) model:
theta1=0.2
phi1=-0.7
sim.arma1<-arima.sim(model=list(ar=phi1,ma=theta1),n=1000)  #Simulate AR(1) model with coefficient 0.5
ts.plot(sim.arma1) #plot the process
#Plot sample auto-correlation function
acf(sim.arma1) # exponential decay
pacf(sim.arma1) #All pacf after lag 1 are not significant (equal to zero).

#To plot theoritical auto-correlation function
lagmax=10 #set maximum lag for plot acf
ACF=ARMAacf(ar=phi1,ma=theta1, lag.max = lagmax, pacf = FALSE)
plot(seq(0,lagmax,1),ACF,type="h",xlab="lag")
abline(h=0) # acfs after lage 1 are all 0.

#To plot theoritical partial auto-correlation function
lagmax=10 #set maximum lag for plot pacf
PACF=ARMAacf(ar=phi1,ma=theta1, lag.max = lagmax, pacf = TRUE)
plot(seq(1,lagmax,1),PACF,type="h",xlab="lag")
abline(h=0) # acfs after lage 1 are all 0.

#ARMA(2,2) model:
theta1=c(0.1,0.2)
phi1=c(-0.3,0.24)
sim.arma2<-arima.sim(model=list(ar=phi1,ma=theta1),n=1000)  #Simulate AR(2) model with coefficients 0.6 and 0.2
ts.plot(sim.arma2) #plot the process
#Plot sample auto-correlation function
acf(sim.arma2) #exponential decay
pacf(sim.arma2)# All acf after lag 2 are not significant (equal to zero).

#To plor theoritical auto-correlation function
lagmax=10 #set maximum lag for  acf plot
ACF=ARMAacf(ar=phi1,ma=theta1, lag.max = lagmax, pacf = FALSE)
plot(seq(0,lagmax,1),ACF,type="h",xlab="lag")
abline(h=0) # acfs after lage 1 are all 0.

#To plor theoritical partial auto-correlation function
lagmax=10 #set maximum lag for  pacf plot
PACF=ARMAacf(ar=phi1,ma=theta1, lag.max = lagmax, pacf = TRUE)
plot(seq(1,lagmax,1),PACF,type="h",xlab="lag")
abline(h=0) # pacfs after lage 2 are all 0.

# ARMAtoMA and ARMAtoAR
#Consider ARMA(1,1) model with theta1=0.9 and phi1=0.6
library(astsa)
ARMAtoMA(ar=0.6, ma=.9, 10) # first 10 coefficient of MA representation # Section 3.0.1
ARMAtoAR(ar=0.6, ma=.9, 10) # first 10 coefficient of Invertiable (or AR) representation # Section 3.0.2


# Use polyroot function for the roots. 
#p(x) = z1 + z2 * x + … + z[n] * x^(n-1)
#polyroot(c(1, 2, 1))