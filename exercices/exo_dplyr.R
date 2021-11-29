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


## 0 - Goal: plot the number of species per ecoregion

# Load sp-eco data:
data <- data.sp.eco.list()

# Look at the head of data:
head(data)

# Look at the repartition of species in each ecoregions:
mam_per_eco <- table(data$ecoregion_id)

# Plot the histogram:
hist(mam_per_eco, breaks = 50)

# Save the histogram in a .png file:
png(filename = here::here("outputs", "exo_dplyr_hist_mams.png"))

# Close the plot so that clean the plot panel:
dev.off()

