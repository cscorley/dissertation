## Combining and Configuring Changeset-based Topic Models {#sec:combo-methodology}

In this section, we explore an approach that uses a single changeset model for
both FLT and DIT tasks.  First, we describe our motivation in Section
\ref{sec:combo-motivation}. We then describe our study design in Section
\ref{sec:combo-design}.  Finally, we describe the results of the study (Section
\ref{sec:combo-results}) and discuss them in detail (Section
\ref{sec:combo-discussion}).


### Motivation {#sec:combo-motivation}

Topic model reuse for two tasks would halve the computational cost required for
model training.  This presumes, however, that the configuration choices made
for corpus construction and the model itself are acceptable for each task.
That is, the model used does not negatively impact either task due to
configuration.

@Biggers-etal_2014 were the first to explore the parameters of a LDA-based FLT.
Unfortunately, these findings for model training parameters may not directly
apply to a LDA-based DIT.  Further, there is no work on optimal configurations
when using a topic model for two tasks.  There is also evidence in the
literature that different configurations may be better suited for different
tasks [@Marcus-Poshyvanyk_2005; @Abadi-etal_2008].

Likewise, we must also make choice with respect to corpus construction, as LDA
can achieve higher performance by adjusting certain elements of a corpus
[@Biggers-etal_2014].  While we do not have enough source code in changesets to
be extract fully parsed elements -- such as comments, identifiers, literals,
and so on -- we do have structure in the changeset itself in the form of the
`diff` (see Figure \ref{fig:diff}).  That is, we have lines removed and added
that represent the change, and also lines for context for where the change is
to be applied.

### Study Design {#sec:combo-design}

In this work, we introduce a *combined* approach that allows for coalescing a
topic-modeling-based FLT and DIT coalesced into using the same topic model
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
same as covered in Section \ref{sec:flt-approach}.  The document extraction
process for the corpus of developer profiles remains the same as covered in
Section \ref{sec:dit-approach}.

The right side of Figure \ref{fig:changeset-combo} illustrates the retrieval
process.  For brevity, the queries and ranking do not appear in the diagram as
they remain the same as described for each search engine in their respective
sections, Sections \ref{sec:flt-approach} and \ref{sec:dit-approach}.  We train
a topic model on the changeset corpus and construct search engines for each
task separately.  In the source code search engine we build an index from the
snapshot corpus.  In the developer search engine we build an index from the
developer corpus.

