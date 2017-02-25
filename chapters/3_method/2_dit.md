## Developer Identification {#sec:dit}

Developer identification is a triaging activity in which a team member
identifies a list of developers that are most apt to complete a change request
and assigning one or more of those developers to the task
[@McDonald-Ackerman_1998].  @Begel-etal_2010 show that developers need help
finding expertise within their organization *more than they need help finding
source code elements*.  In this second, we outline an approach using online
topic models for developer identification.  First, we describe our motivation
and background in Sections \ref{sec:dit-motivation} and
\ref{sec:dit-background}, respectively.  We then describe our study design in
Section \ref{sec:dit-design}.  Finally, we describe the results of the study
(Section \ref{sec:dit-results}) and discuss them in detail (Section
\ref{sec:dit-discussion}).


### Motivation {#sec:dit-motivation}

Software features are functionalities defined by requirements and are
accessible to developers and users.  Software change is continual, because
revised requirements lead to new features, increasing expectations lead to
feature enhancements, achieving intended behavior leads to removal of defective
features (i.e., bugs).  Users and developers propose change requests to the
project issue tracker.  Change requests are sometimes called issue reports, and
specific kinds of change requests include feature requests, enhancement
requests, and bug reports.

Triaging a change request involves steps completed either by a single person or
by a team of developers in a triage meeting.  How triage occurs differs from
team to team, but the general steps required are as follows.  First, the
triager(s) must see if the request has enough information for consideration.
The triager marks the request as a duplicate if the request already exists
elsewhere in the tracker or was previously completed.  After confirming that
the request is new and has enough information, the triager decides whether the
request will be completed, and how soon it will be completed, based on its
severity, frequency, risk, and other factors.  Finally, the triager assigns a
request to the developer.  Ultimately, the goal of triage is deciding priority
of the request and assignment to the developer that is best suited to complete
the change request.

Triaging is a common and difficult task.  Triage is even more difficult on
projects where developer teams are large or geographically distributed
[@Herbsleb-etal_2001].  Triaging requires contextual knowledge about the
product, team structure, individual expertise, workload balance, and
development schedules in order to correctly assign a change request.  A project
member triaging a change request will need to consider these factors in order
to correctly assign the change request to a set of developers with appropriate
expertise [@McDonald-Ackerman_1998].

Triaging can be a time consuming and error prone process when done manually.  A
triager reassigns a change request assigned in error to a different developer,
or the original developer reassigns the request themselves.  @Jeong-etal_2009
found that reassignment occurs between 37%--44% of the time and introduces an
average of 50 days delay in completing the request.  Automated support for
triaging helps to decrease change request time-to-triage and to correct, or
prevent, human error.

@McDonald-Ackerman_1998 show that there are two expertise finding problems:
identification and selection.  In a semi-automated system, the system
automatically identifies and suggests an expert for assignment.  In a
fully-automated system, the system identifies and assigns a developer to the
change request.  @Anvik-etal_2006 notes that a fully-automated approach may not
be feasible given the amount of contextual knowledge required for triage.

### Background {#sec:dit-background}

Location-based techniques are a common developer identification technique and
build upon feature location techniques.  We refer the reader to Section
\ref{sec:flt-background} for a background on how a typical feature location
techniques works.

We use an FLT to identify a ranked list of source code entities related to a
particular task.  Using ownership knowledge about the identified entities, we
can choose an appropriate developer to complete the task.  For example, if the
FLT identifies the file `foo.py` as the most related entity, then we would want
to know about the maintainer, or owner, of `foo.py`.  There are multiple ways
to determine the ownership of a source code entity [@Bird-etal_2011;
@Kagdi-etal_2012; @Corley-etal_2012; @Hossen-etal_2014].

A simple, example ownership metric is the number of times a developer has
committed changes to a file.  That is, if over the software history Johanna
modified `foo.py` 20 times, while Heather only has 5 modifications to `foo.py`,
then we consider Johanna as the owner of `foo.py`.  Here, we would assign all
tasks related to `foo.py` to Johanna.
### Study Design {#sec:dit-design}

In this work, we introduce a topic-modeling-based DIT in which we
incrementally build the model from source code *changesets*.  By training an
online learning algorithm using changesets, the DIT maintains an up-to-date
model without incurring the non-trivial computational cost associated with
retraining traditional DITs.

#### Approach {#sec:dit-approach}

![Developer identification using changesets\label{fig:changeset-triage}](figures/changeset-triage.pdf)

Our changeset approach requires two types of document extraction: one for the
every changeset in the source code history and a developer profile of the words
each individual developer used in those changesets.  The left side of Figure
\ref{fig:changeset-triage} illustrates the dual-document extraction approach.

The document extraction process for the changesets remains the same as covered
in Section \ref{sec:flt-approach}.  The document extraction process for the
developer corpus is straightforward.  Following @Matter-etal_2009, each
developer will have their own document, or profile, consisting of each
changeset they have committed to the source code repository.  That is, a
developer document consists of only words they have changed.  There may be
weighting schemes to this [@Shokripour-etal_2013], such as only considering
words which they have added or removed, while ignoring context words.

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

We follow the same process used in Section \ref{sec:flt-approach} for a
historical simulation of how a changeset-based DIT would perform in a realistic
scenario.

#### Evaluation

In this section we describe the design of a case study in which we
compare topic models trained on changesets to those trained on snapshots.
For this work, we pose the following research questions:

\donep
:   \doneq

\dtwop
:   \dtwoq

##### Methodology {#sec:dit-methodology}

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


##### Setting {#sec:dit-setting}

<!-- This is almost an exact copy of what's in FLT -->
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

##### Data Collection and Analysis {#sec:dit-data-collection}

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
