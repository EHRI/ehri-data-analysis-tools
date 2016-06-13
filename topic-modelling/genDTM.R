#!/usr/bin/env Rscript

source("lib.R")
argv <- if(exists("argv")) argv else commandArgs(trailingOnly = TRUE)
if (showHelp()) {
    printf("Create a corpus and document-term matrix (DTM), outputting the data\n")
    printf("to [name]-prefixed RData files.\n")
    printf("\nArgs: [name] [source-file-dir-or-file1] ... [fileN]\n")

    stopQuietly()    
}

if (length(argv) < 2) {
    stop(paste("Args vector must be set to: [name] [source-dir-or-file] ... [fileN]"))
}


library(tm)
library(SnowballC)
library(rJava)

name <- argv[1]
filesOrDir <- argv[2:length(argv)]

getSource <- function () {
    if (length(filesOrDir) == 1 && dir.exists(filesOrDir)) {
        DirSource(filesOrDir)
    } else {
        SimpleSource(length = length(filesOrDir), 
                        filelist = filesOrDir, class = "DirSource", mode = "text")
    }
}

#Read the source texts and define the language
printf("Loading corpus '%s'...\n", filesOrDir)
corpus <- Corpus(getSource(), readerControl = list(language="en"))
 
#Remove numbers, punctuation and unnecessary white space
printf("Removing numbers, punctuation, whitespace, and transforming to lower case.\n")
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, content_transformer(tolower))
 
printf("Removing stopwords\n")
extraStopWords <- scan("extra-stopwords.txt", what="", sep="\n")
allStopWords <- append(stopwords("SMART"), extraStopWords)
#Remove stopwords like the, and, a, etc. that do not add meaning.
corpus <- tm_map(corpus, removeWords, allStopWords)

printf("Stemming...\n")
#Reduce the words to their stems so that running is the same as run
corpus <- tm_map(corpus, stemDocument, language = "english")

printf("Creating document-term matrix\n")
#Create and clean document-term matrix
dtm <-DocumentTermMatrix(corpus)
# NB: Play around with this number...
dtm <- removeSparseTerms(dtm, 0.6)
rowTotals <- apply(dtm , 1, sum) #Find the sum of words in each Document

# Remove empty rows from the corpus to keep a one-to-one
# correspondence between our term matrix
# http://stackoverflow.com/q/13944252/285374
empty.rows <- dtm[rowTotals == 0, ]$dimnames[1][[1]]
dtm[1, ]$dimnames[1][[1]]
dtm <- dtm[rowTotals> 0, ] 
corpus <- tm_filter(
    corpus,
    FUN = function(doc) !is.element(meta(doc)$id, empty.rows)    
)

saveRDS(corpus, paste(name, "corpus.RData", sep = "-"), compress = TRUE)
saveRDS(dtm, paste(name, "dtm.RData", sep = "-"), compress = TRUE)

