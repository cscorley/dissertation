## Combining and Configuring Changset-based Topic Models {#results-config}

In this section, we will describe the results of the study outlined in Section
\ref{method-combo}.

\cone{} ask whether a single topic model can be used for more than a single
task, specifically for feature location and developer identification.  Tables
\ref{table:bookkeeper_model_sweep}, \ref{table:mahout_model_sweep},
\ref{table:openjpa_model_sweep}, \ref{table:pig_model_sweep},
\ref{table:tika_model_sweep}, and \ref{table:zookeeper_model_sweep} show the
results for BookKeeper, Mahout, OpenJPA, Pig, Tika, and ZooKeeper,
respectively. In the tables, we bold entries where the MRR is highest for each
of the two tasks. Our goal is not to find which configuration works best for
each system and task, but rather to determine whether one configuration is
*capable* of producing acceptable results for both tasks.

Overall, all systems performed best for the DIT when $K = 500$, while lower $K$
work slightly better for the FLT with exception to BookKeeper.  Automatic
learning of hyperparameters $\alpha$ and $\eta$ also yield higher performance
throughout.  Although no configuration was found in any system that yielded
optimal parameters for both tasks, there are several configurations that do
yield moderately high performance for both tasks.


\input{tables/bookkeeper_model_sweep}
\input{tables/mahout_model_sweep}
\input{tables/openjpa_model_sweep}
\input{tables/pig_model_sweep}
\input{tables/tika_model_sweep}
\input{tables/zookeeper_model_sweep}


\input{figures/combo/flt_rq1_bookkeeper}
\input{figures/combo/dit_rq1_bookkeeper}
\input{figures/combo/flt_rq1_mahout}
\input{figures/combo/dit_rq1_mahout}
\input{figures/combo/flt_rq1_openjpa}
\input{figures/combo/dit_rq1_openjpa}
\input{figures/combo/flt_rq1_pig}
\input{figures/combo/dit_rq1_pig}
\input{figures/combo/flt_rq1_tika}
\input{figures/combo/dit_rq1_tika}
\input{figures/combo/flt_rq1_zookeeper}
\input{figures/combo/dit_rq1_zookeeper}


\ctwo{} asks what portions of a changeset are most critical for performance of
different tasks, specifically for feature location and developer
identification.  Tables \ref{table:bookkeeper_corpus_sweep},
\ref{table:mahout_corpus_sweep}, \ref{table:openjpa_corpus_sweep},
\ref{table:pig_corpus_sweep}, \ref{table:tika_corpus_sweep}, and
\ref{table:zookeeper_corpus_sweep} show the results for BookKeeper, Mahout,
OpenJPA, Pig, Tika, and ZooKeeper, respectively. In the tables, we bold entries
where the MRR is highest for each of the two tasks. Our goal is not to find
which configuration works best for each system and task, but rather to
determine whether one configuration is *capable* of producing acceptable
results for both tasks.

The results for the corpus construction sweep vary across systems and tasks.
Importantly, there does not seem to be any particular configuration that is
shared between systems or tasks.



\input{tables/bookkeeper_corpus_sweep}
\input{tables/mahout_corpus_sweep}
\input{tables/openjpa_corpus_sweep}
\input{tables/pig_corpus_sweep}
\input{tables/tika_corpus_sweep}
\input{tables/zookeeper_corpus_sweep}



\input{figures/combo/flt_rq2_bookkeeper}
\input{figures/combo/dit_rq2_bookkeeper}
\input{figures/combo/flt_rq2_mahout}
\input{figures/combo/dit_rq2_mahout}
\input{figures/combo/flt_rq2_openjpa}
\input{figures/combo/dit_rq2_openjpa}
\input{figures/combo/flt_rq2_pig}
\input{figures/combo/dit_rq2_pig}
\input{figures/combo/flt_rq2_tika}
\input{figures/combo/dit_rq2_tika}
\input{figures/combo/flt_rq2_zookeeper}
\input{figures/combo/dit_rq2_zookeeper}
