### Text Retrieval Models {#sec:related-models}

In this section, we review commonly used text retrieval models.  First, we
review the boolean and vector space models.  Then, we delve into the topic
models that make up the basis of this work.

#### Boolean Model

The Boolean model is the simplest of the models used for constructing a search
engine.  This approach builds an index of the corpus by treating each document
as a set of unique terms.  Essentially, a boolean model weights all terms
equally: either the term is in the document or it isn't.  A user constructs
queries with single keywords joined by boolean expressions such as `AND`, `OR`,
and `NOT`.

#### Vector Space Model

The Vector Space Model (VSM) is an algebraic model introduced by
@Salton-etal_1975.  VSM uses the $M \times N$ term-document matrix $C$ directly
as an index, where $M$ is the number of unique terms in the corpus and $N$ is
the number of documents in the corpus.  VSM represents each document in C as a
vector of term weights, assigning words that appear in a document a weight by
some weighting scheme and words that do not appear a weight of zero.  That is,
$C_{ij}$ is the weight of the $i$th term in the $j$th document in the corpus
$C$.

To search in the VSM, we transform a query document $q$ (i.e., any document of
interest) into a vector of term weights.  Then, we perform pairwise comparisons
of this document to each document in the index.  We can use any vector-based
measurement metric, such as cosine similarity, during the pairwise comparisons
to measure the query document similarity.  Documents in the index are then
ranked according to how similar they are to the query document.

#### Topic Models

A topic model is a statistical model for discovering the abstract *topics* that
occur in a corpus.  For example, documents on Babe Ruth and baseball should end
up in the same topic, while Dennis Rodman and basketball should end up in
another.  Additionally, documents may also express multiple topics.  That is, a
document on Dennis Rodman could relate to multiple topics: basketball, tattoos,
and vibrant hair coloring.  In this section, we will describe common topic
modeling algorithms and give a brief overview of the related works.

##### Latent Semantic Indexing

Latent semantic indexing (LSI) [@Deerwester-etal_1990] is an indexing and
retrieval methodology that extends the VSM.  LSI relies on a mathematical
technique called singular value decomposition (SVD) to find latent structure in
a corpus represented in the VSM.

LSI begins with the $M \times N$ term-document matrix $C$, as in VSM.
SVD computes $C$ into three matrices by its rank $r$ ($\leq min(M, N)$):

1) $T$ (also called $\phi$), an $M \times r$ term-topic vector matrix;
2) $S$, an $r \times r$ singular values matrix;
3) $D$ (also called $\theta$), an $N \times r$ document-topic vector matrix.

That is, $C = TSD^T$.

However, SVD allows for a reduction strategy to use smaller matrices that
approximate $C$ to reduce noise [@Salton-McGill_1983].  That is, SVD reduces
the features in $S$ by only keeping the first $K$ largest values, where $K <
r$, and removing the remaining values.  Corresponding columns in $T$ and rows
in $D$ of values removed from $S$ are also removed.  The result of this
operation is a topic space approximation $C_K$, or $C \approx C_K =
T_KS_KD_K^T$.  Now, the dot product between two columns in $C_K$ reflects the
extent to which two documents (i.e., the columns) contain similar topics.

To search in LSI, we transform a query document $q$ into the LSI topic space.
First, we vectorize $q$ into a vector of term weights, as in VSM.  Next,
because $C = TSD^T$, and hence $D = C^TS^{-1}$, we multiply $q$ by $TS^{-1}$ to
transform $q$ into a topic-document vector.  Afterwards, we use this vector to
make pairwise comparisons against all documents of $C_K$ as before.

Extensions to SVD enable the algorithm to be *online* [@Zha-Simon_1999;
@Levey-Lindenbaum_2000; @Gorrell-Webb_2005; @Brand_2006], thereby allowing for
an online LSI.  Online LSI allows for incremental updates to the model without
needing to know about the documents prior to model construction.  @Rehurek_2011
further extends the work of @Brand_2006 to an LSI implementation that is both
online and distributed.  @Halko-etal_2011 outline a distributed algorithm , but
not online.

##### Latent Dirichlet Allocation

Latent Dirichlet allocation (LDA) [@Blei-etal_2003] is a fully generative
model, assuming documents are generated according to a latent document-topic
distribution and topic-word distribution.  Of course, the goal of LDA is not to
generate new documents from these distributions, although you certainly could,
but is instead to infer the distributions of observed and unobserved documents.
That is, LDA models each document as a probability distribution indicating the
likelihood that it expresses each topic and models each topic that it infers as
a probability distribution indicating the likelihood of a word from the corpus
coming from the topic.

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

The hyperparameters $\alpha$ and $\beta$ influence the "smoothness" of the
model.  Hyperparameter $\alpha$ influences the topic distribution per document,
and hyperparameter $\beta$ influences the word distribution per topic.  For
example, lowering $\beta$ results in each topic will become more specific
(i.e., a topic is likely to consist of words not in any other topics), while
increasing $\beta$ causes each topic to become more general (i.e., it causes
words to begin to appear across multiple topics).  Likewise, lowering $\alpha$
causes each document to express less topics while raising $\alpha$ causes
documents to relate to more topics.

To search in LDA, we transform a query document $q$ into a topic probability
distribution, similiar to LSI.  First, we vectorize $q$ into a vector of term
weights, as in VSM.  Next, we *infer* from the model the topic probability
distribution for the query.  Afterwards, we use this distribution to make
pairwise comparisons against all documents of $\theta$.

@Hoffman-etal_2010 introduce a version of LDA which is online.
@Zhai-Boyd-Graber_2013 introduce an extension of LDA in which the model also
does not need to know about the corpus vocabulary prior to training.
The Hierarchical Dirichlet Process (HDP) [@Teh-etal_2006] is a similar model,
in that it does not not need to have a pre-determined number of topics set.
