## Discussion {#sec:flt-discussion}

The results outlined in the previous section (\ref{sec:flt-results}) warrants
some qualitative discussion.  In particular, our analysis shows significant
affects between snapshots and changesets, and between batch changesets and
changesets in the simulated environment.  The results are mixed between each
and are not conclusive.  However, we argue this is desirable to show that the
accuracy of a changeset-based FLT is similar to that of a snapshot-based FLT
but without the retraining cost.


### \foneq

<!--All
max bound:	4968
fancy:	False
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
across all systems. The figure suggests that snapshot-based models and
changeset-based models have similar results overall with changesets performing
slightly better, but does not help to understand how each feature query
performs for each model.  With respect to RQ1, we will investigate the queries
and effectiveness measures between the batch snapshot and batch changesets in
detail.  We will first discuss all systems, and then each subject system in
turn.


For the 1055 queries across all systems, only 755 were successful.  That is,
300 queries did not retrieve any files identified as changed by fixing the
related issues.  These are likely caused by files that were removed over time
and did not make it into release and highlights the volatility of software
developement.  155 queries returns the same effectiveness measure in both
approaches, or about 20.0% of the time.  Of these 155 queries, 139 (17.93%)
have an effectiveness measure of 1 (the best possible measure) for both
approaches.

After excluding the 155 queries in which ranks which are the same, 87 (11.2%)
of the remaining 620 queries have effectiveness measures is within 1 rank of
each other.  Likewise, 254 (32.78%) queries have a difference in effectiveness
measure less than or equal to 10.  Finally, 398 (51.4%) have the effectiveness
measure is within 50 ranks of each other.  The remaining 222 queries (28.6%)
perform noticeably different ($> 50$ ranks apart).

<!-- BookKeeper v4.3.0
max bound:	843
fancy:	False
same:	38	0.265734265734
same (ones):	34	0.237762237762
diff of 1:	14	0.0979020979021
diff of 2:	13	0.0909090909091
diff of 3:	4	0.027972027972
within <=1:	14	0.0979020979021
within <=5:	40	0.27972027972
within <=10:	46	0.321678321678
within <=50:	74	0.517482517483
other (>50.000000):	31	0.216783216783
within <= 8 (1.000000%):	42	0.293706293706
within <= 42 (5.000000%):	73	0.51048951049
within <= 84 (10.000000%):	84	0.587412587413
within <= 422 (50.000000%):	95	0.664335664336
other > 422 (50.000000%):	10	0.0699300699301
worst (Changesets - Snapshot) 639.0 -680.0
total:	143
-->

\input{figures/flt/rq1_bookkeeper}

Figure \ref{fig:flt:rq1:bookkeeper} shows the effectiveness measures for
\bookkeeper.  Again, the figure suggests that changesets perform better than
snapshots, even though the difference of MRR is only $0.0056$ (Table
\ref{table:feature_location_rq1}.)  For 

<!-- Mahout v0.10.0
max bound:	1556
fancy:	False
same:	6	0.12
same (ones):	5	0.1
diff of 1:	5	0.1
diff of 2:	4	0.08
diff of 3:	0	0.0
within <=1:	5	0.1
within <=5:	12	0.24
within <=10:	15	0.3
within <=50:	23	0.46
other (>50.000000):	21	0.42
within <= 16 (1.000000%):	17	0.34
within <= 78 (5.000000%):	24	0.48
within <= 156 (10.000000%):	28	0.56
within <= 778 (50.000000%):	40	0.8
other > 778 (50.000000%):	4	0.08
worst (Changesets - Snapshot) 865.0 -1133.0
total:	50
-->

\input{figures/flt/rq1_mahout}

<!-- OpenJPA v2.3.0
max bound:	4968
fancy:	False
same:	16	0.12213740458
same (ones):	14	0.106870229008
diff of 1:	12	0.0916030534351
diff of 2:	5	0.0381679389313
diff of 3:	3	0.0229007633588
within <=1:	12	0.0916030534351
within <=5:	25	0.190839694656
within <=10:	36	0.274809160305
within <=50:	62	0.473282442748
other (>50.000000):	53	0.404580152672
within <= 50 (1.000000%):	62	0.473282442748
within <= 248 (5.000000%):	76	0.580152671756
within <= 497 (10.000000%):	89	0.679389312977
within <= 2484 (50.000000%):	112	0.854961832061
other > 2484 (50.000000%):	3	0.0229007633588
worst (Changesets - Snapshot) 888.0 -4478.0
total:	131
-->

\input{figures/flt/rq1_openjpa}

<!-- Pig v0.14.0
max bound:	2098
fancy:	False
same:	30	0.172413793103
same (ones):	26	0.149425287356
diff of 1:	15	0.0862068965517
diff of 2:	10	0.0574712643678
diff of 3:	11	0.0632183908046
within <=1:	15	0.0862068965517
within <=5:	48	0.275862068966
within <=10:	52	0.298850574713
within <=50:	90	0.51724137931
other (>50.000000):	54	0.310344827586
within <= 21 (1.000000%):	67	0.385057471264
within <= 105 (5.000000%):	106	0.609195402299
within <= 210 (10.000000%):	119	0.683908045977
within <= 1049 (50.000000%):	137	0.787356321839
other > 1049 (50.000000%):	7	0.0402298850575
worst (Changesets - Snapshot) 762.0 -1556.0
total:	174
-->

\input{figures/flt/rq1_pig}

<!-- Tika v1.8
max bound:	954
fancy:	False
same:	5	0.138888888889
same (ones):	4	0.111111111111
diff of 1:	9	0.25
diff of 2:	4	0.111111111111
diff of 3:	2	0.0555555555556
within <=1:	9	0.25
within <=5:	16	0.444444444444
within <=10:	19	0.527777777778
within <=50:	23	0.638888888889
other (>50.000000):	8	0.222222222222
within <= 10 (1.000000%):	19	0.527777777778
within <= 48 (5.000000%):	23	0.638888888889
within <= 95 (10.000000%):	26	0.722222222222
within <= 477 (50.000000%):	29	0.805555555556
other > 477 (50.000000%):	2	0.0555555555556
worst (Changesets - Snapshot) 163.0 -539.0
total:	36
-->

\input{figures/flt/rq1_tika}

<!-- ZooKeeper v3.5.0
max bound:	927
fancy:	False
same:	60	0.248962655602
same (ones):	56	0.232365145228
diff of 1:	32	0.132780082988
diff of 2:	16	0.0663900414938
diff of 3:	10	0.0414937759336
within <=1:	32	0.132780082988
within <=5:	72	0.298755186722
within <=10:	86	0.356846473029
within <=50:	126	0.522821576763
other (>50.000000):	55	0.228215767635
within <= 9 (1.000000%):	85	0.352697095436
within <= 46 (5.000000%):	121	0.502074688797
within <= 93 (10.000000%):	144	0.597510373444
within <= 464 (50.000000%):	175	0.726141078838
other > 464 (50.000000%):	6	0.0248962655602
worst (Changesets - Snapshot) 405 -517
total:	241
-->

\input{figures/flt/rq1_zookeeper}


### \ftwoq

\todo{discuss figures here}
\input{figures/flt/rq2_overview}

\input{figures/flt/rq2_bookkeeper}
\input{figures/flt/rq2_mahout}
\input{figures/flt/rq2_openjpa}
\input{figures/flt/rq2_pig}
\input{figures/flt/rq2_tika}
\input{figures/flt/rq2_zookeeper}


<!-- Changesets Historical Files
-->

<!-- BookKeeper v4.3.0
max bound:	843
fancy:	False
same:	29	0.202797202797
same (ones):	21	0.146853146853
diff of 1:	16	0.111888111888
diff of 2:	8	0.0559440559441
diff of 3:	8	0.0559440559441
within <=1:	16	0.111888111888
within <=5:	43	0.300699300699
within <=10:	59	0.412587412587
within <=50:	83	0.58041958042
other (>50.000000):	31	0.216783216783
within <= 8 (1.000000%):	52	0.363636363636
within <= 42 (5.000000%):	82	0.573426573427
within <= 84 (10.000000%):	95	0.664335664336
within <= 422 (50.000000%):	112	0.783216783217
other > 422 (50.000000%):	2	0.013986013986
total:	143
-->

<!-- Mahout v0.10.0
max bound:	1556
fancy:	False
same:	6	0.12
same (ones):	4	0.08
diff of 1:	7	0.14
diff of 2:	4	0.08
diff of 3:	1	0.02
within <=1:	7	0.14
within <=5:	14	0.28
within <=10:	16	0.32
within <=50:	27	0.54
other (>50.000000):	17	0.34
within <= 16 (1.000000%):	21	0.42
within <= 78 (5.000000%):	32	0.64
within <= 156 (10.000000%):	37	0.74
within <= 778 (50.000000%):	43	0.86
other > 778 (50.000000%):	1	0.02
total:	50
-->

<!-- OpenJPA v2.3.0
max bound:	4968
fancy:	False
same:	15	0.114503816794
same (ones):	14	0.106870229008
diff of 1:	7	0.0534351145038
diff of 2:	4	0.030534351145
diff of 3:	7	0.0534351145038
within <=1:	7	0.0534351145038
within <=5:	24	0.18320610687
within <=10:	33	0.251908396947
within <=50:	65	0.496183206107
other (>50.000000):	51	0.389312977099
within <= 50 (1.000000%):	65	0.496183206107
within <= 248 (5.000000%):	101	0.770992366412
within <= 497 (10.000000%):	107	0.81679389313
within <= 2484 (50.000000%):	116	0.885496183206
other > 2484 (50.000000%):	0	0.0
total:	131
-->

<!-- Pig v0.14.0
max bound:	2098
fancy:	False
same:	22	0.126436781609
same (ones):	19	0.109195402299
diff of 1:	12	0.0689655172414
diff of 2:	8	0.0459770114943
diff of 3:	2	0.0114942528736
within <=1:	12	0.0689655172414
within <=5:	35	0.201149425287
within <=10:	47	0.270114942529
within <=50:	92	0.528735632184
other (>50.000000):	60	0.344827586207
within <= 21 (1.000000%):	67	0.385057471264
within <= 105 (5.000000%):	123	0.706896551724
within <= 210 (10.000000%):	138	0.793103448276
within <= 1049 (50.000000%):	151	0.867816091954
other > 1049 (50.000000%):	1	0.00574712643678
total:	174
-->

<!-- Tika v1.8
max bound:	954
fancy:	False
same:	6	0.166666666667
same (ones):	4	0.111111111111
diff of 1:	6	0.166666666667
diff of 2:	1	0.0277777777778
diff of 3:	0	0.0
within <=1:	6	0.166666666667
within <=5:	7	0.194444444444
within <=10:	12	0.333333333333
within <=50:	24	0.666666666667
other (>50.000000):	6	0.166666666667
within <= 10 (1.000000%):	12	0.333333333333
within <= 48 (5.000000%):	23	0.638888888889
within <= 95 (10.000000%):	28	0.777777777778
within <= 477 (50.000000%):	30	0.833333333333
other > 477 (50.000000%):	0	0.0
total:	36
-->

<!-- ZooKeeper v3.5.0
max bound:	927
fancy:	False
same:	43	0.178423236515
same (ones):	36	0.149377593361
diff of 1:	28	0.116182572614
diff of 2:	21	0.0871369294606
diff of 3:	12	0.0497925311203
within <=1:	28	0.116182572614
within <=5:	81	0.336099585062
within <=10:	118	0.489626556017
within <=50:	169	0.701244813278
other (>50.000000):	29	0.120331950207
within <= 9 (1.000000%):	114	0.473029045643
within <= 46 (5.000000%):	168	0.697095435685
within <= 93 (10.000000%):	182	0.755186721992
within <= 464 (50.000000%):	198	0.821576763485
other > 464 (50.000000%):	0	0.0
total:	241
-->

<!--All
max bound:	4968
fancy:	False
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
total:	775
-->

### Situations


In this study, we've also asked two research questions which lead to two
distinct comparisons.  First, we compare a batch TM-based FLT trained on the
changesets of a project's history to one trained on the snapshot of source code
entities.  Second, we compare a batch TM-based FLT trained on changesets to a
online TM-based FLT trained on the same changesets over time.  Our results are
mixed between the research questions, hence we end up with four possible
situations; we will now discuss each of these situations in detail.


#### Batch changesets are better than batch shapshot *and* batch changesets are better than changesets in the simulated environment

#### Batch changesets are better than batch shapshot *and* changesets in the simulated environment are better than batch changesets

#### Batch snapshot are better than batch changeset *and* changesets in the simulated environment are better than batch changesets

#### Batch snapshot are better than batch changeset *and* batch changesets are better than changesets in the simulated environment


### A study on classes and methods

An initial study was completed in @Corley-etal_2015.
\todo{more, obvs}
