# Previous Work

## Traceability link recovery {#tefse2011}

## Modeling ownership {#icpc2012}

## Duplicate bug report detection {#msr2013}

<!--
    relates to triage steps
-->

## Modeling changeset topics {#mud2014}

This section discusses the work in @Corley-etal:2014.

### Terminology

In addition to the terminology described in Section \ref{terminology}, we
use the following terminology to describe document extraction of changesets.

diff:
:   set of text which represents the differences between two texts

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

changeset
:   ideally represents a single feature modification, addition, or deletion,
which may crosscut many source code entities

commit
:   a representation of a changeset in a version control system, such as Git or
Subversion.

### Approach

- Document extraction
- Preprocessing
- Training
- Retrieval

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

