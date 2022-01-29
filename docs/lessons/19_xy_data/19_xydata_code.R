

# Introduction ------------------------------------------------------------

library(tidyverse)
hai <- read_csv("https://decisionslab.unl.edu/data/thayer_stevens_2020_data1.csv") %>%
  select(experiment, participant, condition, panas_pre = panas_pre_pos,
         panas_post = panas_post_pos, panas_neg = panas_pre_neg,
         bds_pre = bds_index_pre, bds_post = bds_index_post, ncpc_pre = ncpc_pre_diff,
         drm = drm_d_prime)

# Focus on paired data on x-y axis


# Associations ------------------------------------------------------------

## Scatter plots -----
hai %>%
  ggplot(aes(x = panas_pre, y = panas_post)) +
  geom_point()

## How do we add a linear regression line?


# To add a diagonal reference line at x=y, use the geom_abline() with slope = 1
hai %>%
  ggplot(aes(x = panas_pre, y = panas_post, color = condition)) +
  geom_point() +
  geom_abline(intercept = 0, slope = 1)


## Bubble charts -----
# In bubble charts, the size of the point gives information
# Two kinds of bubble charts
# One maps the size to a third continuous variable

## How would we map panas_neg to point size?


# The second counts the number of observations for each x-y point using geom_count()
# Here's the original plot with potential overlapping points
hai %>%
  ggplot(aes(x = bds_pre, y = bds_post)) +
  geom_point()

# Use geom_count() to scale dot size to number of observations
hai %>%
  ggplot(aes(x = bds_pre, y = bds_post)) +
  geom_count()


## Correlation plots -----
# Correlation plots produce a matrix of scatterplots of all combinations of numerical variables
hai_numeric <- hai %>%
  select(panas_pre:drm)

# Use base R's pairs() function to plot all pairwise combinations
pairs(hai_numeric)

# Create function to plot histograms
panel.hist <- function(x, ...) {
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(usr[1:2], 0, 1.5) )
  h <- hist(x, plot = FALSE)
  breaks <- h$breaks; nB <- length(breaks)
  y <- h$counts; y <- y/max(y)
  rect(breaks[-nB], 0, breaks[-1], y, col = "cyan", ...)
}
# Create function to calculate and print correlation coefficients
panel.cor <- function(x, y, digits = 2, prefix = "", cex.cor, ...) {
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r <- abs(cor(x, y))
  txt <- format(c(r, 0.123456789), digits = digits)[1]
  txt <- paste0(prefix, txt)
  if(missing(cex.cor)) cex.cor <- 0.8/strwidth(txt)
  text(0.5, 0.5, txt, cex = cex.cor * r)
}
# Add correlations to upper panel and histograms to diagonal
pairs(hai_numeric, upper.panel = panel.cor, diag.panel = panel.hist)

# To plot these in a ggplot environment, use ggpairs from the {GGally} package
# install.packages("GGally")
library(GGally)
ggpairs(hai, columns = 4:10)

# You can also include categorical variables to get separate histograms and boxplots
ggpairs(hai, columns = 3:10)

# Or you can add a grouping variable to aesthetics
ggpairs(hai, columns = 4:10, aes(color = condition))


## Heatmaps -----
# Heatmaps illustrate the overall correlations rather than plot the actual raw data
# We will build one from scratch to plot in ggplot
# First, calculate correlation matrix
my_corr <- cor(hai_numeric, use = "pairwise.complete.obs")
# Next, remove the lower part of the matrix
my_corr_lower <- my_corr
my_corr_lower[lower.tri(my_corr_lower)] <- NA
# Then, create long version of matrix to plot
my_corr_long <- data.frame(my_corr_lower) %>%
  rownames_to_column(var = "var1") %>%
  pivot_longer(-var1, names_to = "var2", values_to = "correlation", values_drop_na = TRUE) %>%
  mutate(var1 = factor(var1, levels = c("panas_pre", "panas_post", "panas_neg", "bds_pre", "bds_post", "ncpc_pre", "drm")),
         var2 = factor(var2, levels = c("panas_pre", "panas_post", "panas_neg", "bds_pre", "bds_post", "ncpc_pre", "drm")))

# Finally, plot a geom_tile() and fill the tiles based on the correlation
my_corr_long %>%
  ggplot(aes(x = var1, y = fct_rev(var2), fill = correlation)) +
  geom_tile() +
  geom_text(aes(label = round(correlation, 2)), color = "white")

# Alternatively, use the ggcorrplot() function from {ggcorrplot}
# install.package("ggcorrplot")
library(ggcorrplot)
ggcorrplot(my_corr, type = "upper")

## Add correlation values with lab = TRUE
ggcorrplot(my_corr, type = "upper", lab = TRUE)

# Convert squares to circles and scale size to correlation value
ggcorrplot(my_corr, type = "upper", method = "circle")


## Slopegraphs -----
# Slopegraphs plot paired categorical variables and a continuous variable.
# They usually work best when there are relatively few levels for both categorical variables.

# We're going to plot the individual participant Pre/Post data as a slopegraph
## To prepare the data, create a new object hai_panas_pos that only includes the hai condition from experiment 2, keeps only the participant, panas_pre, and panas_post variables, and reshapes the data in a long format with prepost and panas columns.

# I also recoded and releveled the prepost data

# Now we can plot all of the data as points
hai_panas_pos %>%
  ggplot(aes(x = prepost, y = panas)) +
  geom_point()

# But we want to make lines that connect the points for each participant with geom_line()
hai_panas_pos %>%
  ggplot(aes(x = prepost, y = panas)) +
  geom_line()

## That didn't work. How do we fix this so that the lines map to participant?


## How would we overlay means plus 95% CIs for prepost?


## That didn't work. Why not?


## How do we make the lines lighter so the means stand out?


## If we want to include a line that connects the means, add geom = "line" to a new stat_summary()


## Interaction plots -----
# Let's wrangling the data to get two categorical variables plus a continuous one
hai_panas_pos2 <- hai %>%
  filter(experiment == 2) %>%
  select(participant, condition, panas_pre, panas_post) %>%
  pivot_longer(-c("participant", "condition"), names_to = "prepost", values_to = "panas") %>%
  mutate(prepost = fct_recode(prepost, "Pre" = "panas_pre", "Post" = "panas_post"),
         prepost = fct_relevel(prepost, c("Pre", "Post")),
         condition = fct_recode(condition, "Control" = "control", "HAI" = "hai"))

# Use summary_stats() to make interaction plot
hai_panas_pos2 %>%
  ggplot(aes(x = prepost, y = panas, group = condition)) +
  stat_summary(fun.data = mean_cl_normal) +
  stat_summary(fun = mean, geom = "line")

# Let's color the condition separately
hai_panas_pos2 %>%
  ggplot(aes(x = prepost, y = panas, group = condition, color = condition)) +
  stat_summary(fun.data = mean_cl_normal) +
  stat_summary(fun = mean, geom = "line")

## How do we shift the position of the data?



# Time series -------------------------------------------------------------

## Single series -----
# Get data used in FDV
preprint_data <- read_tsv("https://raw.githubusercontent.com/OmnesRes/prepub/master/analyses/preprint_data.txt") %>%
  rename(source = X1)

# Create long version to plot and convert to date
preprint_long <- preprint_data %>%
  pivot_longer(-source, names_to = "date", values_to = "submissions") %>%
  mutate(date = lubridate::ym(date))

# Subset bioRxiv data
biorxiv_data <- preprint_long %>%
  filter(source == "bioRxiv" & submissions > 0)

# Plot time series points
biorxiv_data %>%
  ggplot(aes(x = date, y = submissions)) +
  geom_point()

# Plot time series line with geom_line()
biorxiv_data %>%
  ggplot(aes(x = date, y = submissions)) +
  geom_line()

# Fill in area under line with geom_area()
biorxiv_data %>%
  ggplot(aes(x = date, y = submissions)) +
  geom_line() +
  geom_area(fill = "steelblue")

## Multiple series -----

# Create data with three preprints
three_preprints <- preprint_long %>%
  filter(source %in% c("bioRxiv", "arXiv q-bio", "PeerJ Preprints") & date > "2014-10-31" & date < "2017-02-01")

## How would we create separate lines for the three sources with different colors?



# Plot challenge ----------------------------------------------------------

## Reproduce this figure using this hai data set: figures/figure_xydata.png
## Hint: It only uses the hai data from experiment 2 and it uses the bds variables.
## The grey lines are individual participant data.




# Extras ------------------------------------------------------------------

library(palmerpenguins)
## Add rugs -----
penguins %>%
  ggplot(aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point()

penguins %>%
  ggplot(aes(x = bill_length_mm, y = body_mass_g)) +
  geom_point() +
  geom_rug()

## Add marginal histograms -----
# install.packages("ggExtra")
library(ggExtra)
penguin_plot <- penguins %>%
  ggplot(aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point()
ggMarginal(penguin_plot, type = "densigram")

penguin_plot2 <- penguins %>%
  ggplot(aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
  geom_point() +
  theme(legend.position = c(0.15, 0.15))
ggMarginal(penguin_plot2, type = "histogram", groupFill = TRUE)


## Plot error bars in scatter plots -------
# Prepare data by calculating means and error
penguins_species <- penguins %>%
  group_by(species) %>%
  summarise(length_mean = mean(bill_length_mm, na.rm = TRUE),
            length_sd = sd(bill_length_mm, na.rm = TRUE),
            depth_mean = mean(bill_depth_mm, na.rm = TRUE),
            depth_sd = sd(bill_depth_mm, na.rm = TRUE)
  )

penguins_species %>%
  ggplot(aes(x = length_mean, y = depth_mean, color = species)) +
  geom_point(show.legend = FALSE) +
  geom_errorbarh(aes(xmin = length_mean - length_sd, xmax = length_mean + length_sd), show.legend = FALSE) +
  geom_errorbar(aes(ymin = depth_mean - depth_sd, ymax = depth_mean + depth_sd), show.legend = FALSE) +
  geom_text(aes(label = species), hjust = -0.25, vjust = -0.75, show.legend = FALSE)


## Trends -----

biorxiv_data %>%
  ggplot(aes(x = date, y = submissions)) +
  geom_point()

# Plot fitted curve with geom_smooth()
biorxiv_data %>%
  ggplot(aes(x = date, y = submissions)) +
  geom_point() +
  geom_smooth()

# Remove error bands with se = FALSE
biorxiv_data %>%
  ggplot(aes(x = date, y = submissions)) +
  geom_point() +
  geom_smooth(se = FALSE)


## Fitting models -----
# Create data frame of Ebbinghaus's forgetting data
forgetting <- data.frame(time = c(1/3, 1, 9, 24, 48, 24*6, 24*31), ebbinghaus = c(0.582, 0.442, 0.358, 0.337, 0.278, 0.254, 0.211))

# Plot Ebbinghaus's forgetting data
forgetting %>%
  ggplot(aes(x = time, y = ebbinghaus)) +
  geom_line()

# Add geom_smooth(). Not pretty (or accurate)
forgetting %>%
  ggplot(aes(x = time, y = ebbinghaus)) +
  geom_line() +
  geom_smooth(se = FALSE)

# Fit power function to data
power_model <- nls(ebbinghaus ~ a * time ^ b, data = forgetting, start = c(a = 47, b = -0.13))
# Create sequence of times
time_seq <- 0:(24*31)
# Apply fitted power function to time sequence
forgetting_fit <- data.frame(time = time_seq, ebbinghaus = predict(power_model, list(time = time_seq)))

# Plot fitted power function over observed data
forgetting %>%
  ggplot(aes(x = time, y = ebbinghaus)) +
  geom_line() +
  geom_line(data = forgetting_fit, color = "steelblue", linetype = 2)
