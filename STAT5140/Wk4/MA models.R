#          *** WEEK 4 STAT5140 ***

library(stats)
# Simulate MA process
#NOTE: "acf" function in "TSA" package drops acf at lag 0.

                                         #MA(1) model:
sim.ma1<-arima.sim(model=list(ma=0.5),n=300)  #Simulate MA(1) model with coefficient 0.5
ts.plot(sim.ma1) #plot the process

#Plot sample auto-correlation function
acf(sim.ma1) # All acf after lag 1 are not significant (equal to zero).

#To plot theoritical auto-correlation function
lagmax=10 #set maximum lag for plot acf
ACF=ARMAacf(ma = 0.5, lag.max = lagmax, pacf = FALSE)
plot(seq(0,lagmax,1),ACF,type="h",xlab="lag")
abline(h=0) # acfs after lage 1 are all 0.

                                          #MA(2) model:
sim.ma<-arima.sim(model=list(ma=c(0.6,0.2)),n=1000)  #Simulate MA(2) model with coefficients 0.6 and 0.2
ts.plot(sim.ma) #plot the process
#Plot sample auto-correlation function
acf(sim.ma) # All acf after lag 2 are not significant (equal to zero).

#To plot theoritical auto-correlation function
lagmax=10 #set maximum lag for  acf plot
ACF=ARMAacf(ma = c(0.6,0.2), lag.max = lagmax, pacf = FALSE)
plot(seq(0,lagmax,1),ACF,type="h",xlab="lag")
abline(h=0) # acfs after lage 1 are all 0.



