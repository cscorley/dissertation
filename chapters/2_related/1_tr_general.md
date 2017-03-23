## Text Retrieval {#sec:related-general}

In this section, we review and summarize the text retrieval process.  The text
retrieval process consists of two general steps: document extraction and
retrieval.  Then, we discuss methods of measuring similarity.  Finally, we
discuss measures for evaluating a text retrieval technique.


### Document Extraction

![The general text retrieval process\label{fig:TR}](figures/text-retrieval.pdf)

The left side of Figure \ref{fig:TR} illustrates the document extraction
process.  A document extractor takes raw data (e.g., text files) and produces a
corpus as output.  Each document in the corpus contains the words associated to
the origin (e.g., a file).  The text extractor is the first part of the
document extractor.  It produces a token stream for each document in the data.

The preprocessor is the second part of the document extractor.  It applies a
series of transformations to each token and produces one or more terms from the
token.  The transformations commonly used are [@Manning-etal_2008]:

1) Split
    :    separate tokens into constituent words by non-alphabetical characters
    or convention (e.g., "two-thirds" becomes "two" and "thirds")
2) Normalize
    :   replace each upper case letter with the corresponding lower case
    letter, or vice versa
3) Filter
    :   remove common words such as natural language articles (e.g., "an" or
    "the"), stop words, or short words
4) Stem
    :   remove prefixes and suffixes to leave just the root word (e.g.,
    "name", "names", "named", and "naming" all reduce to "name")) A common
    stemmer used is by @Porter_1980.
5) Weigh
    :   adjust the representation of a term in a document by some scheme,
    such as term-frequency inverse-document-frequency (tf-idf)
    [@Salton-Buckley_1988]
6) Prune
    :   remove terms that occur in, for example, over 80% or under 2% of the
    documents [@Madsen-etal_2004].


#### Document Extraction of Software {#sec:related-software}

There are some additional considerations for applying text retrieval to
software.  In addition to the transformations already outlined, extended
transformations [@Marcus-etal_2004; @Marcus-Menzies_2010] commonly used in
software are:

1) Split
    :    separate tokens into constituent words based on common coding style
    conventions (e.g., the use of camel case or underscores) and on the presence
    of non-letters (e.g., punctuation or digits)
2) Filter
    :   remove common words such programming language keywords, or standard
    library entity names
3) Weigh
    :   adjust the representation of a term in a document by some scheme, such
    as by the entity type [@Bassett-Kraft_2013].


### Search Engine Construction and Retrieval

The right side of Figure \ref{fig:TR} illustrates the retrieval process.  The
main component of the retrieval process is the search engine
[@Manning-etal_2008].  A search engine typically consists of an index and a
classifier for ranking [@Croft-etal_2010].  Search engines based on topic
models also need a trained model.  The primary function of the search engine is
to rank documents in relation to the query.

First, the engine transforms the corpus into an index.  If the search engine
relies on a topic model, then the engine uses the model to infer an index
document-topic distributions for each document.  Otherwise, the document-terms
may have further transformations applied or used directly as the index.

Next, the engine takes a pairwise classification of the query to each document
in the index and ranks the documents according to similarity.  We use a
similarity measure for probability distributions for the pairwise comparisons.

### Similarity measures

A similarity measure in text retrieval is useful for comparing two documents.
Typically, documents are represented as a bag-of-words, or a term vector.
Hence, we can use any vector-based similarity measure.  Further, we can use
discrete probability distributions, such as a document-topic proportion, as a
vector.  In the following definitions, $P$ and $Q$ are two discrete probability
distributions of the same length $K$ unless noted otherwise.

#### Cosine similarity

Cosine similarity (CS) is a commonly seen similarity measure [@Croft-etal_2010]
and is easy to implement:

\begin{equation}
    {\rm CS}(P, Q) = {P \cdot Q \over \|P\| \|Q\|}
\label{eq:cosine}
\end{equation}

where $P$ and $Q$ are term vectors.  Since cosine similarity does not operate
on probability distributions, it is not a fit measurement for some models.


#### Hellinger distance

We define Hellinger distance ($H$) as:

\begin{equation}
    {\rm H}(P, Q) = \frac{1}{\sqrt{2}} \; \sqrt{\sum_{i=1}^{K} (\sqrt{P_i} - \sqrt{Q_i})^2}
\label{eq:hellinger}
\end{equation}

####  Kullback-Leibler divergence

Kullback-Leibler (KL) diverence is used for constructing topic models, but is
not a good measure for similarity as ${\rm KL}(P, Q) \neq {\rm KL}(Q, P)$.

\begin{equation}
    {\rm KL}(P, Q) = \sum_{i=1}^{K} P_i \, \ln\frac{P_i}{Q_i}
\label{eq:kl}
\end{equation}


#### Jensen-Shannon divergence

Jensen-Shannon (JS) divergence measure addresses the KL-divergence issue
by averaging the two KL measures together:

\begin{equation}
    {\rm JS}(P, Q) = \frac{1}{2}{\rm KL}(P, M)+\frac{1}{2}{\rm KL}(Q, M)
\label{eq:js}
\end{equation}

where $M=\frac{1}{2}(P+Q)$.  This makes JS-divergence an appropriate more
measure for probability distributions over KL-divergence.

### Evaluation measures

In the following section, we describe evaluation measures.  We divide the
measures into two groups: set-based measures and ranked-based measures.

For the following discussion, we define the following sets: $A =
\{\mbox{relevant documents}\}$, the documents related to some query
$q \in Q$; and $B = \{\mbox{retrieved documents}\}$, the documents retrieved
for some query $q \in Q$.

#### Set-based measures

Set-based measures are useful when the text retrieval technique returns only a
sub-set of the documents being searched over, i.e., the top 100 documents.

##### Recall

*Recall* is the fraction of relevant retrieved documents.  We define recall as:

\begin{equation}
\operatorname{recall} =
    \frac{|A \cap B|}{|A|}
    =
    P(B|A)
\label{eq:recall}
\end{equation}


##### Precision

*Precision* is the fraction of retrieved documents that are relevant.  We
define precision as:

\begin{equation}
\operatorname{precision} =
    \frac{|A \cap B|}{|B|}
    =
    P(A|B)
\label{eq:precision}
\end{equation}

##### F-measure

In some situations, we may want to make trade-offs between precision and
recall.  For this, we can use the *F-measure*.  The F-measure is a weighted
harmonic mean of precision and recall:

\begin{equation}
\operatorname{F} =
    \frac{1}{\alpha\frac{1}{\operatorname{precision}} +
            (1 - \alpha)\frac{1}{\operatorname{recall}}
            }
            =
    \frac{(\beta^2 + 1) \cdot \operatorname{precision} \cdot \operatorname{recall}}{ %
    \beta^2 \cdot \operatorname{precision} + \operatorname{recall}}
    \mbox{ }
    \mbox{ }
    \mbox{ where }
    \mbox{ }
    \mbox{ }
    \beta^2 = \frac{1 - \alpha}{\alpha}
\label{eq:f-measureweighted}
\end{equation}

where $\alpha \in [0,1]$ and thus $\beta^2 \in [0, \infty]$.  A *balanced
F-measure* equally weights precision and recall by $\alpha=0.5$.  When using a
balanced F-measure, the formula simplifies to:

\begin{equation}
\operatorname{F} =
    \frac{2 \cdot \operatorname{precision} \cdot \operatorname{recall}}{(\operatorname{precision} + \operatorname{recall})}
\label{eq:f-measure}
\end{equation}

##### Precision at k

Precision at k is easy to compute and understand.  It is the calculated
precision for the first $k$ retrieved documents.  It awards for more relevant
documents appearing in the first $k$ retrieved documents.  However, it has the
disadvantage of not distinguishing between the rankings of the relevant
document, and is merely a count-based score.

\begin{equation}
\operatorname{precision}(k) =
    \frac{|A \cap B_{1..k}|}{|B_{1..k}|}
    =
    P(A|B_{1..k})
\label{eq:precisionatk}
\end{equation}

where $B_{1..k}$ is the top $k$ documents retrieved.  This is also written as
*precision@k*.

#### Ranked-based measures

Since text retrieval techniques can also return a ranking of all documents
searched, it is not beneficial to use set-based measures without only looking
at the top-$k$ documents, as in *precision@k*.


##### Average Precision (AP)

Average precision is useful for scoring single queries.  It awards for highly
ranking relevant documents.

\begin{equation}
\operatorname{AP} =
    \frac{
        \sum_{i}^{|B|}
        (\operatorname{precision(i)} \times \operatorname{rel}(i))
    } {|A|}
\label{eq:ap}
\end{equation}

where $rel(i)$ is the binary relevance function of the document at rank $i$,
such that it is 1 if document at rank $i \in A$, and 0 otherwise.

##### Mean Average Precision (MAP)

Mean average precision uses AP to compute the scores over all queries, and is
useful for summarizing the effectiveness of multiple queries
[@Manning-etal_2008].

\begin{equation}
\operatorname{MAP} =
    \frac{1}{|Q|}
    \sum_{q}^{Q}
    AP(q)
\label{eq:map}
\end{equation}

where $AP(q)$ is the average precision for query $q$.


##### Mean Reciprocal Rank (MRR)

Reciprocal rank is often useful when there is one relevant document to the
query.  *Mean reciprocal rank* is an average of reciprocal ranks over different
queries, hence it is useful for evaluating the effectiveness of a search engine
[@Croft-etal_2010].

\begin{equation}
\operatorname{MRR} =
    \frac{1}{|Q|} \sum_{q}^{Q} \frac{1}{\operatorname{bestRank}(q)}
\label{eq:mrr}
\end{equation}

where $bestRank$ is a function equaling the rank of the first relevant item $a
\in A$ for query $q$.

##### Discounted Cumulative Gain (DCG)

Discounted Cumulative Gain is an intuitive measure based on the assumptions
that highly relevant documents are more useful than marginally relevant
documents and that relevant documents with bad rank is not useful to the user
[@Jaervelin-Kekaelaeinen_2002].  Essentially, it awards when more relevant
documents are ranked higher and penalizes, or discounts, when those relevant
documents are not ranked high.

\begin{equation}
\operatorname{DCG}(k) = rel(1) + \sum_{i=2}^{k} \frac{rel(i)}{log_2i}
\label{eq:dcg}
\end{equation}

where $rel(i)$ is the graded relevance level of the document at rank $i$.
A simple graded relevance function could be a binary judgement,
such that it is 1 if document at rank $i \in A$, and 0 otherwise.
Note that DCG does not penalize the relevance of the first retrieved document.


### Statistical significance tests

The simplest experiment for text retrieval involves comparing two approaches: a
baseline approach and some new approach.  This design could use a set of common
queries for each approach, obtaining matched pairs of *effectiveness measures*.
A popular effectiveness measure used in software is by @Poshyvanyk-etal_2007,
and uses the rank of the first relevant document found.

We can form a null and alternative hypotheses for a one-tailed test using the
evaluation measures discussed above to determine which of the approaches is
better and by using a significance test on the effectiveness measures to
determine if we should reject or accept a hypothesis.  We can also use a
two-sided test to determine if there is a difference between the two
approaches.

There are several applicable ranked-based significance tests we can use.
According to @Croft-etal_2010, the most common ones are the t-test, the
Wilcoxon sign-ranked test, and the sign test.

#### t-test

The t-test assumes a normal distribution of samples.  That is, in the case of
matched pairs, that the difference between effectiveness measures for each
query is taken from a normal distribution.  However, the t-test assumes that
the effectiveness measure is interval, while effectiveness measures are
typically ordinal, making the t-test an objectionable choice depending on the
effectiveness measure used.

#### Wilcoxon signed-rank test

The Wilcoxon sign-ranked test is nonparametric and does not make the same
assumptions that the t-test does, making it a more desirable choice of a test
when the effectiveness measure is ordinal.  We define the test as:

\begin{equation}
    w = \sum_{i=1}^{N} sign(x_i - y_i) \times R_i
\end{equation}

where $N$ is the number of differences $\neq 0$, $x$ and $y$ are pairs of
effectiveness measures, $sign(v)$ returns the sign of value $v$, $R_i$ is the
rank of that value. $R_i$ is not the raw "rank" from the data; rather, it is
the rank of the pair in a sorted list of their differences.

##### Effect size

An effect size can be derived from the Wilcoxon signed-rank test statistic,
$w$ [@Kerby_2014]. Given $w$, a rank correlation $r$ can be defined as $r =
w/S$, where $S$ is the sum of all ranks.

