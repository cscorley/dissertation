
## Modeling changeset topics {#mud2014}

In @Corley-etal_2014 we conducted an exploratory study on modeling the topics
of changesets. We wanted to determine whether topic modeling changesets can
perform as well as, or better than, topic modeling a snapshot. Towards this
goal, we posed two research questions:

RQ1
:   Do changeset- and snapshot-based corpora express the same terms?

RQ2
:   Are topic models trained on changesets more distinct than topic models
trained on a snapshot?

To answer these questions, we conducted an exploratory study on four subject
systems. The four subjects of our study --- Apache Ant, Eclipse AspectJ,
Joda-Time, and PostgreSQL --- varied in language, size and application domain.

![Extraction and Modeling Process \label{fig:mud2014}](figures/mud2014.pdf)

Our document extraction process is shown on the left side of Figure
\ref{fig:mud2014} and our modeling generation is shown on the right side. We
extract documents from both a snapshot of the repository at a tagged release
and each commit reachable from that tag's commit. The same preprocessing steps
are employed on all documents extracted. We then used LDA to model the
documents into topics.

First, we investigated whether changeset corpora were any different than
traditional snapshot corpora, and what differences there might be. For two of
the systems, we found that the changeset vocabulary was a superset to the
snapshot vocabulary. We measured the cosine distance of each distribution of
words, and found for 3 of the systems low (between 0.003 to 0.07), while the
last was much higher than the others (over 0.33).

Next, we investigated whether a topic model trained on a changeset corpus was
more or less distinct than a topic model trained on a snapshot corpus. For 2 of
the 4 systems, we found that the changeset corpus produced more distinct
topics, while for the other 2 it did not.

In conclusion, we found that building topic models from changesets did not
incur any quality trade-offs in terms of term frequency and topic distinctness.
