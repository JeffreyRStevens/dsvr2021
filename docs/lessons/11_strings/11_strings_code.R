


# Introduction -------------------------------------------------------------------
# Working with character strings
# Matching strings
# Combining strings with output

# We'll use the {stringr} package, which is a core tidyverse package

library(tidyverse)
library(palmerpenguins)


# Working with character strings -----------------------------------------------------------------

## Useful character vectors -----

letters
LETTERS
month.name
month.abb
as.character(lubridate::wday(1:7, label = TRUE, abbr = FALSE))

## Quotes and escaping ------

# Create strings with either single quotes or double quotes.
string1 <- "This is a string"
string1
writeLines(string1)
(string2 <- 'So is this.')
writeLines(string2)
(string3 <- 'If I want to include a "double quote" inside a string, I use single quotes')
writeLines(string3)

# Include a literal single or double quote in a string you can use \ to “escape” it:
double_quote <- "\"" # or '"'
writeLines(double_quote)
single_quote <- '\'' # or "'"
writeLines(single_quote)

# Because \ escapes, you can't just wrap it in quotes
# Jeff, copy and paste the next line without the third quote rather than run it from the editor!!!!!!!!!!!
"\""
# If you want an actual backslash printed, you need two \\
backslash <- "\\"
writeLines(backslash)

# When using R Markdown and LaTeX, sometimes you need to escape other characters, which requires two \\
my_cis <- "The 95\\% confidence intervals included 0."
writeLines(my_cis)


## String length -----

# Return number of characters in a string with str_length()
(r4ds_string <- c("a", "R for data science", NA))
str_length(r4ds_string)  # nchar() in base R
# This differs from length...
length(r4ds_string)

# Truncate strings with str_trunc()
x <- "This string is moderately long"
str_trunc(x, 20, side = "right")
str_trunc(x, 20, side = "left")
str_trunc(x, 20, side = "center")
str_trunc(x, 20, side = "right", ellipsis = "")

# Add whitespace with str_pad()
(abcs <- c("a", "abc", "abcdef"))
str_pad(abcs, 2)
str_pad(abcs, max(str_length(abcs)))  # pad to right align
str_pad(abcs, 10, side = "both")  # pad to (almost) center align

# Trim whitespace with str_trim() and str_squish()
(space_string <- "  String with trailing, leading, and double   whitespace\t")
str_trim(space_string)  # trims trailing and leading whitespace
str_squish(space_string)  # also trims extra internal whitespace


## Combining strings -----

# Combine two or more strings with str_c():
c("x", "y", "z")
str_c("x", "y", "z")
str_c("x", "y", "z", sep = ", ")

# Collapse a vector of strings into a single string with collapse argument
str_c(c("x", "y", "z"), collapse = ", ")
# When would this be useful?
str_c(month.name, collapse = ", ")
unique(penguins$species)
str_c(unique(penguins$species), collapse = ", ")


## Extracting strings -----

# Extract parts of a string based on position with str_sub()
x <- c("apple", "banana", "pear")
str_sub(x, 1, 3)  # substr() in base R
# Negative numbers count backwards from end
str_sub(x, -3, -1)
# Useful when you don't have delimiters. But use delimiters!
penguins
penguins %>%
  mutate(island = str_sub(island, 1, 3),
         species = str_sub(species, 1, 1),
         year = str_sub(year, -2, -1))
# Also can substitute characters based on position
x
str_sub(x, 1, 1) <- "#"  # replace first character
x
str_sub(x, -1, -1) <- "*"  # replace last character
x
str_sub(x, 0, 0) <- "~"  # add before first character
x


## Changing case -----

# Control capitalization with str_to_lower(), str_to_upper(), str_to_title(), and str_to_sentence()
(y <- "hello, World")
str_to_lower(y)  # tolower() in base R
str_to_upper(y)  # toupper() in base R
str_to_title(y)
str_to_sentence(y)
# Useful for column names (though in the opposite direction)
str_to_upper(names(penguins))
# Or to change case of column entries
penguins %>%
  mutate(sex_upper = str_to_sentence(sex))
# But notice what happened to data type


# Matching strings --------------------------------------------------------

## Viewing matches -----

# View string patterns with str_view()
x <- c("apple", "banana", "pear")
str_view(x, "an")
str_view(x, ".a.")

# Note that you will rarely use str_view() because you want to actually do stuff with strings, not just view. But the principles of pattern matching described here will carry over to other string functions.

# Use:
# ^ to match the start of the string.
# $ to match the end of the string.
str_view(x, "^a")
str_view(x, "a$")

# \d: matches any digit.
# \s: matches any whitespace (e.g. space, tab, newline).
str_view("March 10, 2020", "\\d")  # view first digit
str_view_all("March 10, 2020", "\\d")  # view all digits
str_view_all("March 10, 2020", "\\s")  # view all spaces
str_view_all("March 10, 2020", "\\s\\d")  # view all spaces and digits
str_view_all("March 10, 2020", "[^\\s\\d]")  # view everything except spaces and digits
str_view_all("March 10, 2020", "[^\\s\\d,]")  # view everything except spaces, digits and ,

# [abc]: matches a, b, or c.
# [^abc]: matches anything except a, b, or c.
str_view(c("abc", "a.c", "a*c", "a c"), "a[ ]")
str_view(c("abc", "a.c", "a*c", "a c"), "a[^ ]")


## Detecting, selecting, and extracting pattern matches -----

# Determine if a character vector matches a pattern with str_detect()
x
str_detect(x, "e")  # results in logical vector
sum(str_detect(x, "e"))  # can be summed for total elements that match
mean(str_detect(x, "e"))  # can calculate mean number of elements that match
x[str_detect(x, "e")]  # show elements that match

# Select the elements that match a pattern with str_subset()
str_subset(x, "e")  # same as x[str_detect(x, "e")]
head(words, n = 20)
str_subset(words, "^rec")  # select elements starting with "rec"
str_subset(words, "ing$")  # select elements ending with "ing"
str_subset(words, "ing")  # select elements including "ing"
# Like a more powerful filter() but for vectors of character strings

# To use in a filter, need to use str_detect() because it returns logical vector
penguins %>%
  filter(sex == "male")  ## using == requires entire value to be "male"
penguins %>%
  filter(str_detect(sex, "male"))  # using str_detect() allows "male" to be anywhere in the value

# Count matches within an element with str_count()
str_count(x, "e")
# How is this different from sum(str_detect(x, "e"))?
sum(str_detect(x, "e"))

# Extract elements that match patterns with str_extract() and str_extract_all()
head(sentences)
str_extract(sentences, "red|orange|yellow|green|blue|purple")
str_extract_all(sentences, "red|orange|yellow|green|blue|purple", simplify = TRUE)


## Replacing pattern matches -----

# Replace matches with new strings with str_replace() and str_replace_all()
str_replace(x, "[aeiou]", "-")  # replace only first instance of match with a string
str_replace_all(x, "[aeiou]", "-")  # replace all matches
# I use this A LOT to recode character variables. Often when there are mistakes in the column entries or open text responses.
mtcars
str_replace(rownames(mtcars), "Merc", "Mercury")
penguins %>%
  mutate(new_species = str_replace(island, "Torgersen", "Party"))

# Replacing matches with NA is a little trickier
str_replace(x, "apple", NA)
x[str_detect(x, "apple")] <- NA
x

# Replace NA with another value, such as "NA" with str_replace_na
str_replace_na(x)  # by default replaces NA with "NA"
str_replace_na(x, "Missing")  # but you can replace with other strings


## Splitting strings -----

# Split a string up into pieces with str_split()
head(sentences, n = 3)
sentences %>%
  head(3) %>%
  str_split(" ")
# Notice this produces a list. Why?
sentences %>%
  head(3) %>%
  str_split(" ", simplify = TRUE)
# Split into specific number of pieces
(fields <- c("Name: Hadley", "Country: NZ", "Age: 35"))
fields %>% str_split(": ", n = 2, simplify = TRUE)


# Combining strings with output ---------------------------------------------

# Pasting character vectors with base R paste()
name <- "Fred"
age <- 50
paste("My name is", name, ", and my age next year is", age + 1, ".")
paste0("My name is", name, ", and my age next year is", age + 1, ".")
paste0("My name is ", name, ", and my age next year is ", age + 1, ".")
paste("My name is ", name, ", and my age next year is ", age + 1, ".", sep = "")

# Gluing character vectors with str_glue()
str_glue("My name is {name}, and my age next year is {age + 1}.")
str_glue("My name is {name}, and my age next year is {age + 1}.", name = "Jane", age = 40)

# Apply to each row of a data frame
penguins %>%
  mutate(full_island = str_glue("{island} Island"))

# Apply to multiple elements of a vector with str_glue_data()
mtcars %>% str_glue_data("{rownames(.)} has {hp} hp")

# What is the difference between these two examples?


# Note str_glue() is wrapper around glue() function from {glue} package.


# PRACTICE ----------------------------------------------------------------

# In the mtcars dataset, extract the first two digits of the mpg variable and the last three digits of the car names.

# For the fruit dataset, capitalize all first word letters in the dataset. Capitalize all words in the dataset.

# Count the number of vowels in each element of the fruit dataset.

# How many fruits in the fruit dataset have the word "fruit" in them?

# Create a vector of the fruits with the word "fruit" in them.

# In the fruit dataset, replace the string "fruit" with "frut".

# Create a new variable in the penguins data frame that appends the string "Sex: " before printing the sex for each observation.



# Resources ---------------------------------------------------------------

# Handling strings with R: https://www.gastonsanchez.com/r4strings
# {glue} package website: https://glue.tidyverse.org/
# Introduction to regular expressions (Codeacademy course): https://www.codecademy.com/learn/introduction-to-regular-expressions/modules/intro-to-regex
