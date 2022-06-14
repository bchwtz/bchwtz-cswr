# This function belongs to main_program_aus_tourism.R in order to filter tourism
# data, plot the corresponding time series and get summarized values.

# The purpose of this function is to summarize the number of trips of the 
# (Australian) tourism data set by region dependent on a chosen state.

# Author: Hannah Behrens
# Date: May 2, 2022
# Version Changelog: 
#   v0.1 - Initial Release
#   v0.2 - ...

################################################################################
## Function Definitions
################################################################################

#' summarizeRegion(): Summarizes the number of trips of the (Australian)
#' tourism data set by region dependent on a chosen state.
#'
#' 
#'
#' @param dataset: The (Australian) tourism data set or a similar one 
#'                 (a tsibble object or a data frame).
#' @param state: The state that is of interest.
#'           
#' @return A data frame, in which the different regions of the chosen state 
#'         as well as the total trips are listed.
#' 


summarizeRegion <- function(dataset, state){
  sum_R <- dataset %>% 
    filter(State == state) %>% 
    group_by(Region) %>% 
    summarize(Trips = sum(Trips))
  sum_R <- as.data.frame(sum_R)
  return(sum_R)
}

