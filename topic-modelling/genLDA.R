#!/usr/bin/env Rscript

source("lib.R")
argv <- if(exists("argv")) argv else commandArgs(trailingOnly = TRUE)
if (showHelp()) {
    printf("Given a DTM in RData format, create an LDA model with the given number\n")
    printf("of topics, outputting the data to a [name]-prefixed RData file.\n")
    printf("\nArgs: [name] [num-topics] [DTM]\n")

    stopQuietly()    
}

if (length(argv) != 3) {
    stop(paste("Args vector must be set to: [name] [num-topics] [DTM]"))
}


library(tm)
library(topicmodels)

name <- argv[1]
numTopics <- as.integer(argv[2])
dtm <- readRDS(argv[3])


printf("Running topic modelling for %d topics...\n", numTopics)
lda <- LDA(dtm, k = numTopics, method = "Gibbs", 
                control = list(seed = 1000, burnin = 1000, thin = 100, iter = 1000))

#documents to topics
lda.topics <- as.matrix(topics(lda))
 
#top 10 terms in each topic
lda.terms <- as.matrix(terms(lda,10))
 
saveRDS(lda, paste(name, "lda.RData", sep = "-"))

#probabilities associated with each topic assignment
topicProbabilities <- as.data.frame(lda@gamma)
saveRDS(topicProbabilities, paste(name, "topicProbabilities.RData", sep = "-"), compress = TRUE)

