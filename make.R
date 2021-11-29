###############################################################################
##
## Script to execute the project
##
## make.R
##
## 29/11/2021
##
## Camille Magneville
##
###############################################################################


# Install dependencies:
devtools::install_deps()


# Load the functions so make them available for use:
# devtools::load_all() or source("R/data_wildfinder.R")
# devtools::load_all() does not work while using targets so use the second option:
source(here::here("R", "data_wildfinder.R"))


# Run the script for the exercice dplyr:
source(here::here("exercices", "exo_dplyr.R"))


# To remove a file:
# unlink(here::here("outputs", "exo_dplyr_hist_mams.png"))
