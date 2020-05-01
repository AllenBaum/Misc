#          *** BOOK:  Introductory Time Series with R ***
#  see:  http://www.maths.adelaide.edu.au/emac2009/#RScripts
#  Ex. 1.4.1
data("AirPassengers")
AP = AirPassengers
start(AP); end(AP); frequency(AP)
# remove season effect by aggregating to the annual level:
layout(1:2)
plot(aggregate(AP))
boxplot(AP ~ cycle(AP))