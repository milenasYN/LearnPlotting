############################################################
# POSITION ADJUSTMENTS
#
# How to ...
#   - create dodged bar charts
#   - create stacked bar charts
#   - create 100% stacked bar charts
#   - jitter point geoms
#   - mitigate overplotting (by using jittering technique)
#
#
# (Release: 2016-10)
#
# sharpsightlabs.com
# © Copyright 2016 Sharp Sight Labs
# All rights reserved
#
############################################################




# load library
library(startingDataScience)


#-----------------------------------------------------------------
# basic bar chart
# - this is a basic bar chart
# - we'll be modifying this with many of our position adjustments,
#   so let's take a look at it and how it's structured
#-----------------------------------------------------------------

# basic bar
ggplot(data = diamonds, aes(x = cut)) +
  geom_bar()


# bar with "fill" mapping
ggplot(data = diamonds, aes(x = cut, fill = color )) +
  geom_bar()



#================================================
# STACK
#  -  "stack" stacks elements on top of eachother
#================================================



#--------------------
#  STACKED BAR CHART
#--------------------
ggplot(data = diamonds, aes(x = cut, fill = color)) +
  geom_bar( position = "stack" )




#================================================
# FILL
# - "fill" Stacks elements on top of each other 
#    and adjusts the resultant stack to fill 
#    the plot area (from top to bottom)
#================================================

#-------------------------
# 100% STACKED BAR CHART
#  (AKA, filled bar chart)
#-------------------------
ggplot(data = diamonds, aes(x = cut, fill = color)) +
  geom_bar( position = "fill" )





#======================================
# DODGE
# - "dodge" dodges elements to the side
#======================================

#------------------
# DODGED BAR CHART
#------------------

ggplot(data = diamonds, aes(x = cut, fill = color)) +
  geom_bar( position = "dodge" )




#=================================
# JITTER
# - "jitter" adds random noise 
#    to the position of an element
#=================================

# basic version (no adjustment)
# - this scatterplot has some mild overplotting
ggplot(data = supercars, aes(x=horsepower_bhp, y=car_0_60_time_seconds)) +
  geom_point()


# JITTERED version 
# - this jittered version mitigates the overplotting
#   and removes the striations in the plot
ggplot(data = supercars, aes(x=horsepower_bhp, y=car_0_60_time_seconds)) +
  geom_point(position = "jitter")



