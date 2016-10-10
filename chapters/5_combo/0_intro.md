# Combining and Configuring Changeset-based Topic Models {#chap:combo}

In this chapter, we explore an approach that uses a single changeset model for
both FLT and DIT tasks.  First, we describe our motivation in Section
\ref{sec:combo-motivation}. We then describe our study design in Section
\ref{sec:combo-design}.  Finally, we describe the results of the study (Section
\ref{sec:combo-results}) and discuss them in detail (Section
\ref{sec:combo-discussion}).


## Motivation {#sec:combo-motivation}

Topic model reuse for two tasks would halve the computational cost required for
model training.  This presumes, however, that the configuration choices made
for corpus construction and the model itself are acceptable for each task.
That is, the model used does not negatively impact either task due to
configuration.

@Biggers-etal_2014 were the first to explore the parameters of a LDA-based FLT.
Unfortunately, these findings for model training parameters may not directly
apply to a LDA-based DIT.  Further, there is no work on optimal configurations
when using a topic model for two tasks.  There is also evidence in the
literature that different configurations may be better suited for different
tasks [@Marcus-Poshyvanyk_2005; @Abadi-etal_2008].

Likewise, we must also make choice with respect to corpus construction, as LDA
can achieve higher performance by adjusting certain elements of a corpus
[@Biggers-etal_2014].  While we do not have enough source code in changesets to
be extract fully parsed elements -- such as comments, identifiers, literals,
and so on -- we do have structure in the changeset itself in the form of the
`diff` (see Figure \ref{fig:diff}).  That is, we have lines removed and added
that represent the change, and also lines for context for where the change is
to be applied.
