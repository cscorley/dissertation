
## Combining and Configuring Changset-based Topic Models {#study-config}

The two previously proposed approaches could potentially be used in unison with
a single model, allowing for halving the computational cost required for the
topic modeling.

### Motivation & Background


- FLT configuration valued @Biggers-etal_2014
- Location based DIT benefit from FLT
- DIT configuration un-explored
- Explicitly evaluating two tasks on the same configuration is unexplored

### Proposal

In this proposal, we introduce a *combined* approach that allows for a
topic-modeling-based FLT and DIT to be coalesced into using the same topic
model built incrementally from source code *changesets*. By training an online
learning algorithm using changesets and combining the two approaches, we
essentially cut the computational cost of the tasks in *half* with a single
topic model can being used for both tasks.

#### Approach

![Combining changeset-based feature location and developer identifiation
\label{fig:changeset-combo}](figures/changeset-combo.pdf)

The changeset topic modeling approach requires three types of document
extraction: one for the snapshot of the state of source code at a commit of
interest, such as a tagged release; one for the every changeset in the source
code history leading up to that commit; and a developer profile of the words
each individual developer changed in those changesets. The left side of Figure
\ref{fig:changeset-combo} illustrates the tri-document extraction approach.

The document extraction process for snapshot and changesets corpora remain the
same as covered in Section \ref{flt-approach}. The document extraction process
for the developer corpus remains the same as covered in Section
\ref{dit-approach}.

The right side of Figure \ref{fig:changeset-combo} illustrates the retrieval
process. For brevity, the queries and ranking are left out of the diagram.
Again, the key intuition to our approach is that a topic model such as LDA or
LSI can infer any given document's topic proportions regardless of the
documents used to train the model. Hence, we train a topic model on the
changeset corpus and construct search engines for each task separately. In the
source code search engine we build an index from the snapshot corpus. In the
developer search engine we build an index from the developer corpus. Querying
and ranking results for each search engine remains the same as described in
their respective sections, Section \ref{flt-approach} and \ref{dit-approach}.

#### Evaluation

In this section we describe the design of a exploratory study in which we
determine whether a single topic model trained on changesets is fit two serve
two purposes. For this work, we pose the following research questions:

RQ1
:   Can the same topic model be used effectively in more than one context?

RQ2
:   What are the effects of using different portions of a changeset for corpus
construction, such as added, removed, context lines, and the commit message?

RQ3
:   How much repository history is needed before the approaches are effective?


##### Methodology

In this work, we can utilize much of the already created framework from the
previous two research areas covered in this proposal. After evaluating the
usefulness of changesets, we will not need to instantiate snapshot models for
this work. Instead, we will create the single changeset topic model to be used
for both tasks. Where this work will differ from the previous two research
areas is in how the topic model is constructed.

For RQ1, we want to find if the two approaches can rely on the same model with
minimal interference from one another's requirements. For example, the FLT task
may perform better with less topics, while the DIT task may require many topics
for optimal performance. Table \ref{table:combo-rq1} outlines the factors about
the model construction we will consider.

Factor      Values
---------   ------
K           {100, 200, 500}
$\alpha$    {1/K, 2/K, 5/K}
$\beta$     {1/K, 2/K, 5/K}
Task        {FLT, DIT}
---------   ------

Table: Case study factors \label{table:combo-rq1}


While RQ1 focuses on model construction, RQ2 focuses on training-corpus
construction. For RQ2, there are several combinations to consider. While thus
far we have always included the entire changeset when training, it may be
beneficial to consider only including portions (i.e., added lines only) while
excluding other portions (i.e., removed lines). It may also be beneficial to
include the natural language text of the commit message. Table
\ref{table:combo-rq2} outlines the 15 combinations over the 4 types of
changeset text.

Text source     Include? 
--------------  ---------
Added lines     {yes, no}
Removed lines   {yes, no}
Context lines   {yes, no}
Commit message  {yes, no}
--------------  ---------

Table: Text sources \label{table:combo-rq2}

Finally, for RQ3 we will need to employ a deeper historical simulation and
analysis than in the previous proposed works. This work will be much more
exploratory than RQ1 and RQ2, as there is no indication thus far of what the
data will contain. An example approach is to use time series analysis
techniques to determine how the effectiveness measure changes over time and if
there is a minimal number of changesets that need to be modeled before the
approach is effective.

##### Subject Systems

For this work, we need a common dataset that covers both the FLT domain and DIT
domain. Fortunately, there are several common systems between the four datasets
in the previous works [@Dit-etal_2013; @Moreno-etal_2014; @Kagdi-etal_2012;
@Linares-Vasquez-etal_2012]. Common systems that can be seen in Tables
\ref{table:flt-datasets} and \ref{table:dit-datasets} include ArgoUML v0.22,
ArgoUML v0.26.2, jEdit v4.3, and muCommander v0.8.5.

