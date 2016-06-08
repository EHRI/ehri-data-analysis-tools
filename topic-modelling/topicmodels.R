#!/usr/bin/env Rscript

library(tm)
library(SnowballC)
library(rJava)
library(topicmodels)

printf <- function(...) cat(sprintf(...))

createModel <- function(dir, numTopics) {
    #Read the source texts and define the language
    printf("Loading corpus '%s'...\n", dir)
    ehri.corpus <- Corpus(DirSource(dir), readerControl = list(language="en"))
     
    #Remove numbers, punctuation and unnecessary white space
    printf("Removing numbers, punctuation, whitespace, and transforming to lower case.\n")
    ehri.corpus <- tm_map(ehri.corpus, removeNumbers)
    ehri.corpus <- tm_map(ehri.corpus, removePunctuation)
    ehri.corpus <- tm_map(ehri.corpus, stripWhitespace)
    ehri.corpus <- tm_map(ehri.corpus, content_transformer(tolower))
     
    printf("Removing stopwords\n")
    extraStopWords <- scan("extra-stopwords.txt", what="", sep="\n")
    allStopWords <- append(stopwords("SMART"), extraStopWords)
    #Remove stopwords like the, and, a, etc. that do not add meaning.
    ehri.corpus <- tm_map(ehri.corpus, removeWords, allStopWords)

    printf("Stemming...\n")
    #Reduce the words to their stems so that running is the same as run
    ehri.corpus <- tm_map(ehri.corpus, stemDocument, language = "english")

    saveRDS(ehri.corpus, "ehri.corpus.rdata", compress = TRUE)

    printf("Creating document-term matrix\n")
    #Create and clean document-term matrix
    ehri.dtm <-DocumentTermMatrix(ehri.corpus)
    # NB: Play around with this number...
    ehri.dtm <- removeSparseTerms(ehri.dtm, 0.6)
    rowTotals <- apply(ehri.dtm , 1, sum) #Find the sum of words in each Document

    # Remove empty rows from the corpus to keep a one-to-one
    # correspondence between our term matrix
    # http://stackoverflow.com/q/13944252/285374
    empty.rows <- ehri.dtm[rowTotals == 0, ]$dimnames[1][[1]]
    ehri.dtm[1, ]$dimnames[1][[1]]
    ehri.dtm <- ehri.dtm[rowTotals> 0, ] 
    ehri.corpus <- tm_filter(
        ehri.corpus,
        FUN = function(doc) !is.element(meta(doc)$id, empty.rows)    
    )

    saveRDS(ehri.dtm, "ehri.dtm.rdata", compress = TRUE)

    printf("Running topic modelling for %d topics...\n", numTopics)
    ehri.lda <- LDA(ehri.dtm, k = numTopics, method = "Gibbs", 
                    control = list(seed = 1000, burnin = 1000, thin = 100, iter = 1000))

    #documents to topics
    ehri.lda.topics <- as.matrix(topics(ehri.lda))
    ehri.lda.topics
     
    #top 10 terms in each topic
    ehri.lda.terms <- as.matrix(terms(ehri.lda,10))
    ehri.lda.terms
     
    saveRDS(ehri.lda, "ehri.lda.rdata")

    #probabilities associated with each topic assignment
    topicProbabilities <- as.data.frame(ehri.lda@gamma)
    saveRDS(topicProbabilities, "topicProbabilities.rdata", compress = TRUE)
}

args <- commandArgs(trailingOnly = TRUE)

# defaults
textDir <- "sample"
numTopics <- 6

if (!is.na(args[1])) {
    relTextDir <- args[1]    

    if(!file.exists(relTextDir)) {
        stop(paste("Directory does not exist! ", relTextDir))
    }

    textDir <- paste(getwd(), relTextDir, sep = "/")
    if (length(args) > 1) {
        numTopics <- as.integer(args[2])
    }
}

createModel(textDir, numTopics)


