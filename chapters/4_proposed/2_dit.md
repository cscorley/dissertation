## Developer identification {#study-triage}

Developer identification is a triaging activity in which a team member
identifies a list of developers that are most apt to complete a change request
and assigning one or more of those developers to the task
[@McDonald-Ackerman_1998].

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
@Corley-etal_2012].

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

The changeset topic modeling approach requires two types of document
extraction: one for the every changeset in the source code history and a
developer profile of the words each individual developer changed in those
changesets. The left side of Figure \ref{fig:changeset-triage} illustrates the
dual-document extraction approach.

The document extraction process for the changesets remains the same as covered
in Section \ref{flt-approach}. The document extraction process for the
developer corpus is straightforward. Each developer will have their own
document consisting of each changeset they have committed to the source code
repository. That is, a developer document will be constructed only by word they
have changed. There may be weighting schemes to this, such as only considering
words which they have added or removed, while ignoring context words.

The right side of Figure \ref{fig:changeset-triage} illustrates the retrieval
process. The key intuition to our approach is that a topic model such as LDA or
LSI can infer any given document's topic proportions regardless of the
documents used to train the model. Hence, we train a topic model on the
changeset corpus, but search for related developers over the developer corpus.
In the search engine, we can use a dynamic programming to keep
$\theta_{Developers}$ up-to-date as new changesets are added to the model. That
is, upon a update to the model, new inferences of only the developer which
affected this changeset are made. Additionally, we can then query the model as
needed and rank the results of that query against $\theta_{Developers}$. Note
that we never infer a $\theta_{Changeset}$ for the changeset documents on which
the model is built.

To leverage the online functionality of the topic models, we can also intermix
the model training and retrieval steps. First, we initialize a model in online
mode. Then, as changes are made, the model is updated with the new changesets
as they are committed. That is, with changesets, we incrementally update a
model and can query it at any moment. This insight means that we can also
evaluate our approach *temporally*. That is, we we can approximate how the
automatic developer identification would perform throughout the evolution of a
project.

#### Evaluation

In this section we describe the design of a case study in which we
compare topic models trained on changesets to those trained on snapshots.
For this work, we pose the following research questions:

RQ1
:   How well do changeset-based topic models perform for developer
identification?

RQ2
:   How well do *temporal simulations* of changeset-based topic models perform
for developer identification?

##### Methodology

For snapshots, the process is straightforward, but requires two separate steps.
First, we need to build a topic model for searching over the source code
snapshot (i.e., just like in the FLT evaluation). Once relevant documents are
identified, we need to determine which developer is the *owner* of that
document. To accomplish this, we turn to the source code history. Following
@Bird-etal_2011, we identify which developer has changed the documents the
most. This implies that the snapshot approach is *dependent* on the performance
of the snapshot-based FLT.

For changesets, we can utilize the same approach as we did for the FLT
evaluation. First, we build a model in batch mode from the changeset corpus.
However, instead of building an index of the snapshot, we build an index of the
developer profiles. That is, we infer a $\theta_{Developers}$ from the
developer corpus and a $\theta_{Queries}$ from the query corpus. Note that we
\emph{do not} infer a $\theta_{Changesets}$ from the changeset corpus from
which the model was built! Finally, we classify the results from both
$\theta$s. While the snapshot approach is dependent on the performance of an
FLT, the changesets are not.

For the temporal simulation, again as in the FLT, we can take a slightly
different approach. We first determine which changesets relate to an issue and
partition mini-batches out of the changesets. Then, we initialize a model in
online mode. For each mini-batch, or partition, we update the model with that
mini-batch. Then, we infer a $\theta_{Developers}$ from the developer corpus
and a retrieve the $\theta_{Queries}$ for the queries related to this
changeset. Finally, we classify the results from both $\theta$s.


##### Subject Systems

<!--
@Kagdi-etal_2012
<http://www.cs.wm.edu/semeru/data/jsme09-bugs-devs/>

@Linares-Vasquez-etal_2012
<http://www.cs.wm.edu/semeru/data/icsm2012-authorship/>
-->

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


ArgoUML is a UML CASE tool that supports standard UML diagrams^[<http://argouml.tigris.org/>].
Eclipse is an intergrated development environment to develop applications in various programming languages^[<https://www.eclipse.org/>].
jEdit is a Java text editor^[<http://www.jedit.org/>].
KOffice is a office productivity suite^[<http://www.kde.org/applications/office>].
muCommander is a cross-platform file manager^[<http://www.mucommander.com/>].

##### Data Collection and Analysis

Like evaluating a topic-modeling-based FLT, to evaluate the performance of a
topic-modeling-based DIT we cannot use measures such as precision and recall
directly. Again, we can use the effectiveness measure by @Poshyvanyk-etal_2007,
thereby enabling us to use MRR. We can also look at only the top-k
recommendations in the list, giving us the measures of precision@k and
recall@k.

For any execution of the experiment, we calculate the MRR of each approach.
We use the Wilcoxon signed-rank test with Holm correction to determine
the statistical significance of the difference between any two rankings.


