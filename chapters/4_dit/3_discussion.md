## Discussion {#sec:dit-discussion}

The results outlined in the Results Section \ref{sec:dit-results} warrants some
qualitative discussion.  In particular, our analysis shows significant affects
between snapshots and changesets, and between batch changesets and changesets
in the simulated environment.  The results are mixed between each and are not
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
systems. The figure suggests that snapshot-based models and changeset-based
models have similar results overall with changesets performing slightly better,
but does not help to understand how each feature query performs for each model.
With respect to \done, we will investigate the queries and effectiveness
measures between the batch snapshot and batch changesets in detail.

\todo{We will first discuss all systems, and then each subject system in turn.}

For the 1055 queries across all systems, 154 queries return the same
effectiveness measure in both approaches, or about 14.6% of the time.  Of these
154 queries, 58 (5.5%) share an effectiveness measure of 1 (the best possible
measure) for both approaches.

After excluding the 154 queries in which ranks which are the same, 245 (23.2%)
of the remaining 901 queries have effectiveness measures is within 1 rank of
each other.  Likewise, 145 (13.8%) queries have a difference in effectiveness
measure of 2.  Finally, 166 (15.7%) have the effectiveness measure difference
of 3.  The remaining 345 queries (38.3%) perform noticeably different ($> 3$
ranks apart).

<!-- BookKeeper v4.3.0
max bound:	5
same:	30	0.182926829268
same (ones):	17	0.103658536585
diff of 1:	61	0.371951219512
diff of 2:	20	0.121951219512
diff of 3:	41	0.25
within <=1:	61	0.371951219512
within <=5:	134	0.817073170732
within <=10:	134	0.817073170732
within <=50:	134	0.817073170732
other (>50.000000):	0	0.0
within <= 0 (1.000000%):	0	0.0
within <= 0 (5.000000%):	0	0.0
within <= 1 (10.000000%):	61	0.371951219512
within <= 3 (50.000000%):	122	0.743902439024
other > 3 (50.000000%):	12	0.0731707317073
worst (Changesets - Snapshot) 4.0 -4.0
total:	164

\input{figures/dit/rq1_bookkeeper}

-->

<!-- Mahout v0.10.0
max bound:	38
same:	16	0.12030075188
same (ones):	4	0.0300751879699
diff of 1:	17	0.127819548872
diff of 2:	19	0.142857142857
diff of 3:	16	0.12030075188
within <=1:	17	0.127819548872
within <=5:	67	0.503759398496
within <=10:	94	0.706766917293
within <=50:	117	0.87969924812
other (>50.000000):	0	0.0
within <= 0 (1.000000%):	0	0.0
within <= 2 (5.000000%):	36	0.270676691729
within <= 4 (10.000000%):	63	0.473684210526
within <= 19 (50.000000%):	109	0.81954887218
other > 19 (50.000000%):	8	0.0601503759398
worst (Changesets - Snapshot) 33.0 -19.0
total:	133

\input{figures/dit/rq1_mahout}

-->

<!-- OpenJPA v2.3.0
max bound:	26
same:	22	0.160583941606
same (ones):	8	0.0583941605839
diff of 1:	27	0.197080291971
diff of 2:	10	0.0729927007299
diff of 3:	15	0.109489051095
within <=1:	27	0.197080291971
within <=5:	72	0.525547445255
within <=10:	101	0.737226277372
within <=50:	115	0.839416058394
other (>50.000000):	0	0.0
within <= 0 (1.000000%):	0	0.0
within <= 1 (5.000000%):	27	0.197080291971
within <= 3 (10.000000%):	52	0.379562043796
within <= 13 (50.000000%):	108	0.788321167883
other > 13 (50.000000%):	7	0.0510948905109
worst (Changesets - Snapshot) 13.0 -21.0
total:	137

\input{figures/dit/rq1_openjpa}
-->

<!-- Pig v0.14.0
max bound:	28
same:	22	0.0990990990991
same (ones):	3	0.0135135135135
diff of 1:	35	0.157657657658
diff of 2:	23	0.103603603604
diff of 3:	28	0.126126126126
within <=1:	35	0.157657657658
within <=5:	138	0.621621621622
within <=10:	184	0.828828828829
within <=50:	200	0.900900900901
other (>50.000000):	0	0.0
within <= 0 (1.000000%):	0	0.0
within <= 1 (5.000000%):	35	0.157657657658
within <= 3 (10.000000%):	86	0.387387387387
within <= 14 (50.000000%):	192	0.864864864865
other > 14 (50.000000%):	8	0.036036036036
worst (Changesets - Snapshot) 17.0 -22.0
total:	222

\input{figures/dit/rq1_pig}
-->

<!-- Tika v1.8
max bound:	26
same:	2	0.05
same (ones):	2	0.05
diff of 1:	9	0.225
diff of 2:	6	0.15
diff of 3:	8	0.2
within <=1:	9	0.225
within <=5:	29	0.725
within <=10:	35	0.875
within <=50:	38	0.95
other (>50.000000):	0	0.0
within <= 0 (1.000000%):	0	0.0
within <= 1 (5.000000%):	9	0.225
within <= 3 (10.000000%):	23	0.575
within <= 13 (50.000000%):	36	0.9
other > 13 (50.000000%):	2	0.05
worst (Changesets - Snapshot) 18.0 -6.0
total:	40

\input{figures/dit/rq1_tika}
-->

<!-- ZooKeeper v3.5.0
max bound:	16
same:	62	0.172701949861
same (ones):	24	0.066852367688
diff of 1:	96	0.267409470752
diff of 2:	67	0.186629526462
diff of 3:	58	0.161559888579
within <=1:	96	0.267409470752
within <=5:	276	0.768802228412
within <=10:	297	0.827298050139
within <=50:	297	0.827298050139
other (>50.000000):	0	0.0
within <= 0 (1.000000%):	0	0.0
within <= 1 (5.000000%):	96	0.267409470752
within <= 2 (10.000000%):	163	0.454038997214
within <= 8 (50.000000%):	293	0.816155988858
other > 8 (50.000000%):	4	0.0111420612813
worst (Changesets - Snapshot) 10.0 -10.0
total:	359

\input{figures/dit/rq1_zookeeper}
-->

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
systems. The figure suggests that snapshot-based models and changeset-based
models have similar results overall with changesets performing slightly better,
but does not help to understand how each feature query performs for each model.
With respect to \dtwo, we will investigate the queries and effectiveness
measures between the batch snapshot and batch changesets in detail.

\todo{We will first discuss all systems, and then each subject system in turn.}

For the 1055 queries across all systems, only 1043 were successful.  These 12
that were unsuccessful were likely due to excluding the commit that fixed the
issue related to the query.  These commits were the first change in the
repository by that maintainer, resulting in them missing from the ranking until
that point \todo{PLEASE FULLY CONFIRM THIS}.  126 queries return the same
effectiveness measure in both approaches, or about 12.1% of the time.  Of these
126 queries, 45 (4.3%) share an effectiveness measure of 1 (the best possible
measure) for both approaches.

After excluding the 126 queries in which ranks which are the same, 213 (20.4%)
of the remaining 917 queries have effectiveness measures is within 1 rank of
each other.  Likewise, 169 (16.2%) queries have a difference in effectiveness
measure of 2.  Finally, 130 (12.5%) have the effectiveness measure difference
of 3.  The remaining 512 queries (55.8%) perform noticeably different ($> 3$
ranks apart).

<!-- BookKeeper v4.3.0
max bound:	5
same:	38	0.233128834356
same (ones):	24	0.147239263804
diff of 1:	59	0.361963190184
diff of 2:	36	0.220858895706
diff of 3:	25	0.153374233129
within <=1:	59	0.361963190184
within <=5:	125	0.766871165644
within <=10:	125	0.766871165644
within <=50:	125	0.766871165644
other (>50.000000):	0	0.0
within <= 0 (1.000000%):	0	0.0
within <= 0 (5.000000%):	0	0.0
within <= 1 (10.000000%):	59	0.361963190184
within <= 3 (50.000000%):	120	0.736196319018
other > 3 (50.000000%):	5	0.0306748466258
worst (Changesets - Historical) 4.0 -3.0
total:	163

\input{figures/dit/rq2_bookkeeper}
-->

<!-- Mahout v0.10.0
max bound:	38
same:	10	0.0769230769231
same (ones):	4	0.0307692307692
diff of 1:	15	0.115384615385
diff of 2:	7	0.0538461538462
diff of 3:	12	0.0923076923077
within <=1:	15	0.115384615385
within <=5:	48	0.369230769231
within <=10:	79	0.607692307692
within <=50:	120	0.923076923077
other (>50.000000):	0	0.0
within <= 0 (1.000000%):	0	0.0
within <= 2 (5.000000%):	22	0.169230769231
within <= 4 (10.000000%):	41	0.315384615385
within <= 19 (50.000000%):	106	0.815384615385
other > 19 (50.000000%):	14	0.107692307692
worst (Changesets - Historical) 37.0 -25.0
total:	130

\input{figures/dit/rq2_mahout}
-->

<!-- OpenJPA v2.3.0
max bound:	26
same:	16	0.117647058824
same (ones):	5	0.0367647058824
diff of 1:	22	0.161764705882
diff of 2:	18	0.132352941176
diff of 3:	13	0.0955882352941
within <=1:	22	0.161764705882
within <=5:	77	0.566176470588
within <=10:	104	0.764705882353
within <=50:	120	0.882352941176
other (>50.000000):	0	0.0
within <= 0 (1.000000%):	0	0.0
within <= 1 (5.000000%):	22	0.161764705882
within <= 3 (10.000000%):	53	0.389705882353
within <= 13 (50.000000%):	115	0.845588235294
other > 13 (50.000000%):	5	0.0367647058824
worst (Changesets - Historical) 23.0 -20.0
total:	136

\input{figures/dit/rq2_openjpa}
-->

<!-- Pig v0.14.0
max bound:	28
same:	17	0.0769230769231
same (ones):	2	0.00904977375566
diff of 1:	36	0.162895927602
diff of 2:	30	0.135746606335
diff of 3:	26	0.117647058824
within <=1:	36	0.162895927602
within <=5:	139	0.628959276018
within <=10:	194	0.877828054299
within <=50:	204	0.923076923077
other (>50.000000):	0	0.0
within <= 0 (1.000000%):	0	0.0
within <= 1 (5.000000%):	36	0.162895927602
within <= 3 (10.000000%):	92	0.41628959276
within <= 14 (50.000000%):	202	0.914027149321
other > 14 (50.000000%):	2	0.00904977375566
worst (Changesets - Historical) 18.0 -10.0
total:	221

\input{figures/dit/rq2_pig}
-->

<!-- Tika v1.8
max bound:	26
same:	5	0.128205128205
same (ones):	3	0.0769230769231
diff of 1:	1	0.025641025641
diff of 2:	8	0.205128205128
diff of 3:	4	0.102564102564
within <=1:	1	0.025641025641
within <=5:	25	0.641025641026
within <=10:	32	0.820512820513
within <=50:	34	0.871794871795
other (>50.000000):	0	0.0
within <= 0 (1.000000%):	0	0.0
within <= 1 (5.000000%):	1	0.025641025641
within <= 3 (10.000000%):	13	0.333333333333
within <= 13 (50.000000%):	32	0.820512820513
other > 13 (50.000000%):	2	0.0512820512821
worst (Changesets - Historical) 19.0 -7.0
total:	39

\input{figures/dit/rq2_tika}
-->

<!-- ZooKeeper v3.5.0
max bound:	16
same:	40	0.112994350282
same (ones):	7	0.0197740112994
diff of 1:	80	0.225988700565
diff of 2:	70	0.197740112994
diff of 3:	50	0.141242937853
within <=1:	80	0.225988700565
within <=5:	260	0.734463276836
within <=10:	314	0.887005649718
within <=50:	314	0.887005649718
other (>50.000000):	0	0.0
within <= 0 (1.000000%):	0	0.0
within <= 1 (5.000000%):	80	0.225988700565
within <= 2 (10.000000%):	150	0.423728813559
within <= 8 (50.000000%):	305	0.861581920904
other > 8 (50.000000%):	9	0.0254237288136
worst (Changesets - Historical) 9.0 -10.0
total:	354

\input{figures/dit/rq2_zookeeper}
-->

### Situations


In this study, we've also asked two research questions which lead to two
distinct comparisons.  First, we compare a batch TM-based DIT trained on the
changesets of a project's history to one trained on the snapshot of source code
entities.  Second, we compare a batch TM-based DIT trained on changesets to a
online TM-based DIT trained on the same changesets over time.  Our results are
mixed between the research questions, hence we end up with four possible
situations; we will now discuss each of these situations in detail.

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

#### Batch changesets are better than batch snapshot *and* changesets in the simulated environment are better than batch changesets

#### Batch snapshot are better than batch changeset *and* changesets in the simulated environment are better than batch changesets

#### Batch snapshot are better than batch changeset *and* batch changesets are better than changesets in the simulated environment

