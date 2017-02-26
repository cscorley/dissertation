## Combining and Configuring Changeset-based Topic Models {#sec:combo-methodology}

In this section, we explore an approach that uses a single changeset model for
both FLT and DIT tasks.  First, we describe our motivation in Section
\ref{sec:combo-motivation}. We then describe our study design in Section
\ref{sec:combo-design}.  Finally, we describe the results of the study (Section
\ref{sec:combo-results}) and discuss them in detail (Section
\ref{sec:combo-discussion}).


### Motivation {#sec:combo-motivation}

Topic model reuse for two tasks would halve the computational cost required for
model training.  This presumes, however, that the configuration choices made
for corpus construction and the model itself are acceptable for each task.
That is, the model used does not negatively impact either task due to
configuration.

@Biggers-etal_2014 were the first to explore the parameters of a LDA-based FLT.
Unfortunately, these findings for model training parameters may not directly
apply to a LDA-based DIT.  Further, there is no work on optimal configurations
when using a topic model for two tasks.  There is also evidence in the
literature that different configurations may be better suited for different
tasks [@Marcus-Poshyvanyk_2005; @Abadi-etal_2008].

Likewise, we must also make choice with respect to corpus construction, as LDA
can achieve higher performance by adjusting certain elements of a corpus
[@Biggers-etal_2014].  While we do not have enough source code in changesets to
be extract fully parsed elements -- such as comments, identifiers, literals,
and so on -- we do have structure in the changeset itself in the form of the
`diff` (see Figure \ref{fig:diff}).  That is, we have lines removed and added
that represent the change, and also lines for context for where the change is
to be applied.

### Study Design {#sec:combo-design}

In this work, we introduce a *combined* approach that allows for coalescing a
topic-modeling-based FLT and DIT coalesced into using the same topic model
built incrementally from source code *changesets*.  By training an online
learning algorithm using changesets and combining the two approaches, we
essentially cut the computational cost of the two tasks in *half* with a single
topic model.

#### Approach

![Combining changeset-based feature location and developer identifiation
\label{fig:changeset-combo}](figures/changeset-combo.pdf)

The changeset topic modeling approach requires three types of document
extraction: one for the snapshot of the state of source code at a commit of
interest, such as a tagged release; one for the every changeset in the source
code history leading up to that commit; and a developer profile of the words
each individual developer changed in those changesets.  The left side of Figure
\ref{fig:changeset-combo} illustrates the tri-document extraction approach.

The document extraction process for snapshot and changesets corpora remain the
same as covered in Section \ref{sec:flt-approach}.  The document extraction
process for the corpus of developer profiles remains the same as covered in
Section \ref{sec:dit-approach}.

The right side of Figure \ref{fig:changeset-combo} illustrates the retrieval
process.  For brevity, the queries and ranking do not appear in the diagram as
they remain the same as described for each search engine in their respective
sections, Sections \ref{sec:flt-approach} and \ref{sec:dit-approach}.  We train
a topic model on the changeset corpus and construct search engines for each
task separately.  In the source code search engine we build an index from the
snapshot corpus.  In the developer search engine we build an index from the
developer corpus.

#### Evaluation

In this section we describe the design of a exploratory study in which we
determine whether a single topic model trained on changesets is fit to serve
two purposes.  For this work, we pose the following research questions:

\conep
:   \coneq

\ctwop
:   \ctwoq

##### Methodology {#sec:combo-methodology}

In this work, we reuse the already-created framework from the previous two
research areas covered in this work.  We will not need to instantiate snapshot
models for this work.  Where this work will differ from the previous two
research areas is in how we construct the corpus and topic model.

For \cone, we want to find if the two approaches can rely on the same model
with minimal interference from one another's requirements.  For example, the
FLT task may perform better with less topics, while the DIT task may require
more topics for optimal performance.  Table \ref{table:combo-rq1} outlines the
factors about the model construction we will consider, giving us 48 possible
combinations.  The factors $\alpha$ and $\eta$ vary between several common
values, but also include automatic learning of these two hyper-parameters
[@Hoffman-etal_2010].  As in sections \ref{sec:flt} and \ref{sec:dit}, the
changeset corpus construction for \cone does not change and includes the entire
`diff`, but does not include the message.

\input{tables/case_study_factors}

While \cone{} focuses on model construction, \ctwo{} focuses on training-corpus
construction.  For \ctwo, there are several combinations to consider.  While
thus far we have always included the entire changeset when training, it may be
beneficial to consider only including portions (i.e., added lines only) while
excluding other portions (i.e., removed lines).  It may also be beneficial to
include the natural language text of the commit message.  Table
\ref{table:combo-rq2} outlines the 16 combinations over the 4 types of
changeset text.  One combination is invalid because it constructs an empty
corpus and thus impossible to train a topic model, leaving 15 total
combinations.

##### Data Collection and Analysis {#sec:combo-data-collection}

To evaluate the performance of a topic-modeling-based FLT and DIT we cannot use
measures such as precision and recall.  This is because each approach creates
rankings pairwise, causing every entity to appear in the rankings.
@Poshyvanyk-etal_2007 define an effectiveness measure for topic-modeling-based
FLTs, which is also applicable to DIT.  This effectiveness measure is the rank
of the first relevant document, whether that document represents a source code
entity or developer profile, and represents the number of documents entities a
developer or triager would have to view before reaching a relevant one.  Most
importantly, this effectiveness measure allows evaluating our approach by using
various rank-based metrics and statistical methods.

\todo{Should I break down \cone into two subquestions: model and corpus?}

For both research questions, we run the experiment of each task across all
possible configurations from two sets of configurations, shown in Tables
\ref{table:combo-rq1} and \ref{table:combo-rq2}.  The first set of
configurations varies the model parameters, while the second set of
configurations varies the corpus construction inclusion parameters.  Each set
is associated with a "default" configuration for the other, e.g., all
variations of model configurations use the same corpus configuration and vice
versa.  The default configurations are the same used throughout this thesis.
\todo{Need to explicitly say which configurations are used for all chapters!}

To answer \cone, we collect the effectiveness measures of each configuration
variation and use them calculate the MRR.  For each task, we create a pair of
effectiveness measures using the optimal configuration, where the optimal
configuration is the one with the highest MRR for that task.  For example, the
FLT result pair consists of the FLT configuration with the highest MRR as its
optimal configuration and the results of the same configuration for the DIT
task.  The DIT pairing is analogous.  We then use the Wilcoxon signed-rank test
with Holm correction to determine the statistical significance of the
difference between the optimal and alternative results for any given
configuration and task.

To answer \ctwo, we focus on configurations that vary the inclusion of text
sources used for corpus construction.  We use the same data that was collected,
but our statistical analysis will differ from \cone.  For each task, since we
have paired data across all 15 configurations, i.e., each configuration has
effectiveness measures for the same issues, we conduct a Friedman Chi-Square
($\chi^2$) test.  We perform post-hoc tests using Wilcoxon rank-sum test
to determine which configurations have an affect.

To determine whether including a particular text sources have an affect, we
turn to Mann-Whitney U tests.  We compare effectiveness measures of all ranks
when the text source is included against excluded.  We use Mann-Whitney here
because there is an unequal amount of results between a text source inclusion
and exclusion due to the invalid configuration of all text sources excluded.
