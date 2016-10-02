## Study Design {#sec:dit-design}

In this work, we introduce a topic-modeling-based DIT in which we
incrementally build the model from source code *changesets*.  By training an
online learning algorithm using changesets, the DIT maintains an up-to-date
model without incurring the non-trivial computational cost associated with
retraining traditional DITs.

### Approach {#sec:dit-approach}

![Developer identification using changesets\label{fig:changeset-triage}](figures/changeset-triage.pdf)

The changeset approach requires two types of document extraction: one for the
every changeset in the source code history and a developer profile of the words
each individual developer used in those changesets.  The left side of Figure
\ref{fig:changeset-triage} illustrates the dual-document extraction approach.

The document extraction process for the changesets remains the same as covered
in Section \ref{sec:flt-approach}.  The document extraction process for the
developer corpus is straightforward.  Following @Matter-etal_2009, each
developer will have their own document consisting of each changeset they have
committed to the source code repository.  That is, a developer document
consists of only words they have changed.  There may be weighting schemes to
this [@Shokripour-etal_2013], such as only considering words which they have
added or removed, while ignoring context words.

The right side of Figure \ref{fig:changeset-flt} illustrates the retrieval
process.  Like in Section \ref{sec:flt-approach}, the key intuition to our
methodology is that a topic model such as LDA or LSI can infer *any* document's
topic proportions regardless of the documents used to train the model.  In our
approach, the seen documents are changesets and the unseen documents are the
developer profiles.

Hence, we train a topic model on the changeset corpus and use the model to
index the developer profiles.  Note that we never construct an index of the
changeset documents used for training.  In our approach, we only use the
changesets to continuously update the topic model and only use the developer
profiles for indexing.

We can follow the same process used in Section \ref{sec:flt-approach} for a
historical simulation of how a changeset-based DIT would perform in a realistic
scenario.

### Evaluation

In this section we describe the design of a case study in which we
compare topic models trained on changesets to those trained on snapshots.
For this work, we pose the following research questions:

\donep
:   \doneq

\dtwop
:   \dtwoq

#### Methodology {#sec:dit-methodology}

For snapshots, the process is straightforward, but requires two separate steps.
First, we need to build a topic model for searching over the source code
snapshot (i.e., just like in the FLT evaluation).  Once we determine the
relevant documents, we need to determine which developer is the *owner* of
those documents.  To accomplish this, we turn to the source code history.
Following @Bird-etal_2011, we identify which developer has changed the
documents the most.  This implies that the snapshot approach is *dependent* on
the performance of the snapshot-based FLT.

For changesets, the approach will not necessarily be dependent on an FLT.  We
can utilize the same approach as we did for the FLT evaluation.  First, we
train a model of the changeset corpus using batch training.  Second, we infer
an index of topic distributions with the developer profiles.  Note that we *do
not* infer topic distributions with the changeset corpus used to train the
model.  Finally, for each query in the dataset, we infer the query's topic
distribution and rank each entity in the developer profiles index with pairwise
comparisons.

For the historical simulation, we take a slightly different approach.  We first
determine which commits relate to each query (or issue) and partition
mini-batches out of the changesets.  We then proceed by initializing a model
for online training.  Using each mini-batch, or partition, we update the model.
Then, we infer an index of topic distributions with the developer profiles at
the commit the partition ends on.  We also obtain a topic distribution for each
query related to the commit.  For each query, we infer the query's topic
distribution and rank each entity in the developer index with pairwise
comparisons.  Finally, we continue by updating the model with the next
mini-batch.

#### Data Collection and Analysis

To evaluate the performance of a topic-modeling-based DIT we cannot use
measures such as precision and recall.  This is because the DIT creates
rankings pairwise, causing every developer to appear in the rankings.  Again,
@Poshyvanyk-etal_2007 define an effectiveness measure for topic-modeling-based
FLTs, which is usable for a DIT.  The effectiveness measure is the rank of the
first relevant document and represents the number of developers the triager
would have to assign before choosing the right developer.  The effectiveness
measure allows evaluating the FLT by using the mean reciprocal rank (MRR).

To answer \done, we run the experiment on the snapshot and changeset corpora as
outlined in Section \ref{sec:dit-methodology}.  We then calculate the MRR
between the two sets of effectiveness measures.  We use the Wilcoxon
signed-rank test with Holm correction to determine the statistical significance
of the difference between the two rankings.  To answer \dtwo, we run the
historical simulation as outlined in Section \ref{sec:dit-methodology} and
compare it to the results of batch changesets from \done.  Again, we calculate
the MRR and use the Wilcoxon signed-rank test.

