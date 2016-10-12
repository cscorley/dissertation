## Results {#sec:combo-results}

In this section, we will describe the results of the study outlined in Section
\ref{sec:combo-design}.

\cone{} ask whether a single topic model can be used for more than a single
task, specifically for feature location and developer identification. Table
\ref{table:all_model_sweep} shows the summary results over all subject systems.
Tables \ref{table:bookkeeper_model_sweep}, \ref{table:mahout_model_sweep},
\ref{table:openjpa_model_sweep}, \ref{table:pig_model_sweep},
\ref{table:tika_model_sweep}, and \ref{table:zookeeper_model_sweep} show the
results for \bookkeeper, \mahout, \openjpa, \pig, \tika, and \zookeeper,
respectively. In the tables, we bold entries where the MRR is highest for each
of the two tasks. Our goal is not to find which configuration works best for
each system and task, but rather to determine whether one configuration is
*capable* of producing acceptable results for both tasks.
\todo{highlight the results from default configs of other chapters}


Overall,

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
over all subject systems. Tables \ref{table:bookkeeper_corpus_sweep},
\ref{table:mahout_corpus_sweep}, \ref{table:openjpa_corpus_sweep},
\ref{table:pig_corpus_sweep}, \ref{table:tika_corpus_sweep}, and
\ref{table:zookeeper_corpus_sweep} show the results for \bookkeeper, \mahout,
\openjpa, \pig, \tika, and \zookeeper, respectively. In the tables, we bold
entries where the MRR is highest for each of the two tasks. Our goal is not to
find which configuration works best for each system and task, but rather to
determine whether one configuration is *capable* of producing acceptable
results for both tasks.

The results for the corpus construction sweep vary across systems and tasks.
Importantly, there does not seem to be any particular configuration that is
shared between systems or tasks.



\input{tables/all_corpus_sweep}
\input{tables/bookkeeper_corpus_sweep}
\input{tables/mahout_corpus_sweep}
\input{tables/openjpa_corpus_sweep}
\input{tables/pig_corpus_sweep}
\input{tables/tika_corpus_sweep}
\input{tables/zookeeper_corpus_sweep}

