

library(tidyverse)
library(palmerpenguins)


# Functions ---------------------------------------------------------------

# Let's build a function that reverses the order of columns in a data frame
col_rev <- function(df) {
  df[ncol(df):1]
}
col_rev(penguins)
col_rev(mtcars)

# Now build a function called raise that takes two arguments: the base and the power.
# The function then raises the base to the power---that is, it just applies the ^ operator.



raise(2, 1)
raise(4, 2)
raise(3, 3)
raise(1:10, 2)
raise(225, 0.5)

# Now adjust the function to set a default power of 2



raise(9)


# Now let's write a function that reverse codes Likert ratings.
## What arguments do we need?

## Formula?


mtcars
reverse_code(mtcars$gear, 1, 5)



# Let's say that we want to write a function that generates a separate plot for each species of penguin.
# Typically, to build a more complicated function, you start with a concrete example.
penguins %>%
  filter(species == "Adelie") %>%
  ggplot(aes(bill_length_mm, bill_depth_mm)) +
  geom_point()

penguin_plot <-

penguin_plot(penguins, "Adelie")

# Conditional execution ---------------------------------------------------

## Conditionals in functions -----
# Let's make a function that take in an integer between 1-4 and maps it to a choice
decider <-

decider(1)
decider(2)
decider(3)
decider(4)

# What is a critical problem with this function?
decider(5)
decider("a")

decider <-




decider2(1)
decider2(5)
decider2("a")
decider2(1:4)

## Conditionals in data processing -----

# Especially useful for quantitative data recoding
penguins %>%
  mutate(bill_size = ifelse(bill_length_mm >= 38, "Large", "Small"))

# More than two outcomes requires nesting
penguins %>%
  mutate(bill_size = ifelse(bill_length_mm >= 40, "Large",
                            ifelse(bill_length_mm >= 38, "Medium", "Small")))

# Also useful when recoding based on multiple columns
# How would you create a new column called breed_status that codes all gentoo penguins
# and any penguins on Torgensen Island as "breeding" and everything else as "non-breeding"?
penguins2 <-

View(penguins2)



# Iteration ---------------------------------------------------------------

# How would we subtract the previous observation's bill length from the current observation?



# How would we randomly sample 15 penguin's data and print them to the console?


