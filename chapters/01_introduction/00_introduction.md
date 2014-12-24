# Introduction

Software developers are often confronted with maintenance tasks that involve
navigation of repositories that preserve vast amounts of project history.
Navigating these software repositories can be a time-consuming task, because
their organization can be difficult to understand. Fortunately, topic models
such as latent Dirichlet allocation (LDA) [@Blei-etal_2003] can help developers
to navigate and understand software repositories by discovering topics (word
distributions) that reveal the thematic structure of the data
[@Linstead-etal_2007; @Thomas-etal_2011; @Hindle-etal_2012].

Program comprehension is a prerequisite to incremental change. A software
developer who is tasked with changing a large software system spends effort on
program comprehension activities to gain the knowledge needed to make the
change [@Corbi_1989]. For example, the developer spends effort to understand
the system architecture or to locate the parts of the source code that
implement the feature(s) being changed. Gaining such knowledge can be a
time-consuming task, especially for developers who are unfamiliar with the
system. Topic models of source code can help such developers to understand the
system by revealing a latent structure that is not obvious from the package
hierarchy or system documentation [@Savage-etal_2010].

Topic models are used to uncover thematic structure (e.g., topics) of source
code entities that are grouped by their natural language content (i.e., the
words in their identifiers, comments, and literals). Such topics often
correspond to the concepts and features implemented by the source code
[@Baldi-etal_2008], and exploring such topics shows promise in helping
developers to understand the entities that make up a system and to understand
how those entities relate [@Kuhn-etal_2007; @Maskeri-etal_2008;
@Savage-etal_2010; @Gethers-etal_2011a]. Recent approaches to exploring
linguistic topics in source code use machine learning techniques that model
correlations among words, such as latent semantic indexing (LSI)
[@Deerwester-etal_1990] and latent Dirichlet allocation (LDA)
[@Blei-etal_2003], and ML techniques that also model correlations among
documents, such as RTM [@Chang-Blei_2010].

Topic models of source code have many applications in addition to general
program comprehension. These applications include feature location
[@Dit-etal_2013a], bug localization [@Lukins-etal_2008; @Rao-etal_2013],
triaging incoming change requests [@Kagdi-etal_2012], traceability link
recovery [@Asuncion-etal_2010], and several other areas [@Biggers_2012]. Yet,
while researchers have had success in using topic models on source code
entities, there is a fundamental issue with the current approaches. This issue
is that the input documents used to build a topic model are source code
entities, and will be the motivating point of this work.

## Terminology

This section defines some of the terminology that will be seen throughout this
work. We adopt and extend terminology from @Biggers-etal_2014. In particular,
we define the following:

feature location
:   the act of identifying the source code entity or entities that implement a
system feature

developer identification
:   the act of identifying the developer most apt to completing a software
maintenance task

term (word), $w$
:   the smallest free-form of a language

token
:   a sequence of non-whitespace characters containing one or more term

entity
:   a named source element such as a method, class, or package

identifier
:   a token representing the name of an entity

comment
:   a sequence of tokens delimited by language specific markers (e.g., `/* */`
or `#`)

literal
:   a sequence of tokens delimited by language specific markers (e.g., `' '`
for strings)

document, $d$
:   a sequence of $D$ terms $w_1, w_2, ..., w_D$, often represented as a
bag of words (i.e., $M$-length vector of term frequencies or weights)

corpus, $C$
:   a sequence of $N$ documents $d_1, d_2, ..., d_N$ (i.e., a $M \times N$
document-term matrix)

vocabulary, $V$
:   a set of $M$ unique terms that appear in a corpus $\{w_1, w_2, ..., w_M\}$

topic, $z$
:   a concept or theme of related terms, often represented as a distribution of
term proportions

topic model, $\phi$
:   a mathematical representation of the thematic structure of a corpus, or how
much a term $w$ contributes to each topic $z$ (i.e., a $M \times K$ topic-term
matrix)

inferrence, $\theta_d$
:   the thematic structure of a given document (i.e., a $K$-length topic
proportion vector)

index, $\theta$
:   a corpus that has been transformed for searching, e.g., in LDA by
inferring the thematic structure of each document (i.e., a $N \times K$
document-topic matrix)

query, $q$
:   a document created by a user

search engine
:   ranks documents by their similarity to a query

diff
:   set of text which represents the differences between two texts (see Figure
\ref{fig:diff})

patch
:   a set of instructions (i.e., diffs) that is used to transform one set of
texts into another

context lines
:   lines of a diff that denote text useful for transforming the text, but do
not represent the differences

added lines
:   lines of a diff that were *added* in order to transform the first text into
the second

removed lines
:   lines of a diff that were *removed* in order to transform the first text into
the second

changeset
:   ideally represents a single feature modification, addition, or deletion,
which may crosscut many source code entities

commit
:   a representation of a changeset in a version control system

version control system (VCS)
:   tool that assists a developer in maintaining software , such as Git or
Subversion

software repository
:   collection of commits over time which represent the history of a software
project, maintained by a VCS

\begin{figure*}[t]
\centering
{\small
\begin{lstlisting}[language=diff, basicstyle=\ttfamily]
diff --git a/lao b/tzu
index 635ef2c..5af88a8 100644
--- a/lao
+++ b/tzu
@@ -1,7 +1,6 @@
-The Way that can be told of is not the eternal Way;
-The name that can be named is not the eternal name.
 The Nameless is the origin of Heaven and Earth;
-The Named is the mother of all things.
+The named is the mother of all things.
+
 Therefore let there always be non-being,
   so we may see their subtlety,
 And let there always be being,
@@ -9,3 +8,6 @@ And let there always be being,
 The two are the same,
 But after they are produced,
   they have different names.
+They both may be called deep and profound.
+Deeper and more profound,
+The door of all subtleties!
\end{lstlisting}
}
\caption{Example of a \texttt{git diff}}
Black or blue lines denote metadata about the change useful for patching.
In particular, black lines represent context lines (beginning with a single space).
Red lines (beginning with a single~\texttt{-}) denote line removals,
and green lines (beginning with a single~\texttt{+}) denote line additions.
\label{fig:diff}
\vspace{-10pt}
\end{figure*}




## Motivation

When modeling a source code repository, the corpus typically represents a
snapshot of the code. That is, a topic model is often trained on a corpus that
contains documents that represent files from a particular version of the
software. Keeping such a model up-to-date is expensive, because the frequency
and scope of source code changes necessitate retraining the model on the
updated corpus. However, it may be possible to automate certain maintenance
tasks without a model of the complete source code. For example, when assigning
a developer to a change task, a topic model can be used to associate developers
with topics that characterize their previous changes. In this scenario, a model
of the text changed by each developer may be more useful than a model of
the files changed by each developer.

While using file-based models is a natural fit for program comprehension tasks
such as feature location and bug localization, they still are unable to stay
up-to-date entirely. Additionally, much of the work for assigning developers to
change requests still uses files as input and an array of heuristics to
identify a developer [@Kagdi-etal_2012]. These methods also have the same flaw
in that they ultimately rely on files for information.

To remedy these shortcomings, we propose to use *changesets* in the training of
a topic model. Like @Rao-etal_2013, the motivation of this work is to create
topic models that can be incrementally updated over time. However, unlike
@Rao-etal_2013, we can rely on the source code history itself to build the
model without needing to manually adjust model latent variables. This gains the
benefit of an increase in query time, but also could lead to a more reliable
model.

The key intuition to this approach is that a topic model algorithm such as
latent Dirichlet allocation or latent semantic indexing can *infer* any given
document's topic proportions regardless of the documents used to train the
model. That is, we can train a model a corpus of changesets and infer the
topics of an entirely different corpus (e.g., source code entities). Further,
now that topic modeling can be done in an online manner [@Hoffman-etal_2010;
@Rehurek_2011], the model can be periodically updated with new changesets as
they enter a source code repository. This implies that a topic model can be
kept up-to-date with the source code as work is being done.

## Research Goals, Questions, and Hypotheses {#thesis-goals}

The primary research goal of this proposal is to evaluate the performance and
reliability of topic models built on the source code histories. This will
require configuring and executing studies in various contexts of software
maintenance work, such as feature location, bug localization, and developer
identification.

A secondary goal is to create a practical framework for building models that
can be used in multiple contexts. This will require building a prototype tool
that could be used by both researchers and practitioners.

Towards achieving these goals, I've identified three core research questions,
defined below.

Research Question 1:
:   How does training a topic model on changesets affect the performance of a
topic-modeling-based feature location techinque?

Research Question 2:
:   How does training a topic model on changesets affect the performance of a
topic-modeling-based developer identification techinque?

Research Question 3:
:   Can a single topic model trained on changesets be effectively used in both
feature location and developer identification techniques?

Essentially, we want to know whether using changesets in a topic-modeling-based
tool is beneficial and whether we can use multiple tools on the same topic
model.


## Limitations and Assumptions

There are various limitations and assumptions in this research that need to be
addressed upfront.

First, the assumption is made that a software project using a changeset-based
topic model has a large history. Topic models need a substantial amount of data
for training, and hence the more history supplied to the model the more
accurate it becomes. There may be solutions to this problem, such as using
the software snapshot after a release in combination with the changesets.

The second assumption follows the first, in that the software repository
history is not changed or re-written after initial training of the topic model.
New version control software, such as Git and Mecurial, allow for history to be
re-written arbitrarily. For instance, a repository may contain work on a
subproject which is then extracted into it's own fully-fledged project at a
later point. This has happened in the case of the Apache Lucene and Solr
projects.

The third assumption is that an optimal configuration exists. Since the models
are only seeing a single document at a time, there may be performance issues
with this approach. Previously, topic models were trained in *batch*, i.e.
knowing about all documents ahead of time, and have many parameters that need
to be configured for optimal performance. Likewise, *online* topic models
include additional parameters that also need to be configured.

Finally, there is an assumption about the topics of a software project itself.
The assumption is that the topics do not experience topic drifting or large
changes in vocabulary. Solutions towards topic drift [@Blei-Lafferty_2006] and
expanding vocabularies [@Zhai-Boyd-Graber_2013] have been suggested by the
topic modeling communities which may address this issue.

## Organization

This work is organized as follows.
Chapter \ref{related-work} discusses related work in the area of text
retrieval, configuration, and applications in software maintenance.
Chapter \ref{previous-work} discusses work already completed that influences
the proposed work.
Chapter \ref{proposed-work} outlines three areas of study which each target a
research question identified in Section \ref{thesis-goals}.
Chapter \ref{conclusion} concludes.
A project schedule for work is given in Appendix \ref{projected-schedule}.
