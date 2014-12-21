# Related work

In this section, we review the literature in detail.
First, we review various text retrieval models.
We then discuss how these TR approaches are applied in software engineering.
Finally, we discuss various areas of software engineering in which TR
has been applied.

## Text Retrieval {#related-general-TR}

In this section, we review and summarize the terminology and text retrieval
process.

### Terminology

We use the following terminology to describe text retrieval:

term (word), $w$:
:   the smallest free-form of a language

token:
:   a sequence of non-whitespace characters containing one or more term

document, $d$:
:   a sequence of $D$ terms $w_1, w_2, ..., w_D$, often represented as a
bag of words (i.e., $M$-length vector of term frequencies or weights)

corpus, $C$:
:   a sequence of $N$ documents $d_1, d_2, ..., d_N$ (i.e., a $M \times N$
document-term matrix)

vocabulary, $V$:
:   a set of $M$ unique terms that appear in a corpus $\{w_1, w_2, ..., w_M\}$

topic, $z$:
:   a concept or theme of related terms, often represented as a distribution of
term proportions

topic model, $\phi$:
:   a mathematical representation of the thematic structure of a corpus, or how
much a term $w$ contributes to each topic $z$ (i.e., a $M \times K$ topic-term
matrix)

inferrence, $\theta_d$
:   the thematic structure of a given document (i.e., a $K$-length topic
proportion vector)

index, $\theta$:
:   a corpus that has been transformed for searching, e.g., in LDA by
inferring the thematic structure of each document (i.e., a $N \times K$
document-topic matrix)

query, $q$:
:   a document created by a user

search engine:
:   ranks documents by their similarity to a query


### Text Retrieval Process

The text retrieval process consists of two general steps: document extraction
and retrieval.

![The general text retrieval process\label{fig:TR}](figures/text-retrieval.pdf)


#### Document extraction

The left side of Figure \ref{fig:TR} illustrates the document extraction
process. A document extractor takes raw data (e.g., text files) and produces a
corpus as output. Each document in the corpus contains the words associated to
the origin (e.g., a file). The text extractor is the first part of the document
extractor. It produces a token stream for each document in the data.

The preprocessor is the second part of the document extractor. It applies a
series of transformations to each token and produces one or more terms from the
token. The transformations commonly used are:

1. Split:
    :    separate tokens into constituent words by non-alphabetical characters
    or convention (e.g., "two-thirds" becomes "two" and "thirds")
2. Normalize:
    :   replace each upper case letter with the corresponding lower case
    letter, or vice versa
3. Filter:
    :   remove common words such as natural language articles (e.g., "an" or
    "the"), stop words, or short words
4. Stem:
    :   remove prefixes and suffixes to leave just the root word (e.g.,
    "name", "names", "named", and "naming" all reduce to "name"). A common
    stemmer used is by @Porter_1980.
5. Weigh:
    :   adjust the representation of a term in a document by some scheme,
    such as term-frequency inverse-document-frequency (tf-idf)
    [@Salton-Buckley_1988]
6. Prune:
    :   remove term that occur in, for example, over 80% or under 2% of the
    documents [@Madsen-etal_2004].

#### Model Construction and Retrieval

The right side of Figure \ref{fig:TR} illustrates the retrieval process. The
main component of the retrieval process is the search engine, which must first
be constructed. A search engine typically consists of a model, an index, and a
classifier for ranking.

The primary function of the search engine is to rank documents in relation to
the query. First, the corpus is transformed into an index. Next, the engine
takes a pairwise classification of the query to each document in the index and
ranks the documents according to similarity. A similarity measure for
probability distributions, such as cosine similarity or Hellinger distance, can
be used for these pairwise comparisons. Hellinger distance ($H$) can be defined
as:

\begin{equation}
    H(P, Q) = \frac{1}{\sqrt{2}} \; \sqrt{\sum_{i=1}^{K} (\sqrt{P_i} - \sqrt{Q_i})^2}
\label{eq:hellinger}
\end{equation}

where $P$ and $Q$ are two discrete probability distributions of length $K$.

## Text Retrieval for Software {#related-software-TR}

### Terminology 

We adopt and extend terminology from @Biggers-etal_2014.
In particular, we define the following:

entity:
:   a named source element such as a method, class, or package

identifier:
:   a token representing the name of an entity

comment:
:   a sequence of tokens delimited by language specific markers (e.g., `/* */`
or `#`)

literal:
:   a sequence of tokens delimited by language specific markers (e.g., `' '`
for strings)

In addition to the transformations outlined in Section
\ref{document-extraction}, extended transformations [@Marcus-etal_2004;
@Marcus-Menzies_2010] commonly used in software are:

1. Split:
    :    separate tokens into constituent words based on common coding style
    conventions (e.g., the use of camel case or underscores) and on the presence
    of non-letters (e.g., punctuation or digits)
2. Filter:
    :   remove common words such programming language keywords, or standard
    library entity names
3. Weight:
    :   adjust the representation of a term in a document by some scheme, such
    as by the entity type [@Bassett-Kraft_2013].


### Boolean Model

The Boolean model is the simplest of the models used for constructing a search
engine. This approach builds an index of the corpus by treating each document
as a set of unique terms. Essentially, all terms are weighted equally: either
the term is in the document or it isn't. Queries can be constructed with
single keywords joined by boolean expressions such as `AND`, `OR`, and `NOT`.

### Vector Space Model

The Vector Space Model (VSM) is an algebraic model introduced by
@Salton-etal_1975. VSM uses the $M \times N$ term-document matrix $C$ directly as
an index, where $M$ is the number of unique terms in the corpus and $N$ is the
number of documents in the corpus. Each document in C is represented as a
vector of term weights: words which appear in a document will be assigned a
weight by some weighting scheme, and words that do not appear have weights of
zero. That is, $C_{ij}$ is the weight of the $i$th term in the $j$th document
in the corpus $C$.

To search in the VSM, a query document $q$ (i.e., any document of interest) is
transformed into a vector of term weights. Then, pairwise comparison of this
document to each document in the index is performed. Any vector-based
measurement metric, such as cosine similarity or Hellinger distance, can be
used during the pairwise comparisons to measure the query document similarity.
Documents in the index are then ranked according to how similar they are to the
query document.

### Topic Models

#### Latent Semantic Indexing

Latent semantic indexing (LSI) [@Deerwester-etal_1990] is an indexing and
retrieval methodology that extends the VSM. LSI relies on a mathematical
technique called singular value decomposition (SVD) to find latent structure in
a corpus represented in the VSM.

LSI begins with the $M \times N$ term-document matrix $C$, as in VSM.
SVD computes $C$ into three matrices by its rank $r$ ($\leq min(M, N)$):

1) $T$, an $M \times r$ term-concept vector matrix;
2) $S$, an $r \times r$ singular values matrix;
3) $D$, an $N \times r$ concept-document vector matrix.

That is, $C = TSD^T$.

However, SVD allows for a reduction strategy to use smaller matrices that
approximate $C$ to reduce noise. That is, the features in $S$ can be reduced by
only keeping the first $K$ largest values, where $K < r$, and removing the
remaining values. Corresponding columns in $T$ and rows in $D$ of values
removed from $S$ are also removed. The result of this operation is a topic
space approximation $C_K$, or $C \approx C_K = T_KS_KD_K^T$. Now, the dot
product between two columns in $C_K$ reflects the extent to which two documents
(i.e., the columns) contain similar concepts.

To search in LSI, a query document $q$ is transformed into the LSI topic space.
First, $q$ is vectorized into a vector of term weights, as in VSM.
Next, because $C = TSD^T$, and hence $D = C^TS^{-1}$, $q$ is multiplied by
$TS^{-1}$ to transform $q$ into the topic space. Afterwards, the dot product of
this vector is performed against all documents of $C_K$ as before.

Several extensions to SVD which enable the algorithm to be *online* have been
identified [@Zha-Simon_1999; @Levey-Lindenbaum_2000; @Gorrell-Webb_2005;
@Brand_2006], thereby allowing for an online LSI. Online LSI allows the model to
be updated incrementally without needing to know about the documents prior to
model construction. @Rehurek_2011 further extends the work of @Brand_2006 to an
LSI implementation that is both online and distributed. @Halko-etal_2011 also
outline an algorithm which is distributed, but not online.

#### Latent Dirichlet Allocation

Latent Dirichlet allocation (LDA) [@Blei-etal_2003] is a fully generative topic
model, where documents are assumed to have been generated according to a
document-topic distribution and topic-word distribution. Of course, the goal of
LDA is not to generate new documents from these distributions, although you
certainly could, but instead infer the distributions of observed documents.
That is, LDA models each document as a probability distribution indicating the
likelihood that it expresses each topic and models each topic that it infers as
a probability distribution indicating the likelihood of a word from the corpus
being assigned to the topic. @Girolami-Kaban_2003 show that pLSI and LDA are
equivalent under a uniform Dirichlet prior.


@Hoffman-etal_2010 introduce a version of LDA which is online.
@Zhai-Boyd-Graber_2013 introduce an extension of LDA in which the model also
does not need to know about the corpus vocabulary prior to training.

## Feature location {#related-flt}

## Developer identification {#related-triage}

## Configuration of Topic Models {#related-config}

