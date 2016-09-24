## Discussion {#sec:dit-discussion}

The results outlined in the Results Section \ref{sec:dit-results} warrants some
qualitative discussion.  In particular, our analysis shows significant affects
between snapshots and changesets, and between batch changesets and changesets
in the simulated environment.  The results are mixed between each and are not
conclusive.  However, we argue this is desirable to show that the accuracy of a
changeset-based DIT is similar to that of a snapshot-based DIT but without the
retraining cost.


### \doneq


\todo{discuss figures here}
\input{figures/dit/rq1_overview}

\input{figures/dit/rq1_bookkeeper}
\input{figures/dit/rq1_mahout}
\input{figures/dit/rq1_openjpa}
\input{figures/dit/rq1_pig}
\input{figures/dit/rq1_tika}
\input{figures/dit/rq1_zookeeper}

<!-- Changesets Snapshot Developers
-->

<!-- BookKeeper v4.3.0
max bound:	5
fancy:	False
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
total:	164
-->

<!-- Mahout v0.10.0
max bound:	38
fancy:	False
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
total:	133
-->

<!-- OpenJPA v2.3.0
max bound:	26
fancy:	False
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
total:	137
-->

<!-- Pig v0.14.0
max bound:	28
fancy:	False
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
total:	222
-->

<!-- Tika v1.8
max bound:	26
fancy:	False
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
total:	40
-->

<!-- ZooKeeper v3.5.0
max bound:	16
fancy:	False
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
total:	359
-->

<!--All
max bound:	38
fancy:	False
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
total:	1055
-->

### \dtwoq


\todo{discuss figures here}
\input{figures/dit/rq2_overview}

\input{figures/dit/rq2_bookkeeper}
\input{figures/dit/rq2_mahout}
\input{figures/dit/rq2_openjpa}
\input{figures/dit/rq2_pig}
\input{figures/dit/rq2_tika}
\input{figures/dit/rq2_zookeeper}

<!-- Changesets Historical Developers
-->

<!-- BookKeeper v4.3.0
max bound:	5
fancy:	False
same:	43	0.262195121951
same (ones):	30	0.182926829268
diff of 1:	58	0.353658536585
diff of 2:	40	0.243902439024
diff of 3:	17	0.103658536585
within <=1:	58	0.353658536585
within <=5:	121	0.737804878049
within <=10:	121	0.737804878049
within <=50:	121	0.737804878049
other (>50.000000):	0	0.0
within <= 0 (1.000000%):	0	0.0
within <= 0 (5.000000%):	0	0.0
within <= 1 (10.000000%):	58	0.353658536585
within <= 3 (50.000000%):	115	0.701219512195
other > 3 (50.000000%):	6	0.0365853658537
total:	164
-->

<!-- Mahout v0.10.0
max bound:	38
fancy:	False
same:	12	0.0902255639098
same (ones):	4	0.0300751879699
diff of 1:	14	0.105263157895
diff of 2:	15	0.112781954887
diff of 3:	11	0.0827067669173
within <=1:	14	0.105263157895
within <=5:	51	0.383458646617
within <=10:	89	0.669172932331
within <=50:	121	0.90977443609
other (>50.000000):	0	0.0
within <= 0 (1.000000%):	0	0.0
within <= 2 (5.000000%):	29	0.218045112782
within <= 4 (10.000000%):	47	0.353383458647
within <= 19 (50.000000%):	110	0.827067669173
other > 19 (50.000000%):	11	0.0827067669173
total:	133
-->

<!-- OpenJPA v2.3.0
max bound:	26
fancy:	False
same:	20	0.14598540146
same (ones):	7	0.0510948905109
diff of 1:	29	0.211678832117
diff of 2:	19	0.138686131387
diff of 3:	21	0.153284671533
within <=1:	29	0.211678832117
within <=5:	88	0.642335766423
within <=10:	107	0.78102189781
within <=50:	117	0.85401459854
other (>50.000000):	0	0.0
within <= 0 (1.000000%):	0	0.0
within <= 1 (5.000000%):	29	0.211678832117
within <= 3 (10.000000%):	69	0.503649635036
within <= 13 (50.000000%):	112	0.817518248175
other > 13 (50.000000%):	5	0.036496350365
total:	137
-->

<!-- Pig v0.14.0
max bound:	28
fancy:	False
same:	20	0.0900900900901
same (ones):	2	0.00900900900901
diff of 1:	41	0.184684684685
diff of 2:	41	0.184684684685
diff of 3:	28	0.126126126126
within <=1:	41	0.184684684685
within <=5:	163	0.734234234234
within <=10:	200	0.900900900901
within <=50:	202	0.90990990991
other (>50.000000):	0	0.0
within <= 0 (1.000000%):	0	0.0
within <= 1 (5.000000%):	41	0.184684684685
within <= 3 (10.000000%):	110	0.495495495495
within <= 14 (50.000000%):	202	0.90990990991
other > 14 (50.000000%):	0	0.0
total:	222
-->

<!-- Tika v1.8
max bound:	26
fancy:	False
same:	6	0.15
same (ones):	3	0.075
diff of 1:	1	0.025
diff of 2:	8	0.2
diff of 3:	4	0.1
within <=1:	1	0.025
within <=5:	25	0.625
within <=10:	32	0.8
within <=50:	34	0.85
other (>50.000000):	0	0.0
within <= 0 (1.000000%):	0	0.0
within <= 1 (5.000000%):	1	0.025
within <= 3 (10.000000%):	13	0.325
within <= 13 (50.000000%):	32	0.8
other > 13 (50.000000%):	2	0.05
total:	40
-->

<!-- ZooKeeper v3.5.0
max bound:	16
fancy:	False
same:	65	0.181058495822
same (ones):	14	0.0389972144847
diff of 1:	84	0.233983286908
diff of 2:	71	0.197771587744
diff of 3:	47	0.130919220056
within <=1:	84	0.233983286908
within <=5:	262	0.729805013928
within <=10:	293	0.816155988858
within <=50:	294	0.818941504178
other (>50.000000):	0	0.0
within <= 0 (1.000000%):	0	0.0
within <= 1 (5.000000%):	84	0.233983286908
within <= 2 (10.000000%):	155	0.431754874652
within <= 8 (50.000000%):	291	0.810584958217
other > 8 (50.000000%):	3	0.008356545961
total:	359
-->

<!--All
max bound:	38
fancy:	False
same:	166	0.157345971564
same (ones):	60	0.0568720379147
diff of 1:	227	0.215165876777
diff of 2:	194	0.183886255924
diff of 3:	128	0.121327014218
within <=1:	227	0.215165876777
within <=5:	710	0.672985781991
within <=10:	842	0.798104265403
within <=50:	889	0.842654028436
other (>50.000000):	0	0.0
within <= 0 (1.000000%):	0	0.0
within <= 2 (5.000000%):	421	0.399052132701
within <= 4 (10.000000%):	642	0.608530805687
within <= 19 (50.000000%):	877	0.831279620853
other > 19 (50.000000%):	12	0.0113744075829
total:	1055
-->

### Situations


In this study, we've also asked two research questions which lead to two
distinct comparisons.  First, we compare a batch TM-based DIT trained on the
changesets of a project's history to one trained on the snapshot of source code
entities.  Second, we compare a batch TM-based DIT trained on changesets to a
online TM-based DIT trained on the same changesets over time.  Our results are
mixed between the research questions, hence we end up with four possible
situations; we will now discuss each of these situations in detail.


#### Batch changesets are better than batch shapshot *and* batch changesets are better than changesets in the simulated environment

#### Batch changesets are better than batch shapshot *and* changesets in the simulated environment are better than batch changesets

#### Batch snapshot are better than batch changeset *and* changesets in the simulated environment are better than batch changesets

#### Batch snapshot are better than batch changeset *and* batch changesets are better than changesets in the simulated environment

