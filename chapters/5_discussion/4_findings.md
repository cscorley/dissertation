## Findings {#sec:findings-discussion}

The primary goal of this work is to evaluate the performance and reliability of
topic models built on the source code histories, i.e., changeset-based topic
modeling, in order to move towards more robust approaches that can be utilized
by practitioners.

### Feature Location

First, with respect to \frp, applying my approach to feature location, I ask:

RQ 1.1
:   \foneq

<!--
    Changeset-based FLTs are as accurate as snapshot-based FLTs.
-->

RQ 1.2
:   \ftwoq

<!--
    Historical simulation reveals that the accuracy of the changeset-based FLT
    is inconsistent as a project evolves, and is actually lower than indicated by
    batch evaluation.
-->

I have shown that it is not only possible to use a changeset-based TM for FLT,
but also desirable.  For \fone, I find that the changeset-based approach can
produce a more accurate model for searching over source code elements over the
traditional snapshot-based approach.  I also find evidence under \ftwo that
batch-evaluated approaches may be both over-informed and under-informed, e.g.,
models trained on data from the future, but does not make good use data
available at particular points of interest.

I have also explored class- and method-level granularity searches with
different subject systems in prior work [@Corley-etal_2015].  The results of
the study presented here differ slightly, but it is difficult to compare the
two, given the data granularities are different.  In @Corley-etal_2015, I were
able to arrive at the same conclusion as \fone, but unable to for \ftwo.  That
is, while I found that the  changeset-based approach was as accurate as
snapshots (\fonep), I were unable to find that the accuracy of the
changeset-based model under historical simulation is consistent with the batch
counterpart (\ftwop).  It is difficult to determine the source of this
inconsistency, as the prior work used datasets constructed by other researchers
[@Moreno-etal_2014].  However, the inconsistency increases suspicion that batch
evaluations are inadequate or non-representational of reality.  I leave
extending the current study and dataset to include class- and method-level
granularity searches as future work.

I arrive at the conclusion that the current approaches using batched
evaluation do not accurately reflect the model performance or the state of the
indexed corpus over time.  Both of these issues combined present serious
threats to validity of prior work in this field.  However, researchers can
mitigate both of these threats by using a historical simulation of their
approaches, instead of only using a batch evaluation.  That does not mean
researchers must use online LDA as I have, but pay closer attention to whether
the approach considers time in their assumptions.  That is, researchers need to
be to ensure their search engines are constructed only from data that existed
*before* the query they are evaluating.

### Developer Identification

For \drp, applying the approach to developer identification, I ask:

RQ 2.1
:   \doneq

<!--
    Changeset-based FLTs are as accurate as snapshot-based DITs.
-->

RQ 2.2
:   \dtwoq

<!--
    Historical simulation reveals that the accuracy of the changeset-based DIT
    is inconsistent as a project evolves, and is actually lower than indicated by
    batch evaluation.
-->

In this work I have shown that although it is possible to use a
changeset-based TM for DIT, it may not be desirable.  For \done, I find that
the changeset-based approach does not produce a more accurate model for
searching over developer profiles over the traditional snapshot-based approach.
I also find evidence, however, under \dtwo that batch-evaluated approaches may
be both over-informed and under-informed, e.g., models trained on data from the
future, but does not make good use data available at particular points of
interest.  As in the previous section on my FLT, I arrive at the conclusion
that the current approaches using batched evaluation do not accurately reflect
the model performance or the state of the indexed corpus over time.

### Combining and Configuring Changeset-based Topic Models

I determine for \crp whether I can gain model re-use for both tasks
by asking the following:

RQ 3.1
:   \coneq

<!--
    The same topic model can be used in more than one context, though more
    optimal configurations may exist on a per-context basis.
-->

RQ 3.2
:   \ctwoq

<!--
    There are significant differences when choosing from the possible elements
    of a changeset for corpus construction.
-->

There will always be improvement by hyper-optimizing the configuration of a
topic model and corpus construction.  The results for \cone suggest that it is
possible reuse the same model for two tasks, as differences are often by one
configuration parameter and not statistically significant. Corpus construction,
however, would appear to require more consideration towards which task is more
important as there are statistically significant effects between the optimal
and alternate configurations.

As shown in results Section \ref{sec:combo-results}, there are effects of
choosing differing text sources.  I have discussed each of these text sources,
comparing configurations that include a particular source to the equivalent
configuration that excludes that same source.  The results and discussion
surrounding \ctwo suggest that it is beneficial to include additions, context,
and messages while excluding removals.  This tends to match the intuitive view
that removals would be detrimental to the performance of the FLT and DIT.

<!--
Corpus:

1. There is a need to choose inputs during corpus construction.
2. Removals seem to usually degrade results, although not dramatically
3. Additions generally improve the results, likely because it was the code
   written that resolved the issue.  Message is the same.
4. Context inclusion seems less impactful, but is generally positive.
-->
