# -*- coding: utf-8 -*-
"""
Created on Wed Sep 18 01:31:56 2019

@author: Daniel Mayo
"""

coords = [[2,4],[5,5],[7,9]]
theta1 = 0.0
alpha = 0.037

m = len(coords)

count = 0
max_iterations = 50000
sigma = 0.0
diff = 1.0
tolerance = 0.0001

while diff > tolerance and count < max_iterations:
    for point in coords:
        x = point[0]
        y = point[1]
        sigma = sigma + ((theta1 * x) - y) * x
        
    new_theta = theta1 - alpha * (1/m) * sigma
    diff = abs(new_theta - theta1)
    theta1 = new_theta
    sigma = 0.0
    count = count + 1

print('The slope of the line that best fits is:', theta1)
print('The number of iterations needed was:', count)

#  Philadelphia_C2SFinal 11052019 v2 Allen