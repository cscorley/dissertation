## Feature Location {#sec:flt-discussion}

Our analysis in Section \ref{sec:flt-results} shows significant effects between
snapshots and changesets, and between batch changesets and changesets in the
simulated environment.  The results are mixed between each subject system and
are not generally conclusive.  However, we argue this is desirable to show that
the accuracy of a changeset-based FLT is similar to that of a snapshot-based
FLT but without the retraining cost.


### \foneq

<!--All
max bound:	4968
same:	155	0.2
same (ones):	139	0.17935483871
diff of 1:	87	0.112258064516
diff of 2:	52	0.0670967741935
diff of 3:	30	0.0387096774194
within <=1:	87	0.112258064516
within <=5:	213	0.274838709677
within <=10:	254	0.327741935484
within <=50:	398	0.513548387097
other (>50.000000):	222	0.286451612903
within <= 50 (1.000000%):	398	0.513548387097
within <= 248 (5.000000%):	516	0.665806451613
within <= 497 (10.000000%):	559	0.721290322581
within <= 2484 (50.000000%):	617	0.796129032258
other > 2484 (50.000000%):	3	0.00387096774194
worst (Changesets - Snapshot) 888.0 -4478.0
total:	775
-->

\input{figures/flt/rq1_overview}

Figure \ref{fig:flt:rq1:overview} shows the effectiveness measures for files
across all systems (figures for all subject systems are available in
Appendix \ref{app:flt}). The figure suggests that snapshot-based models and
changeset-based models have similar results overall with changesets performing
slightly better, but does not help to understand how each feature query
performs for each model.  With respect to \fone, we will investigate the
queries and effectiveness measures between the batch snapshot and batch
changesets in detail.

For the 1055 queries across all systems, only 775 were successful.  That is,
280 queries did not retrieve any files identified as changed by fixing the
related issues.  These are likely caused by files that were removed over time
and did not make it into release and highlights the volatility of software
development.  It is typical for unsuccessful queries to be filtered from the
benchmark, hence we have removed them from our data analyses instead of
penalizing a particular approach.

\todo{here is a nice place for a table show-casing which approach is missing most}

There were 155 queries that return the same effectiveness measure in both
approaches, or about 20.0% of the time.  Of these 155 queries, 139 (17.9%) have
an effectiveness measure of 1 (the best possible measure) for both approaches.
After excluding the 155 queries in which ranks which are the same, 87 (11.2%)
of the remaining 620 queries have effectiveness measures is within 1 rank of
each other.  Likewise, 254 (32.8%) queries have a difference in effectiveness
measure less than or equal to 10.  Finally, 398 (51.4%) have the effectiveness
measure is within 50 ranks of each other.  The remaining 222 queries (28.6%)
perform noticeably different ($> 50$ ranks apart).

\todo{50 too large, better to compare by percentage?}

### \ftwoq


<!--All
max bound:	4968
same:	121	0.156129032258
same (ones):	98	0.126451612903
diff of 1:	76	0.098064516129
diff of 2:	46	0.0593548387097
diff of 3:	30	0.0387096774194
within <=1:	76	0.098064516129
within <=5:	204	0.263225806452
within <=10:	285	0.367741935484
within <=50:	460	0.593548387097
other (>50.000000):	194	0.250322580645
within <= 50 (1.000000%):	460	0.593548387097
within <= 248 (5.000000%):	613	0.790967741935
within <= 497 (10.000000%):	634	0.818064516129
within <= 2484 (50.000000%):	654	0.843870967742
other > 2484 (50.000000%):	0	0.0
worst (Changesets - Historical) 1062.0 -2153.0
total:	775
-->

\input{figures/flt/rq2_overview}

Figure \ref{fig:flt:rq2:overview} shows the effectiveness measures for files
across all systems (figures for all subject systems are available in
Appendix \ref{app:flt}). The figure suggests that historical simulation slightly
underperforms a batch changeset model, but does not help to understand how each
feature query performs for each model.  With respect to \ftwo, we will
investigate the queries and effectiveness measures between the batch changesets
and historical simulation using changesets in detail.

For the 1055 queries across all systems, again only 775 were successful.  121
queries return the same effectiveness measure in both approaches, or about
15.6% of the time.  Of these 121 queries, 98 (12.6%) have an effectiveness
measure of 1 (the best possible measure) for both approaches.

After excluding the 121 queries in which ranks which are the same, 76 (9.8%) of
the remaining 654 queries have effectiveness measures is within 1 rank of each
other.  Likewise, 285 (36.8%) queries have a difference in effectiveness
measure less than or equal to 10.  Finally, 460 (59.4%) have the effectiveness
measure is within 50 ranks of each other.  The remaining 194 queries (25.0%)
perform noticeably different ($> 50$ ranks apart).


### Situations

In this study, we've asked two research questions which lead to two
distinct comparisons.  First, we compare a batch TM-based FLT trained on the
changesets of a project's history to one trained on the snapshot of source code
entities.  Second, we compare a batch TM-based FLT trained on changesets to a
online TM-based FLT trained on the same changesets over time.  Our results are
mixed between the research questions, hence we end up with four possible
situations; we will now discuss each of these situations in detail.

<!--
    SS < CS && CS > HS
       4          5
            4
        bookkeeper
        openjpa
        pig
        zookeeper

    SS < CS && CS < HS
       4          1
            0

    SS > CS && CS > HS
       2          5
            1
        tika

    SS > CS && CS < HS
       2          1
            1
        mahout
-->

#### Batch changesets are better than batch snapshot *and* batch changesets are better than changesets in the simulated environment

This situation occurs in 4 out of 6 systems: \bookkeeper, \openjpa, \pig,
\zookeeper.  We hypothesize that this is because in the batch evaluation, the
model is trained on all data before being queried, while in the historical
simulation the model is trained on partial data before being queried.  This
allows for the batch model to be more accurate because it is trained on more
data and reveals feature location research evaluations may not be accurately
portraying how an FLT would perform in a real scenario.  We note that this is
the scenario that occurs the most and aligns with the statistical results.

#### Batch changesets are better than batch snapshot *and* changesets in the simulated environment are better than batch changesets

We note that this situation never occurs. This also supports the hypothesis
that historical simulation more accurately portrays the system over time as it
more accurately captures the correct state of the system (i.e., the source code
entities) at the point in time when querying is done.  Since querying on the
batch models is after the model is trained, there may be source code entities
that do not exist in the system anymore that were at one time changed to
complete a certain task.  Again, the historical simulation better captures this
scenario.

#### Batch snapshot are better than batch changeset *and* changesets in the simulated environment are better than batch changesets

This situation occurs in a single system: \mahout.  Similarly, this could be
because of how the models are trained.  Although batch changesets perform worse
in both cases, historical simulation using changesets outweighs batch snapshot
modelling.  This does not necessarily mean that changesets are bad, but may
more accurately model the system over time.

#### Batch snapshot are better than batch changeset *and* batch changesets are better than changesets in the simulated environment

This situation occurs in a single system: \tika.  We note that this system does
not achieve statistical significance for either case.  This also supports the
hypothesis that historical simulation more accurately portrays the system over
time.  However, we cannot conclude this without also historically simulating
snapshot TM-based FLTs.

