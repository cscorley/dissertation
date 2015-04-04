## Developer identification {#study-triage}

Developer identification is a triaging activity in which a team member
identifies a list of developers that are most apt to complete a change request
and assigning one or more of those developers to the task
[@McDonald-Ackerman_1998].
@Begel-etal_2010 show that developers need help finding expertise within their
organization *more than they need help finding source code elements*. 

### Motivation

Software features are functionalities that are defined by requirements and are
accessible to developers and users. Software change is continual, because new
features must be added to meet revised requirements, existing features must be
enhanced to satisfy increased expectations, and defective features (i.e., bugs)
must be removed to achieve intended behavior. Changes to a software system are
proposed by developers or users, who submit change requests to the project
issue tracker. Change requests are sometimes called issue reports, and specific
kinds of change requests include feature requests, enhancement requests, and
bug reports.

Triaging a change request involves several steps that can be completed either
by a single person or by a team of developers in a triage meeting. How triage
occurs differs from team to team, but the general steps required are as
follows. First, the triager(s) must see if the request has enough information
to be considered. It is marked as a duplicate if the request already exists.
After it is confirmed that the request is new and has enough information, a
decision must be made if and how soon it will be completed based on its
severity, frequency, risk, and other factors. Finally, the triager assigns a
request to the developer. Ultimately, the goal of triage is deciding priority
of the request and assignment to the developer that is best suited to complete
the change request.

Triaging is a common and difficult task. Triage is even more difficult on
projects where developer teams are large or geographically distributed
[@Herbsleb-etal_2001]. A project member triaging a change request will need to
consider several factors in order to correctly assign the change request to a
set of developers with appropriate expertise [@McDonald-Ackerman_1998].
Triaging requires contextual knowledge about the product, team structure,
individual expertise, workload balance, and development schedules in order to
correctly assign a change request.

Triaging can be a time consuming and error prone process when done manually. If
a change request was assigned in error, it will need to be reassigned to the
appropriate developer. @Jeong-etal_2009 found that reassignment occurs between
37%--44% of the time and introduces an average of 50 days delay in completing
the request. Automated support for triaging helps to decrease change request
time-to-triage and to correct, or prevent, human error.

@McDonald-Ackerman_1998 show that there are two expertise finding problems:
identification and selection. In a semiautomated system, expertise
identification is automated, and suggests an expert for selection. In a
fully-automated system, the expert is identified and selected for assignment to
the change request. @Anvik-etal_2006 notes that a fully-automated approach may
not be feasible given the amount of contextual knowledge required for triage.

### Background {#dit-background}

Several developer identification techniques build upon feature location
techniques. We refer the reader to Section \ref{flt-background} for a
background on how a typical feature location technique might work.

After a ranked list of source code entities related to a particular task have
been identified by an FLT, we can now use ownership knowledge to determine the
appropriate developer to complete a task. For example, if file `foo.py` was
identified as the most related entity, then we would want to know about the
maintainer, or owner, of `foo.py`. There are multiple ways to determine the
ownership of a source code entity [@Bird-etal_2011; @Kagdi-etal_2012;
@Corley-etal_2012; @Hossen-etal_2014].

A simple, example ownership metric is the number of times a developer has
committed changes to a file. That is, if over the software history Johanna
modified `foo.py` 20 times, while Heather only has 5 modifications to `foo.py`,
then Johanna would be considered the owner of `foo.py`.

### Proposal

In this proposal, we introduce a topic-modeling-based DIT in which the model is
built incrementally from source code *changesets*. By training an online
learning algorithm using changesets, the DIT maintains an up-to-date model
without incurring the non-trivial computational cost associated with retraining
traditional DITs.

#### Approach {#dit-approach}

![Developer identification using changesets\label{fig:changeset-triage}](figures/changeset-triage.pdf)

The changeset approach requires two types of document extraction: one for the
every changeset in the source code history and a developer profile of the words
each individual developer used in those changesets. The left side of Figure
\ref{fig:changeset-triage} illustrates the dual-document extraction approach.

The document extraction process for the changesets remains the same as covered
in Section \ref{flt-approach}. The document extraction process for the
developer corpus is straightforward. Following @Matter-etal_2009, each
developer will have their own document consisting of each changeset they have
committed to the source code repository. That is, a developer document will be
constructed only by words they have changed. There may be weighting schemes to
this [@Shokripour-etal_2013], such as only considering words which they have
added or removed, while ignoring context words.

The right side of Figure \ref{fig:changeset-flt} illustrates the retrieval
process. The key intuition to our methodology is that a topic model such as LDA
or LSI can infer *any* document's topic proportions regardless of the documents
used to train the model.  In fact, this is also what determining the topic
proportions of a user-created or generated query relies on. Likewise, so are
other unseen documents. In our approach, the seen documents are changesets and
the unseen documents are the developer profiles.

Hence, we train a topic model on the changeset corpus and use the model to
index the developer profiles.  Note that we never construct an index of the
changeset documents on which the model is trained.  In our approach, we only
use the changesets to continuously update the topic model and only use the
developer profiles for indexing.

To leverage the online functionality of the topic models, we can also intermix
the model training, indexing, and retrieval steps.  First, we initialize a
model in online mode.  Then, as changes are made, the model is updated with the
new changesets as they are committed.  That is, with changesets, we
incrementally update a model and can query it at any moment. This will allow
for a *historical simulation* of how a changeset-based DIT would perform in a
realistic scenario.

#### Evaluation

In this section we describe the design of a case study in which we
compare topic models trained on changesets to those trained on snapshots.
For this work, we pose the following research questions:

RQ1
:   Is a changeset-based DIT as accurate as a snapshot-based DIT?

RQ2
:   Does the accuracy of a changeset-based DIT fluctuate as a project evolves?

##### Methodology

For snapshots, the process is straightforward, but requires two separate steps.
First, we need to build a topic model for searching over the source code
snapshot (i.e., just like in the FLT evaluation). Once relevant documents are
identified, we need to determine which developer is the *owner* of that
document. To accomplish this, we turn to the source code history. Following
@Bird-etal_2011, we identify which developer has changed the documents the
most. This implies that the snapshot approach is *dependent* on the performance
of the snapshot-based FLT.

For changesets, the approach will not necessarily be dependent on an FLT. We
can utilize the same approach as we did for the FLT evaluation. First, we train
a model of the changeset corpus using batch training.  Second, we infer an
index of topic distributions with the developer profiles.  Note that we *do
not* infer topic distributions with the changeset corpus on which the model was
built.  Finally, for each query in the dataset, we infer the query's topic
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
comparisons. Finally, we continue by updating the model with the next
mini-batch.

##### Subject Systems

There are two publicly-available and recently published datasets that could be
used in this study. Between these two datasets are over 415 defects and
features from 5 open source Java projects. Choosing a publicly-available
dataset allows for this work to be set in context of work completed by other
researchers.

Table \ref{table:dit-datasets} summarizes the subject systems from the
datasets. The first is a dataset of 5 software systems by @Kagdi-etal_2012. The
second is a dataset of 3 software systems by @Linares-Vasquez-etal_2012. Both
datasets were automatically extracted from changesets that relate to the
queries (issue reports). 

Subject System           Change Requests
--------------          ---------------- 
ArgoUML v0.22           91
ArgoUML v0.26.2         23
Eclipse v2.0            14
Eclipse v3.0            14
Eclipse v3.3.2          14
jEdit v4.3              143
KOffice v2.0-Beta 2     24
muCommander v0.8.5      92
Total                   415
--------------          ---------------- 

Table: Developer identification subject systems and goldset sizes
\label{table:dit-datasets}


ArgoUML is a UML diagramming tool^[<http://argouml.tigris.org/>].
Eclipse is an IDE for development in various programming languages^[<https://www.eclipse.org/>].
jEdit is a text editor^[<http://www.jedit.org/>].
KOffice is a office productivity suite^[<http://www.kde.org/applications/office>].
muCommander is a cross-platform file manager^[<http://www.mucommander.com/>].

##### Data Collection and Analysis

Like evaluating a topic-modeling-based FLT, to evaluate the performance of a
topic-modeling-based DIT we cannot use measures such as precision and recall.
This is because the FLT creates the rankings pairwise, causing every entity
being searched to appear in the rankings. Again, we can use the effectiveness
measure by @Poshyvanyk-etal_2007, thereby enabling us to use MRR. The
effectiveness measure is the rank of the first relevant document and represents
the number of developers the triager would have to assign before the right
developer is chosen. The effectiveness measure allows evaluating the FLT by
using the mean reciprocal rank (MRR). We can also look at only the top-k
recommendations in the list, giving us the measures of precision@k and
recall@k.

To answer RQ1, we run the experiment on the snapshot and changeset corpora as
outlined in Section \ref{flt-methodology}. We then calculate the MRR between
the two sets of effectiveness measures. We use the Wilcoxon signed-rank test
with Holm correction to determine the statistical significance of the
difference between the two rankings. To answer RQ2, we run the historical
simulation as outlined in Section \ref{flt-methodology} and compare it to the
results of batch changesets from RQ1. Again, we calculate the MRR and use the
Wilcoxon signed-rank test.

