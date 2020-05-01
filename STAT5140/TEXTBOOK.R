#          *** TEXTBOOK SCRIPTS STAT5140 ***

# reset graphing area:
frame()
par(mfrow=c(1,1))

#  ex. 1.9 (11)
w = rnorm(500,0,1)
plot(w)
v = filter(w, sides = 2, filter=rep(1/3,3))
par(mfrow=c(2,1))
plot.ts(w, main = "White noise")
plot.ts(v, ylim=c(-3,3), main = "moving average")

# ex. 1.10 (11)
w = rnorm(550,0,1)
x = filter(w, filter=c(1,-.9), method="recursive")[-(1:50)]
plot.ts(x, ylim=c(-3,3), main = "autoregression")

# ex. 1.11 (12)
set.seed(154)
w = rnorm(200); x = cumsum(w)
wd = w + .2; xd = cumsum(wd)
plot.ts(xd, ylim=c(-5,55), main = "random walk", ylab='')
lines(x, col= 4); abline(h=0, col=4, lty=2); abline(a=0, b=.2, lty=2)

# ex. 1.12 (13)
cs = 2*cos(2*pi*1:500/50 + .6*pi); w = rnorm(500,0,1)
par(mfrow=c(3,1), mar=c(3,2,2,1), cex.main=1.5)
plot.ts(cs, main=expression(2*cos(2*pi*t/50+.6*pi)))
plot.ts(cs+w,main=expression(2*cos(2*pi*t/50+.6*pi) + N(0,1)))
plot.ts(cs+5*w,main=expression(2*cos(2*pi*t/50+.6*pi) + N(0,25)))
