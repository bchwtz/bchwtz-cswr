# This function belongs to main_program_aus_tourism.R in order to filter tourism
# data, plot the corresponding time series and get summarized values.

# The purpose of this function is to plot the resulting time series of the 
# filtered Australian tourism data set or a similar one (time on x-axis and 
# number of trips on y-axis).

# Author: Hannah Behrens
# Date: May 2, 2022
# Version Changelog: 
#   v0.1 - Initial Release
#   v0.2 - ...

################################################################################
## Function Definitions
################################################################################

#' plotTs(): Plots the time series of the filtered tourism data.
#'
#' This function plots the time series of the filtered Australian tourism data 
#' set (time on x-axis and number of trips on y-axis) or of a similar one 
#' dependent on the chosen state, region and purpose(s). If several purposes are
#' chosen, multiple time series will be plotted. 
#' 
#'
#' @param filtered_data: The filtered (Australian) tourism data set or a similar
#'                       one (a tibble object or a data frame) (filtered based
#'                       on selectedData()).
#'           
#' @return A ggplot which shows the time series of the filtered data set.
#' 


plotTs <- function(filtered_data){
    ts_plot <- ggplot(filtered_data, mapping = aes(x = as.Date(Quarter), 
                                                   y = Trips,
                                                   color = Purpose))+ 
      geom_line()+
      xlab("Time [Quarter]")+
      ylab("Overnight trips ('000)")
    ts_plot # return the created ggplot
}