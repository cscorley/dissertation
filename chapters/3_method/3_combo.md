## Combining and Configuring Changset-based Topic Models {#method-config}

The two previously proposed approaches are potentially usable in unison with
a single model, allowing for halving the computational cost required for the
topic modeling.

### Motivation

When using a topic modeler, we must make configuration choices.
@Biggers-etal_2014 were the first to explore the parameters of a LDA-based FLT.
Unfortunately, these findings may not directly apply to a LDA-based DIT.
Further, there is no work on optimal configurations when using a topic model
for two tasks.  There is also evidence in the literature that different
configurations may be better suited for different tasks
[@Marcus-Poshyvanyk_2005; @Abadi-etal_2008].

### Study Design

In this proposal, we introduce a *combined* approach that allows for coalescing
a topic-modeling-based FLT and DIT coalesced into using the same topic model
built incrementally from source code *changesets*.  By training an online
learning algorithm using changesets and combining the two approaches, we
essentially cut the computational cost of the two tasks in *half* with a single
topic model.

#### Approach

![Combining changeset-based feature location and developer identifiation
\label{fig:changeset-combo}](figures/changeset-combo.pdf)

The changeset topic modeling approach requires three types of document
extraction: one for the snapshot of the state of source code at a commit of
interest, such as a tagged release; one for the every changeset in the source
code history leading up to that commit; and a developer profile of the words
each individual developer changed in those changesets.  The left side of Figure
\ref{fig:changeset-combo} illustrates the tri-document extraction approach.

The document extraction process for snapshot and changesets corpora remain the
same as covered in Section \ref{flt-approach}.  The document extraction process
for the developer corpus remains the same as covered in Section
\ref{dit-approach}.

The right side of Figure \ref{fig:changeset-combo} illustrates the retrieval
process.  For brevity, the queries and ranking do not appear in the diagram.
We train a topic model on the changeset corpus and construct search engines for
each task separately.  In the source code search engine we build an index from
the snapshot corpus.  In the developer search engine we build an index from the
developer corpus.  Querying and ranking results for each search engine remains
the same as described in their respective sections, Section \ref{flt-approach}
and \ref{dit-approach}.

#### Evaluation

In this section we describe the design of a exploratory study in which we
determine whether a single topic model trained on changesets is fit to serve
two purposes.  For this work, we pose the following research questions:

RQ 3.5.1
:   Can we use the same topic model in more than one context effectively?

RQ 3.5.2
:   What are the effects of using different portions of a changeset for corpus
construction, such as added, removed, context lines, and the commit message?

RQ 3.5.3
:   How much repository history do we need before the approaches are effective?


##### Methodology

In this work, we can utilize much of the already created framework from the
previous two research areas covered in this proposal.  After evaluating the
usefulness of changesets, we will not need to instantiate snapshot models for
this work.  Instead, where this work will differ from the previous two research
areas is in how we construct the topic model.

For *RQ 3.5.1*, we want to find if the two approaches can rely on the same
model with minimal interference from one another's requirements.  For example,
the FLT task may perform better with less topics, while the DIT task may
require more topics for optimal performance.  Table \ref{table:combo-rq1}
outlines the factors about the model construction we will consider.  The
factors $\alpha$ and $\eta$ vary between several common values, but also
include automatic learning of these two hyper-parameters [@Hoffman-etal_2010].

\input{tables/case_study_factors}

While *RQ 3.5.1* focuses on model construction, *RQ 3.5.2* focuses on
training-corpus construction.  For *RQ 3.5.2*, there are several combinations
to consider.  While thus far we have always included the entire changeset when
training, it may be beneficial to consider only including portions (i.e., added
lines only) while excluding other portions (i.e., removed lines).  It may also
be beneficial to include the natural language text of the commit message.
Table \ref{table:combo-rq2} outlines the 15 combinations over the 4 types of
changeset text.

\todo{what about RQ 3.5.3}
