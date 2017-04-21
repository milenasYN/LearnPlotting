############################################################
# LAYERING
# (i.e., building plots in layers)
#
# How to ...
# - build charts in layers
# - set default mappings inside of ggplot() function
# - set mappings inside of geoms
#
#
# (Release: 2016-10)
#
# sharpsightlabs.com
# © Copyright 2016 Sharp Sight Labs
# All rights reserved
#
############################################################



#---------------------------------
# load startingDataScience package
#---------------------------------

library(startingDataScience)




#=============
# BLANK CHART
#=============

# completely blank
ggplot(data = diamonds)


# blank chart 
#  - we've given it two variables, but haven't drawn anything!
ggplot(data = diamonds, aes(x = carat, y = price))




#==============================
# SINGLE LAYER
#==============================

#----------------------------
# we add a layer with the '+'
#----------------------------
ggplot(data = diamonds, aes(x = carat, y = price)) + 
  geom_point()



#-------------------------------------
# Data and mappings inside of ggplot() 
#  act as defaults for your layers
#-------------------------------------
ggplot( data = diamonds, aes(x = carat, y = price) ) + 
  geom_point()



#--------------------------------------------
# Datasets and variable mappings 
#  can be specified completely within a layer
#--------------------------------------------
ggplot() + 
  geom_point( data = diamonds, aes(x = carat, y = price) )





#================
# MULTIPLE LAYERS
#================

#---------------
# China CO2 data
#---------------

# inspect
head(china_CO2)


# china co2
# - lines
# - points
ggplot(data = china_CO2, aes(x = year, y = co2_emission_percap_qt)) +
  geom_line() + #LAYER
  geom_point()  #LAYER



#-------------------------
# San Francisco crime data
#-------------------------

# inspect
head(sf_crime)
head(sf_neighborhoods)


# plot SF crime data
# two layers:
#  1. neighborhood polygons
#  2. crimes (points)

ggplot() +
  geom_polygon(data = sf_neighborhoods , aes(x = x_location, y = y_location, group = group)) +
  geom_point(data = sf_crime , aes(x = x_location, y = y_location))


