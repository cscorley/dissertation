## Combining and Configuring Changset-based Topic Models {#results-config}

\input{tables/bookkeeper_model_sweep}

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

\input{tables/mahout_model_sweep}
\input{tables/openjpa_model_sweep}
\input{tables/pig_model_sweep}
\input{tables/tika_model_sweep}
\input{tables/zookeeper_model_sweep}

<!--
    BESTS

    BookKeeper
        TFTF    0.48 0.69
        FFTT    0.57 0.64

    Mahout
        TTTF    0.17 0.33
        TFFT    0.24 0.32

    OpenJPA
        TTFT    0.17 0.40
        TFTT    0.24 0.37

    Pig
        TFTT    0.20 0.23
        FFTF    0.11 0.29

    Tika
        TTTF    0.30 0.44
        TFFT    0.36 0.33

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
