# This function is part of the Exercise "cswr_programming_R_exercises_
# vectorization.Rmd" of the module "Programming with R".
# The aim is to determine all possible linear models (no interaction between the
# predictors) for a given dependent variable (y) of a given data set like
# datasets::airquality.

# This function constructs all possible linear models based on a given set of
# variables and a dependent variable.
#


# Author: Hannah Behrens
# Date: May 10, 2022
# Version Changelog:
#   v0.1 - Initial Release

#' @param x: A list of all predictor variables (and the dependent variable)
#'           which are the basis to create a linear model.
#' @param y: The dependent variable of the linear model (is the last element of
#'           x, by default).
#' @return A list of the created formula and the linear model based on the inputs.


determiningLinMod <- function(x, y = x[length(x)]){
  # predictors x1 ,..., x_{length(x)-1}
  predictors <- paste(x[-length(x)], collapse = " + ") # concatenate the predictors
  # by a + -sign
  make_formula <- paste(y, " ~ 1 + ", predictors)
  formula_lm <- as.formula(make_formula) # convert the string to a formula
  lin_model <- lm(formula_lm, data = data) # call lm()
  # return the formulas as well as the model
  return(list(formula = formula_lm, model = lin_model))
}
