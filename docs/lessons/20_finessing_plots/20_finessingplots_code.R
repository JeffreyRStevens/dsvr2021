

# Introduction ------------------------------------------------------------

library(tidyverse)
hai <- read_csv("https://decisionslab.unl.edu/data/thayer_stevens_2020_data1.csv") %>%
  select(experiment, participant, condition, gender, pets_now, parent_income, panas_pre = panas_pre_pos,
         panas_post = panas_post_pos, anxiety = vas_anxiety_pre) %>%
  mutate(parent_income = fct_relevel(parent_income, c("< $25000", "$25000-$50000", "$50000-$75000",  "$75000-$100000", "> $100000", "Preferred not to answer")),
         pets = fct_recode(factor(pets_now), "Has pets" = "1", "Has no pets" = "0"))

## How do we calculate a difference score between panas_post and panas_pre?


## How do we combine condition and gender into a column called cond_gend and keep the old columns?



# Overlapping data --------------------------------------------------------

hai %>%
  ggplot(aes(x = condition, y = panas_diff)) +
  geom_point()

## What are two ways that we've already talked about to deal with overlapping points?



## Jitter -----
# We can adjust the position of data with jitter
hai %>%
  ggplot(aes(x = condition, y = panas_diff)) +
  geom_point(position = "jitter")

## Use the geom_jitter() function to jitter the position of the data


# Control degree of jitter with width argument
hai %>%
  ggplot(aes(x = condition, y = panas_diff)) +
  geom_jitter(width = 0.05)


## Beeswarm -----
# Beeswarm plots are more orderly than jitter
# install.packages("ggbeeswarm")
library(ggbeeswarm)

## Replace geom_jitter() with geom_beeswarm()



# Redundant coding --------------------------------------------------------

## How would we plot lines connecting the mean panas_diff values for parent_income with separate lines for cond_gend?


## Add redundant coding by mapping color, shape, linetype to cond_gend


# But since these are factorial combinations of levels, we can manually map properties to factor levels
hai %>%
  ggplot(aes(x = parent_income, y = panas_diff, group = cond_gend, color = cond_gend, shape = cond_gend, linetype = cond_gend)) +
  stat_summary(fun = mean) +
  stat_summary(fun = mean, geom = "line") +
  scale_color_manual(values = c("firebrick", "steelblue", "firebrick", "steelblue")) +
  scale_linetype_manual(values = c(1, 1, 2, 2)) +
  scale_shape_manual(values = c(1, 1, 17, 17))


# Scaling axes ------------------------------------------------------------
# Scaling axes is done with the scale_x/y_continuous() and scale_x/y_discrete() functions.

## Altering axis range -----
# There are two ways to alter an axis range.
# The first sets the limits to the axis scale and sets data outside limits to NA.
# This will remove data outside the limits, which can change stats transformations.

# Discrete axis
hai %>%
  ggplot(aes(x = parent_income, y = panas_diff)) +
  geom_boxplot()

# Let's first scale the discrete x axis to limit the levels
hai %>%
  ggplot(aes(x = parent_income, y = panas_diff)) +
  geom_boxplot() +
  scale_x_discrete(limits = c("$25000-$50000", "$50000-$75000", "$75000-$100000"))

# There is a short cut that focuses on x-axis limits
hai %>%
  ggplot(aes(x = parent_income, y = panas_diff)) +
  geom_boxplot() +
  xlim(c("$25000-$50000", "$50000-$75000", "$75000-$100000"))

# Continuous axis
hai %>%
  ggplot(aes(x = condition, y = panas_diff)) +
  geom_boxplot()

# Need switch to scale_y_continuous() function
hai %>%
  ggplot(aes(x = condition, y = panas_diff)) +
  geom_boxplot() +
  scale_y_continuous(limits = c(-2, 2))

# Or use ylim() function
hai %>%
  ggplot(aes(x = condition, y = panas_diff)) +
  geom_boxplot() +
  ylim(-2, 2)

# Or use lims() function which can control x and y in same function
hai %>%
  ggplot(aes(x = condition, y = panas_diff)) +
  geom_boxplot() +
  lims(y = c(-2, 2))

## Now use ylim() and make the axis -1 to 1


## What happened?

# The second alters the coordinate system and preserves data.
# This effectively 'zooms in' the axis scale.

# Here is the original plot
hai %>%
  ggplot(aes(x = condition, y = panas_diff)) +
  geom_boxplot()

# Here is what happens when we set limits using scale_y_continous() (or ylim() or lims())
hai %>%
  ggplot(aes(x = condition, y = panas_diff)) +
  geom_boxplot() +
  scale_y_continuous(limits = c(-1, 1))

# Now let's set limits by working with the coordinate system
hai %>%
  ggplot(aes(x = condition, y = panas_diff)) +
  geom_boxplot() +
  coord_cartesian(ylim = c(-1, 1))

# This works for discrete axes, too
hai %>%
  ggplot(aes(x = parent_income, y = panas_diff)) +
  geom_boxplot() +
  coord_cartesian(xlim = c(2, 4))


## Altering axis values -----
# What if we don't like the increments used on the axis?
hai %>%
  ggplot(aes(x = parent_income, y = pets_now)) +
  stat_summary(fun.data = mean_se)

## We want the axis to run from 0 to 0.7 in increments of 0.1. How do we create a vector like this?


# Set the breaks argument in scale_y_continuous()
hai %>%
  ggplot(aes(x = parent_income, y = pets_now)) +
  stat_summary(fun.data = mean_se) +
  scale_y_continuous(breaks = pets_increments)

## Remove axis text labels by setting labels = NULL



# Multiple plots ----------------------------------------------------------

## Faceting -----
# Creates separate panels based on discrete data to help visualize interactions.

# Interaction plot with groups
hai %>%
  ggplot(aes(x = condition, y = panas_diff, color = pets, group = pets)) +
  stat_summary(fun.data = mean_cl_normal, position = position_dodge(width = 0.1)) +
  stat_summary(fun = mean, geom = "line", position = position_dodge(width = 0.1))

# Separate out pets into a facet rather than a group
hai %>%
  ggplot(aes(x = condition, y = panas_diff)) +
  geom_beeswarm(color = "grey70") +
  stat_summary(fun.data = mean_cl_normal) +
  facet_wrap(~pets)

## Add gender as rows with facet_grid()


## Add scales = "free" to allow scales to vary freely


## Add experiment before pets to get another factor in there



## Compound plots -----
# Compound plots add separate plots into the same figure (e.g., subfigures)
# First, let's save some plots
(condition_plot <- hai %>%
   ggplot(aes(x = condition, y = panas_diff)) +
   stat_summary(fun.data = mean_cl_normal) +
   stat_summary(fun = mean, geom = "line", aes(group = 1)))

(pets_plot <- hai %>%
    ggplot(aes(x = pets, y = panas_diff)) +
    stat_summary(fun.data = mean_cl_normal) +
    stat_summary(fun = mean, geom = "line", aes(group = 1)))

(income_plot <- hai %>%
    ggplot(aes(x = parent_income, y = panas_diff, group = cond_gend, color = cond_gend, shape = cond_gend, linetype = cond_gend)) +
    stat_summary(fun = mean) +
    stat_summary(fun = mean, geom = "line") +
    scale_color_manual(values = c("firebrick", "steelblue", "firebrick", "steelblue")) +
    scale_linetype_manual(values = c(1, 1, 2, 2)) +
    scale_shape_manual(values = c(1, 1, 17, 17)) +
    theme(legend.position = c(0.9, 0.2)))

condition_plot

library(patchwork)

# Use the + operator to add multiple plots to the same compound plot
condition_plot + pets_plot + income_plot
ggsave(here::here("figures/patchwork1.png"), width = 12)

# Control layout with () and /
(condition_plot + pets_plot) / income_plot
ggsave(here::here("figures/patchwork2.png"), width = 12, height = 10)

# Add subfigure tags with plot_annotation()
(condition_plot + pets_plot) / income_plot + plot_annotation(tag_levels = 'A')

# Add tag prefixes and suffixes
(condition_plot + pets_plot) / income_plot + plot_annotation(tag_levels = 'a', tag_prefix = "(", tag_suffix = ")")


# Plotting challenge ------------------------------------------------------
## Reproduce this figure using this hai data set: figures/figure_finessing.png



# Extra -------------------------------------------------------------------

## Contour plot -----
# If you have a lot of overlapping points...
hai %>%
  ggplot(aes(x = panas_pre, y = panas_post)) +
  geom_point()

# You can also use contour plots to illustrate their density
hai %>%
  ggplot(aes(x = panas_pre, y = panas_post)) +
  geom_density_2d()


## Heatmap -----
# Or use heatmaps, which color the squares based on number of overlapping points
hai %>%
  ggplot(aes(x = panas_pre, y = panas_post)) +
  geom_bin2d()


## Log scales -----
# The default axes scale is linear
hai %>%
  ggplot(aes(x = condition, y = anxiety)) +
  geom_boxplot()

# But you can switch to a base 10 log scale with scale_x/y_log10()
hai %>%
  ggplot(aes(x = condition, y = anxiety)) +
  geom_boxplot() +
  scale_y_log10()

# You can use other transformations (e.g., natural log, square root) by setting the trans argument in scale_x/y_continuous
hai %>%
  ggplot(aes(x = condition, y = anxiety)) +
  geom_boxplot() +
  scale_y_continuous(trans = "log")


## Percent scales -----
# You can convert proportions to percents with scales::percent
hai %>%
  ggplot(aes(x = parent_income, y = pets_now)) +
  stat_summary(fun.data = mean_se) +
  scale_y_continuous(breaks = seq(0, 0.7, 0.1), labels = scales::percent(seq(0, 0.7, 0.1), accuracy = 1))


## Dollar scales -----
# You can format scales as dollars with scales::dollar
# Obviously, this column is not actually in dollars, but it illustrates the function
hai %>%
  ggplot(aes(x = parent_income, y = panas_pre)) +
  stat_summary(fun.data = mean_se) +
  scale_y_continuous(labels = scales::dollar)
