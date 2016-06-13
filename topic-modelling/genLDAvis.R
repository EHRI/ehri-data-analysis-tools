#!/usr/bin/env Rscript

source("lib.R")
argv <- if(exists("argv")) argv else commandArgs(trailingOnly = TRUE)
if (showHelp()) {
    printf("Create an LDA visualisation in the [name]-prefixed directory.\n")
    printf("\nArgs: [name] [corpus] [DTM] [LDA]\n")

    stopQuietly()    
}

if (length(argv) != 4) {
    stop(paste("Args vector must be set to: [name] [corpus] [DTM] [LDA]"))
}

library(tm)
library(topicmodels)
library(LDAvis)
library(stringi)
library(dplyr)
library(servr)

name <- argv[1]
corpus <- readRDS(argv[2])
dtm <- readRDS(argv[3])
lda <- readRDS(argv[4])


phi <- posterior(lda)$terms %>% as.matrix
theta <- posterior(lda)$topics %>% as.matrix

vocab <- colnames(phi)
doc_length <- vector()
for (i in 1:length(corpus)) {
    temp <- paste(corpus[[i]]$content, collapse = ' ')
    temp.s <- stri_count(temp, regex = '\\S+')
    if (temp.s != 0) { doc_length <- c(doc_length, temp.s)}
}

temp_frequency <- inspect(dtm);

freq_matrix <- data.frame(ST = colnames(temp_frequency), Freq = colSums(temp_frequency))

# write a JSON representation of the model suitable for rendering with LDAvis
json <- createJSON(phi = phi, theta = theta, 
                   vocab = vocab, doc.length = doc_length,
                   term.frequency = freq_matrix$Freq)
write(json, paste(name, "data.json", sep="-")) 

outdir <- paste(name, "vis", sep = "-")
serVis(json, out.dir = outdir)
printf("Rendered LDAvis to %s/index.html\n", outdir)
