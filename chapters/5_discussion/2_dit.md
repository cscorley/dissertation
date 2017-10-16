## Developer Identification {#sec:dit-discussion}

The results Section \ref{sec:dit-results} shows significant effects between
snapshots and changesets, and between batch changesets and changesets in the
simulated environment.  The results are mixed between each and are not
conclusive.  However, we argue this is desirable to show that the accuracy of a
changeset-based DIT is similar to that of a snapshot-based DIT but without the
retraining cost.


### \doneq

<!--All
max bound:	38
same:	154	0.145971563981
same (ones):	58	0.0549763033175
diff of 1:	245	0.232227488152
diff of 2:	145	0.137440758294
diff of 3:	166	0.157345971564
within <=1:	245	0.232227488152
within <=5:	716	0.678672985782
within <=10:	845	0.800947867299
within <=50:	901	0.854028436019
other (>50.000000):	0	0.0
within <= 0 (1.000000%):	0	0.0
within <= 2 (5.000000%):	390	0.369668246445
within <= 4 (10.000000%):	658	0.623696682464
within <= 19 (50.000000%):	890	0.843601895735
other > 19 (50.000000%):	11	0.0104265402844
worst (Changesets - Snapshot) 33.0 -22.0
total:	1055
-->

\input{figures/dit/rq1_overview}

Figure \ref{fig:dit:rq1:overview} shows the effectiveness measures across all
systems (figures for all subject systems are available in
Appendix \ref{app:dit}). The figure suggests that snapshot-based models and
changeset-based models have similar results overall with changesets performing
slightly better, but does not help to understand how each feature query
performs for each model.  With respect to \done, we will investigate the
queries and effectiveness measures between the batch snapshot and batch
changesets in detail.

For the 1055 queries across all systems, 154 queries return the same
effectiveness measure in both approaches, or about 14.6% of the time.  Of these
154 queries, 58 (5.5%) share an effectiveness measure of 1 (the best possible
measure) for both approaches.  After excluding the 154 queries in which ranks
which are the same, 245 (23.2%) of the remaining 901 queries have effectiveness
measures is within 1 rank of each other.  Likewise, 145 (13.8%) queries have a
difference in effectiveness measure of 2.  Finally, 166 (15.7%) have the
effectiveness measure difference of 3.  The remaining 345 queries (38.3%)
perform noticeably different ($> 3$ ranks apart).


### \dtwoq

<!--All
max bound:	38
same:	126	0.120805369128
same (ones):	45	0.0431447746884
diff of 1:	213	0.204218600192
diff of 2:	169	0.162032598274
diff of 3:	130	0.124640460211
within <=1:	213	0.204218600192
within <=5:	674	0.646212847555
within <=10:	848	0.813039309684
within <=50:	917	0.879194630872
other (>50.000000):	0	0.0
within <= 0 (1.000000%):	0	0.0
within <= 2 (5.000000%):	382	0.366251198466
within <= 4 (10.000000%):	601	0.576222435283
within <= 19 (50.000000%):	901	0.863854266539
other > 19 (50.000000%):	16	0.0153403643337
worst (Changesets - Historical) 37.0 -25.0
total:	1043
-->

\input{figures/dit/rq2_overview}

Figure \ref{fig:dit:rq2:overview} shows the effectiveness measures across all
systems (figures for all subject systems are available in Appendix
\ref{app:dit}). The figure suggests that snapshot-based models and
changeset-based models have similar results overall with changesets performing
slightly better, but does not help to understand how each feature query
performs for each model.  With respect to \dtwo, we will investigate the
queries and effectiveness measures between the batch snapshot and batch
changesets in detail.

For the 1055 queries across all systems, only 1043 were successful.  After
manual investigation, we determined these 12 that were unsuccessful due to
excluding the commit that fixed the issue related to the query.  These commits
were the first change in the repository by that maintainer[^alias], resulting in that
maintainer missing from the ranking until that point.  126 queries return the
same effectiveness measure in both approaches, or about 12.1% of the time.  Of
these 126 queries, 45 (4.3%) share an effectiveness measure of 1 (the best
possible measure) for both approaches.

[^alias]: Or an alias of that developer, e.g., committed under a different email

After excluding the 126 queries in which ranks which are the same, 213 (20.4%)
of the remaining 917 queries have effectiveness measures is within 1 rank of
each other.  Likewise, 169 (16.2%) queries have a difference in effectiveness
measure of 2.  Finally, 130 (12.5%) have the effectiveness measure difference
of 3.  The remaining 512 queries (55.8%) perform noticeably different ($> 3$
ranks apart).

### Situations

In this study, we've asked two research questions which lead to two distinct
comparisons.  First, we compare a batch TM-based DIT trained on the changesets
of a project's history to one trained on the snapshot of source code entities.
Second, we compare a batch TM-based DIT trained on changesets to a online
TM-based DIT trained on the same changesets over time.  Our results are mixed
between the research questions, hence we end up with four possible situations;
we will now discuss each of these situations in detail.

<!--
    SS < CS && CS > HS
       2          5
            2
        mahout
        openjpa

    SS < CS && CS < HS
       2          1
            0

    SS > CS && CS > HS
       4          5
            3
        bookkeeper
        tika
        zookeeper

    SS > CS && CS < HS
       4          1
            1
        pig
-->

#### Batch changesets are better than batch snapshot *and* batch changesets are better than changesets in the simulated environment

This situation occurs in 2 out of 6 systems: \mahout and \openjpa.  We
hypothesize that this is because in the batch evaluation, the model is trained
on all data before being queried, while in the historical simulation the model
is trained on partial data before being queried.  This allows for the batch
model to be more accurate because it is trained on more data and reveals
feature location research evaluations may not be accurately portraying how an
DIT would perform in a real scenario.

#### Batch changesets are better than batch snapshot *and* changesets in the simulated environment are better than batch changesets

We note that this situation never occurs. This also supports the hypothesis
that historical simulation more accurately portrays the system over time as it
more accurately captures the correct state of the system (i.e., the developers
maintaining the system) at the point in time when querying is done.  Since
querying on the batch models is after the model is completely trained, there
may be developers that are no longer, or have yet to start, maintaining the
system anymore.  Again, the historical simulation may better capture this
scenario.

#### Batch snapshot are better than batch changeset *and* changesets in the simulated environment are better than batch changesets

This situation occurs in 3 out of 6 systems: \bookkeeper, \tika, and
\zookeeper.  Similarly, this could be because of how the models are trained.
Although batch changesets perform worse in both cases, historical simulation
using changesets outweighs batch snapshot modelling.  This does not necessarily
mean that changesets are bad, but may more accurately model the system over
time.

#### Batch snapshot are better than batch changeset *and* batch changesets are better than changesets in the simulated environment

This situation occurs in a single system: \pig.  We note that this system does
not achieve statistical significance for either case.  This also supports the
hypothesis that historical simulation more accurately portrays the system over
time.  However, we cannot conclude this without also historically simulating
snapshot TM-based DITs.

### Changeset-based Developer Identification {#sec:dit-summary}

In this work we have shown that it is not only possible to use a
changeset-based TM for DIT, but also desirable.  For \done, we find that the
changeset-based approach can produce a more accurate model for searching over
developer profiles over the traditional snapshot-based approach.  We also
find evidence under \dtwo that batch-evaluated approaches may be both
over-informed and under-informed, e.g., models trained on data from the future,
but does not make good use data available at particular points of interest.  As
in Section \ref{sec:flt-summary}, we arrive at the conclusion that the current
approaches using batched evaluation do not accurately reflect the model
performance or the state of the indexed corpus over time.
