

# Data wrangling with {dplyr}


library(tidyverse)
library(nycflights13)
head(flights, n = 10)


# What function do you use to subset rows based on data values?















# FILTER ------------------------------------------------------------------

# filter() subsets rows based on their values
(today <- filter(flights, month == 6, day == 2))

# Remember logical operators: >, >=, <, <=, !=, ==, %in%

# Boolean operators
# Listing comparisons with commas uses Boolean AND (see above)
filter(flights, month == 6 & day == 2)
flights %>% filter(month == 6 & day == 2)

# To find Boolean OR, use |
filter(flights, month == 11 | month == 12)

# Filter out NAs with !is.na()
(df <- tibble(x = c(1, NA, 3)))

filter(df, !is.na(x))

# How would we find observations that departed more than 18 hours late?


# How would we find observations of flights scheduled in the afternoon that departed more than 18 hours late?


# What function do you use to sort rows?





# ARRANGE -----------------------------------------------------------------

# arrange() sorts order of rows based on their values
arrange(flights, carrier, dep_delay, arr_delay)


# Sort in descending order with desc()
arrange(flights, desc(dep_delay))

# This can be done manually in RStudio, but it is not saved



# What function do you use to choose columns?




# SELECT ------------------------------------------------------------------

# select() selects and reorders columns
select(flights, year, month, day)

# Select all columns between year and day (inclusive)
select(flights, year:day)

# Select all columns except those from year to day (exclusive)
select(flights, -(year:day))

# Select all columns containing specific character string
select(flights, contains("_time"))

# Move a few columns to the front using everything()
select(flights, time_hour, air_time, everything())

# Or using relocate()
relocate(flights, time_hour, air_time, .before = year)

# You can rename columns using select()
select(flights, tail_num = tailnum)

# But this causes what problem?

# Use rename() instead
rename(flights, tail_num = tailnum)

# How would we extract only columns dealing with departure times?

# What are two ways to put the carrier and flight columns after the day column?

# How would we change the name of the carrier column to be "airline"?



# What function do you use to create new columns or change values in columns?


# MUTATE ------------------------------------------------------------------

# mutate() alters an existing column or creates a new column
(flights_sml <- select(flights, year:day, ends_with("delay"), distance, air_time, carrier))
mutate(flights_sml, air_time = air_time / 60)
mutate(flights_sml,
       gain = dep_delay - arr_delay,
       speed = distance / (air_time / 60)
)

# transmute() only keeps newly created columns
transmute(flights,
          gain = dep_delay - arr_delay
)

# How would you create a new column called dist_km that converts the distance column into kilometers by multiplying by 1.61?


# You will use mutate() a lot to recode data later


# PIPE ------------------------------------------------------------------

# The pipe function %>% from the {magrittr} package (automatically loaded with
# all tidyverse functions) allows you to chain {dplyr} (or other tidyverse)
# commands together.

# Without pipe
flights_sml <- select(flights, year:day, ends_with("delay"), distance, air_time, carrier)
flights_sml <- mutate(flights_sml,
       gain = dep_delay - arr_delay,
       speed = distance / (air_time / 60)
)

# With pipe
flights_sml2 <- select(flights, year:day, ends_with("delay"), distance, air_time, carrier) %>%
mutate(gain = dep_delay - arr_delay,
       speed = distance / (air_time / 60)
)

# Chain multiple commands together
(flights_sml3 <- select(flights, year:day, ends_with("delay"), distance, air_time, carrier) %>%
  filter(carrier == "AA") %>%
  mutate(gain = dep_delay - arr_delay,
         speed = distance / air_time * 60) %>%
  arrange(gain))

# Often, people will start with the data object on the first line
flights_sml3 <- flights %>%
  select(year:day, ends_with("delay"), distance, air_time, carrier) %>%
  filter(carrier == "AA") %>%
  mutate(gain = dep_delay - arr_delay,
         speed = distance / air_time * 60
  ) %>%
  arrange(gain)


# SUMMARIZE ---------------------------------------------------------------

# Hadley is from New Zealand, so many of his functions can be spelled both the British and American ways. Sometimes, it is good to use the British way to avoid masking of summarize.



# summarise() applies a function over a data frame.
summarise(flights, delay = mean(dep_delay, na.rm = TRUE))

# Use across() to apply summarise() to multiple columns
summarise(flights, across(contains("_time"), ~mean(.x, na.rm = TRUE)))


# But summarise() is probably most useful with group_by().
(by_day2 <- flights %>%
  group_by(year, month, day) %>%
  summarise(delay = mean(dep_delay, na.rm = TRUE)))


# You can pipe after summarizing
flights %>%
  group_by(dest) %>%
  summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>%
  filter(count > 20, dest != "HNL")

# You can even pipe to graphs, but don't assign them if you want to view them
flights %>%
  group_by(dest) %>%
  summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>%
  filter(count > 20, dest != "HNL") %>%
  ggplot(mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)


# Use na.rm to ignore NAs. Otherwise, any summarized vector with an NA will result in NA
flights %>%
  group_by(year, month, day) %>%
  summarise(mean = mean(dep_delay))
flights %>%
  group_by(year, month, day) %>%
  summarise(mean = mean(dep_delay, na.rm = TRUE))

# Or remove rows with NAs first
flights %>%
  filter(!is.na(dep_delay), !is.na(arr_delay)) %>%
  group_by(year, month, day) %>%
  summarise(mean = mean(dep_delay))

# How would we calculate the number of flights recorded for each carrier sorted from most to fewest flights?


# How would we calculate the mean flight distance for each departure airport and month?



# PRACTICE ----------------------------------------------------------------

# In one line of code, create data frame of all American Airlines (AA) flights departing from JFK








# In one line of code, create data from of flights arriving to the New York City airports (JFK, LGA, EWR)









# In one line of code, create data frame with the rows sorted by the distance between cities








# In one line of code, create data frame only with delay columns








# In one line of code, create data frame with the tailnum column at the beginning and renamed as tail_num









# Create data frame called `delta_long` with a new column of air times converted to hours called `air_time_hours`. Then subset all Delta flights with air times greater than 6 hours ordered by scheduled flight departure time










# In one line of code and using {dplyr} commands and the `max()` function, find the air time in hours for the longest flight in `delta_long`.










# In one line of code, create a data frame with the carrier, origin, scheduled departure time, and actual departure time. Capitalize the first letter of each column.










# Create a data frame that converts air time to hours, calculates the mean and standard deviation (ignoring missing values) of the hours of air time for each carrier and origin only for destination ORD, put the mean and sd columns first, change the origin column name to "start", and sort the rows by airport





