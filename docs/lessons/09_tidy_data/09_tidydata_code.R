library(tidyverse)
library(palmerpenguins)

library(nycflights13)




# Tidy data ---------------------------------------------------------------

library(tidyr)
library(dplyr)

# Tidy data rules
# 1. Each variable must have its own column.
# 2. Each observation must have its own row.
# 3. Each value must have its own cell.

head(table1, n = 4)
head(table2, n = 4)
head(table3, n = 4)
head(table4a, n = 4)
head(table4b, n = 4)
head(table5, n = 4)

# Which table is tidy and why?



# Pivoting ----------------------------------------------------------------

# This is the NEW way of rearranging data (formerly spread and gather, which still work and what is used in the physical book)

# Why is table4a not tidy?
table4a

# Make a wide data frame long

(table6 <- table4a %>%
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases"))

# Why did we have to use backticks to specify 1999 and 2000?

# Let's reverse this
table6 %>%
    pivot_wider(id_cols = country, names_from = year, values_from = cases)

table6 %>%
  pivot_wider(id_cols = country, names_from = year, values_from = cases, names_prefix = "cases_")



# Why is table2 not tidy?
table2

# Make a long data frame wide
table2 %>%
  pivot_wider(names_from = type, values_from = count)





# How do we tidy up this data frame?
(preg <- tribble(
  ~pregnant, ~male, ~female,
  "yes",     NA,    10,
  "no",      20,    12
))






preg %>%
  pivot_longer(c(male, female), names_to = "gender", values_to = "count")







# Import the data file https://decisionslab.unl.edu/data/thayer_stevens_2020_data1.csv
hai_data_raw <- read_csv("https://decisionslab.unl.edu/data/thayer_stevens_2020_data1.csv")
View(hai_data_raw)

# Select the participant and positive panas data
(hai_panas_pos <- select(hai_data_raw, participant, starts_with("panas") & ends_with("pos")))

# Make wide data long with column for pre/post and column for panas_pos value
(hai_panas_pos_long <- pivot_longer(hai_panas_pos, cols = -participant, names_to = "prepost", values_to = "panas_pos"))

# Make long data wide
(hai_panas_pos_wide <- pivot_wider(hai_panas_pos_long, id_cols = participant, names_from = "prepost", values_from = "panas_pos"))



# Separating and uniting --------------------------------------------------

# Why is table3 not tidy?
table3

# separate() pulls apart one column into multiple columns, by splitting wherever a separator character appears
table3 %>%
  separate(rate, into = c("cases", "population"))

# Convert new columns to numbers
table3 %>%
  separate(rate, into = c("cases", "population"), convert = TRUE)

# Separate based on number of characters
table3 %>%
  separate(year, into = c("century", "year"), sep = 2)

# Why is table5 not tidy?
table5

# unite() is the inverse of separate(): it combines multiple columns into a single column
table5 %>%
  unite(new, century, year)

# control the separator
table5 %>%
  unite(new, century, year, sep = "")



# Separate hai_data_raw date column into year, month, day
View(hai_data_raw)

separate(hai_data_raw, date, into = c("year", "month", "day"))


# Unite condition and experiment into cond_exp
unite(hai_data_raw, cond_exp, condition, experiment, sep = "-")
unite(hai_data_raw, cond_exp, condition, experiment, sep = "-", remove = FALSE)






# Missing data ------------------------------------------------------------

# complete() takes a set of columns, and finds all unique combinations. It then ensures the original dataset contains all those values, filling in explicit NAs where necessary
(stocks <- tibble(
  year   = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
  qtr    = c(   1,    2,    3,    4,    2,    3,    4),
  return = c(1.88, 0.59, 0.35,   NA, 0.92, 0.17, 2.66)
))

stocks %>%
  complete(year, qtr)



# Case study --------------------------------------------------------------


who

(who1 <- who %>%
  pivot_longer(
    cols = new_sp_m014:newrel_f65,
    names_to = "key",
    values_to = "cases",
    values_drop_na = TRUE
  ))

# Clean up some typos (we'll learn about stringr later)
(who2 <- who1 %>%
  mutate(names_from = stringr::str_replace(key, "newrel", "new_rel")))


# Separate key into three columns by -
(who3 <- who2 %>%
  separate(key, c("new", "type", "sexage"), sep = "_"))


# Remove some redundant columns
(who4 <- who3 %>%
  select(-new, -iso2, -iso3))


# Separate sexage into two columns by using the character number separator
(who5 <- who4 %>%
  separate(sexage, c("sex", "age"), sep = 1))


# Build a pipeline
(who_all <- who %>%
  pivot_longer(
    cols = new_sp_m014:newrel_f65,
    names_to = "key",
    values_to = "cases",
    values_drop_na = TRUE
  ) %>%
  mutate(
    key = stringr::str_replace(key, "newrel", "new_rel")
  ) %>%
  separate(key, c("new", "var", "sexage")) %>%
  select(-new, -iso2, -iso3) %>%
  separate(sexage, c("sex", "age"), sep = 1))




# PRACTICE ----------------------------------------------------------------

# Using the `who_all` data, for each country and sex, compute the total number of cases of TB.


# Check out the `ChickWeight` (not chickwts) dataset. Filter the data frame to only include `Time` values from 0-12 and call this `chicks`. Pivot the `chicks` data frame so that for each `chick` the seven `Time` values each become a column with the `weight` column as values for those columns and add the prefix "time_" to the column names.


# Check out the `relig_income` dataset. Pivot all of the columns except `religion` to be two columns called `income` and `count`.
