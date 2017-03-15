############################################################
# MANIPULATING COLOR, SIZE, TRANSPARENCY (ggplot2)
#
# How to ...
#   - color your geoms with solid colors
#   - map variables to color aesthetic
#   - change the size of geoms
#   - create a bubble chart
#   - change the transparency of geoms
#   - mitigate overplotting (by changing transparency)
#
#
# (Release: 2016-10)
#
# sharpsightlabs.com
# © Copyright 2016 Sharp Sight Labs
# All rights reserved
#
############################################################

# Load library
library(startingDataScience)

#===================
# MANIPULATING COLOR
#===================

# no color (for comparison)
ggplot(data = diamonds, aes(x = carat, y = price)) + geom_point()

#-------------
# solid colors
#-------------

# points
# - color aesthetic
ggplot(data = diamonds, aes(x = carat, y = price)) + geom_point(color = "dark red")

# more points
# (san francisco crime data)
ggplot(data = sf_crime, aes(x = x_location, y = y_location)) + geom_point(color = "yellow")

# bars
# - fill aesthetic
ggplot(data = diamonds, aes(x = cut)) + geom_bar(fill = "dark red")


# histograms
# - fill aesthetic
ggplot(data = diamonds, aes(x = carat)) + geom_histogram(fill = "dark red")


#-----------------
# using hex colors
#-----------------

# points
# - set to lime green (hex)
ggplot(data = diamonds, aes(x = carat, y = price)) + geom_point(color = "#009900")

# bars
# - set to lime green (hex)
ggplot(data = diamonds, aes(x = cut)) + geom_bar(fill = "#009900")

#-----------------------------------------
# mapping variable to color/fill aesthetic
#-----------------------------------------

# diamonds
# - map clarity to color aesthetic
ggplot(data = diamonds, aes(x = carat, y = price)) + geom_point( aes(color = clarity ) )


# supercars
# - map torque to color aesthetic
ggplot(data = supercars, aes(x = horsepower_bhp, y = top_speed_mph)) +  geom_point(aes(color = torque_lb_ft))

#==================
# MANIPULATING SIZE
#==================

#-------------------------
# simple size modification
#-------------------------

# these points are much smaller
# - this can help mitigate overplotting
ggplot(data = diamonds, aes(x = carat, y = price)) + geom_point(size = .1)

#-------------
# BUBBLE CHART
#-------------

# create data
set.seed(53)

foo <- rnorm( n = 15, mean = 5, sd = 2)
bar <- foo + rnorm(n = 15, mean = 5, sd =4)
size_var <- runif(15, 1,10)

bubble_data <- data.frame(foo, bar, size_var)


# plot bubble chart
ggplot(data = bubble_data, aes(x = foo, y = bar)) + geom_point(aes(size = size_var))

# supercar bubble chart
# - map "car_weight_tons" to size aesthetic
ggplot(data = supercars, aes(x = horsepower_bhp, y = top_speed_mph)) + geom_point(aes(size = car_weight_tons))

#==========================
# MANIPULATING TRANSPARENCY
#==========================

#--------------
# DIAMONDS DATA
#--------------

# basic version
ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_point()


# increased transparency
ggplot(data = diamonds, aes(x = carat, y = price)) + geom_point(alpha = .05)

# increased transparency
# - and color
ggplot(data = diamonds, aes(x = carat, y = price)) + geom_point(alpha = .05, color = "dark red")


#-----------
# SF Crime
#-----------

# basic version
ggplot(data = sf_crime, aes(x = x_location, y = y_location)) + geom_point()


# increased transparency

ggplot(data = sf_crime, aes(x = x_location, y = y_location)) + geom_point(alpha = .05)
