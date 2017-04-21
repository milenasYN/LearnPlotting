############################################################
# FACETING 
# (AKA: SMALL MULTIPLES / TRELLIS CHARTS)
#
# How to ...
#   - create small multiple charts
#   - use two different faceting techniques: wrap and grid
#
#
# (Release: 2016-10)
#
# sharpsightlabs.com
# © Copyright 2016 Sharp Sight Labs
# All rights reserved
#
############################################################



# load package
library(startingDataScience)



#===============================================================================
# FACET WRAP
#  facet_wrap() creates a “ribbon” of panels that wrap from one line to the next
#===============================================================================


# UNFACETED version
# density plot of price
ggplot(diamonds, aes(x = price)) +
  geom_density()

# FACETED
ggplot(diamonds, aes(x = price)) +
  geom_density() +
  facet_wrap(~cut)



# Specify number of columns
ggplot(diamonds, aes(x = price)) +
  geom_density() +
  facet_wrap(~cut, ncol = 2)


# Specify number of rows
ggplot(diamonds, aes(x = price)) +
  geom_density() +
  facet_wrap(~cut, nrow = 5)



#========================================================================
# FACET GRID
# facet_grid() creates a “grid” of panels using two categorical variables
#========================================================================

# UNFACETED version
# density plot of price
ggplot(diamonds, aes(x = price)) +
  geom_density()



# FACETED
ggplot(diamonds, aes(x = price)) +
  geom_density() +
  facet_grid(cut ~ color)





#=========================================================
# SINGLE COLUMN / SINGLE ROW 
# - note: this is ultimately a variation on  facet_grid()
#         we use a special syntax with the "."
#=========================================================


# SINGLE COLUMN
ggplot(diamonds, aes(x = price)) +
  geom_density() +
  facet_grid(cut ~ .)


# SINGLE ROW
ggplot(diamonds, aes(x = price)) +
  geom_density() +
  facet_grid(. ~ cut)






######################################
# MORE EXAMPLES
################


#-----------
# supercars
#-----------

# inspect
head(supercars)
glimpse(supercars)


# top speed distribution
ggplot(data = supercars, aes(x = top_speed_mph)) +
  geom_histogram() +
  facet_wrap(~decade)


# horsepower BY top speed BY decade
ggplot(data = supercars, aes(x = horsepower_bhp, y = top_speed_mph)) +
  geom_point(alpha = .6) +
  facet_wrap(~decade)




#---------
# diamonds
#---------

# price distribution BY cut
ggplot(data = diamonds, aes(x = price)) +
  geom_histogram() +
  facet_wrap(~cut)


# carat BY price BY cut
# - note: not much to see here .... but, a good check
ggplot(data=diamonds, aes(x = carat, y = price)) +
  geom_point() +
  facet_wrap(~cut)




