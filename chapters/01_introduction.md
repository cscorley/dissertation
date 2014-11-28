# Introduction

Basic idea:

- Lots of software maintenance tasks being automated by topic modeling
- Topic modeling is now online, but we are not using it?
- We build topic models from source code, meaning the model is tied to a
  specific instance of it
    - This makes the models not very useful in practice. Slow, outdated.
- Why not build topic models out of the changesets
    - Changesets are a view of the source code over time
    - We can build comparable topic models with changesets
- We can better evaluate the accuracy of the techniques because we
    can process changesets overtime, sort of like a similuation of
    what actually happened (or as close as we can get to it)
- We only need *one* model per branch. The doc-topic can be any *any*
  granularity desired, and the model does not need to be re-built from
  scratch everytime.
- Look at how does the changeset model compare to the typical source
  code model
    - Combinations of: context/added/removed lines in the diff
    - Per-file changed or whole changeset
    - Ignore whitespaces
    - Only look at the changed words instead of the entire lines
        - Combinations of: context/added/removed

Software developers are often confronted with maintenance tasks that
involve navigation of repositories that preserve vast amounts of project
history.  Navigating these software repositories can be a time-consuming
task, because their organization can be difficult to understand.
Fortunately, topic models such as latent Dirichlet allocation (LDA)
[@Blei-etal:2003] can help developers to navigate and understand
software repositories by discovering topics (word distributions) that
reveal the thematic structure of the data [@Linstead-etal:2007;
@Thomas-etal:2011; @Hindle-etal:2012].

Program comprehension is a prerequisite to incremental change.
A software developer who is tasked with changing a large software system
spends effort on program comprehension activities to gain the knowledge
needed to make the change [@Corbi:1989]. For example, the developer
spends effort to understand the system architecture or to locate the
parts of the source code that implement the feature(s) being changed.
Gaining such knowledge can be a time-consuming task, especially for
developers who are unfamiliar with the system. Topic models of source
code can help such developers to understand the system by revealing a
latent structure that is not obvious from the package hierarchy or
system documentation [@Savage-etal:2010].

Topic models are clusters of source code entities (e.g., classes) that
are grouped by their natural language content (i.e., the words in their
identifiers, comments, and literals). Such topics often correspond to
the concepts and features implemented by the source code
[@Baldi-etal:2008], and exploring such topics shows promise in helping
developers to understand the entities that make up a system and to
understand how those entities relate [@Kuhn-etal:2007; @Maskeri-etal:2008;
@Savage-etal:2010; @Gethers-etal:2011a]. Recent approaches to exploring
linguistic topics in source code use machine learning techniques that
model correlations among words, such as latent semantic indexing (LSI)
[@Deerwester-etal:1990] and latent Dirichlet allocation (LDA)
[@Blei-etal:2003], and ML techniques that also model correlations among
documents, such as RTM [@Chang-Blei:2010].

Topic models of source code have many applications in addition to
general program comprehension. These applications include feature
location\needcite, bug localization [@Rao-etal:2013], triaging
incoming change requests [@Kagdi-etal:2012], aspect
mining [@Baldi-etal:2008], and traceability link
recovery [@Asuncion-etal:2010]. Yet, while researchers have had
success in using topic models on source code entities, there is a
fundamental issue with the current approaches. This issue is that the
input documents used to build a topic model are source code entities,
and will be the motivating point of this work.


## Motivation

<!--
- Software evolves quickly
- Current file-based models do not keep up-to-date models
- Keeping them up-to-date involves:
    - Rebuilding at every commit (slowest)
    - Rebuilding at intervals (data loss)
    - Modify the model internally using heuristics
- In FLTs, file-based models are easy and natural, but not necessary to
  build the model.
- In triaging, file-based models do not capture the appropriate
  information, e.g., the developer's topics.
- Models can be built from any text input. We do not need to use the
  files as a proxy. The word occurrences will still occur in changesets!
-->

When modeling a source code repository, the corpus typically represents
a snapshot of the code. That is, a topic model is often trained on a
corpus that contains documents that represent files from a particular
version of the software. Keeping such a model up-to-date is expensive,
because the frequency and scope of source code changes necessitate
retraining the model on the updated corpus. However, it may be possible
to automate certain maintenance tasks without a model of the complete
source code. For example, when assigning a developer to a change task, a
topic model can be used to associate developers with topics that
characterize their previous changes. In this scenario, a model of the
changesets created by each developer may be more useful than a model of
the files changed by each developer. Moreover, as a typical changeset is
smaller than a typical file, a changeset-based model is less expensive
to keep current than a file-based model.

While using file-based models is a natural fit for program comprehension
tasks such as feature location and bug localization, they still are
unable to stay up-to-date entirely.
Additionally, much of the work for assigning developers to change
requests still uses files as input and an array of heuristics to
identify a developer [@Kagdi-etal:2012]\needcite.
These methods also have the same flaw in that they ultimately rely on
files for information.

Like Rao et al. [@Rao-etal:2013], the motivation of this work is to
create topic models that can be incrementally updated over time.
However, unlike Rao et al., we can rely on the source code history
itself to build the model without needing to manually adjust model
latent variables.
This gains the benefit of an increase in query time, but also could lead
to a more reliable model.


[Related work]

I am a fan of using Google^[<http://google.com>]

  Right     Left     Center     Default
-------     ------ ----------   -------
     12     12        12            12
    123     123       123          123
      1     1          1             1

Table:  Demonstration of simple table syntax\label{demo}

A reference to the Table \ref{demo}.

## Research Goals, Questions, and Hypotheses

The primary research goal of this proposal is to evaluate the performance
and reliability of topic models built on the source code histories. This
will require configuring and executing studies in various contexts of
software maintenance work, such as feature location, bug localization,
and developer identification.

A secondary goal is to create a practical framework for building models
that can be used in multiple contexts.
This will require building a prototype tool that could be used by both
researchers and practitioners.

<!--
- To evaluate models built on changesets to other models (typically
  based on files only, but may include additional information)
- Provide a practical framework for building models that can be used in
  multiple contexts (FLT, bug localization, triage).
- Provide insight for researchers and tool developers on best practices
  for using changeset-based models
-->


## Limitations and Assumptions

<!--
    Possible threats?
-->

## Terminology and Background

We adopt terminology similar to that of @Biggers-etal:2014. In particular,
we the following terms:

A *term* (or *word*), $w$, is the basic unit of discrete data in a lexicon and is a sequence of letters.
A *token* is a sequence of non-whitespace characters containing one or more term.
An *entity* is a named source element such as a class or method,
and an *identifier* is a token representing the name of an entity.
*Comments* and *literals* are sequences of tokens delimited by
language-specific markers (e.g., /\* \*/ and quotes).
The *document*, $d$, is a sequence of words $d = (w_1, \ldots, w_m)$,
and a *corpus* , $C$, is a set of documents $C = (d_1, \ldots, d_n)$.

The left side of Figure~\ref{fig:snapshot} illustrates the document extraction
process. A document extractor takes source code as input and produces a corpus
as output. Each document in the corpus contains the words associated with a
source code entity such as a class or method. The text extractor is the first
part of the document extractor. It parses the source code and produces a token
stream for each class. The preprocessor is the second part of the document
extractor. It applies a series of transformations to each token and produces
one or more words from the token. The transformations [@Marcus-etal:2004;
@Marcus-Menzies:2010] commonly used are:

Splitting

:   separate tokens into constituent words based on common coding
  style conventions (e.g., the use of camel case or underscores) and on the
  presence of non-letters (e.g., punctuation or digits)

Normalizing

:   replace each upper case letter with the corresponding lower
  case letter

Filtering

:   remove common words such as articles (e.g., "an" or "the"),
  programming language keywords, standard library entity names, or short words

Stemming

:   removing prefixes and suffixes to leave just the root word

The right side of Figure~\ref{fig:snapshot} illustrates the retrieval process.
The main prerequisite of the retrieval process is to build the search engine.
The search engine is constructed from the topic model trained from the corpus
and an index of that corpus inferred from that model, known as $\theta$.
The primary function of the search engine is to rank documents in relation to the query.
The search engine performs a pairwise classification of the query
to each document and ranks the documents according score.

To accomplish the classification step using a topic model,
the search engine infers $\theta_{Snapshot}$, i.e.,
the topic-document probability distribution of each document in the snapshot corpus,
as well as $\theta_{Query}$, i.e., the topic-document probability distribution of the query.
Then a similarity measure for probability distributions, such as
cosine similarity or Hellinger distance, can be used to make pairwise comparisons
between $\theta_{Query}$ and $\theta_{Snapshot}$.
Hellinger distance ($H$) can be defined as:

\begin{equation}
    H(P, Q) = \frac{1}{\sqrt{2}} \; \sqrt{\sum_{i=1}^{k} (\sqrt{P_i} - \sqrt{Q_i})^2}
\label{eq:hellinger}
\end{equation}

where $P$ and $Q$ are two discrete probability distributions of length $k$.

