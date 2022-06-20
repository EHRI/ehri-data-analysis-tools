# Exploratory Topic Modelling Using Python
##### by Mike Bryant and Maria Dermentzi 

This notebook aims to walk readers through the process of topic modelling in Python and accompanies the article (to be) published in the European Holocaust Research Infrastructure (EHRI) Document Blog entitled "Exploratory Topic Modelling Using Python".

#### Credits:
The transcripts that form the corpus in this tutorial were obtained through the [United States Holocaust Memorial Museum](https://www.ushmm.org/) (USHMM).

## What is Topic Modelling?
Topic modelling is a technique by which documents within a corpus are clustered based on the manner in which certain groups of terms are used together within the text. The commonalities between such term groupings tend to form what we would normally call “topics”, providing a way to automatically categorise documents by their structural content, rather than any a priori knowledge system. Topic modelling is generally most effective when a corpus is large and diverse, so the individual documents within in are not too similar in composition. In EHRI, of course, we focus on the Holocaust, so documents available to us are naturally restricted in scope. It was an interesting experiment, however, to test to what extent a corpus of Holocaust-related documents was able to be topic modelled, and what “topics” emerged within it.

The specific type of topic modelling we’re looking at is called latent Dirichlet allocation (LDA), subject of an influential paper by Blei et al. (2003).

## The Dataset/Putting Together the Corpus
We were on the lookout for datasets that would be easily accessible and, for convenience, predominantly in English. One such dataset was the USHMM extensive collection of [oral history testimonies](https://www.ushmm.org/online/oral-history/detail.php?SurveyId=226&letter=U&ord=127), for which there are a considerable number of textual transcripts. The museum’s total collection consists of over 80,703 testimonies, 41,695 of which are available in English, with 2,894 of them listing a transcript.  

Since there is not yet a ready-to-download dataset that includes these transcripts, we had to construct our own. Using a web scraping tool, we managed to create a list of the links pointing to the metadata (including transcripts) of the testimonies that were of interest to us. After obtaining the transcript and other metadata of each of these testimonies, we were able to create our dataset and curate it to remove any unwanted entries. For example, we made sure to remove entries with restrictions on access or use. We also removed entries with transcripts that consisted only of some automatically generated headers and entries which turned out to be in languages other than English. The remaining 1,873 transcripts form the corpus of this tutorial — a small, but still decently sized dataset.

#### How to access the datasets outside the Jupyter Notebook
The datasets produced through this tutorial are available on Zenodo:
https://doi.org/10.5281/zenodo.6670234

## How to use
You can either dowload the repository and run the Jupyter notebook on your local device (you might need to install any libraries that are not already installed in your device - see [requirements.txt](/requirements.txt)), run it on Binder [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/mdermentzi/ehri-topic-modelling-guide/HEAD?labpath=USHMM_Oral_Testimonies_Topic_Modelling.ipynb), or simply click on the [USHMM_Oral_Testimonies_Topic_Modelling.ipynb](/USHMM_Oral_Testimonies_Topic_Modelling.ipynb) file on Github.

## Visualisations
[Link to the LDAvis for the three-topic model](https://mdermentzi.github.io/ehri-topic-modelling-guide/model_3_topics.html#topic=1&lambda=0.6&term=)  
[Link to the LDAvis for the six-topic model](https://mdermentzi.github.io/ehri-topic-modelling-guide/model_6_topics.html#topic=1&lambda=0.6&term=)

## References:

Bird, S., Klein, E., & Loper, E. (2009). Natural language processing with Python: Analyzing text with the natural language toolkit.  O’Reilly Media, Inc.

Blei, D. M., Ng, A. Y., & Jordan, M. I. (2003). Latent dirichlet allocation. Journal of Machine Learning Research, 3(Jan), 993–1022.

Harris, C. R., Millman, K. J., Walt, S. J. van der, Gommers, R., Virtanen, P., Cournapeau, D., Wieser, E., Taylor, J., Berg, S., Smith, N. J., Kern, R., Picus, M., Hoyer, S., Kerkwijk, M. H. van, Brett, M., Haldane, A., Río, J. F. del, Wiebe, M., Peterson, P., … Oliphant, T. E. (2020). Array programming with NumPy. Nature, 585(7825), 357–362. https://doi.org/10.1038/s41586-020-2649

Honnibal, M., Montani, I., Van Landeghem, S., & Boyd, A. (2020). spaCy: Industrial-strength Natural Language Processing in Python. https://doi.org/10.5281/zenodo.1212303

Lau, J. H., Newman, D., & Baldwin, T. (2014). Machine Reading Tea Leaves: Automatically Evaluating Topic Coherence and Topic Model Quality. Proceedings of the 14th Conference of the European Chapter of the Association for Computational Linguistics, 530–539. https://doi.org/10.3115/v1/E14-1056

Martin, F., & Johnson, M. (2015). More Efficient Topic Modelling Through a Noun Only Approach. Proceedings of the Australasian Language Technology Association Workshop 2015, 111–115. https://aclanthology.org/U15-1013

Mattingly, W. J. B. (2021, February 23). What is Laten Dirichlet Allocation LDA (Topic Modeling for Digital Humanities 03.01). https://www.youtube.com/watch?v=o7OqhzMcDfs

Mattingly, W. J. B. (2022). Implementing LDA in Python—Introduction to Python for Humanists. In Introduction to Python for Digital Humanities. https://python-textbook.pythonhumanities.com/04_topic_modeling/03_03_lda_model_demo.html

Reback, J., McKinney, W., jbrockmendel, Van den Bossche, J., Augspurger, T., Cloud, P., gfyoung, Sinhrks, Klein, A., Roeschke, M., Hawkins, S., Tratner, J., She, C., Ayd, W., Petersen, T., Garcia, M., Schendel, J., Hayden, A., MomIsBestFriend, … Mortada Mehyar. (2020). pandas-dev/pandas: Pandas 1.0.3. Zenodo. https://doi.org/10.5281/zenodo.3715232

Řehůřek, R. (n.d.-a). Corpora and Vector Spaces. Gensim: Topic Modelling for Humans. Retrieved 16 June 2022, from https://radimrehurek.com/gensim/auto_examples/core/run_corpora_and_vector_spaces.html

Řehůřek, R. (n.d.-b). LDA Model. Gensim: Topic Modelling for Humans. Retrieved 16 June 2022, from https://radimrehurek.com/gensim/auto_examples/tutorials/run_lda.html#sphx-glr-auto-examples-tutorials-run-lda-py

Řehůřek, R., & Sojka, P. (2010). Software Framework for Topic Modelling with Large Corpora. Proceedings of the LREC 2010 Workshop on New Challenges for NLP Frameworks, 45–50.

Richardson, L. (n.d.). Beautiful soup documentation. https://www.crummy.com/software/BeautifulSoup/bs4/doc/#

Schofield, A., Magnusson, M., & Mimno, D. (2017). Pulling Out the Stops: Rethinking Stopword Removal for Topic Models. Proceedings of the 15th Conference of the European Chapter of the Association for Computational Linguistics: Volume 2, Short Papers, 432–436. https://aclanthology.org/E17-2069

Schofield, A., & Mimno, D. (2016). Comparing Apples to Apple: The Effects of Stemmers on Topic Models. Transactions of the Association for Computational Linguistics, 4, 287–300. https://doi.org/10.1162/tacl_a_00099

Schofield, A., Thompson, L., & Mimno, D. (2017). Quantifying the Effects of Text Duplication on Semantic Models. Proceedings of the 2017 Conference on Empirical Methods in Natural Language Processing, 2737–2747. https://doi.org/10.18653/v1/D17-1290

Sievert, C., & Shirley, K. (2014). LDAvis: A method for visualizing and interpreting topics. Proceedings of the Workshop on Interactive Language Learning, Visualization, and Interfaces, 63–70. https://doi.org/10.3115/v1/W14-3110

United States Holocaust Memorial Museum. (2007). Oral History Interview Guidelines. https://www.ushmm.org/m/pdfs/20121003-oral-history-interview-guide.pdf

## Further Reading/Resources

#### Tutorials:
Mattingly, W. J. B. (2021, February 23). What is Laten Dirichlet Allocation LDA (Topic Modeling for Digital Humanities 03.01). https://www.youtube.com/watch?v=o7OqhzMcDfs

Mattingly, W. J. B. (2022). Implementing LDA in Python—Introduction to Python for Humanists. In Introduction to Python for Digital Humanities. https://python-textbook.pythonhumanities.com/04_topic_modeling/03_03_lda_model_demo.html

Řehůřek, R. (n.d.-a). Corpora and Vector Spaces. Gensim: Topic Modelling for Humans. Retrieved 16 June 2022, from https://radimrehurek.com/gensim/auto_examples/core/run_corpora_and_vector_spaces.html

Řehůřek, R. (n.d.-b). LDA Model. Gensim: Topic Modelling for Humans. Retrieved 16 June 2022, from https://radimrehurek.com/gensim/auto_examples/tutorials/run_lda.html#sphx-glr-auto-examples-tutorials-run-lda-py

#### Other readings:
Schmidt, B. M. (2012). Words alone: Dismantling topic models in the humanities. Journal of Digital Humanities, 2(1), 49–65.

Schofield, A. K. (2019) Text Processing for the Effective Application of Latent Dirichlet Allocation. [Online] [online]. Available from: https://ecommons.cornell.edu/handle/1813/67305 (Accessed 17 June 2022).

Sievert, C. & Shirley, K. (2014) ‘LDAvis: A method for visualizing and interpreting topics’, in Proceedings of the Workshop on Interactive Language Learning, Visualization, and Interfaces. [Online]. 2014 Baltimore, Maryland, USA: Association for Computational Linguistics. pp. 63–70. [online]. Available from: http://aclweb.org/anthology/W14-3110 (Accessed 27 May 2022).