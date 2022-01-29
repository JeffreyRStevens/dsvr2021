

# Factors practice --------------------------------------------------------

## Prepare data -----
# Import data
hai <- read_csv("https://decisionslab.unl.edu/data/thayer_stevens_2020_data1.csv") %>%
  select(date:parent_income, vas_anxiety_pre) %>%
  glimpse()
# Convert character columns to factors



## Relevel factor -----

# Create vector of parent income and assign to 'income'


# How do we check levels of income?


# How do we put them in the order in which they show up in the data?
income %>%
  fct_inorder()

# How do we put them in the order starting with no answer and then increasing in income?
ggplot(hai, aes(parent_income)) +
  geom_bar()
income_order <- c("Preferred not to answer", "< $25000", "$25000-$50000", "$50000-$75000",  "$75000-$100000", "> $100000")



# How do we do this in the data frame?


ggplot(hai, aes(parent_income)) +
  geom_bar()

## Reorder factor based on other data -----
# Prepare data
# How do we find the mean vas_anxiety_pre value for each parent_income?
anxiety <- hai %>%
  group_by(parent_income) %>%
  summarize(mean_anxiety = mean(vas_anxiety_pre, na.rm = TRUE)) %>%
  glimpse()

# Now let's plot them
ggplot(anxiety, aes(x = mean_anxiety, y = parent_income)) +
  geom_point()

# What if we want to order the parent_income levels by the mean_anxiety?
anxiety %>%
  mutate(parent_income = fct_reorder(parent_income, mean_anxiety)) %>%
  ggplot(aes(y = parent_income, x = mean_anxiety)) +
  geom_point()

ggplot(anxiety, aes(x = mean_anxiety, y = fct_reorder(parent_income, mean_anxiety))) +
  geom_point()

## Recode factor -----
# The race categories in this dataset are out of date. Let's recode White/Caucasian to White
hai <- hai %>%
  mutate(race = fct_recode(race, "White" = "White/Caucasian")) %>%
  glimpse()

# The condition variables are too informal with all lower case and wouln't look good on plots. Recode them to HAI and Control

View(hai)

# How would we collapse all incomes below $50,000 into a "Low" level and those $50,000 and above into a "High" level (and maintain "Preferred not to answer")?


# Dates practice ----------------------------------------------------------

library(lubridate)

## Today's date/time -----
# How do we get today's date? How about the time?


## Parsing dates -----
# Parse the following dates
# January 31st, 2017


# 31-Jan-2017


# 01/31/2017 08:01


## Extracting date components -----
today <- today()

# How do we extract today's month


# How do we extract today's month as an abbreviated word?


# How do we extract today's month as a full word?



## Math with dates -----

# Calculate how many days the year 2020 had?


# How many days has it been since September 11th, 2001?


# What will be the date in 100 days? What day of the week with that be?



# Filter the hai data collected between and including 2019-03-31 and 2019-04-16



# Resources ---------------------------------------------------------------

# Software Carpentry's Understanding Factors: https://swcarpentry.github.io/r-novice-inflammation/12-supp-factors/
# {forcats} package website: https://forcats.tidyverse.org/
# {forcats} cheatsheet: https://raw.githubusercontent.com/rstudio/cheatsheets/master/factors.pdf

# {lubridate} package website: https://lubridate.tidyverse.org/
# {lubridate} cheatsheet: https://raw.githubusercontent.com/rstudio/cheatsheets/master/lubridate.pdf
