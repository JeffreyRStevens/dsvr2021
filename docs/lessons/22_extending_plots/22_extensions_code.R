

library(tidyverse)
library(palmerpenguins)

# Include stats with plots ------------------------------------------------

# install.packages("ggstatsplot")
library(ggstatsplot)
penguins %>%
  ggbetweenstats(x = sex, y = body_mass_g)



# Use APA theme -----------------------------------------------------------
# install.packages("jtools")
library(jtools)
penguins %>%
  ggplot(aes(x = species, y = body_mass_g)) +
  geom_boxplot() +
  theme_apa()


# Add significance lines --------------------------------------------------

# install.packages("ggsignif")
library(ggsignif)
penguins %>%
  ggplot(aes(x = species, y = body_mass_g)) +
  geom_boxplot() +
  geom_signif(comparisons = list(c("Chinstrap", "Gentoo")), map_signif_level = TRUE, tip_length = 0) +
  geom_signif(y_position = 6600, comparisons = list(c("Adelie", "Gentoo")), map_signif_level = TRUE, tip_length = 0) +
  theme_apa()



