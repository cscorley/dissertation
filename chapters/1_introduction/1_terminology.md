## Terminology {#sec:intro-terminology}

This section defines some of the terminology seen throughout this work.
We adopt and extend terminology from @Biggers-etal_2014. In particular, we
define the following:

feature location
:   the act of identifying the source code entity or entities implementing a
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
:   a structure optimized for searching, e.g., in LDA by
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
:   a set of instructions (i.e., diffs) used to transform one set of texts into
another

context lines
:   lines of a diff that denote text useful for transforming the text, but do
not represent the differences

added lines
:   lines of a diff that were *added* to transform the first text into the
second

removed lines
:   lines of a diff that were *removed* to transform the first text into the
second

changeset
:   ideally represents a single feature modification, addition, or deletion,
which may crosscut two or more source code entities

commit
:   a representation of a changeset in a version control system

version control system (VCS)
:   tool that assists a developer in maintaining software , such as Git or
Subversion

software repository
:   collection of commits over time which represent the history of a software
project, maintained by a VCS


<!--
\begin{figure*}[t]
\centering
\begin{lstlisting}[language=diff, basicstyle=\ttfamily\scriptsize, numbers=none]
diff --git a/src/java/net/sf/jabref/EntryEditor.java b/src/java/net/sf/jabref/EntryEditor.java
index 8c56723..6b4788e 100644
--- a/src/java/net/sf/jabref/EntryEditor.java
+++ b/src/java/net/sf/jabref/EntryEditor.java
@@ -669,7 +669,8 @@ public class EntryEditor extends JPanel implements VetoableChangeListener {
     public void storeCurrentEdit() {
         Component comp = Globals.focusListener.getFocused();
         if ((comp == source) || ((comp instanceof FieldEditor) && this.isAncestorOf(comp))) {
-            ((FieldEditor)comp).clearAutoCompleteSuggestion();
+            if (comp instanceof FieldEditor)
+                ((FieldEditor)comp).clearAutoCompleteSuggestion();
             storeFieldAction.actionPerformed(new ActionEvent(comp, 0, ""));
         }
     }
\end{lstlisting}
\caption{Example of a \texttt{git diff}}
This changeset addresses JabRef's Issue \#2904968.
Black or blue lines denote metadata about the change useful for patching.
In particular, black lines represent context lines (beginning with a single space).
Red lines (beginning with a single~\texttt{-}) denote line removals,
and green lines (beginning with a single~\texttt{+}) denote line additions.
\label{fig:diff}
\vspace{-10pt}
\end{figure*}
-->

\definecolor{myorange}{rgb}{0.7,0.2,0}

\begin{figure*}[t]
\centering
\begin{lstlisting}[basicstyle=\ttfamily\scriptsize\color{myorange}, numbers=none]
commit b1432f097ada17573c2dbf81e982915e3e81c815
Author: Tim Allison <tallison@apache.org>
Date:   Fri Jul 24 18:22:47 2015 +0000

    TIKA-1689: revert mistakenly flipped sort order of parsers from r1677328

    git-svn-id: https://svn.apache.org/repos/asf/tika/trunk@1692564 13f79535-47bb-0310-9956-ffa450edef68
\end{lstlisting}
\begin{lstlisting}[language=diff, basicstyle=\ttfamily\scriptsize, numbers=none]
diff --git a/tika-core/src/main/java/org/apache/tika/utils/ServiceLoaderUtils.java b/tika-core/src/main/java/org/apache/tika/utils/ServiceLoaderUtils.java
index ef278808..5ee1fe86 100644
--- a/tika-core/src/main/java/org/apache/tika/utils/ServiceLoaderUtils.java
+++ b/tika-core/src/main/java/org/apache/tika/utils/ServiceLoaderUtils.java
@@ -38,9 +38,9 @@ public class ServiceLoaderUtils {
                 if (t1 == t2) {
                     return n1.compareTo(n2);
                 } else if (t1) {
-                    return 1;
-                } else {
                     return -1;
+                } else {
+                    return 1;
                 }
             }
         });
\end{lstlisting}
\caption{Example of a \texttt{git diff}}

    This changeset addresses \tika Issue \#1689.  The first half (in orange),
    shows the commit id, author name, date of commit, and the message
    associated with the change, followed by the actual diff of the change.
    Green lines (beginning with a single~\texttt{+}) denote addition lines, and
    red lines (beginning with a single~\texttt{-}) denote removals lines. Black
    or blue lines denote metadata about the change useful for applying the
    patch.  In particular, black lines (beginning with a single space)
    represent context lines.

\label{fig:diff}
\vspace{-10pt}
\end{figure*}
