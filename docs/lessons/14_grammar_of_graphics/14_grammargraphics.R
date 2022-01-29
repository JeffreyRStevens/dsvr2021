

library(tidyverse)
library(here)
hai <- read_csv("https://decisionslab.unl.edu/data/thayer_stevens_2020_data1.csv") %>%
  select(condition, pre = nback_d_prime_pre, post = nback_d_prime_post, stress = vas_stress_post)

# Building basic plots ----------------------------------------------------

# Seven components of ggplots
#  Data
#  Coordinate -- places data in coordinate system
#  Position -- control placement of data on coordinate
#  Geom -- represents data
#  Mappings -- maps data to properties of geom
#  Stat -- transforms data
#  Facet -- split graph into subplots
#
# ggplot(data = <DATA>) +
#   <GEOM_FUNCTION>(
#     mapping = aes(<MAPPINGS>),
#     stat = <STAT>,
#     position = <POSITION>
#   ) +
#   <COORDINATE_FUNCTION> +
#   <FACET_FUNCTION>

# Full specification of plot
ggplot(data = hai) +
  geom_point(
    mapping = aes(x = pre, y = post),
    stat = "identity",
    position = "identity"
  ) +
  scale_x_continuous() +
  scale_y_continuous() +
  facet_null()

# Required specification of plot
ggplot(data = hai) +
  geom_point(mapping = aes(x = pre, y = post))

# How we'll specify plots
hai %>%
  ggplot(aes(x = pre, y = post)) +
  geom_point()

# Can flip order of x and y as long as argument name is given
hai %>%
  ggplot(aes(y = post, x = pre)) +
  geom_point()

# If argument name is not given, argument order is used
hai %>%
  ggplot(aes(post, pre)) +
  geom_point()

## Build a graph showing the individual data points for stress for each condition


## Now build a box plot of the same thing


## Now include data points behind box plot


## Now include box plot behind data points



# Changing aesthetics -----------------------------------------------------

# Remember aesthetics map aspects of the data to the plot
# Going back to our original plot
hai %>%
  ggplot(aes(x = pre, y = post)) +
  geom_point()

## How do we assign the color "steelblue" to all data? Is this an aesthetic?


## How do we assign different colors to the different conditions? Is this an aesthetic?


# Why is condition not in quotes but steelblue is?
# We'll learn more about choosing color soon

## How do we assign different symbols and colors to the different condition?


## Those symbols are too small. How do we make them bigger?


# There's some overlap in the points. Let's make them partially transparent
hai %>%
  ggplot(aes(x = pre, y = post, color = condition, shape = condition)) +
  geom_point(size = 5, alpha = 0.5)

# Let's add a regression line
hai %>%
  ggplot(aes(x = pre, y = post)) +
  geom_point(size = 5, alpha = 0.5) +
  geom_smooth(method = "lm")

# Let's make separate regression lines with no color differences
hai %>%
  ggplot(aes(x = pre, y = post, group = condition)) +
  geom_point(size = 5, alpha = 0.5) +
  geom_smooth(method = "lm")

## How would we make separate regression lines with different line and point colors per condition?


## How would we replicate this plot but make both of the lines black?


## How would we make one regression line with different point colors per condition?


## How would we replicate this plot but make the line dashed?


# Saving plots -----------------------------------------------------------

# Save ggplots with ggsave
hai %>%
  ggplot(aes(x = pre, y = post, color = condition)) +
  geom_point(size = 5, alpha = 0.5) +
  geom_smooth(method = "lm")
ggsave(here("figures/hai_pre_post_condition.png"))

# Changing image size changes scaling
ggsave(here("figures/hai_pre_post_condition2.png"), width = 8, height = 8)

# So we may need to adjust scaling with scale argument
ggsave(here("figures/hai_pre_post_condition3.png"), width = 8, height = 8, scale = 0.65)

# Font sizes are fine, but points are too big, so let's fix that
hai %>%
  ggplot(aes(x = pre, y = post, color = condition)) +
  geom_point(size = 2, alpha = 0.5) +
  geom_smooth(method = "lm") +
  ggsave(here("figures/hai_pre_post_condition4.png"), width = 8, height = 8, scale = 0.65)



# Resources ---------------------------------------------------------------

# Grammar of Graphics book (Wilkinson 2005): http://www.springer.com/statistics/computational/book/978-0-387-24544-7
# A Layered Grammar of Graphics article (Wickham 2010): https://vita.had.co.nz/papers/layered-grammar.pdf

# {ggplot2} package website: https://ggplot2.tidyverse.org/reference/index.html
# ggplot2 cheatsheet:  https://github.com/rstudio/cheatsheets/raw/master/data-visualization-2.1.pdf
# ggplot2 book: https://ggplot2-book.org/

