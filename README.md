
# Data Science and Visualization in R

Update: 2022-01-29

This is the repository for PSYC 492/971 Data Science and Visualization
in R. In it, you will find:

-   [syllabus](https://github.com/JeffreyRStevens/dsvr2021/blob/main/docs/syllabus.pdf)
-   [lesson presentations and
    code](https://github.com/JeffreyRStevens/dsvr2021/tree/main/docs/lessons)
-   [exercises](https://github.com/JeffreyRStevens/dsvr2021/tree/main/inst/tutorials)
-   [module
    check-ins](https://github.com/JeffreyRStevens/dsvr2021/tree/main/docs/checkins)
-   [data
    files](https://github.com/JeffreyRStevens/dsvr2021/tree/main/data)

To copy this repo to you computer, use the command line to get to the
directory where you want the repo and type:

`git clone https://github.com/JeffreyRStevens/dsvr2021.git`

If you have questions or thoughts that you want to pose to the class,
post them in the repo’s
[Discussions](https://github.com/JeffreyRStevens/dsvr2021/discussions).
Also, check out the Discussions to answer other people’s questions.

If you find any bugs (malfunctioning code), typos (mistakes in content),
or difficult/confusing content or want to request a feature, please
submit an [issue](https://github.com/JeffreyRStevens/dsvr2021/issues).

## Schedule

| Lesson | Topic                               | Readings                                                                                                                                                                                                                                                        |
|-------:|:------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|      1 | Data science and R                  | [SIDS 1](https://moderndive.netlify.app/1-getting-started.html), [RYWM 1](https://rladiessydney.org/courses/ryouwithme/01-basicbasics-1/), [Wickham 2020](https://tidyverse.tidyverse.org/articles/manifesto.html)                                              |
|      2 | Coding basics                       | [R4DS Ch. 1](https://r4ds.had.co.nz/introduction.html), [4](https://r4ds.had.co.nz/workflow-basics.html), [6](https://r4ds.had.co.nz/workflow-scripts.html), [8](https://r4ds.had.co.nz/workflow-projects.html)                                                 |
|      3 | Version control                     | [Bryan 2017](https://doi.org/10.7287/peerj.preprints.3159v2)                                                                                                                                                                                                    |
|      4 | Literate programming                | [R4DS Ch. 27](https://r4ds.had.co.nz/r-markdown.html), [Markdown tutorial](https://commonmark.org/help/tutorial/)                                                                                                                                               |
|      5 | Data types and structures           | [R4DS Ch. 20](https://r4ds.had.co.nz/vectors.html)                                                                                                                                                                                                              |
|      6 | Importing and exporting data        | [R4DS Ch. 11](https://r4ds.had.co.nz/data-import.html)                                                                                                                                                                                                          |
|      7 | Cleaning columns                    | [R4DS Ch. 5.1, 5.4, 5.5](https://r4ds.had.co.nz/transform.html)                                                                                                                                                                                                 |
|      8 | Wrangling rows                      | [R4DS Ch. 5.2, 5.3, 5.6](https://r4ds.had.co.nz/transform.html)                                                                                                                                                                                                 |
|      9 | Tidy data                           | [R4DS Ch. 12](https://r4ds.had.co.nz/tidy-data.html)                                                                                                                                                                                                            |
|     10 | Merging data                        | [R4DS Ch. 13](https://r4ds.had.co.nz/relational-data.html)                                                                                                                                                                                                      |
|     11 | Character strings                   | [R4DS Ch. 14](https://r4ds.had.co.nz/strings.html)                                                                                                                                                                                                              |
|     12 | Factors, dates, and times           | [R4DS Ch. 15](https://r4ds.had.co.nz/factors.html), [16](https://r4ds.had.co.nz/dates-and-times.html)                                                                                                                                                           |
|     13 | Functions and flow                  | [R4DS Ch. 19](https://r4ds.had.co.nz/functions.html), [21](https://r4ds.had.co.nz/iteration.html)                                                                                                                                                               |
|     14 | Grammar of graphics                 | [R4DS Ch. 3](https://r4ds.had.co.nz/data-visualisation.html), [FDV Ch. 1](https://clauswilke.com/dataviz/introduction.html), [2](https://clauswilke.com/dataviz/aesthetic-mapping.html), [3](https://clauswilke.com/dataviz/coordinate-systems-axes.html)       |
|     15 | Design and style                    | [FDV Ch. 17](https://clauswilke.com/dataviz/proportional-ink.html), [25](https://clauswilke.com/dataviz/avoid-line-drawings.html), [26](https://clauswilke.com/dataviz/no-3d.html), [29](https://clauswilke.com/dataviz/telling-a-story.html)                   |
|     16 | Color                               | [FDV Ch. 4](https://clauswilke.com/dataviz/color-basics.html), [19](https://clauswilke.com/dataviz/color-pitfalls.html)                                                                                                                                         |
|     17 | Visualizing distributions           | [FDV Ch. 7](https://clauswilke.com/dataviz/histograms-density-plots.html), [8](https://clauswilke.com/dataviz/ecdf-qq.html), [9](https://clauswilke.com/dataviz/boxplots-violins.html)                                                                          |
|     18 | Visualizing amounts and proportions | [FDV Ch. 6](https://clauswilke.com/dataviz/visualizing-amounts.html), [10](https://clauswilke.com/dataviz/visualizing-proportions.html), [11](https://clauswilke.com/dataviz/nested-proportions.html)                                                           |
|     19 | Visualizing x-y data                | [FDV Ch. 12](https://clauswilke.com/dataviz/visualizing-associations.html), [13](https://clauswilke.com/dataviz/time-series.html), [14](https://clauswilke.com/dataviz/visualizing-trends.html)                                                                 |
|     20 | Finessing plots                     | [FDV Ch. 18](https://clauswilke.com/dataviz/overlapping-points.html), [20](https://clauswilke.com/dataviz/redundant-coding.html), [21](https://clauswilke.com/dataviz/multi-panel-figures.html), [23](https://clauswilke.com/dataviz/balance-data-context.html) |
|     21 | Adorning plots                      | [FDV Ch. 22.1-22.2](https://clauswilke.com/dataviz/figure-titles-captions.html), [24](https://clauswilke.com/dataviz/small-axis-labels.html), [R4DS Ch. 28](https://r4ds.had.co.nz/graphics-for-communication.html)                                             |
|     22 | Extending plots                     | [FDV Ch. 16](https://clauswilke.com/dataviz/visualizing-uncertainty.html), [27](https://clauswilke.com/dataviz/image-file-formats.html)                                                                                                                         |
|     23 | Tables                              | [FDV Ch. 22.3](https://clauswilke.com/dataviz/figure-titles-captions.html#tables), [RMC 10.1](https://bookdown.org/yihui/rmarkdown-cookbook/kable.html)                                                                                                         |
|     24 | TBA                                 |                                                                                                                                                                                                                                                                 |

FDV = [Fundamentals of Data
Visualization](https://clauswilke.com/dataviz), R4DS = [R for Data
Science](https://r4ds.had.co.nz/), RMC = [R Markdown
Cookbook](https://bookdown.org/yihui/rmarkdown-cookbook), RYWM =
[RYouWithMe](https://rladiessydney.org/courses/ryouwithme/), SIDS =
[Statistical Inference via Data
Science](https://moderndive.netlify.app/)

![](figures/monster_support_allisonhorst.jpg)

Illustrations by [Allison Horst](https://www.allisonhorst.com/).
