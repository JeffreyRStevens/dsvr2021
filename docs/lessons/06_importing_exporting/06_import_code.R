
library(here)



mydf <- read.csv(here("data/penguins.csv"))


library(readr)
mydf2 <- read_csv(here("data/penguins.csv"))

mydf3 <- read.csv("https://decisionslab.unl.edu/data/stevens_etal_2020_obed_data1.csv")
mydf4 <- read_csv("https://decisionslab.unl.edu/data/stevens_etal_2020_obed_data1.csv")

library(readxl)
mydf5 <- read_excel(here("data/penguins.xlsx"), sheet = "Sheet2")


write.csv(mydf, here("data/newdata.csv"))
write_csv(mydf, here("data/newdata2.csv"))


library(skimr)
skim(mydf2)

install.packages("dataReporter")
dataReporter::makeCodebook(mydf3, file = here("docs/inclass_demos/06_codebook.Rmd"))

