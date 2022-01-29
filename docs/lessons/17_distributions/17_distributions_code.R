


# Introduction ------------------------------------------------------------

library(tidyverse)
hai <- read_csv("https://decisionslab.unl.edu/data/thayer_stevens_2020_data1.csv") %>%
  select(condition, parent_income, panas_pre = panas_pre_pos, panas_post = panas_post_pos)

# Focus on distributions of continuous data


# Histograms --------------------------------------------------------------

# To make histograms, we use geom_histogram(), which uses the stat_bin() statistical transformation
hai %>%
  ggplot(aes(x = panas_post)) +
  geom_histogram()

# What if we don't like the bins? Change number with bins or the size with binwidth
## Change the number of bins to 20




## How do we add a border to the bars?


## How do we make the bars steelblue?



# Density plots -----------------------------------------------------------

# To make density plots, we use geom_density(), which uses the stat_density() statistical transformation
hai %>%
  ggplot(aes(x = panas_post)) +
  geom_density()

## How can we make the density function solid and steelblue1?


## How do we fill the density function with steelblue1 and make the line darkorchid?


## How do we fill the density function with steelblue1 but make the line transparent?


# You can adjust the bandwidth (density equivalent of histogram's binwidth) with bw
hai %>%
  ggplot(aes(x = panas_post)) +
  geom_density(bw = 0.1)
hai %>%
  ggplot(aes(x = panas_post)) +
  geom_density(bw = 0.05)
hai %>%
  ggplot(aes(x = panas_post)) +
  geom_density(bw = 0.7)


# Overlapping density -----------------------------------------------------------
# To create separate densities for condition, fill by condition
hai %>%
  ggplot(aes(x = panas_post, fill = condition)) +
  geom_density()

## How do we make the fills partially transparent?



# Boxplots ----------------------------------------------------------------

# Boxplots require the geom_boxplot() function, which uses the stat_boxplot() statistical transformation

# Let's create boxplots of the panas_pre for each parent_income
hai %>%
  ggplot(aes(x = parent_income, y = panas_pre)) +
  geom_boxplot()

## Need to reorder the levels. What function do we use?


## How do we have ggplot calculate means and standard error?


## Let's combine these


## Oops lines are overlapping. Let's make boxplot lines grey


## I want to plot boxplots for PANAS separately for condition and pre/post.
## What do we need to do to prepare the data?


## But I want the plot to be labeled Pre and Post not panas_pre and panas_post.
## And I want condition to be Control and HAI rather than control and hai.
## How do I do that?


## To plot the condition/prepost combinations on the x axis, the need to be a single columns.
## How do we combine condition and prepost into a single column?


# Now let's plot panas by cond_combine
hai_long %>%
  ggplot(aes(x = cond_combine, y = panas)) +
  geom_boxplot()

## Uh, oh--the order of the levels is not correct. Now we need to relevel.


hai_long %>%
  ggplot(aes(x = cond_combine, y = panas)) +
  geom_boxplot()

## It's a little hard to compare across prepost. How do we color based on that?


# Let's get rid of the legend
hai_long %>%
  ggplot(aes(x = cond_combine, y = panas, color = prepost)) +
  geom_boxplot(show.legend = FALSE)

# But this isn't how I would really do this. Instead, I would use facets.
hai_long %>%
  ggplot(aes(x = prepost, y = panas)) +
  geom_boxplot() +
  facet_wrap(~ condition)

# Maybe add mean and 95% CIs
hai_long %>%
  ggplot(aes(x = prepost, y = panas)) +
  geom_boxplot(color = "grey60") +
  stat_summary(fun.data = mean_cl_normal) +
  facet_wrap(~ condition)


# Violin plots ------------------------------------------------------------

# Violin plots require the geom_violin() function, which uses the stat_density() statistical transformation

# Let's create violin plots of the last boxplots + stat_summary
hai_long %>%
  ggplot(aes(x = prepost, y = panas)) +
  geom_violin(color = "grey60") +
  stat_summary(fun.data = mean_cl_normal) +
  facet_wrap(~ condition)

## Make the density area steelblue1 and lines steelblue


# Now draw quartiles
hai_long %>%
  ggplot(aes(x = prepost, y = panas)) +
  geom_violin(draw_quantiles = c(0.25, 0.5, 0.75)) +
  stat_summary(fun.data = mean_cl_normal) +
  facet_wrap(~ condition)



# Extras -------------------------------------------------------------------


## Ridgeline plots-----
# install.packages("ggridges")
library(ggridges)

# To separate many densities across the y axis to make a ridgeline plot, use geom_density_ridges()
hai %>%
  ggplot(aes(x = panas_pre, y = parent_income)) +
  geom_density_ridges()

## Oops, parent income isn't in the correct order. How do we fix this?
hai <- hai %>%
  mutate(parent_income = fct_relevel(parent_income, c("< $25000", "$25000-$50000", "$50000-$75000", "$75000-$100000", "> $100000", "Preferred not to answer")))

hai %>%
  ggplot(aes(x = panas_pre, y = parent_income)) +
  geom_density_ridges()


## Half-eye plots -----
# install.packages("ggdist")
library(ggdist)

hai %>%
  ggplot(aes(panas_post, y = condition, color = condition, fill = condition)) +
  stat_halfeye(point_color = "black", interval_color = "black", alpha = 0.5, show.legend = FALSE)


## Raincloud plots -----

hai %>%
  ggplot(aes(panas_post, y = condition, color = condition, fill = condition)) +
  stat_dots(side = "bottom", alpha = 0.5, show.legend = FALSE) +
  stat_halfeye(point_color = "black", interval_color = "black", alpha = 0.5, show.legend = FALSE)


