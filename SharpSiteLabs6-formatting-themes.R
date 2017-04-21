#####################################################################
# FORMATTING AND THEMES
#
# How to ...
#   - add axis labels
#   - add a plot title
#   - format the axis labels and plot titles (change color, font etc)
#   - remove gridlines
#   - change gridline colors
#   - create a theme (that you can reuse to format multiple charts)
#
#
# (Release: 2016-11)
#
# sharpsightlabs.com
# © Copyright 2016 Sharp Sight Labs
# All rights reserved
#
#####################################################################


library(startingDataScience)


#----------------
# Add plot title
#----------------

ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_point() +
  labs(title = "Carat vs. Price")


#-------------
# Add x-label
#-------------

ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_point() +
  labs(x = "Weight (carats)")



#-------------
# Add y-label
#-------------

ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_point() +
  labs(y = "Price (dollars)")



#--------------------------------------
# Add plot title, x-label, and y-label
#--------------------------------------

ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_point() +
  labs(title = "Carat vs. Price", x = "Weight (carats)", y = "Price (dollars)")



#------------------
# Change text size
#------------------

ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_point() +
  labs(title = "Carat vs. Price") +
  theme(plot.title = element_text(size = 20))



#-------------------
# Change text color
#-------------------

ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_point() +
  labs(title = "Carat vs. Price") +
  theme(plot.title = element_text(color = "red"))


#-------------------
# Change title font
#-------------------

ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_point() +
  labs(title = "Carat vs. Price") +
  theme(plot.title = element_text(family = "Times"))



#-------------------------------------
# Change axis title color (BOTH axes)
#-------------------------------------

ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_point() +
  theme(axis.title = element_text(color = "red"))




#---------------------------
# Change x-axis title color 
#---------------------------

ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_point() +
  theme(axis.title.x = element_text(color = "red"))



#---------------------------
# Change y-axis title color 
#---------------------------

ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_point() +
  theme(axis.title.y = element_text(color = "red"))




#-------------------------------------
# Change axis text color (BOTH axes)
#-------------------------------------

ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_point() +
  theme(axis.text = element_text(color = "red"))




#---------------------------
# Change x-axis text color 
#---------------------------

ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_point() +
  theme(axis.text.x = element_text(color = "red"))



#---------------------------
# Change y-axis text color 
#---------------------------

ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_point() +
  theme(axis.text.y = element_text(color = "red"))




#--------------------
# Remove axis titles
#--------------------

ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_point() +
  theme(axis.title = element_blank())



#------------------
# Remove gridlines
#------------------

ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_point(color = "red") +
  theme(panel.grid = element_blank())


#------------------------
# Remove minor gridlines
#------------------------

ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_point() +
  theme(panel.background = element_rect(fill = "grey")) +
  theme(panel.grid.minor = element_blank())



ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_point(color = "yellow") +
  labs(title = "Carat vs. Price") +
  theme(text = element_text(color = "#444444")) +
  theme(plot.title = element_text(size = 18, family="Trebuchet MS")) +
  theme(axis.title = element_text(size= 12, family="Trebuchet MS")) +
  theme(panel.background = element_rect(fill = "dark grey")) +
  theme(panel.grid.minor = element_blank()) +
  theme(panel.grid.major = element_line()) 
  


#--------------
# Create Theme
#--------------

theme.newTheme <-
  theme(text = element_text(color = "#444444", family="Trebuchet MS")) +
  theme(plot.title = element_text(size = 18)) +
  theme(axis.title = element_text(size = 12)) +
  theme(panel.background = element_rect(fill = "dark grey")) +
  theme(panel.grid.minor = element_blank())

  

#-------------
# Apply Theme
#-------------

ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_point(color = "yellow") +
  labs(title = "Carat vs. Price") +
  theme.newTheme




  