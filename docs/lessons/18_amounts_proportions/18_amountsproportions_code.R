

# Introduction ------------------------------------------------------------

library(tidyverse)
hai <- read_csv("https://decisionslab.unl.edu/data/thayer_stevens_2020_data1.csv") %>%
  select(condition, age_num, gender, race, parent_income)

# Focus on amount and proportion data for categories

# Bar plots ---------------------------------------------------------------

## Calculate counts ----
# Calculate counts for bar plots with geom_bar()
hai %>%
  ggplot(aes(x = parent_income)) +
  geom_bar()

## Need to reorder the levels. What function do we use?


hai %>%
  ggplot(aes(x = parent_income)) +
  geom_bar()

## Now make the bars mapped to parent_income and the borders black


# Convert counts to proportions
hai %>%
  ggplot(aes(x = parent_income, y = (..count..)/sum(..count..))) +
  geom_bar()


## Plot counts -----

# Plot amounts directly

## How do we create a new object that calculates the counts for each level of income?


# Plot amounts directly with stat = "identity"
hai_income_count %>%
  ggplot(aes(x = parent_income, y = n)) +
  geom_bar(stat = "identity")

## Use geom_col(), which is just a wrapper for geom_bar(stat = "identity")


## How would we convert the count data to a proportion?


# Now let's plot the proportion
hai_income_count %>%
  ggplot(aes(x = parent_income, y = prop)) +
  geom_col()

# Note this is just for amounts and proportions---that is, when there is a single data point per group.
# There is a strong consensus among statisticians that bar plot should not be used for means because they hide distributional information.
# http://users.stat.umn.edu/~rend0020/Teaching/STAT8801-2015Spring/handouts/24-dynamite.pdf
# So I will not show you how to make a dynamite plot.
# Instead, plot the raw data or a distribution plot (boxplot, violin plot, etc.).
# I would then overlay means and error over the raw/distribution plot.



# Grouping and positioning data --------------------------------------------------------

# If we want to include another variable in our bar plots, we can add them as a group/color/fill
hai %>%
  ggplot(aes(x = parent_income, fill = condition)) +
  geom_bar() # equivalent to geom_bar(position = "stack")

# This stacks the bars by default. This is an example of a position adjustment specified by the `position` argument.
## You can switch from absolute counts to relative proportions by assigning `position = "fill"`. Try it.


# Another important positioning adjustment is dodging, or placing groups next to one another.
## Set position to `dodge`
hai %>%
  ggplot(aes(x = parent_income, fill = condition)) +
  geom_bar(position = "dodge")


# Another way that doesn't use position is to build a population pyramid
hai %>%
  count(parent_income, condition) %>%
  ggplot(aes(x = parent_income, y = ifelse(condition == "hai", n, -n), fill = condition)) +
  geom_col()

## Flip the x and y axis variables



# Dot plots ---------------------------------------------------------------

## What is the principle of proportional ink?


# Dots are often easier to interpret, especially if they are not grounded at 0
hai_income_count %>%
  ggplot(aes(x = parent_income, y = n)) +
  geom_point()

## Often dot plots are oriented with the dependent variable on the x axis. How do we do this?


# Another way is to flip the coordinates with coord_flip()
hai_income_count %>%
  ggplot(aes(x = parent_income, y = n)) +
  geom_point() +
  coord_flip()

## What might be advantages of coord_flip()?

# Now let's try the race data
hai %>%
  group_by(race) %>%
  count() %>%
  ggplot(aes(x = race, y = n)) +
  geom_point() +
  coord_flip()

# Though income levels have a natural order, race does not. So let's order the levels based on the counts.
## How do we order levels based on another variable?


## Sometimes, people like to include a line, which means that it needs to start at 0



# Coordinate systems --------------------------------------------------------------
# Cartesian coordinate systems have two axes (x and y) that are straight.
hai_income_count %>%
  ggplot(aes(x = parent_income, y = n)) +
  geom_col()

# Polar coordinate systems have one straight and one circular axis.
hai_income_count %>%
  ggplot(aes(x = parent_income, y = n)) +
  geom_col() +
  coord_polar()


# Pie charts --------------------------------------------------------------
# Pie charts use polar coordinate systems with the circular (y) axis set to the counts,
# an empty x axis, and the fill set to the categorical variable.
hai_income_count %>%
  ggplot(aes(x = "", y = n, fill = parent_income)) +
  geom_col() +
  coord_polar("y", start = 0)

# Let's remove the axes and background
hai_income_count %>%
  ggplot(aes(x = "", y = n, fill = parent_income)) +
  geom_col() +
  coord_polar("y", start = 0) +
  theme_void()


## Reproduce this figure using this hai data set: figures/figure_amountsproportions.png





# Extras -------------------------------------------------------------------

## Bin continuous data to categories -----
## How do we visualize continuous data counts?


# Categorize continuous variables with cut()
hai <- hai %>%
  mutate(age_categories = cut(age_num, breaks = c(0, 19, 22, 100)),
         age_categories = fct_recode(age_categories, "<20" = "(0,19]", "20-22" = "(19,22]", ">22" = "(22,100]")) %>%
  relocate(age_categories, .after = age_num)

hai %>%
  ggplot(aes(x = age_categories)) +
  geom_bar()

## Treemaps -----
# install.packages("treemapify")
library(treemapify)

hai_income_count %>%
  ggplot(aes(area = n, fill = parent_income, label = parent_income)) +
  geom_treemap() +
  geom_treemap_text(grow = TRUE, place = "center")

## Mosaic plots -----
# install.packages("ggmosaic")
library(ggmosaic)

hai %>%
  ggplot() +
  geom_mosaic(aes(x = product(age_categories, parent_income), fill = age_categories))

