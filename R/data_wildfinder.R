###############################################################################
##
## 3 functions to read WWF data (general, works for everyone) using readR and ...
## ... here packages
##
## data_wildfinder.R
##
## 29/11/2021
##
## Camille Magneville
##
###############################################################################


#' Import WWF species data
#'
#' @return a tibble containing id of species and taxonomic information
#'
#' @export
#'


data.sp.list <- function() {

  # give the relative path to the data and read it:
  data_sp <- readr::read_csv(
            here::here("data", "wwf-wildfinder", "wildfinder-mammals_list.csv")
          )

  return(data_sp)

}



#' Import WWF ecoregions data
#'
#' @return a tibble containing ecoregions id and caracteristics
#'
#' @export
#'


data.eco.list <- function() {

  # give the relative path to the data and read it:
  data_eco <- readr::read_csv(
    here::here("data", "wwf-wildfinder", "wildfinder-ecoregions_list.csv")
  )

  return(data_eco)

}



#' Import WWF data linking ecoregions and mammal species
#'
#' @return a tibble containing ecoregions ids and mammal species ids
#'
#' @export
#'


data.sp.eco.list <- function() {

  # give the relative path to the data and read it:
  data_sp_eco <- readr::read_csv(
    here::here("data", "wwf-wildfinder", "wildfinder-ecoregions_species.csv")
  )

  return(data_sp_eco)

}

