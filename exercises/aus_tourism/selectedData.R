# This function belongs to main_program_aus_tourism.R in order to filter tourism
# data, plot the corresponding time series and get summarized values.

# The purpose is to filter the Australian tourism data (or a similar one) by its
# variables state, region and optionally by purpose in order to get some 
# summarized values and to plot the corresponding time series. 

# Author: Hannah Behrens
# Date: May 2, 2022
# Version Changelog: 
#   v0.1 - Initial Release
#   v0.2 - ...

################################################################################
## Function Definitions
################################################################################

#' Filters the Australian tourism data set or an alternative data set whose 
#' structure is similar.
#'
#' 
#'
#' @param dataset: The (Australian) tourism data set or a similar one 
#'                 (a tibble object or a data frame).
#' @param state: The state that is of interest.
#' @param region: The region that is filtered dependent on the state.
#' @param purpose: The purpose of the visit which can be optionally filtered
#'                 (whether a value is assigned to the argument purpose or not) 
#'                 dependent on the chosen state and region.
#' 
#'           
#' @return The filtered data set (a tibble object or a data frame).
#' 

selectedData <- function(dataset, state, region, purpose=NULL){
  
  filtered_Data <- dataset %>% 
    filter(State == state, Region == region) 
  
  if (!is.null(purpose)) { # filter either for a specific purpose or not
    filtered_Data <- filtered_Data %>%
      filter(Purpose == purpose)
  }
  return(filtered_Data)
}