
library(palmerpenguins)
library(tidyverse)


mydata <- penguins

species_means <- mydata %>%
  group_by(species) %>%
  summarise(across(where(is.numeric), mean, na.rm = TRUE))

adelie_means <- species_means %>%
  filter(species == "Adelie")
adelie_means$bill_length_mm

chinstrap_means <- species_means %>%
  filter(species == "Chinstrap")
chinstrap_means$bill_length_mm

gentoo_means <- species_means %>%
  filter(species == "Gentoo")
gentoo_means$bill_length_mm

bill_length_depth_plot <- ggplot(mydata, aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point()
bill_length_depth_plot


