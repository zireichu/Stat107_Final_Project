
packages <- c(
  "tidyverse",
  "readr",
  "dplyr",
  "ggplot2",
  "knitr",
  "rmarkdown"
)
installed_packages <- rownames(installed.packages())
for (package in packages) {
  if (!package %in% installed_packages) {
    install.packages(package) }}
invisible(lapply(packages, library, character.only = TRUE))

