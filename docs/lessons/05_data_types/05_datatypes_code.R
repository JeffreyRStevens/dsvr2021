

mydf <- data.frame(
  datetime = as.Date(c("2021-04-21 11:56:12", "2021-04-21 14:57:44", "2021-04-22 03:09:56", "2021-04-22 12:39:22")),
  session_complete = as.logical(c("TRUE", "TRUE", "TRUE", "FALSE")),
  condition = as.factor(c("control", "control", "experimental", "experimental")),
  mean_response = c(17.53, 24.45, 19.82, NA),
  age = c(19, 20, 19, NA),
  comments = c("none", "Great study", "good", NA)
  )
knitr::kable(mydf)



(a <- 7.2)
typeof(a)
class(a)



(b <- 7)
typeof(b)
class(b)



(c <- 7L)
typeof(c)
class(c)



(d <- "Hello, world")
(e <- "7")
typeof(e)
class(e)



a
(mytest <- a > 5)
d
(mytest2 <- d == "Good-bye, world")
typeof(mytest2)
class(mytest2)



(i <- factor("ab", levels = c("ab", "cd")))
typeof(i)
class(i)



(j <- as.Date("1970-01-01"))
typeof(j)
class(j)

(k <- as.Date("2021-05-26"))
k-j



e
typeof(e)
(l <- as.numeric(e))
typeof(l)

(m <- "TRUE")
typeof(m)
(n <- as.logical(m))
typeof(n)



(o <- factor(0, levels = c("1", "0")))
as.numeric(o)

as.character(o)
as.numeric(as.character(o))



c
c[1]
c[2]
c[2] <- 3
c
c[3] <- 8
c
c[2] <- NA
c



(myvec1 <- c(1, 5, 3, 6))
(myvec2 <- c(11, 14, 18, 12))
c(myvec1, myvec2)

(myvec3 <- c("a", "b", "c"))



myvec2
myvec3
c(myvec2, myvec3)



seq(from = 0, to = 20, by = 5)
seq(from = 20, to = 0, by = -5)
seq(0, 1, 0.2)



4:9
9:4



rep(0, times = 10)

rep(myvec3, times = 3)
rep(c("d", "e", "f"), times = 3)

rep(1:4, times = 3)

rep(1:4, each = 3)



myvec3
length(myvec3)



myvec2
typeof(myvec2)
str(myvec2)

myvec3
typeof(myvec3)
str(myvec3)



myvec2
myvec2[2:4]
myvec2[c(1, 2, 4)]
myvec2[c(4, 1, 3)]


matrix(rnorm(20, mean = 0, sd = 1), nrow = 4)
(mymat1 <- matrix(1:20, nrow = 4))
(mymat2 <- matrix(letters[1:12], nrow = 2, byrow = TRUE, dimnames = list(c("Low", "High"), NULL)))



mymat1
dim(mymat1)



typeof(mymat2)
str(mymat1)
str(mymat2)



mymat1
mymat1[2, 4]
mymat1[1:3, 2]



mymat1[1, 3:5]
mymat1[, 3]
mymat1[4, ]



(mylist <- list(a = 1:4, b = c(4, 3, 8, 5), c = LETTERS[10:15], d = c("yes", "yes")))



typeof(mylist)
typeof(mylist$b)
str(mylist)


mydf



typeof(mydf)
str(mydf)



(mydf1 <- data.frame(1:3, 8:6))



names(mydf1) <- c("subject", "response")
mydf1



(mydf1 <- data.frame(1:3, 8:6))
names(mydf1) <- c("subject", "response")
mydf1



var1 <- c(1:6)
var2 <- c(6:1)
var3 <- c(21:26)
mydf2 <- data.frame(var1, var2, resp = var3)
mydf2



mydf1
mydf1[2, 2]
mydf1[2, 2] <- 6
mydf1[2, 2]

mydf1[2, ]
mydf1[, 2]
mydf1[2:3, 2]



mydf1$response
mydf1$response[2]
mydf1$response[2:3]



head(mtcars)
dplyr::glimpse(mtcars)
tail(mtcars, n = 3)



names(mydf2)
names(mydf2) <- c("subject", "order", "response")



dim(mtcars)
nrow(mtcars)
ncol(mtcars)



mydf2
(mytibble <- tibble::tibble(mydf2))

