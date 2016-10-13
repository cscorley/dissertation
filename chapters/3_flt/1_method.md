## Study Design {#sec:flt-design}

In this work, we introduce a topic-modeling-based FLT in which we
incrementally build the model from source code *changesets*.  By training an
online learning algorithm using changesets, our FLT maintains an up-to-date
model without incurring the non-trivial computational cost associated with
retraining traditional FLTs.

### Approach {#sec:flt-approach}

![Feature location using changesets\label{fig:changeset-flt}](figures/changeset-flt.pdf)

The overall difference in our methodology and the standard methodology
described in Section \ref{sec:flt-background} is minimal.  For example, compare
Figures \ref{fig:snapshot-flt} and \ref{fig:changeset-flt}.  In the changeset
approach, we only need to replace the training documents while the remainder of
the approach remains the same.

The changeset approach requires two types of document extraction: the snapshot
of the state of source code at a point of interest, such as a commit of a
tagged release, and every changeset in the source code history leading up to
the same point of interest.  The left side of Figure \ref{fig:changeset-flt}
illustrates the dual-document extraction approach.

The document extraction process for the snapshot remains the same as covered in
Section \ref{sec:flt-background} while the document extractor for the changesets
parses each changeset for the removed, added, and context lines.  From there,
the text extractor tokenizes each line.  The same preprocessor transformations
as before occur in both the snapshot and changesets.  The snapshot vocabulary
is always a subset of the changeset vocabulary [@Corley-etal_2014].

The right side of Figure \ref{fig:changeset-flt} illustrates the retrieval
process.  The key intuition to our methodology is that a topic model such as
LDA or LSI can infer *any* document's topic proportions regardless of the
documents used to train the model.  This is also what determining the topic
proportions of a user-created query has relied on in most TM-based FLTs.
Likewise, so are other unseen documents.  In our approach, the seen documents
are changesets and the unseen documents are the source code entities of the
snapshot.

Hence, we train a topic model on the changeset corpus and use the model to
index the snapshot corpus.  Note that we never construct an index of the
changeset documents used to train the model.  We only use the changesets to
continuously update the topic model and only use the snapshot for indexing.

To leverage the online functionality of the topic models, we can also intermix
the model training, indexing, and retrieval steps.  First, we initialize a
model in online mode.  We update the model with new changesets whenever a
developer makes a new commit.  That is, with changesets, we incrementally
update a model and can query it at any moment.  This allows for a *historical
simulation* of how a changeset-based FLT would perform in a realistic scenario.

### Evaluation

In this section we describe the design of a case study in which we compare
topic models trained on changesets to those trained on snapshots.  For this
work, we pose the following research questions:

\fonep
:   \foneq

\ftwop
:   \ftwoq

#### Methodology {#sec:flt-methodology}

For snapshots, the process is straightforward and corresponds to Figure
\ref{fig:snapshot-flt}.  We first train a model on the snapshot corpus using
batch training.  That is, the model can see all documents in the corpus at
once.  Then, we infer an index of topic distributions with the snapshot corpus.
For each query in the dataset, we infer the query's topic distribution and rank
each entity in the index with pairwise comparisons.

For changesets, the process varies slightly from a snapshot approach, as shown
in Figure \ref{fig:changeset-flt}.  First, we train a model of the changeset
corpus using batch training.  Second, we infer an index of topic distributions
with the snapshot corpus.  Note that we *do not* infer topic distributions with
the changeset corpus.  Finally, for each query in the dataset, we infer the
query's topic distribution and rank each entity in the snapshot index with
pairwise comparisons.

For the historical simulation, we must take a different approach.  We first
determine which commits relate to each query (or issue) and partition
mini-batches out of the changesets.  We then proceed by initializing a model
for online training with no initial corpus.  Using each mini-batch, or
partition, we update the model.  Then, we infer an index of topic distributions
with the snapshot corpus at the commit the partition ends on.  We also obtain a
topic distribution for each query related to the commit.  For each query, we
infer the query's topic distribution and rank each entity in the snapshot index
with pairwise comparisons.  Finally, we continue by updating the model with the
next mini-batch.

Since our dataset is extracted from the commit that implemented the change, our
partitioning is inclusive of that commit.  That is, we update the model with
the linked commit and infer the snapshot index from that commit.  This allows
our evaluations to capture any entities added to address the issue report, as
well as changed entities, but does not capture any entities removed by the
change.

#### Setting {#sec:flt-setting}

Our document extraction process is shown on the left side of Figure
\ref{fig:changeset-flt}.  We implemented our document extractor in Python v2.7
using the [Dulwich library](http://www.samba.org/~jelmer/dulwich/) for
interacting with the source code repository.  We extract documents from both a
snapshot of the repository at a tagged snapshot and each commit reachable from
that tag's commit.  The same preprocessing steps are employed on all extracted
documents.

To extract text from the changesets, we look at the \texttt{git diff} between
two commits.  In our changeset text extractor, we extract all text related to
the change, e.g., context, removed, and added lines; metadata lines are ignored.
Note that we do not consider where the text originates from, only that it is
text changed by the commit.

After extracting tokens, we split the tokens based on camel case, underscores,
and non-letters.  We only keep the split tokens; original tokens are discarded.
We normalize to lower case before filtering non-letters, English stop
words [@Fox_1992], Java keywords, and words shorter than three characters
long.  We do not stem words.

We implemented our modeling using the Python library Gensim
[@Rehurek-Sojk_2010], version 0.12.1. We use the same configurations on each
subject system.  We do not try to adjust parameters between the different
systems to attempt to find a better, or best, solution; rather, we leave them
the same to reduce confounding variables.  We do realize that this may lead to
topic models that may not be best-suited for feature location on a particular
subject system.  However, this constraint gives us confidence that the
measurements collected are fair and that the results are not influenced by
selective parameter tweaking.  Again, our goal is to show the performance of
the changeset-based FLT against snapshot-based FLT under the same conditions.

Gensim's LDA implementation is based on an online LDA by @Hoffman-etal_2010 and
uses variational inference instead of a collapsed Gibbs sampler.  Unlike Gibbs
sampling, in order to ensure that the model converges for each document, we set
the model to take $1000$ iterations over a document during the inference step,
and as many passes over the corpus as needed until there is little improvement
in the evidence lower bound. That is, we allow the model to behave as a batch,
or offline, model.  We set the following LDA parameters for all systems: $500$
topics, a symmetric $\alpha=1/K$, and a symmetric $\eta=1/K$.  These are
default values for $\alpha$ and $\eta$ in Gensim, and have been found to work
well for the FLT task [@Biggers-etal_2014].

For the historical simulation, since we must use online training, we found it
beneficial to consider two new parameters for online LDA: $\kappa$ and
$\tau_0$.  As noted in @Hoffman-etal_2010, it is beneficial to adjust $\kappa$
and $\tau_0$ to higher values for smaller mini-batches, e.g. a single
changeset.  These two parameters control how much influence a new mini-batch
has on the model when training.  We follow the recommendations in
@Hoffman-etal_2010, choosing $\tau_0=1024$ and $\kappa=0.9$ for all systems,
because the historical simulation often has mini-batch sizes in single digits.
Additionally, since we are operating in fully online mode, we cannot take
multiple passes over the entire corpus as that would defeat the purpose of a
historical simulation.

#### Data Collection and Analysis {#sec:flt-data-collection}

To evaluate the performance of a topic-modeling-based FLT we cannot use
measures such as precision and recall.  This is because the FLT creates
rankings pairwise, causing every entity to appear in the rankings.
@Poshyvanyk-etal_2007 define an effectiveness measure for topic-modeling-based
FLTs.  This effectiveness measure is the rank of the first relevant document
and represents the number of source code entities a developer would have to
view before reaching a relevant one.  Most importantly, this effectiveness
measure allows evaluating the FLT by using the mean reciprocal rank (MRR) and
the Wilcoxon signed-rank test.

To answer \fone, we run the experiment on the snapshot and changeset corpora as
outlined in Section \ref{sec:flt-methodology}.  We then calculate the MRR
between the two sets of effectiveness measures.  We use the Wilcoxon
signed-rank test with Holm correction to determine the statistical significance
of the difference between the two rankings.  To answer \ftwo, we run the
historical simulation as outlined in Section \ref{sec:flt-methodology} and
compare it to the results of batch changesets from \fone using the same
measures.

We must note that when performing evaluations on FLTs, it is possible to
encounter a query that will fail to retrieve any related documents.  This is
related to both our approach and goldset extraction process.  Since our
approach indexes only on the snapshot corpus for a particular commit of
interest, it is possible that a file changed to fix a particular issue in the
goldset no longer exists or was never committed to source control by
maintainers.  We exclude these queries from all analysis.
