#!/usr/bin/env Rscript

#cranRepo <- "http://cran.ma.imperial.ac.uk/"
#install.packages("devtools", repos=cranRepo)
#install.packages("stringi", repos=cranRepo)
#install.packages("dplyr", repos=cranRepo)
#install.packages("servr", repos=cranRepo)
#devtools::install_github("cpsievert/LDAvis")

library(tm)
library(topicmodels)
library(LDAvis)
library(stringi)
library(dplyr)
library(servr)

args <- commandArgs(trailingOnly = TRUE)
name <- if (!is.na(args[1])) args[1] else "sample"

#topicProbabilities <- readRDS("topicProbabilities.rdata")

ehri.corpus <- readRDS("ehri.corpus.rdata")
ehri.dtm <- readRDS("ehri.dtm.rdata")
ehri.lda <- readRDS("ehri.lda.rdata")

phi <- posterior(ehri.lda)$terms %>% as.matrix
theta <- posterior(ehri.lda)$topics %>% as.matrix

vocab <- colnames(phi)
doc_length <- vector()
for (i in 1:length(ehri.corpus)) {
    temp <- paste(ehri.corpus[[i]]$content, collapse = ' ')
    temp.s <- stri_count(temp, regex = '\\S+')
    if (temp.s != 0) { doc_length <- c(doc_length, temp.s)}
}

temp_frequency <- inspect(ehri.dtm)

freq_matrix <- data.frame(ST = colnames(temp_frequency), Freq = colSums(temp_frequency))

# write a JSON representation of the model suitable for rendering with LDAvis
json <- createJSON(phi = phi, theta = theta, vocab = vocab, doc.length = doc_length, term.frequency = freq_matrix$Freq);
write(json, paste(name, "json", sep=".")) 

serVis(json, out.dir = paste(name, "vis", sep = "-"), open.browser = FALSE)
