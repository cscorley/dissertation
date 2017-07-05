<!-- this fixes the issue with all tables having label A.nn -->
\renewcommand{\thetable}{\Alph{chapter}.\arabic{table}}

# Feature Location Boxplots {#app:flt}

slugline

<!-- BookKeeper v4.3.0
max bound:	843
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

<!-- old text
Figure \ref{fig:flt:rq1:bookkeeper} shows the effectiveness measures for
\bookkeeper.  Again, the figure suggests that changesets perform better than
snapshots, even though the difference of MRR is only $0.0056$ (Table
\ref{table:feature_location_rq1}.)
-->


<!-- Mahout v0.10.0
max bound:	1556
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

<!-- BookKeeper v4.3.0
max bound:	843
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
worst (Changesets - Historical) 620.0 -392.0
total:	143

-->

\input{figures/flt/rq2_bookkeeper}

<!-- Mahout v0.10.0
max bound:	1556
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
worst (Changesets - Historical) 823.0 -636.0
total:	50

-->

\input{figures/flt/rq2_mahout}

<!-- OpenJPA v2.3.0
max bound:	4968
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
worst (Changesets - Historical) 594.0 -2153.0
total:	131

-->

\input{figures/flt/rq2_openjpa}

<!-- Pig v0.14.0
max bound:	2098
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
worst (Changesets - Historical) 1062.0 -784.0
total:	174

-->

\input{figures/flt/rq2_pig}

<!-- Tika v1.8
max bound:	954
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
worst (Changesets - Historical) 101.0 -128.0
total:	36

-->

\input{figures/flt/rq2_tika}

<!-- ZooKeeper v3.5.0
max bound:	927
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
worst (Changesets - Historical) 415 -183
total:	241

-->

\input{figures/flt/rq2_zookeeper}


# Developer Identification Boxplots  {#app:dit}

slugline

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


-->

\input{figures/dit/rq1_bookkeeper}

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


-->
\input{figures/dit/rq1_mahout}

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

-->

\input{figures/dit/rq1_openjpa}

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

-->

\input{figures/dit/rq1_pig}

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

-->

\input{figures/dit/rq1_tika}

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

-->
\input{figures/dit/rq1_zookeeper}


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

-->

\input{figures/dit/rq2_bookkeeper}

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

-->

\input{figures/dit/rq2_mahout}

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

-->

\input{figures/dit/rq2_openjpa}

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

-->

\input{figures/dit/rq2_pig}

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

-->

\input{figures/dit/rq2_tika}

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

-->

\input{figures/dit/rq2_zookeeper}


# Model Configuration Sweep {#app:model}

In these tables, we bold entries where the MRR is highest for each of the two
tasks and also highlight the row of the configuration used throughout this
dissertation.

\input{tables/all_model_sweep}
\input{figures/combo/flt_rq1_all}
\input{figures/combo/dit_rq1_all}

\input{tables/bookkeeper_model_sweep}
\input{figures/combo/flt_rq1_bookkeeper}
\input{figures/combo/dit_rq1_bookkeeper}

\input{tables/mahout_model_sweep}
\input{figures/combo/flt_rq1_mahout}
\input{figures/combo/dit_rq1_mahout}

\input{tables/openjpa_model_sweep}
\input{figures/combo/flt_rq1_openjpa}
\input{figures/combo/dit_rq1_openjpa}

\input{tables/pig_model_sweep}
\input{figures/combo/flt_rq1_pig}
\input{figures/combo/dit_rq1_pig}

\input{tables/tika_model_sweep}
\input{figures/combo/flt_rq1_tika}
\input{figures/combo/dit_rq1_tika}

\input{tables/zookeeper_model_sweep}
\input{figures/combo/flt_rq1_zookeeper}
\input{figures/combo/dit_rq1_zookeeper}

# Corpus Construction Sweep {#app:corpus}

In these tables, we bold entries where the MRR is highest for each of the two
tasks and also highlight the row of the configuration used throughout this
dissertation.

\input{tables/all_corpus_sweep}
\input{figures/combo/flt_rq2_all}
\input{figures/combo/dit_rq2_all}

\input{tables/bookkeeper_corpus_sweep}
\input{figures/combo/flt_rq2_bookkeeper}
\input{figures/combo/dit_rq2_bookkeeper}

\input{tables/mahout_corpus_sweep}
\input{figures/combo/flt_rq2_mahout}
\input{figures/combo/dit_rq2_mahout}

\input{tables/openjpa_corpus_sweep}
\input{figures/combo/flt_rq2_openjpa}
\input{figures/combo/dit_rq2_openjpa}

\input{tables/pig_corpus_sweep}
\input{figures/combo/flt_rq2_pig}
\input{figures/combo/dit_rq2_pig}

\input{tables/tika_corpus_sweep}
\input{figures/combo/flt_rq2_tika}
\input{figures/combo/dit_rq2_tika}

\input{tables/zookeeper_corpus_sweep}
\input{figures/combo/flt_rq2_zookeeper}
\input{figures/combo/dit_rq2_zookeeper}

# Corpus Construction Inclusion and Exclusion {#app:comparison}

In these tables, we bold entries where the MRR is highest between each of the
two inclusion or exclusion configurations.

\input{tables/versus-wilcox-all-flt-additions}
\input{tables/versus-wilcox-all-dit-additions}
\input{tables/versus-wilcox-all-flt-removals}
\input{tables/versus-wilcox-all-dit-removals}
\input{tables/versus-wilcox-all-flt-context}
\input{tables/versus-wilcox-all-dit-context}
\input{tables/versus-wilcox-all-flt-message}
\input{tables/versus-wilcox-all-dit-message}

\input{tables/versus-wilcox-bookkeeper-flt-additions}
\input{tables/versus-wilcox-bookkeeper-dit-additions}
\input{tables/versus-wilcox-bookkeeper-flt-removals}
\input{tables/versus-wilcox-bookkeeper-dit-removals}
\input{tables/versus-wilcox-bookkeeper-flt-context}
\input{tables/versus-wilcox-bookkeeper-dit-context}
\input{tables/versus-wilcox-bookkeeper-flt-message}
\input{tables/versus-wilcox-bookkeeper-dit-message}

\input{tables/versus-wilcox-mahout-flt-additions}
\input{tables/versus-wilcox-mahout-dit-additions}
\input{tables/versus-wilcox-mahout-flt-removals}
\input{tables/versus-wilcox-mahout-dit-removals}
\input{tables/versus-wilcox-mahout-flt-context}
\input{tables/versus-wilcox-mahout-dit-context}
\input{tables/versus-wilcox-mahout-flt-message}
\input{tables/versus-wilcox-mahout-dit-message}

\input{tables/versus-wilcox-openjpa-flt-additions}
\input{tables/versus-wilcox-openjpa-dit-additions}
\input{tables/versus-wilcox-openjpa-flt-removals}
\input{tables/versus-wilcox-openjpa-dit-removals}
\input{tables/versus-wilcox-openjpa-flt-context}
\input{tables/versus-wilcox-openjpa-dit-context}
\input{tables/versus-wilcox-openjpa-flt-message}
\input{tables/versus-wilcox-openjpa-dit-message}

\input{tables/versus-wilcox-pig-flt-additions}
\input{tables/versus-wilcox-pig-dit-additions}
\input{tables/versus-wilcox-pig-flt-removals}
\input{tables/versus-wilcox-pig-dit-removals}
\input{tables/versus-wilcox-pig-flt-context}
\input{tables/versus-wilcox-pig-dit-context}
\input{tables/versus-wilcox-pig-flt-message}
\input{tables/versus-wilcox-pig-dit-message}

\input{tables/versus-wilcox-tika-flt-additions}
\input{tables/versus-wilcox-tika-dit-additions}
\input{tables/versus-wilcox-tika-flt-removals}
\input{tables/versus-wilcox-tika-dit-removals}
\input{tables/versus-wilcox-tika-flt-context}
\input{tables/versus-wilcox-tika-dit-context}
\input{tables/versus-wilcox-tika-flt-message}
\input{tables/versus-wilcox-tika-dit-message}

\input{tables/versus-wilcox-zookeeper-flt-additions}
\input{tables/versus-wilcox-zookeeper-dit-additions}
\input{tables/versus-wilcox-zookeeper-flt-removals}
\input{tables/versus-wilcox-zookeeper-dit-removals}
\input{tables/versus-wilcox-zookeeper-flt-context}
\input{tables/versus-wilcox-zookeeper-dit-context}
\input{tables/versus-wilcox-zookeeper-flt-message}
\input{tables/versus-wilcox-zookeeper-dit-message}
