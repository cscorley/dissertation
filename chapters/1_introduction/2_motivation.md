## Motivation {#sec:intro-motivation}

When modeling a source code repository, the corpus typically represents a
snapshot of the code.  That is, a topic model is often trained on a corpus that
contains documents that represent source code entities (e.g., files, classes,
or methods) from a particular version of the software at a particular moment in
time.  Keeping such a model up-to-date is expensive, because the frequency and
scope of source code changes necessitate retraining the model on the updated
corpus [@Rao_2013].  It may be possible to automate certain maintenance tasks
without a model of the complete source code.  For example, when assigning a
developer to a change task, we can use a topic model to relate developers with
topics that characterize their previous changes.  In this scenario, a model of
the text changed by each developer may be more useful than a model of the
entities changed by each developer.

While using entity-based models is a natural fit for program comprehension
tasks such as feature location and bug localization, they still are unable to
stay up-to-date entirely [@Rao_2013].  Further, much of the work for assigning
developers to change requests still use source code entities as input and an
array of heuristics to identify a developer [@Kagdi-etal_2012;
@Hossen-etal_2014].  These methods also have the same flaw in that they
ultimately rely on source code entities for information.

To remedy these shortcomings, we propose to use *changesets* in the training of
a topic model.  Like @Rao-etal_2013, the motivation of this work is to create
topic models that can be incrementally updated over time.  Unlike
@Rao-etal_2013, we can rely on the source code history itself to build the
model without needing to manually adjust model latent variables to account for
document changes.  This gains the benefit of a decrease in model construction
and query times, but also could lead to a more reliable model.

The key intuition to this approach is that a topic model algorithm such as
latent Dirichlet allocation can *infer* any given document's topic proportions
regardless of the documents used to train the model.  That is, we can train a
model a corpus of changesets and infer the topics of an entirely different
corpus (e.g., source code entities).  Further, now that topic modeling
algorithms are online [@Hoffman-etal_2010; @Rehurek_2011], the model can be
periodically updated with new changesets as they enter a source code
repository.  With this approach, the topic model is up-to-date with the current
source code, even as developers are using the model for work.

**Thesis Statement**

:   Training online topic models on software repositories removes retraining
costs while maintaining accuracy of a traditional snapshot-based topic model
for different software maintenance problems.

### Feature Location {#sec:flt-motivation}

The state-of-the-practice in feature location is to use an IDE tool based on
keyword or regular expression search, but @Ko-etal_2006 observed such tools
leading developers to failed searches nearly 90% of the time.  The
state-of-the-art in feature location [@Dit-etal_2013a] is to use a feature
location technique (FLT) based, at least in part, on text retrieval (TR).  The
standard methodology [@Marcus-etal_2004] is to extract a document for each
class or method in a source code snapshot, to train a TR model on those
documents, and to create an index of the documents from the trained model.
Topic models (TMs) [@Blei_2012] such as latent Dirichlet allocation (LDA)
[@Blei-etal_2003] are the state-of-the-art in TR and outperform vector-space
models (VSMs) in the contexts of natural language [@Deerwester-etal_1990;
@Blei-etal_2003] and source code [@Poshyvanyk-etal_2007; @Lukins-etal_2010].
Yet, modern TMs such as online LDA [@Hoffman-etal_2010] natively support only
the online addition of a new document, whereas some VSMs also natively support
online modification or removal of an existing document.  So, TM-based FLTs
provide the best accuracy, but unlike VSM-based FLTs, they require
computationally-expensive retraining subsequent to source code changes.

@Rao_2013 proposed FLTs based on customizations of LDA and latent semantic
indexing (LSI) that support online modification and removal.  These FLTs
require less-frequent retraining than other TM-based FLTs, but the remaining
cost of periodic retraining inhibits their application to large software, and
the reliance on customization hinders their extension to new TMs.

We envision an FLT that is:

1) accurate like a TM-based FLT,
2) inexpensive to update like a VSM-based FLT,
3) and extensible to accommodate any off-the-shelf TR model that supports
   online addition of a new document.

Unfortunately, our vision is incompatible with the standard methodology for
FLTs.  Existing VSM-based FLTs fail to satisfy the first criteria, and existing
TM-based FLTs fail to satisfy the second or third criteria.  Indeed, given the
current state-of-the-art in TR, it is impossible for a FLT to satisfy all three
criteria while following the standard methodology.

In this work, we propose a new methodology for FLTs.  Our methodology is to
extract a document for each changeset in the source code history and to train a
TR model on the changeset documents, and then to extract a document for each
source file in a source code snapshot and to create an index of the
source file documents from the trained (changeset) model.  This new
methodology stems from four key observations:

- Like a source code file, a changeset contains program text.
- Unlike a source code file, a changeset is immutable.
- A changeset corresponds to a commit.
- An atomic commit involves a single feature.

It follows from the first two observations that it is possible for an FLT
following our methodology to satisfy all three of the aforementioned criteria.
The next two observations influence the training and indexing steps of our
methodology, which have the conceptual effect of relating source files to
changeset topics.  By contrast, the training and indexing steps of the standard
methodology have the conceptual effect of relating files to file topics.

### Developer Identification {#sec:dit-motivation}

The state-of-the-practice in developer identification is largely a manual,
communicative process.  However, developer identification can be a time
consuming and error prone process when done manually.  @Jeong-etal_2009 found
that reassignment occurs between 37%--44% of the time and introduces an average
of 50 days delay in completing the request.  Developer identification is a
common and difficult task, and is even more difficult on projects where
developer teams are large or geographically distributed [@Herbsleb-etal_2001].
Developer identification requires contextual knowledge about the product, team
structure, individual expertise, workload balance, and development schedules in
order to correctly assign a change request.  A project member triaging a change
request will need to consider these factors in order to correctly assign the
change request to a set of developers with appropriate expertise
[@McDonald-Ackerman_1998].

The state-of-the-art in developer identification [@Kagdi-etal_2012] aims to
automate this process, either partially or fully.  @Anvik-etal_2006 notes that
a fully-automated approach may not be feasible given the amount of contextual
knowledge required for triage.  One approach is to use a developer
identification technique (DIT) based, again at least in part, on text retrieval
(TR).  This category of approaches, as described by @Shokripour-etal_2013,
involves combining an FLT to locate the features in source code and using
change heuristics to select the correct developer [@Bird-etal_2011;
@Corley-etal_2012; @Hossen-etal_2014].  Any DIT relying on a TR-based FLT will
exhibit the same issues as we described in the previous section.

We would like to further adapt our vision for an accurate, easy-to-update FLT
to a DIT.  In this work, we propose a new methodology for DITs that is not
necessarily based on the performance of an FLT.  Again, our methodology is to
extract a document for each changeset in the source code history and to train a
TR model on the changeset documents.  However, rather than using a
heuristic-and-FLT-based approach, we choose to use extract *developer
profiles*: documents which describe all changes a developer has made on the
project.  We can then create an index of the developer profiles from the
trained (changeset) model and skip all heuristics.

<!--
@McDonald-Ackerman_1998 show that there are two expertise finding problems:
identification and selection.  In a semi-automated system, the system
automatically identifies and suggests an expert for assignment.  In a
fully-automated system, the system identifies and assigns a developer to the
change request.

Triaging a change request involves steps completed either by a single person or
by a team of developers in a triage meeting, such as a sprint planning meeting.
How triage occurs differs from team to team, but the general steps required are
as follows.  First, the triager(s) must see if the request has enough
information for consideration.  The triager marks the request as a duplicate if
the request already exists elsewhere in the tracker or was previously
completed.  After confirming that the request is new and has enough
information, the triager decides whether the request will be completed, and how
soon it will be completed, based on its severity, frequency, risk, and other
factors.  Finally, the triager assigns a request to the developer.  Ultimately,
the goal of triage is deciding priority of the request and assignment to the
developer that is best suited to complete the change request.

A triager reassigns a change request assigned in error to a
different developer, or the original developer reassigns the request
themselves.

Automated support for triaging helps to decrease change request
time-to-triage and to correct, or prevent, human error.

-->

### Combining and Configuring Changeset-based Topic Models {#sec:combo-motivation}

Topic model reuse for two tasks would halve the computational cost required for
model training.  This presumes, however, that the configuration choices made
for corpus construction and the model itself are acceptable for each task.
That is, the model used does not negatively impact either task due to
configuration.

@Biggers-etal_2014 were the first to explore the parameters of a LDA-based FLT.
Unfortunately, these findings for model training parameters may not directly
apply to a LDA-based DIT.  Further, there is no work on optimal configurations
when using a topic model for two tasks.  There is also evidence that different
configurations may be better suited for different tasks
[@Marcus-Poshyvanyk_2005; @Abadi-etal_2008].

Likewise, we must also make choices with respect to corpus construction, as LDA
can achieve higher performance by adjusting certain elements of a corpus
[@Biggers-etal_2014] or by increasing and decreasing the importance of certain
elements of the corpus [@Bassett-Kraft_2013].  While we do not have enough
source code in changesets to extract fully parsed elements -- such as comments,
identifiers, literals, and so on -- we do have structure in the changeset
itself in the form of the `diff` (see Figure \ref{fig:diff}).  That is, we have
lines removed and added that represent the change, and also lines for context
for where the change is to be applied.
