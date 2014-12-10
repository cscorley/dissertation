# Proposed work

In this chapter, I outline the proposed work and methodologies to be used for
each.

## Feature location {#study-flt}

Feature location is a program comprehension activity in which a developer
inspects source code to locate the classes or methods that implement a feature
of interest.

### Motivation

Many feature location techniques (FLTs) are based on text retrieval models, and
in such FLTs it is typical for the models to be built from source code
snapshots. However, source code evolution leads to model obsolescence and thus
to the need to retrain the model from the latest snapshot.


### Background {#flt-background}

![Typical feature location process\label{fig:snapshot-flt}](figures/snapshot-flt.pdf)

The left side of Figure \ref{fig:snapshot-flt} illustrates the document extraction
process. A document extractor takes source code as input and produces a corpus
as output. Each document in the corpus contains the words associated with a
source code entity such as a class or method. The text extractor is the first
part of the document extractor. It parses the source code and produces a token
stream for each class. The preprocessor is the second part of the document
extractor. It applies a series of transformations to each token and produces
one or more words from the token.

The right side of Figure \ref{fig:snapshot-flt} illustrates the retrieval process.
The main prerequisite of the retrieval process is to build the search engine.
The search engine is constructed from the topic model trained from the corpus
and an index of that corpus inferred from that model, known as $\theta$.
The primary function of the search engine is to rank documents in relation to the query.
The search engine performs a pairwise classification of the query
to each document and ranks the documents according score.

To accomplish the classification step using a topic model,
the search engine infers $\theta_{Snapshot}$, i.e.,
the topic-document probability distribution of each document in the snapshot corpus,
as well as $\theta_{Query}$, i.e., the topic-document probability distribution of the query.
Then a similarity measure for probability distributions, such as
cosine similarity or Hellinger distance, can be used to make pairwise comparisons
between $\theta_{Query}$ and $\theta_{Snapshot}$.


### Proposal


In this proposal, we introduce a topic-modeling-based FLT in which the model is built
incrementally from source code *changesets*. By training an online learning
algorithm using changesets, the FLT maintains an up-to-date model without
incurring the non-trivial computational cost associated with retraining
traditional FLTs.

#### Approach {#flt-proposed-approach}

![Feature location using changesets\label{fig:changeset-flt}](figures/changeset-flt.pdf)

The changeset topic modeling approach requires two types of document
extraction: one for the snapshot of the state of source code at a commit of
interest, such as a tagged release, and one for the every changeset in the
source code history leading up to that commit. The left side of
Figure \ref{fig:changeset-flt} illustrates the dual-document extraction approach.

The document extraction process for the snapshot remains the same as covered in Section \ref{flt-background}.
The document extractor for the changesets parses each changeset for the removed, added, and context lines.
From there, each line is tokenized by the text extractor.
In a changeset it may be desirable to parse further for source code entities
using island grammar parsing [@Moonen_2001],
although not necessary for this approach.
It may also be desirable to only use portions of the changeset, such as only using added or removed lines.
The same preprocessor transformations as before also occur in changesets.

The right side of Figure \ref{fig:changeset-flt} illustrates the retrieval
process. The key intuition to our approach is that a topic model such as LDA or
LSI can infer any given document's topic proportions regardless of the
documents used to train the model. Hence, we train a topic model on the
changeset corpus, but search for related documents over the snapshot corpus. In
the search engine, we can use a dynamic programming to keep $\theta_{Snapshot}$
up-to-date as new changesets are added to the model. That is, upon a update to
the model, new inferences of only the source code documents affected by this
changeset are made. Additionally, we can then query the model as needed and
rank the results of that query against $\theta_{Snapshot}$. Note that we never
infer a $\theta_{Changeset}$ for the changeset documents on which the model is
built.

To leverage the online functionality of the topic models, we can also intermix
the model training and retrieval steps. First, we initialize a model in online
mode. Then, as changes are made, the model is updated with the new changesets
as they are committed. That is, with changesets, we incrementally update a
model and can query it at any moment. This insight means that we can also
evaluate our approach *temporally*. That is, we we can approximate how the FLT
would perform throughout the evolution of a project.


#### Evaluation

- FLT using both LSI and LDA
- @Dit-etal_2013
- @Moreno-etal_2014
- These datasets contain >1200 defects and features from 14 OSS Java projects
- We can also do temporal stuff to approximate how the FLT would perform
  throughout the evolution of a project.

## Developer identification {#study-triage}

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
appropriate developer. Jeong et al. [@Jeong-etal_2009] found that reassignment
occurs between 37\%--44\% of the time and introduces an average of 50 days
delay in completing the request. Automated support for triaging helps to
decrease change request time-to-triage and to correct, or prevent, human error.

McDonald and Ackerman [@McDonald-Ackerman_1998] show that there are two
expertise finding problems: identification and selection. In a semiautomated
system, expertise identification is automated, and suggests an expert for
selection. In a fully-automated system, the expert is identified and selected
for assignment to the change request. Anvik [@Anvik-etal_2006] notes that a
fully-automated approach may not be feasible given the amount of contextual
knowledge required for triage.

### Background {#triage-background}
### Proposal



#### Approach

![Developer identification using changesets\label{fig:changeset-triage}](figures/changeset-triage.pdf)

The changeset topic modeling approach requires two types of document
extraction:  and one for the every changeset in the source code history and a
developer profile of the words each individual developer changed in those
changesets. The left side of Figure \ref{fig:changeset-triage} illustrates the
dual-document extraction approach.

The document extraction process for the changesets remains the same as covered in
Section \ref{flt-proposed-approach}.


The right side of Figure \ref{fig:changeset-triage} illustrates the retrieval
process. The key intuition to our approach is that a topic model such as LDA or
LSI can infer any given document's topic proportions regardless of the
documents used to train the model. Hence, we train a topic model on the
changeset corpus, but search for related developers over the developer corpus.
In the search engine, we can use a dynamic programming to keep
$\theta_{Developers}$ up-to-date as new changesets are added to the model. That
is, upon a update to the model, new inferences of only the source code
documents affected by this changeset are made. Additionally, we can then query
the model as needed and rank the results of that query against
$\theta_{Developers}$. Note that we never infer a $\theta_{Changeset}$ for the
changeset documents on which the model is built.

To leverage the online functionality of the topic models, we can also intermix
the model training and retrieval steps. First, we initialize a model in online
mode. Then, as changes are made, the model is updated with the new changesets
as they are committed. That is, with changesets, we incrementally update a
model and can query it at any moment. This insight means that we can also
evaluate our approach *temporally*. That is, we we can approximate how the
automatic developer identification would perform throughout the evolution of a
project.


#### Evaluation

- DIT using both LSI and LDA
- Datasets?
- We can also do temporal stuff to approximate how the DIT would perform
  throughout the evolution of a project.



## Combining and Configuring Changset-based Topic Models {#study-config}

### Motivation

### Background

### Proposal


#### Approach

![Combining changeset-based feature location and developer identifiation
\label{fig:changeset-combo}](figures/changeset-combo.pdf)


#### Evaluation



