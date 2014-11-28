# Related work

In this section, we review the literature in detail.
First, we review various information retrieval techniques popular in
software engineering.

## Information Retrieval {#related-IR}

### Vector Space Model {#related-VSM}

### Latent Semantic Indexing {#related-LSI}

Latent semantic indexing [@Deerwester-etal:1990] is an indexing and retrieval
methodology. LSI uses a statistical technique, singular value decomposition to
identify patterns within the unstructured data, identifying relationships
between terms and documents, placing documents that are related close to one
another creating a semantic space. That is, LSI estimates the latent structure
by taking each document in the corpus and forming weighted vectors applying
cosine similarity to the vectors measuring the semantic similarities between
documents [@Binkley-Lawrie:2010]. @Rehurek:2011 outlines extensions to LSI
which enable the algorithm to be online. Online LSI allows the model to be
updated incrementally without needing to know about the documents prior to
model construction. 


### Latent Dirichlet Allocation {#related-LDA}

Latent Dirichlet allocation [@Blei-etal:2003] is a generative topic model. LDA
models each document in a corpus of discrete data as a finite mixture over a
set of topics and models each topic as an infinite mixture over a set of topic
probabilities.  That is, LDA models each document as a probability distribution
indicating the likelihood that it expresses each topic and models each topic
that it infers as a probability distribution indicating the likelihood of a
word from the corpus being assigned to the topic.

@Hoffman-etal:2010 introduce a version of LDA which is online.
@Zhai-Boyd-Graber:2013 introduce an extension of LDA in which the model also
does not need to know about the corpus vocabulary prior to training.

## Feature location {#related-feature-location}

## Developer identification {#related-developer-identification}

