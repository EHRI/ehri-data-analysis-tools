Topic Modelling Experiments
===========================

Most of the code in these scripts is derived from the examples
available around the web, such as:

http://www.slideshare.net/rdatamining/text-mining-with-r-an-analysis-of-twitter-data

Several small Rscript scripts are provided:

 - genDTM.R
 - genLDA.R
 - genLDAvis.R
 - predict.R

### genDTM.R [name] [corpus-dir-or-files...]

Generate a document-term matrix (DTM) from a collection of files. See --help for details.

    ./genDTM.R test1 corpus-directory

The resulting corpus and DTM will be saved to the CWD as `test1-corpus.RData` and `test1-dtm.RData`
for subsequent use. Terms present in the `extra-stopwords.txt` file will be treated as standard
stopwords.

### genLDA.R [name] [num-topics] [DTM RData]

Generate an LDA model with N topics given a document-term matrix saved by `genDTM.R`. See --help for details.

    ./genLDA.R test1 3 test1-dtm.RData

The resulting LDA model will be saved as `test1-lda.RData`.

### genLDAvis.R [name] [corpus Rdata] [DTM RData] [LDA RData]

    ./genLDAvis.R test1 test1-corpus.RData test1-dtm.RData test1-lda.RData

Generate a visualisation of the LDA, applied to the given corpus and DTM. The
HTML/CSS/JS will be saved to the `test1-vis` directory.

To serve this directory directly from R, run the following from a prompt:

```r
library(servr)
servr::http(dir = "test1-vis") # substitute actual output dir...
# Data should be served at localhost:4321...
```

#### predict.R [name] [DTM RData] [LDA RData]

Output the probabilities that each file in the DTM corpus belongs to a given
topic:

    ./predict.R test1 test1-dtm.RData test1-lda.RData

Output will be saved as a JSON file called `test1-posteriors.json`, mapping the
file name against an array of probabilities that it belongs to a given topic. To
predict for files not in the original corpus, generate a new DTM using `genDTM.R`
with the (new) files given as arguments and run `predict.R` with the previously
generated LDA model and the new DTM.
