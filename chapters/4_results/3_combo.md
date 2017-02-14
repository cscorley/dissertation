## Results {#sec:combo-results}

In this section, we will describe the results of the study outlined in Section
\ref{sec:combo-design}.

\cone{} asks whether a single topic model can be used for more than a single
task, specifically for feature location and developer identification. Tables
\ref{table:all_model_sweep} and \ref{table:all_corpus_sweep} show the summary
results over all subject systems for model construction and corpus
construction, respectively.  In the tables, we bold entries where the MRR is
highest for each of the two tasks and also highlight the row of the
configuration used throughout this dissertation.  Our goal is not to find which
configuration works best for each system and task, but rather to determine
whether one configuration is *capable* of producing acceptable results for both
tasks.

For model construction, the both tasks perform best when $K=500$ and
$\eta=auto$, but differ when it comes to $\alpha$. FLT prefers the lower alpha,
$2/K$, while DIT is best with the highest alpha, $5/K$.  A Wilcoxon rank-sum
test reveals that the optimal FLT is statistically significant ($p<0.01$)
compared to the alternate with an effect size low at $r=0.2181$.  Likewise, a
Wilcoxon rank-sum test reveals that the optimal DIT is not statistically
significant ($p=0.2262$) compared to the alternate.  This suggests that the DIT
is less sensitive to parameter changes, allowing the user to select the model
configuration that works best for FLT.
<!-- probably due to the less actual ranks possible -->


\todo{repeat this test against each system, construct wilcoxon table?}

For corpus construction, the both tasks perform best when including the context
and message, but differ when it comes to including additions. FLT prefers
additions to be included, while DIT does not.  Neither task performs best when
removals are included.  A Wilcoxon rank-sum test reveals that the optimal FLT
is statistically significant ($p<0.01$) compared to the alternate with an
effect size of $r=0.1273$.  Likewise, a Wilcoxon rank-sum test also reveals
that the optimal DIT is statistically significant ($p<0.01$) compared to the
alternate with an effect size of $r=0.2580$.  This suggests that correct corpus
construction plays a somewhat important role in both tasks, but the effect of
choosing an alternate over the optimal is low.

\todo{repeat this test against each system, construct wilcoxon table?}

\input{tables/all_model_sweep}
\input{tables/bookkeeper_model_sweep}
\input{tables/mahout_model_sweep}
\input{tables/openjpa_model_sweep}
\input{tables/pig_model_sweep}
\input{tables/tika_model_sweep}
\input{tables/zookeeper_model_sweep}

\ctwo{} asks what portions of a changeset are most critical for performance of
different tasks, specifically for feature location and developer
identification.  Table \ref{table:all_corpus_sweep} shows the summary results
over all subject systems. As in \cone, our goal is not to find which
configuration works best for each system and task, but rather to determine
whether a particular text source affects the tasks.

As seen in the results for \cone, the results for the corpus construction sweep
vary across systems and tasks.  Importantly, there does not seem to be any
particular configuration that is shared between systems or tasks.  For all
subject systems, both tasks perform best when including changeset context and
message text sources. FLT sees a slight increase in MRR ($0.0546$) when the
additions text source is included, while DIT slightly decreases in MRR
($0.038$).

\input{tables/combo_friedman_results}

Tables \ref{table:combo-friedman-flt} and \ref{table:combo-friedman-dit} show
the Friedman test results for FLT and DIT, respectively.  The Friedman test of
all subject systems shows significance for both FLT ($p < 0.01$) and DIT ($p <
0.01$), indicating a difference between configurations for each task.
Likewise, the Friedman test for each individual system shows significance for
both FLT ($p < 0.01$) and DIT ($p < 0.01$), with two exceptions.  The two
non-significant exceptions were \mahout FLT task with $p=0.4802$ and \tika DIT
task with $p=0.0578$.

A post-hoc test was conducted using Wilcoxon rank-sum test with Holm correction
for each possible configuration pairing (105 tests).  For combined
effectiveness measures of all subject systems, 49 pairs were statistically
significant at $p<0.01$ for the FLT task.  Similarly, for the DIT task,
combined results of all subject systems contains 86 pairs that are
statistically significant at $p<0.01$.

\todo{output these wilcoxon values to the friedman results tables? they're just
counts.}

<!--

('Overall', 'DIT') (1026.4202237626146, 3.3513230863942486e-210)
('Overall', 'FLT') (204.92519870085692, 5.4081738142632788e-36)
('BookKeeper v4.3.0', 'DIT') (269.15965685137962, 3.0826378883316631e-49)
('BookKeeper v4.3.0', 'FLT') (120.17870967741979, 5.8050748444333064e-19)
('Mahout v0.10.0', 'DIT') (50.551435851920118, 4.9350360355472855e-06)
('Mahout v0.10.0', 'FLT') (13.59583301299296, 0.48023490708350502)
('OpenJPA v2.3.0', 'DIT') (124.62989253393617, 7.7689368153807406e-20)
('OpenJPA v2.3.0', 'FLT') (39.360167260803301, 0.00032079920046939486)
('Pig v0.14.0', 'DIT') (887.09399971431264, 2.5129987045198387e-180)
('Pig v0.14.0', 'FLT') (53.36931027853425, 1.6459942163479751e-06)
('Tika v1.8', 'DIT') (23.153468323977627, 0.057817878117764045)
('Tika v1.8', 'FLT') (39.141343807653421, 0.00034683358355782473)
('ZooKeeper v3.5.0', 'DIT') (454.49564930784339, 3.9880227095427624e-88)
('ZooKeeper v3.5.0', 'FLT') (71.613097718627287, 9.8353877807822766e-10)

-->

\input{tables/all_corpus_sweep}
\input{tables/bookkeeper_corpus_sweep}
\input{tables/mahout_corpus_sweep}
\input{tables/openjpa_corpus_sweep}
\input{tables/pig_corpus_sweep}
\input{tables/tika_corpus_sweep}
\input{tables/zookeeper_corpus_sweep}

\todo{mann-whitney tests?}
