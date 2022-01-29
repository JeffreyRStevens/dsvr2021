
# This code is commented because it was not actually run (since the input file was fictional)
## read_csv("mypath/myfile.csv")

## filter(mydata, mycolumn == "Sophomore")

## plot(x, y)

## write_csv(mydata, "mypath/myfile.csv")




## read_csv(file = "mypath/myfile.csv")

## filter(.data = mydata, mycolumn == "Sophomore")

## plot(x = x, y = y)

## write_csv(x = mydata, file = "mypath/myfile.csv")



## mydata <- read_csv(file = "mypath/myfile.csv")

## trimmed_data <- filter(.data = mydata, mycolumn == "Sophomore")

## myplot <- plot(x = x, y = y)




2+2 # this is a comment--I can say stuff that isn't run. use me often!
## # this is also a comment--I can be on my own line!


# This is a section ------

## This is a subsection ------

### This is a subsubsection ------


# the best way
x <- 9

# avoid this
y = 10

# definitely don't do this
11 -> z


# chain assignments of the same value to different objects
a <- b <- c <- 0


# while you can do this
a <- 1; b <- 2; c <- 3

# do this instead
a <- 1
b <- 2
c <- 3


mean(x[1,4:10],na.rm=TRUE)+0.5

mean(x[1, 4:10], na.rm = TRUE) + 0.5

mean(x, na.rm = T)

mean(x, na.rm = TRUE)



# This is commented because it is just meant to show indents (though it is functional code that can be run)
## for(i in 1:10) {
## for(j in 1:5) {
## print(x[i, j])
## }
## }


## for(i in 1:10) {
##   for(j in 1:5) {
##     print(x[i, j])
##   }
## }

# This is commented because x has not been defined.
## if (x > 5) {print("Too big!")}


## if (x > 5) {
##   print("Too big!")
## }

