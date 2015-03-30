
## Combining and Configuring Changset-based Topic Models {#study-config}

The two previously proposed approaches could potentially be used in unison with
a single model, allowing for halving the computational cost required for the
topic modeling.

### Motivation & Background

### Proposal

In this proposal, we introduce a *combined* approach that allows for a
topic-modeling-based FLT and DIT to be coalesced into using the same topic
model built incrementally from source code *changesets*. By training an online
learning algorithm using changesets and combining the two approaches, we
essentially cut the computational cost of the tasks in *half* with a single
topic model can being used for both tasks.

#### Approach

![Combining changeset-based feature location and developer identifiation
\label{fig:changeset-combo}](figures/changeset-combo.pdf)

The changeset topic modeling approach requires three types of document
extraction: one for the snapshot of the state of source code at a commit of
interest, such as a tagged release; one for the every changeset in the source
code history leading up to that commit; and a developer profile of the words
each individual developer changed in those changesets. The left side of Figure
\ref{fig:changeset-combo} illustrates the tri-document extraction approach.

The document extraction process for snapshot and changesets corpora remain the
same as covered in Section \ref{flt-approach}. The document extraction process
for the developer corpus remains the same as covered in Section
\ref{dit-approach}.

The right side of Figure \ref{fig:changeset-combo} illustrates the retrieval
process. For brevity, the queries and ranking are left out of the diagram.
Again, the key intuition to our approach is that a topic model such as LDA or
LSI can infer any given document's topic proportions regardless of the
documents used to train the model. Hence, we train a topic model on the
changeset corpus and construct search engines for each task separately. In the
source code search engine we build an index from the snapshot corpus. In the
developer search engine we build an index from the developer corpus. Querying
and ranking results for each search engine remains the same as described in
their respective sections, Section \ref{flt-approach} and \ref{dit-approach}.

#### Evaluation

In this section we describe the design of a exploratory study in which we
determine whether a single topic model trained on changesets is fit two serve
two purposes. For this work, we pose the following research questions:

RQ1
:   Can the same topic model be used effectively in more than one context?

RQ2
:   What configuration considerations must we make when training a multi-use
topic model?

    RQ2.1
    :   What are the affects of the online decaying parameters?

    RQ2.2
    :   What are the affects of using only portions of a changeset, such as
    added, removed, and context lines?

    RQ2.3
    :   What are the affects of including the commit message in the changeset
    document?

RQ3
:   How much repository history is needed before the approaches are effective?

##### Methodology

##### Subject Systems

For this work, we need a common dataset. Fortunately, there are several common
systems between the four datasets in the previous works [@Dit-etal_2013;
@Moreno-etal_2014; @Kagdi-etal_2012; @Linares-Vasquez-etal_2012]. Common
systems can be seen in Tables \ref{table:flt-datasets} and
\ref{table:dit-datasets} include ArgoUML v0.22, ArgoUML v0.26.2, jEdit v4.3,
and muCommander v0.8.5.



##### Data Collection and Analysis

