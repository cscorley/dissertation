## Terminology

This section defines some of the terminology that will be seen throughout this
work. We adopt and extend terminology from @Biggers-etal_2014. In particular,
we define the following:

feature location
:   the act of identifying the source code entity or entities that implement a
system feature

developer identification
:   the act of identifying the developer most apt to completing a software
maintenance task

term (word), $w$
:   the smallest free-form of a language

token
:   a sequence of non-whitespace characters containing one or more term

entity
:   a named source element such as a method, class, or package

identifier
:   a token representing the name of an entity

comment
:   a sequence of tokens delimited by language specific markers (e.g., `/* */`
or `#`)

literal
:   a sequence of tokens delimited by language specific markers (e.g., `' '`
for strings)

document, $d$
:   a sequence of $D$ terms $w_1, w_2, ..., w_D$, often represented as a
bag of words (i.e., $M$-length vector of term frequencies or weights)

corpus, $C$
:   a sequence of $N$ documents $d_1, d_2, ..., d_N$ (i.e., a $M \times N$
term-document matrix)

vocabulary, $V$
:   a set of $M$ unique terms that appear in a corpus $\{w_1, w_2, ..., w_M\}$

topic, $z$
:   a concept or theme of related terms, often represented as a distribution of
term proportions

topic model, $\phi$
:   a mathematical representation of the thematic structure of a corpus, or how
much a term $w$ contributes to each topic $z$ (i.e., a $K \times M$ topic-term
matrix)

inferrence, $\theta_d$
:   the thematic structure of a given document (i.e., a $K$-length topic
proportion vector)

index, $\theta$
:   a corpus that has been transformed for searching, e.g., in LDA by
inferring the thematic structure of each document (i.e., a $N \times K$
document-topic matrix)

query, $q$
:   a document created by a user

search engine
:   ranks documents by their similarity to a query

diff
:   set of text which represents the differences between two texts (see Figure
\ref{fig:diff})

patch
:   a set of instructions (i.e., diffs) that is used to transform one set of
texts into another

context lines
:   lines of a diff that denote text useful for transforming the text, but do
not represent the differences

added lines
:   lines of a diff that were *added* in order to transform the first text into
the second

removed lines
:   lines of a diff that were *removed* in order to transform the first text into
the second

changeset
:   ideally represents a single feature modification, addition, or deletion,
which may crosscut many source code entities

commit
:   a representation of a changeset in a version control system

version control system (VCS)
:   tool that assists a developer in maintaining software , such as Git or
Subversion

software repository
:   collection of commits over time which represent the history of a software
project, maintained by a VCS

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




