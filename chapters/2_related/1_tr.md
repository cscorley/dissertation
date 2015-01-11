## Text Retrieval {#related-general-TR}

In this section, we review and summarize the text retrieval process. The text
retrieval process consists of two general steps: document extraction and
retrieval. Then, we discuss various methods of measuring similarity. Finally,
we discuss measures for evaluating a text retrieval technique.


![The general text retrieval process\label{fig:TR}](figures/text-retrieval.pdf)

### Document extraction

The left side of Figure \ref{fig:TR} illustrates the document extraction
process. A document extractor takes raw data (e.g., text files) and produces a
corpus as output. Each document in the corpus contains the words associated to
the origin (e.g., a file). The text extractor is the first part of the document
extractor. It produces a token stream for each document in the data.

The preprocessor is the second part of the document extractor. It applies a
series of transformations to each token and produces one or more terms from the
token. The transformations commonly used are [@Manning-etal_2008]:

1. Split
    :    separate tokens into constituent words by non-alphabetical characters
    or convention (e.g., "two-thirds" becomes "two" and "thirds")
2. Normalize
    :   replace each upper case letter with the corresponding lower case
    letter, or vice versa
3. Filter
    :   remove common words such as natural language articles (e.g., "an" or
    "the"), stop words, or short words
4. Stem
    :   remove prefixes and suffixes to leave just the root word (e.g.,
    "name", "names", "named", and "naming" all reduce to "name"). A common
    stemmer used is by @Porter_1980.
5. Weigh
    :   adjust the representation of a term in a document by some scheme,
    such as term-frequency inverse-document-frequency (tf-idf)
    [@Salton-Buckley_1988]
6. Prune
    :   remove term that occur in, for example, over 80% or under 2% of the
    documents [@Madsen-etal_2004].

### Search Engine Construction and Retrieval

The right side of Figure \ref{fig:TR} illustrates the retrieval process. The
main component of the retrieval process is the search engine
[@Manning-etal_2008], which must first be constructed. A search engine
typically consists of an index and a classifier for ranking. Search engines
based on topic models also need a trained model.

The primary function of the search engine is to rank documents in relation to
the query. First, the corpus is transformed into an index. Next, the engine
takes a pairwise classification of the query to each document in the index and
ranks the documents according to similarity. A similarity measure for
probability distributions, such as the ones enumerated in the following Section
\ref{similarity-measures}, can be used for these pairwise comparisons.

### Similarity measures

- Cosine similarity (CS)
    \begin{equation}
        {\rm CS}(P, Q) = {P \cdot Q \over \|P\| \|Q\|}
    \label{eq:cosine}
    \end{equation}
- Hellinger
    Hellinger distance ($H$) can be defined
    as:

    \begin{equation}
       {\rm H}(P, Q) = \frac{1}{\sqrt{2}} \; \sqrt{\sum_{i=1}^{K} (\sqrt{P_i} - \sqrt{Q_i})^2}
    \label{eq:hellinger}
    \end{equation}

    where $P$ and $Q$ are two discrete probability distributions of length $K$.
- Kullback-Leibler divergence (not a true measure)
    \begin{equation}
        {\rm KL}(P, Q) = \sum_{i=1}^{K} P_i \, \ln\frac{P_i}{Q_i}
    \label{eq:kl}
    \end{equation}
    but ${\rm KL}(P, Q) \neq {\rm KL}(Q, P)$

- Jensen-Shannon divergence (uses KL, but is true measure)
    \begin{equation}
        {\rm JS}(P, Q) = \frac{1}{2}{\rm KL}(P, M)+\frac{1}{2}{\rm KL}(Q, M)
    \label{eq:js}
    \end{equation}

    where $M=\frac{1}{2}(P+Q)$

- Total variation distance
    \begin{equation}
        {\rm TV}(P, Q) = \frac{1}{2} \sum_{i=1}^{K} \left| P_i - Q_i \right|
    \label{eq:tv}
    \end{equation}

### Evaluation Measures

<!--
prec rec [66] R. Baeza-Yates, B. Ribeiro-Neto, et al., Modern Information Retrieval, vol. 463.
ACM press New York, 1999.
map [30] C. D. Manning, P. Raghavan, and H. Schu ̈tze, Introduction to Information Retrieval.
New York, NY, USA: Cambridge University Press, 2008.
mrr E.M.VoorheesandD.M.Tice,“BuildingaQuestionAnsweringTestcollection,”in Proceedings of the 23rd Annual International ACM SIGIR Conference on Research
and development in Information Retrieval, SIGIR ’00, pp. 200–207, 2000.
rank-based @Lukins-etal_2008
score J. A. Jones and M. J. Harrold, “Empirical Evaluation of the Tarantula Automatic Fault-Localization Technique,” in Automated Software Engineering, 2005.
-->

In the following section, we describe evaluation measures.
The measures can be divided into two groups: set-based measures and
ranked-based measures.

For the following discussion, we define the following sets: $A =
\{\mbox{relevant documents}\}$, the documents which are related for some query
$q \in Q$; and $B = \{\mbox{retrieved documents}\}$, the documents which were
retrieved for some query $q \in Q$.

#### Set-based measures

*Recall* is the fraction of relevant documents $B$ that are retrieved and can be
defined as:

\begin{equation}
\operatorname{recall} =
    \frac{|A \cap B|}{|A|}
    =
    P(B|A)
\label{eq:recall}
\end{equation}

Precision is the fraction of retrieved documents $B$ that are relevant and can be
defined as:

\begin{equation}
\operatorname{precision} =
    \frac{|A \cap B|}{|B|}
    =
    P(A|B)
\label{eq:precision}
\end{equation}

In some situations, we may want to make trade-offs between precision and
recall. For this, we can use the *F-measure*. The F-measure is a weighted
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

where $\alpha \in [0,1]$ and thus $\beta^2 \in [0, \infty]$. Usually, a
*balanced F-measure* is used and equally weights precision and recall by
$\alpha=0.5$. When using a balanced F-measure, the formula simplifies to:

\begin{equation}
\operatorname{F} =
    \frac{2 \cdot \operatorname{precision} \cdot \operatorname{recall}}{(\operatorname{precision} + \operatorname{recall})}
\label{eq:f-measure}
\end{equation}

#### Ranked-based measures

Since many text retrieval techniques return a ranking of all documents
searched, it may be beneficial to consider precision of only the top $k$
documents. *Precision at $k$* can be defined as:

\begin{equation}
\operatorname{precision}(k) =
    \frac{|A \cap B_{1..k}|}{|B_{1..k}|}
    =
    P(A|B_{1..k})
\label{eq:precisionatk}
\end{equation}
where $B_{1..k}$ is the top $k$ documents retrieved. This is also written
as *precision@$k$*.

Mean Average Precision (MAP)
\begin{equation}
\operatorname{MAP} =
    \frac{1}{|Q|}
    \sum_{q}^{Q}
    \frac{1}{|A|}
    \sum_{a}^{A}
    \operatorname{precision}(\operatorname{rank}(a))
\label{eq:map}
\end{equation}
where $rank$ is a function equaling the rank $i$ where $a = B_i$.

Mean Reciprocal Rank (MRR)
\begin{equation}
\operatorname{MRR} =
    \frac{1}{|Q|} \sum_{q}^{Q} \frac{1}{\operatorname{bestRank}(q)}
\label{eq:mrr}
\end{equation}
where $bestRank$ is a function equaling the rank of the first item $a \in
A$ for query $q$.

- Stats
    - Spearman rank
    - Wilcoxon


## Text Retrieval Models

In this section, we review commonly used text retrieval models. First, we
review the boolean and vector space models. Then, we delve into the topic
models on which this work is based.

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

A topic model is a statistical model for discovering the abstract *topics* that
occur in a corpus. For example, documents on Babe Ruth and baseball should end
up in the same topic, while Dennis Rodman and basketball should end up in
another. Additionally, documents may also express multiple topics. That is, a
document on Dennis Rodman could be related to multiple topics: basketball,
tattoos, and vibrant hair coloring. In this section, we will describe several
topic modeling algorithms and give a brief overview of the related works.

#### Latent Semantic Indexing

Latent semantic indexing (LSI) [@Deerwester-etal_1990] is an indexing and
retrieval methodology that extends the VSM. LSI relies on a mathematical
technique called singular value decomposition (SVD) to find latent structure in
a corpus represented in the VSM.

LSI begins with the $M \times N$ term-document matrix $C$, as in VSM.
SVD computes $C$ into three matrices by its rank $r$ ($\leq min(M, N)$):

1) $T$ (also called $\phi$), an $M \times r$ term-topic vector matrix;
2) $S$, an $r \times r$ singular values matrix;
3) $D$ (also called $\theta$), an $N \times r$ topic-document vector matrix.

That is, $C = TSD^T$.

However, SVD allows for a reduction strategy to use smaller matrices that
approximate $C$ to reduce noise [@Salton-McGill_1983]. That is, the features in
$S$ can be reduced by only keeping the first $K$ largest values, where $K < r$,
and removing the remaining values. Corresponding columns in $T$ and rows in $D$
of values removed from $S$ are also removed. The result of this operation is a
topic space approximation $C_K$, or $C \approx C_K = T_KS_KD_K^T$. Now, the dot
product between two columns in $C_K$ reflects the extent to which two documents
(i.e., the columns) contain similar topics.

To search in LSI, a query document $q$ is transformed into the LSI topic space.
First, $q$ is vectorized into a vector of term weights, as in VSM. Next,
because $C = TSD^T$, and hence $D = C^TS^{-1}$, $q$ is multiplied by $TS^{-1}$
to transform $q$ into a topic-document vector. Afterwards, the of
this vector can be performed against all documents of $C_K$ as before.

Several extensions to SVD which enable the algorithm to be *online* have been
identified [@Zha-Simon_1999; @Levey-Lindenbaum_2000; @Gorrell-Webb_2005;
@Brand_2006], thereby allowing for an online LSI. Online LSI allows the model
to be updated incrementally without needing to know about the documents prior
to model construction. @Rehurek_2011 further extends the work of @Brand_2006 to
an LSI implementation that is both online and distributed. @Halko-etal_2011
outline an algorithm which is distributed, but not online.

#### Probabilistic Latent Semantic Indexing

Probabilistic Latent Semantic Indexing (pLSI) [@Hofmann_1999] is a generative
model that extends LSI to define a latent variable that is the topics in
documents.
The general algorithm is as follows.

1) Select a document $d$ with probability $P(d)$.
2) Select a topic $z$ with probability $P(z|d)$.
3) Generate a word $w$ with probability $P(w|z)$.


#### Latent Dirichlet Allocation

Latent Dirichlet allocation (LDA) [@Blei-etal_2003] is a fully generative
model, where documents are assumed to have been generated according to a
document-topic distribution and topic-word distribution. Of course, the goal of
LDA is not to generate new documents from these distributions, although you
certainly could, but instead infer the distributions of observed documents.
That is, LDA models each document as a probability distribution indicating the
likelihood that it expresses each topic and models each topic that it infers as
a probability distribution indicating the likelihood of a word from the corpus
being assigned to the topic.

LDA assumes the following generative process:

1) Choose $\theta \sim \mathrm{Dir}(\alpha)$.
2) Choose $\phi \sim \mathrm{Dir}(\beta)$.
3) For each of the $N$ words $w_n$:
    a) Choose a topic $z_k \sim \mathrm{Multinomial}(\theta_d).$
    b) Choose a word $w_n \sim \mathrm{Multinomial}(\phi_{z})$.

Here,
$\alpha$ is the Dirichlet hyperparameter for the per-document topic distributions,
$\beta$ is the Dirichlet hyperparameter for the per-term topic distributions,
$\theta$ is a $N \times K$ topic-document distribution matrix,
with $\theta_d$ as the topic-document distribution for document d,
and
$\phi$ is a $M \times K$ term-topic distribution matrix,
with $\phi_z$ as the term-topic distribution for topic z.

The hyperparameters $\alpha$ and $\beta$ are used to influence the "smoothness"
of the model. Topic distribution per document is influenced by $\alpha$, and
term distribution per topic is influenced by $\beta$. For example, as $\beta$
is lowered, each topic will become more specific (i.e., a topic is likely to be
made up of words not in any other topics), while increasing $\beta$ causes each
topic to become more general (i.e., it causes words to begin to appear across
multiple topics). Likewise, lowering $\alpha$ causes each document to express
less topics while raising $\alpha$ causes documents to relate to more topics.


@Girolami-Kaban_2003 show that pLSI and LDA are
equivalent under a uniform Dirichlet prior.

@Hoffman-etal_2010 introduce a version of LDA which is online.
@Zhai-Boyd-Graber_2013 introduce an extension of LDA in which the model also
does not need to know about the corpus vocabulary prior to training.

## Text Retrieval for Software {#related-software-TR}

There are some additional considerations for applying text retrieval to
software. In this section, we discuss where the text retrieval process might
change.

In addition to the transformations outlined in Section
\ref{document-extraction}, extended transformations [@Marcus-etal_2004;
@Marcus-Menzies_2010] commonly used in software are:

1. Split
    :    separate tokens into constituent words based on common coding style
    conventions (e.g., the use of camel case or underscores) and on the presence
    of non-letters (e.g., punctuation or digits)
2. Filter
    :   remove common words such programming language keywords, or standard
    library entity names
3. Weight
    :   adjust the representation of a term in a document by some scheme, such
    as by the entity type [@Bassett-Kraft_2013].




