# Introduction

Software developers are often confronted with maintenance tasks that
involve navigation of repositories that preserve vast amounts of project
history.  Navigating these software repositories can be a time-consuming
task, because their organization can be difficult to understand.
Fortunately, topic models such as latent Dirichlet allocation (LDA)
[@Blei-etal:2003] can help developers to navigate and understand
software repositories by discovering topics (word distributions) that
reveal the thematic structure of the data [@Linstead-etal:2007;
@Thomas-etal:2011; @Hindle-etal:2012].

Program comprehension is a prerequisite to incremental change.
A software developer who is tasked with changing a large software system
spends effort on program comprehension activities to gain the knowledge
needed to make the change [@Corbi:1989]. For example, the developer
spends effort to understand the system architecture or to locate the
parts of the source code that implement the feature(s) being changed.
Gaining such knowledge can be a time-consuming task, especially for
developers who are unfamiliar with the system. Topic models of source
code can help such developers to understand the system by revealing a
latent structure that is not obvious from the package hierarchy or
system documentation [@Savage-etal:2010].

Topic models are clusters of source code entities (e.g., classes) that
are grouped by their natural language content (i.e., the words in their
identifiers, comments, and literals). Such topics often correspond to
the concepts and features implemented by the source code
[@Baldi-etal:2008], and exploring such topics shows promise in helping
developers to understand the entities that make up a system and to
understand how those entities relate [@Kuhn-etal:07; @Maskeri-etal:08;
@Savage-etal:10; @Gethers-etal:11a]. Recent approaches to exploring
linguistic topics in source code use machine learning techniques that
model correlations among words, such as latent semantic indexing (LSI)
[@Deerwester-etal:1990] and latent Dirichlet allocation (LDA)
[@Blei-etal:2003], and ML techniques that also model correlations among
documents, such as RTM [@Chang-Blei:2010].

Topic models of source code have many applications in addition to
general program comprehension. These applications include feature
location\needcite, bug localization [@Rao-etal:2013], triaging
incoming change requests [@Kagdi-etal:2011], aspect
mining [@Baldi-etal:2008], and traceability link
recovery [@Asuncion-etal:2010]. Yet, while researchers have had
success in using topic models on source code entities, there is a
fundamental issue with the current approaches. This issue is that the
input documents used to build a topic model are source code entities,
and will be the motivating point of this work.
<!-- Yet, while researchers have used the extrinsic properties of topics
in software engineering tasks, they have not yet measured their
intrinsic properties. We believe that understanding these intrinsic
properties will lead to a better understanding of how topics are
implemented and thus will lead to a better understanding of how topics
relate to each other and to source code entities such as packages or
classes. -->


## Motivation

<!--
- Software evolves quickly
- Current file-based models do not keep up-to-date models
- Keeping them up-to-date involves:
    - Rebuilding at every commit (slowest)
    - Rebuilding at intervals (data loss)
    - Modify the model internally using heuristics
- In FLTs, file-based models are easy and natural, but not necessary to
  build the model.
- In triaging, file-based models do not capture the appropriate
  information, e.g., the developer's topics.
- Models can be built from any text input. We do not need to use the
  files as a proxy. The word occurrences will still occur in changesets!
-->

When modeling a source code repository, the corpus typically represents
a snapshot of the code. That is, a topic model is often trained on a
corpus that contains documents that represent files from a particular
version of the software. Keeping such a model up-to-date is expensive,
because the frequency and scope of source code changes necessitate
retraining the model on the updated corpus. However, it may be possible
to automate certain maintenance tasks without a model of the complete
source code. For example, when assigning a developer to a change task, a
topic model can be used to associate developers with topics that
characterize their previous changes. In this scenario, a model of the
changesets created by each developer may be more useful than a model of
the files changed by each developer. Moreover, as a typical changeset is
smaller than a typical file, a changeset-based model is less expensive
to keep current than a file-based model.

While using file-based models is a natural fit for program comprehension
tasks such as feature location and bug localization, they still are
unable to stay up-to-date entirely.
Additionally, much of the work for assigning developers to change
requests still uses files as input and an array of heuristics to
identify a developer [@Kagdi-etal:2011]\needcite.
These methods also have the same flaw in that they ultimately rely on
files for information.

Like Rao et al. [@Rao-etal:2013], the motivation of this work is to
create topic models that can be incrementally updated over time.
However, unlike Rao et al., we can rely on the source code history
itself to build the model without needing to manually adjust model
latent variables.
This gains the benefit of an increase in query time, but also could lead
to a more reliable model.

![Alt text\label{figgg}](image.png)

A reference to the Figure \ref{figgg}.

[Related work]

I am a fan of using Google^[<http://google.com>]

  Right     Left     Center     Default
-------     ------ ----------   -------
     12     12        12            12
    123     123       123          123
      1     1          1             1

Table:  Demonstration of simple table syntax\label{demo}

A reference to the Table \ref{demo}.


## Research goals

The primary research goal of this proposal is to evaluate the performance
and reliability of topic models built on the source code histories. This
will require configuring and executing studies in various contexts of
software maintenance work, such as feature location, bug localization,
and developer identification.

A secondary goal is to create a practical framework for building models
that can be used in multiple contexts.
This will require building a prototype tool that could be used by both
researchers and practitioners.

<!--
- To evaluate models built on changesets to other models (typically
  based on files only, but may include additional information)
- Provide a practical framework for building models that can be used in
  multiple contexts (FLT, bug localization, triage).
- Provide insight for researchers and tool developers on best practices
  for using changeset-based models
-->


