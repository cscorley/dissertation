# Previous Work

## Traceability link recovery {#tefse2011}

This section discusses the work in @Corley-etal_2011.

## Modeling ownership {#icpc2012}

This section discusses the work in @Corley-etal_2012.

## Duplicate bug report detection {#msr2013}

This section discusses the work in @Klein-etal_2014.

## Modeling changeset topics {#mud2014}

This section discusses the work in @Corley-etal_2014.

### Terminology

In addition to the terminology described in Section \ref{terminology} and
Section \ref{terminology-software}, we use the following terminology to
describe document extraction of changesets.

diff:
:   set of text which represents the differences between two texts (see Figure
\ref{fig:diff})

patch:
:   a set of instructions (i.e., diffs) that is used to transform one set of
texts into another

context lines:
:   lines of a diff that denote text useful for transforming the text, but do
not represent the differences

added lines:
:   lines of a diff that were *added* in order to transform the first text into
the second

removed lines:
:   lines of a diff that were *removed* in order to transform the first text into
the second

changeset:
:   ideally represents a single feature modification, addition, or deletion,
which may crosscut many source code entities

commit:
:   a representation of a changeset in a version control system, such as Git or
Subversion.

\begin{figure*}[t]
\centering
{\small
\begin{lstlisting}[language=diff, basicstyle=\ttfamily]
diff --git a/lao b/tzu
index 635ef2c..5af88a8 100644
--- a/lao
+++ b/tzu
@@ -1,7 +1,6 @@
-The Way that can be told of is not the eternal Way;
-The name that can be named is not the eternal name.
 The Nameless is the origin of Heaven and Earth;
-The Named is the mother of all things.
+The named is the mother of all things.
+
 Therefore let there always be non-being,
   so we may see their subtlety,
 And let there always be being,
@@ -9,3 +8,6 @@ And let there always be being,
 The two are the same,
 But after they are produced,
   they have different names.
+They both may be called deep and profound.
+Deeper and more profound,
+The door of all subtleties!
\end{lstlisting}
}
\caption{Example of a \texttt{git diff}}
Black or blue lines denote metadata about the change useful for patching.
In particular, black lines represent context lines (beginning with a single space).
Red lines (beginning with a single~\texttt{-}) denote line removals,
and green lines (beginning with a single~\texttt{+}) denote line additions.
\label{fig:diff}
\vspace{-10pt}
\end{figure*}


### Summary


In this paper conducted an exploratory study on modeling the topics of
changesets. We wanted to determine whether topic modeling changesets can
perform as well as, or better than, topic modeling a snapshot. Towards this
goal, we posed two research questions:

RQ1
:   Do changeset- and snapshot-based corpora express the same terms?

RQ2
:   Are topic models trained on changesets more distinct than topic models
trained on a snapshot?

To answer these questions, we conducted an exploratory study on four subject
systems. The four subjects of our study --- Apache
Ant\footnote{\url{http://ant.apache.org/}}, Eclipse
AspectJ\footnote{\url{http://eclipse.org/aspectj/}},
Joda-Time\footnote{\url{http://www.joda.org/joda-time/}}, and
PostgreSQL\footnote{\url{http://www.postgresql.org/}} --- varied in language,
size and application domain.

![Extraction and Modeling Process \label{fig:mud2014}](figures/mud2014.pdf)

Our document extraction process is shown on the left side of Figure
\ref{fig:mud2014} and our modeling generation is shown on the right side. We
extract documents from both a snapshot of the repository at a tagged release
and each commit reachable from that tag's commit. The same preprocessing steps
are employed on all documents extracted. We then used LDA to model the
documents into topics.

First, we investigated whether changeset copora were any different than
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
