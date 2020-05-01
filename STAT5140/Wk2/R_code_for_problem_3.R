#problem # 3(a)
time = seq(1,1000, by=1)
x=c()
for( i in 1:1000){
  phi=runif(1,-pi,pi)
  x[i] <- sin((2*pi/100)*i + phi)
}
ts.plot(x)

#problem # 3(b)
y=c()
for( i in 1:1000){
  phi=runif(1,0,pi)
  y[i] <- sin((2*pi/100)*i + phi)
}
ts.plot(y)