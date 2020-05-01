set.seed(111)
num = 1
phi = runif(num, 0, pi)
time = seq(1,1000, by=1)
x <- sin(2*pi/100*time + phi)

rho = runif(num, 0, pi)
y <- sin(2*pi/100*time + rho)
plot(time, x, col="red")
lines(time, y, col="green")


