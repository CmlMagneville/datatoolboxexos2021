###############################################################################
##
## Script for dplyr exercice
##
## exo_dplyr.R
##
## 29/11/2021
##
## Camille Magneville
##
###############################################################################


## Hors exercice - Goal: plot the number of species per ecoregion just to write something

# Load sp-eco data:
data <- data.sp.eco.list()

# Look at the head of data:
head(data)

# Look at the repartition of species in each ecoregions:
mam_per_eco <- table(data$ecoregion_id)

# Plot the histogram:
hist(mam_per_eco, breaks = 50, xlab = "Mammal species number",
                               ylab = "Ecoregions number",
                               col = "aquamarine")

# Save the histogram in a .png file:
png(filename = here::here("outputs", "exo_dplyr_hist_mams.png"))

# Close the plot so that clean the plot panel:
dev.off()


### Question 1 : dans combien de royaumes/biomes/ecoregions differents ...
### ... trouve t-on chacune des 7 especes d'Ursides?


## 1 - Importer les donnees

data_sp_eco <- data.sp.eco.list()
data_sp <- data.sp.list()
data_eco <- data.eco.list()


## 2 - Joindre les 3 tables:

# Joindre dans un premier temps data_eco et data_sp_eco pour avoir le lien ...
# ... ecoregions/especes mais il y a une ecoregion ou pas d'espece donc left_join ...
# ... ne marche pas: on fait un inner_join():

data_link_sp_eco <- dplyr::inner_join(data_eco, data_sp_eco, by = "ecoregion_id")

# Puis joindre ces donnees avec les donnees especes (attention, certaines des ...
# ... especes comprises dans le tableau data_link_sp_eco n'ont pas d'infos ...
# ... dans la table d'espece data_sp, donc doit faire un inner_join()):

data_full <- dplyr::inner_join(data_link_sp_eco, data_sp, by = "species_id")


## 3 - Garder les especes qui nous interessent:

# garder les especes du genre Ursidae et supprimer l'espece Ursus malayanus:
data_ursus <- data_full %>%
  dplyr::filter(family == 'Ursidae') %>%
  dplyr::filter(sci_name != "Ursus_malayanus")


## 4 - Calculer le nb de royaumes/biomes/ecoregions uniques pour chaque region:

summary_ursus <- data_ursus %>%
                    # change en facteur le nom des especes:
                   dplyr::mutate(sci_name = as.factor(sci_name)) %>%
                    # on groupe en fonction des noms d'especes:
                   dplyr::group_by(sci_name) %>%
                    # on cree 3 colonnes qui representent le nombre de realm...
                   dplyr::summarise(nb_realm = dplyr::n_distinct(realm),
                                    nb_biome = dplyr::n_distinct(biome),
                                    nb_eco   = dplyr::n_distinct(ecoregion))


### Question 2: visualisation graphique sur le jeu de donnees Pantheria


## 1 - Load le jeu de donnees:

# utilise read_delim car pas un comma separated file:
pantheria <- readr::read_delim("data/pantheria-traits/PanTHERIA_1-0_WR05_Aug2008.txt", delim = "\t")


## 2 - Ranger les donnees:

pantheria_clean <- pantheria %>%
                    # convert 2 columns as factors:
                    dplyr::mutate(MSW05_Order = as.factor(MSW05_Order),
                                  MSW05_Family = as.factor(MSW05_Family)) %>%
                    # rename some columns:
                    dplyr::rename("Adult_Body_Mass" = "5-1_AdultBodyMass_g",
                                  "Dispersal_Age"   = "7-1_DispersalAge_d",
                                  "Gestation"       = "9-1_GestationLen_d",
                                  "Home_Range"      = "22-2_HomeRange_Indiv_km2",
                                  "Litter_Per_Year" =  "16-1_LittersPerYear",
                                  "Max_Longevity"   = "17-1_MaxLongevity_m") %>%
                    # select a few columns:
                    dplyr::select("MSW05_Family", "MSW05_Order",
                                  "Max_Longevity", "Home_Range",
                                  "Litter_Per_Year") %>%
                    # replace -999 value by NA:
                    dplyr::na_if(-999)


## 3 - Representer les donnees:


# combien d'observations dans chaque famille / chaque ordre pour famille et ...
# ... ordre de + de 100 observations?

pantheria_clean %>%

  # grouper par famille:
  dplyr::group_by(MSW05_Family) %>%
  # calculer le nombre d'observation par famille avec la fonction mutate et n():
  dplyr::mutate(n = n()) %>%
  # ne garder que les familles avec + de 100 observations:
  dplyr::filter(n > 100) %>%

  # do the plot:
  ggplot2::ggplot() +
  ggplot2::aes(x = n, y = reorder(MSW05_Family, n)) +
  ggplot2::geom_col() +
  ggplot2::ylab("Family names") +
  ggplot2::xlab("Counts") +
  ggplot2::ggtitle("Number of observation per family (n > 100)")


# scatter plot of litter size as a function of longevity:


pantheria_clean %>%

  # enleve les lignes qui ont des NA dans Litiere ET Longevity:
  dplyr::filter(!is.na(Litter_Per_Year), !is.na(Max_Longevity)) %>%
  # regrouper par Famille:
  dplyr::group_by(MSW05_Family) %>%
  # calculer le nombre d'observation par famille avec la fonction mutate et n():
  dplyr::mutate(n = n()) %>%
  # ne garder que les familles avec + de 10 observations:
  dplyr::filter(n > 10) %>%

  # plot:
  ggplot2::ggplot() +
  ggplot2::aes(x = Max_Longevity, y = Litter_Per_Year, color = MSW05_Family) +
  ggplot2::geom_point(show.legend = FALSE) +
  ggplot2::geom_smooth(method = "lm", show.legend = FALSE) +
  ggplot2::ylab("Litter Size") +
  ggplot2::xlab("Longevity") +
  ggplot2::ggtitle("Litter size as a function of Longevity (n > 10)") +
  ggplot2::facet_wrap(vars(MSW05_Family))

