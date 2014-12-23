# Introduction


<!--
Basic idea:

- Lots of software maintenance tasks being automated by topic modeling
- Topic modeling is now online, but we are not using it?
- We build topic models from source code, meaning the model is tied to a
  specific instance of it
    - This makes the models not very useful in practice. Slow, outdated.
- Why not build topic models out of the changesets
    - Changesets are a view of the source code over time
    - We can build comparable topic models with changesets
- We can better evaluate the accuracy of the techniques because we can process
  changesets overtime, sort of like a similuation of what actually happened (or
  as close as we can get to it)
- We only need *one* model per branch. The doc-topic can be any *any*
  granularity desired, and the model does not need to be re-built from scratch
  everytime.
- Look at how does the changeset model compare to the typical source code model
    - Combinations of: context/added/removed lines in the diff
    - Per-file changed or whole changeset
    - Ignore whitespaces
    - Only look at the changed words instead of the entire lines
        - Combinations of: context/added/removed
-->

Software developers are often confronted with maintenance tasks that involve
navigation of repositories that preserve vast amounts of project history.
Navigating these software repositories can be a time-consuming task, because
their organization can be difficult to understand. Fortunately, topic models
such as latent Dirichlet allocation (LDA) [@Blei-etal_2003] can help developers
to navigate and understand software repositories by discovering topics (word
distributions) that reveal the thematic structure of the data
[@Linstead-etal_2007; @Thomas-etal_2011; @Hindle-etal_2012].

Program comprehension is a prerequisite to incremental change. A software
developer who is tasked with changing a large software system spends effort on
program comprehension activities to gain the knowledge needed to make the
change [@Corbi_1989]. For example, the developer spends effort to understand
the system architecture or to locate the parts of the source code that
implement the feature(s) being changed. Gaining such knowledge can be a
time-consuming task, especially for developers who are unfamiliar with the
system. Topic models of source code can help such developers to understand the
system by revealing a latent structure that is not obvious from the package
hierarchy or system documentation [@Savage-etal_2010].

Topic models are clusters of source code entities (e.g., classes) that are
grouped by their natural language content (i.e., the words in their
identifiers, comments, and literals). Such topics often correspond to the
concepts and features implemented by the source code [@Baldi-etal_2008], and
exploring such topics shows promise in helping developers to understand the
entities that make up a system and to understand how those entities relate
[@Kuhn-etal_2007; @Maskeri-etal_2008; @Savage-etal_2010; @Gethers-etal_2011a].
Recent approaches to exploring linguistic topics in source code use machine
learning techniques that model correlations among words, such as latent
semantic indexing (LSI) [@Deerwester-etal_1990] and latent Dirichlet allocation
(LDA) [@Blei-etal_2003], and ML techniques that also model correlations among
documents, such as RTM [@Chang-Blei_2010].

Topic models of source code have many applications in addition to general
program comprehension. These applications include feature location\needcite,
bug localization [@Rao-etal_2013], triaging incoming change requests
[@Kagdi-etal_2012], aspect mining [@Baldi-etal_2008], and traceability link
recovery [@Asuncion-etal_2010]. Yet, while researchers have had success in
using topic models on source code entities, there is a fundamental issue with
the current approaches. This issue is that the input documents used to build a
topic model are source code entities, and will be the motivating point of this
work.


## Motivation

<!--
- Software evolves quickly
- Current file-based models do not keep up-to-date models
- Keeping them up-to-date involves:
    - Rebuilding at every commit (slowest)
    - Rebuilding at intervals (data loss)
    - Modify the model internally using heuristics
- In FLTs, file-based models are easy and natural, but not necessary to build
the model.
- In triaging, file-based models do not capture the appropriate information,
e.g., the developer's topics.
- Models can be built from any text input. We do not need to use the files as a
proxy. The word occurrences will still occur in changesets!
-->

When modeling a source code repository, the corpus typically represents a
snapshot of the code. That is, a topic model is often trained on a corpus that
contains documents that represent files from a particular version of the
software. Keeping such a model up-to-date is expensive, because the frequency
and scope of source code changes necessitate retraining the model on the
updated corpus. However, it may be possible to automate certain maintenance
tasks without a model of the complete source code. For example, when assigning
a developer to a change task, a topic model can be used to associate developers
with topics that characterize their previous changes. In this scenario, a model
of the changesets created by each developer may be more useful than a model of
the files changed by each developer. Moreover, as a typical changeset is
smaller than a typical file, a changeset-based model is less expensive to keep
current than a file-based model.

While using file-based models is a natural fit for program comprehension tasks
such as feature location and bug localization, they still are unable to stay
up-to-date entirely. Additionally, much of the work for assigning developers to
change requests still uses files as input and an array of heuristics to
identify a developer [@Kagdi-etal_2012]. These methods also have the same flaw
in that they ultimately rely on files for information.

Like @Rao-etal_2013, the motivation of this work is to create topic models that
can be incrementally updated over time. However, unlike @Rao-etal_2013, we can
rely on the source code history itself to build the model without needing to
manually adjust model latent variables. This gains the benefit of an increase
in query time, but also could lead to a more reliable model.

## Research Goals, Questions, and Hypotheses

The primary research goal of this proposal is to evaluate the performance and
reliability of topic models built on the source code histories. This will
require configuring and executing studies in various contexts of software
maintenance work, such as feature location, bug localization, and developer
identification.

A secondary goal is to create a practical framework for building models that
can be used in multiple contexts. This will require building a prototype tool
that could be used by both researchers and practitioners.

Towards achieving these goals, I've identified three core research questions,
defined below.

Research Question 1:
:   How does training a topic model on changesets affect the performance of a
topic-modeling-based feature location techinque?

Research Question 2:
:   How does training a topic model on changesets affect the performance of a
topic-modeling-based developer identification techinque?

Research Question 3:
:   Can a single topic model trained on changesets be effectively used in both
feature location and developer identification techniques?

Essentially, we want to know whether using changesets in a topic-modeling-based
tool is beneficial and whether we can use multiple tools on the same topic
model.

<!--
- To evaluate models built on changesets to other models (typically based on
files only, but may include additional information)
- Provide a practical framework for building models that can be used in
multiple contexts (FLT, bug localization, triage).
- Provide insight for researchers and tool developers on best practices for
using changeset-based models
-->


## Limitations and Assumptions

<!--
    Possible threats?
-->

There are various limitations and assumptions in this research that need to be
addressed upfront.

First, the assumption is made that a software project using a changeset-based
topic model has a large history. Topic models need a substantial amount of data
for training, and hence the more history supplied to the model the more
accurate it becomes. There may be solutions to this problem, such as using
the software snapshot after a release in combination with the changesets.

The second assumption follows the first, in that the software repository
history is not changed or re-written after initial training of the topic model.
New version control software, such as Git and Mecurial, allow for history to be
re-written arbitrarily. For instance, a repository may contain work on a
subproject which is then extracted into it's own fully-fledged project at a
later point. This has happened in the case of the Apache Lucene and Solr
projects.

The third assumption is that an optimal configuration exists. Since the models
are only seeing a single document at a time, there may be performance issues
with this approach. Previously, topic models were trained in *batch*, i.e.
knowing about all documents ahead of time, and have many parameters that need
to be configured for optimal performance. Likewise, *online* topic models
include additional parameters that also need to be configured.

