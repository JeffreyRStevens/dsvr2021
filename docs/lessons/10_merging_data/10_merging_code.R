

library(tidyverse)
library(nycflights13)



# Binding rows and columns ------------------------------------------------

mtcars
mtcars2 <- data.frame(mpg = c(30, 32, 42), cyl = c(4, 6, 4), disp = c(158, 202, 193), hp = c(135, 165, 98), drat = c(3.01, 2.76, 3.15), wt = c(3.45, 2.98, 3.18), qsec = c(17.85, 20.98, 16.03), vs = c(0, 0, 1), am = c(0, 0, 0), gear = c(4, 4, 4), carb = c(1, 3, 2), range = c(NA, NA, 53))
rownames(mtcars2) <- c("Dodge Neon", "Ford Mustang", "Chevrolet Volt")
mtcars2

# Columns don't have to be identical for bind_rows()
bind_rows(mtcars, mtcars2)

# But they do for base R's rbind()
rbind(mtcars, mtcars2)
rbind(mtcars, mtcars2[1:11])

# Can combine multiple data frames at once
bind_rows(mtcars, mtcars2, mtcars2)

rbind(mtcars, mtcars2[1:11], mtcars2[1:11])

# Only use bind_cols() if you are 100% sure that the rows and columns are the same!

(mtcars3 <- data.frame(x = rnorm(32, 0, 1), y = rnorm(32, 100, 12), z = rnorm(32, 0.5, 0.1)))

bind_cols(mtcars, mtcars3)



# Joins ------------------------------------------------------------

# Four new tibbles
airlines
airports
planes
weather

# Go to figure 13.1

# A primary key uniquely identifies an observation in its own table. For example, planes$tailnum is a primary key because it uniquely identifies each plane in the planes table.
# A foreign key uniquely identifies an observation in another table. For example, flights$tailnum is a foreign key because it appears in the flights table where it matches each flight to a unique plane.

# Check that tailnum is primary key for planes (that is, there is only one instance of each level)
planes %>%
  count(tailnum) %>%
  filter(n > 1)

# If you don't have a primary key, create a surrogate key with mutate() or row_number()

# A primary key and the corresponding foreign key in another table form a relation.

# How would you link weather to flights?




## Mutating joins ----------------------------------------------------------

# This is the join that you will use the most

# To add full airline name to flights data
(flights2 <- flights %>%
  select(year:day, hour, origin, dest, tailnum, carrier))

airlines

flights2 %>%
  # select(-origin, -dest) %>%
  left_join(airlines, by = "carrier")


# An inner join matches pairs of observations whenever their keys are equal---unmatched rows are not included
(x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  3, "x3"
))
(y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2",
  4, "y3"
))
x %>%
  inner_join(y, by = "key")

# An outer join keeps observations that appear in at least one of the tables
# A left join keeps all observations in x.
# A right join keeps all observations in y.
# A full join keeps all observations in x and y.
# Go to Figures 13.4.3

# One table has duplicate keys
(x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  2, "x3",
  1, "x4"
))
(y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2"
))
left_join(x, y, by = "key")

# Select columns used to join with argument by =
planes
flights2 %>%
  left_join(planes, by = "tailnum")

# Otherwise, it uses all shared column names, which may be wrong
flights2 %>%
  left_join(planes)

# If data frames have different names for the same column data, use by = c("a" = "b")
airports
flights2 %>%
  left_join(airports, c("dest" = "faa"))




## Filtering joins ---------------------------------------------------------

# Filtering joins affect the observations, not the variables.

# semi_join(x, y) keeps all observations in x that have a match in y.
(top_dest <- flights %>%
  count(dest, sort = TRUE) %>%
  head(10))
flights %>%
  semi_join(top_dest, by = "dest")

# This is equivalent to a filter but is more flexible if you are using multiple columns as keys
flights %>%
  filter(dest %in% top_dest$dest)

# anti_join(x, y) drops all observations in x that have a match in y.
flights %>%
  anti_join(planes, by = "tailnum") %>%
  count(tailnum, sort = TRUE)

# I use this to filter out bad participants
# full_data %>%
#   anti_join(bad_participants, by = "participant")


# PRACTICE -------------------------------------------------------------

# Make table4a and table4b tidy then join them to replicate table1.


# Add the following new data to the end of the penguins data set
new_penguins <- data.frame(species = "Gentoo", island = "Biscoe", bill_length_mm = 49.6, bill_depth_mm = 15.3, flipper_length_mm = 222, body_mass_g = 5400, sex =  "female", year = 2021)



# Add the following new column to the original penguins data set
recorders <- data.frame(recorder = sample(c("CD", "JCR", "RA", "NS", "ES", "EH", "AF", "MH", "AB"), 344, replace = TRUE))



# Merge this data frame with island information to the penguins data set, ignoring islands not in the penguins data set
island_info <- data.frame(island = c("Adolph", "Biscoe", "Dream", "Torgersen"), lat = c("66-19S", "65-26S", "64-44S", "64-46S"), long = c("67-11W", "65-30W", "64-14W", "64-05W"))



# Remove the following airlines' data from the flights data frame in two different ways: once using filter() and once using anti_join()
small_airlines <- data.frame(carrier = c("9E", "FL", "MQ", "OO", "YV"))


