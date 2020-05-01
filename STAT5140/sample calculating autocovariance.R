> eps <- rnorm(100, mean = 0, sd = 1)
> mu <- 2
> X_t <- mu + eps
> ts.plot(X_t, main = "Example of (random) stationary time series", ylab = expression(X[t]))
> acf(X_t, main = "Auto-covariance function of X")
> hist(eps)
> head(eps)