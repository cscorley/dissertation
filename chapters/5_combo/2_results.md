## Results {#sec:combo-results}

In this section, we will describe the results of the study outlined in Section
\ref{sec:combo-design}.

\cone{} ask whether a single topic model can be used for more than a single
task, specifically for feature location and developer identification. Tables
\ref{table:all_model_sweep} and \ref{table: all_corpus_sweep} show the summary
results over all subject systems for model construction and corpus
construction, respectively.  In the tables, we bold entries where the MRR is
highest for each of the two tasks and also highlight the row of the
configuration used throughout this dissertation. Our goal is not to find which
configuration works best for each system and task, but rather to determine
whether one configuration is *capable* of producing acceptable results for both
tasks.

For model construction, the both tasks perform best when $K=500$ and
$\eta=auto$, but differ when it comes to $\alpha$. FLT prefers the lower alpha,
$2/K$, while DIT is best with the highest alpha, $5/K$.  A Wilcoxon rank-sum
test reveals that the optimal FLT is \attn{xxxx} compared to the alternate.
Likewise, a Wilcoxon rank-sum test reveals that the optimal DIT is \attn{xxxx}
compared to the alternate.  This suggests that \attn{xxxx}

\todo{repeat this test against each system, construct wilcoxon table?}

For corpus construction, the both tasks perform best when including the context
and message, but differ when it comes to including additions. FLT prefers
additions to be included, while DIT does not.  Neither task performs best when
removals are included.  A Wilcoxon rank-sum test reveals that the optimal FLT
is \attn{xxxx} compared to the alternate.  Likewise, a Wilcoxon rank-sum test
reveals that the optimal DIT is \attn{xxxx} compared to the alternate.  This
suggests that \attn{xxxx}

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
particular configuration that is shared between systems or tasks.



\input{tables/all_corpus_sweep}
\input{tables/bookkeeper_corpus_sweep}
\input{tables/mahout_corpus_sweep}
\input{tables/openjpa_corpus_sweep}
\input{tables/pig_corpus_sweep}
\input{tables/tika_corpus_sweep}
\input{tables/zookeeper_corpus_sweep}

