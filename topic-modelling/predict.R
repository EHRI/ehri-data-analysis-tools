#!/usr/bin/env Rscript

source("lib.R")
argv <- if(exists("argv")) argv else commandArgs(trailingOnly = TRUE)
if (!interactive() && length(intersect(argv, c("-h", "-help", "--help")) > 0)) {
    printf("Given a DTM and an LDA model, output predictions for individual texts,\n")
    printf("saving the data in a [name]-prefixed JSON object file.\n")
    printf("\nArgs: [name] [DTM] [LDA]\n")

    stopQuietly()    
}

if (length(argv) != 3) {
    stop("Args vector must be set to: [name] [DTM] [LDA]")
}


library(tm)
library(topicmodels)
library(RJSONIO)

name <- argv[1]
dtm <- readRDS(argv[2])
lda <- readRDS(argv[3])

printf("Generating posteriors...\n")
post <- posterior(lda, dtm)
topics <- data.frame(post$topics)

topics
# Map to a list with rownames as keys, see:
# http://stackoverflow.com/a/14370455/285374
json <- setNames(split(topics, seq(nrow(topics))), rownames(topics))

write(toJSON(json), paste(name, "posteriors.json", sep = "-"))
