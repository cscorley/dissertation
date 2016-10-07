## Study Design {#sec:combo-design}

In this work, we introduce a *combined* approach that allows for coalescing a
topic-modeling-based FLT and DIT coalesced into using the same topic model
built incrementally from source code *changesets*.  By training an online
learning algorithm using changesets and combining the two approaches, we
essentially cut the computational cost of the two tasks in *half* with a single
topic model.

### Approach

![Combining changeset-based feature location and developer identifiation
\label{fig:changeset-combo}](figures/changeset-combo.pdf)

The changeset topic modeling approach requires three types of document
extraction: one for the snapshot of the state of source code at a commit of
interest, such as a tagged release; one for the every changeset in the source
code history leading up to that commit; and a developer profile of the words
each individual developer changed in those changesets.  The left side of Figure
\ref{fig:changeset-combo} illustrates the tri-document extraction approach.

The document extraction process for snapshot and changesets corpora remain the
same as covered in Section \ref{sec:flt-approach}.  The document extraction
process for the developer corpus remains the same as covered in Section
\ref{sec:dit-approach}.

The right side of Figure \ref{fig:changeset-combo} illustrates the retrieval
process.  For brevity, the queries and ranking do not appear in the diagram as
they remain the same as described for each search engine in their respective
sections, Section \ref{sec:flt-approach} and \ref{sec:dit-approach}.  We train
a topic model on the changeset corpus and construct search engines for each
task separately.  In the source code search engine we build an index from the
snapshot corpus.  In the developer search engine we build an index from the
developer corpus.

### Evaluation

In this section we describe the design of a exploratory study in which we
determine whether a single topic model trained on changesets is fit to serve
two purposes.  For this work, we pose the following research questions:

\conep
:   \coneq

\ctwop
:   \ctwoq

#### Methodology

In this work, we utilize much of the already created framework from the
previous two research areas covered in this work.  We will not need to
instantiate snapshot models for this work.  Instead, where this work will
differ from the previous two research areas is in how we construct the corpus
and topic model.

For \cone, we want to find if the two approaches can rely on the same
model with minimal interference from one another's requirements.  For example,
the FLT task may perform better with less topics, while the DIT task may
require more topics for optimal performance.  Table \ref{table:combo-rq1}
outlines the factors about the model construction we will consider.  The
factors $\alpha$ and $\eta$ vary between several common values, but also
include automatic learning of these two hyper-parameters [@Hoffman-etal_2010].

\input{tables/case_study_factors}

While \cone{} focuses on model construction, \ctwo{} focuses on training-corpus
construction.  For \ctwo, there are several combinations to consider.  While
thus far we have always included the entire changeset when training, it may be
beneficial to consider only including portions (i.e., added lines only) while
excluding other portions (i.e., removed lines).  It may also be beneficial to
include the natural language text of the commit message.  Table
\ref{table:combo-rq2} outlines the 15 combinations over the 4 types of
changeset text.
