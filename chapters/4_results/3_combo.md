## Combining and Configuring Changset-based Topic Models {#results-config}

In this section, we will describe the results of the study outlined in Section
\ref{method-combo}.

RQ 3.5.1 ask whether a single topic model can be used for more than a single
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

<!--

    BESTS

    BookKeeper
        500 auto 1      0.51  0.65
        500 auto 2      0.45  0.70

    Mahout
        100 5 auto      0.39  0.24
        500 auto auto   0.17  0.33

    OpenJPA
        200 auto 5      0.24  0.29
        500 auto 1      0.22  0.40

    Pig
        100 5 auto      0.40  0.16
        500 1 5         0.18  0.24

    Tika
        100 2 1         0.41  0.27
        500 5 auto      0.20  0.46

    Zookeeper
        200 auto 2      0.43  0.31
        500 2 auto      0.33  0.37
    -->

\input{tables/bookkeeper_model_sweep}
\input{tables/mahout_model_sweep}
\input{tables/openjpa_model_sweep}
\input{tables/pig_model_sweep}
\input{tables/tika_model_sweep}
\input{tables/zookeeper_model_sweep}

RQ 3.5.2 asks what portions of a changeset are most critical for performance of
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

Again, the results vary across systems and tasks.


<!--
        ARCM

    BookKeeper
        FFTT    0.57 0.64
        TFTF    0.48 0.69

    Mahout
        TFFT    0.24 0.32
        TTTF    0.17 0.33

    OpenJPA
        TFTT    0.24 0.37
        TTFT    0.17 0.40

    Pig
        TFTT    0.20 0.23
        FFTF    0.11 0.29

    Tika
        TFFT    0.36 0.33
        TTTF    0.30 0.44

    Zookeeper
        TTFT    0.43 0.38
        FFTT    0.41 0.44
    -->


\input{tables/bookkeeper_corpus_sweep}
\input{tables/mahout_corpus_sweep}
\input{tables/openjpa_corpus_sweep}
\input{tables/pig_corpus_sweep}
\input{tables/tika_corpus_sweep}
\input{tables/zookeeper_corpus_sweep}
