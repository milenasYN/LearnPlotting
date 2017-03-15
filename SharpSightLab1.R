############################################################
# FIVE ESSENTIAL VISUALIZATIONS 
#
# How to create ...
#   - scatterplots
#   - line charts
#   - bar charts
#   - histograms
#   - boxplots
#
# (Release: 2016-10)
#
# sharpsightlabs.com
#
############################################################


#---------------------------------
# load startingDataScience package
#---------------------------------

library(startingDataScience)

# INSPECT diamonds data frame
head(diamonds)
names(diamonds)
dim(diamonds)


#=============
# BLANK CHART
#=============

# completely blank
ggplot(data = diamonds)
  

# blank chart 
#  - we've given it two variables, but haven't drawn anything!
ggplot(data = diamonds, aes(x = carat, y = price))

#=============
# SCATTERPLOT
#=============

# scatterplot
# - carat vs price
ggplot(data = diamonds, aes(x = carat, y = price )) + geom_point()

#=============
# LINE CHART
#=============

#------------------
# economics dataset
#------------------

# inspect economics dataset
head(economics)


# plot line chart
# - unemployment vs date (i.e., unemployment over time)
ggplot(data = economics, aes(x = date, y = unemploy)) +  geom_line() 


# area chart
# - this is ultimately a variation on the line chart we just plotted
ggplot(data = economics, aes(x = date, y = unemploy)) +  geom_area() 

#-----------------
# pressure dataset
#-----------------

# inspect pressure dataset
head(pressure)

# line chart 
# - temp vs pressure
ggplot(data = pressure, aes(x = temperature, y = pressure)) +  geom_line()

#===========
# HISTOGRAM
#===========

# histogram of price
ggplot(data = diamonds, aes(x = price)) +  geom_histogram()


# histogram of price
# - adjust binwidth
ggplot(data = diamonds, aes(x = price)) +  geom_histogram(binwidth = 200)

#===========
# BAR CHARTS
#===========

# inspect
head(diamonds)
levels(diamonds$cut)

#-----------------------------------
# count observations for each class
#  using stat = "count"
#-----------------------------------

# bar chart
# - count of diamond cuts
ggplot(data = diamonds, aes(x = cut)) +  geom_bar(stat = "count")


# NOTE: "count" is default
# - if we don't specify a stat, it will default to count
ggplot(data = diamonds, aes(x = cut)) +  geom_bar()

#------------------------------
# display value for each class
#  using a bar chart
#   stat = "identity"
#------------------------------

# wrangle data using dplyr
diamonds %>% group_by(cut) %>% summarise(mean(price))

# create summarized dataset
# - this is the same as above code
#   we're just storing the resulting dataframe

df.meanPrice_by_cut <- diamonds %>% group_by(cut) %>% summarize(meanPrice = mean(price))


# inspect summarized dataset
head(df.meanPrice_by_cut)

# plot summarized dataset
ggplot(data = df.meanPrice_by_cut, aes(x = cut, y = meanPrice)) +  geom_bar(stat = "identity")

#=========
# BOXPLOT
#=========

# boxplot
# - distribution of price, by cut
ggplot(data = diamonds, aes(x = cut, y = price)) + geom_boxplot()


# violin plot
# - distribution of price, by cut
# - this is basically a variation of the boxplot above
ggplot(data = diamonds, aes(x = cut, y = price)) +  geom_violin()

#EOF