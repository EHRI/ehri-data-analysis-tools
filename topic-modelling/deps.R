#!/usr/bin/env Rscript

cranRepo <- "http://cran.ma.imperial.ac.uk/"
install.packages("tm", repos=cranRepo)
install.packages("topicmodels", repos=cranRepo)
install.packages("SnowballC", repos=cranRepo)
install.packages("rJava", repos=cranRepo)
install.packages("devtools", repos=cranRepo)
install.packages("stringi", repos=cranRepo)
install.packages("dplyr", repos=cranRepo)
install.packages("servr", repos=cranRepo)
install.packages("RJSONIO", repos=cranRepo)
devtools::install_github("cpsievert/LDAvis")


