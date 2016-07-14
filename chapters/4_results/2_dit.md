## Developer Identification {#results-dit}

In this section, we will describe the results of the study outlined in Section
\ref{method-flt}.

\input{tables/triage_rq1}

\done{} asks how well a topic model trained on changesets performs against one
trained on source code entities.  Table \ref{table:triage_rq1} summarizes the
results of each subject system.  In the table, we bold which of the two MRRs is
greater.  Since our goal is to show that training with changesets is just as
good, or better than, training on snapshots, we only care about statistical
significance when the MRR is in favor of snapshots.

We note an improvement in MRR for 2 of the 6 systems when using changesets.
Unfortunately, neither of these systems were statistically significant at
$p<0.01$.  Only 3 of the 4 systems with MRR in favor of snapshots were
statistically significant.  Hence, changeset topics do not seem to improve
performance over snapshot models for 4 of the 6 systems. However, only a single
system, Pig, presents a large spread in MRR. This is also reflected in the
effect sizes for each system.  Overall, snapshots perform better than
changesets.


\input{tables/triage_rq2}

\dtwo{} asks how well a simulation of using a topic model would perform as it
were to be used in real-time.  This is a much closer evaluation of an DIT to it
being used in an actual development environment.  Table \ref{table:triage_rq2}
summarizes the results of each subject system.  In each of the tables, we bold
which of the two MRRs is greater.  Again, since our goal is to show that
temporal considerations must be given during DIT evaluation, we only care about
statistical significance when the MRR is in favor of batch.

There is an improvement in MRR for only 3 of the 6 systems, one of which is
statistically significant at $p<0.01$.  None of the 3 results in favor of batch
changesets, were statistically significant.  However, the spread in MRR for
each system is relatively close, suggesting that historical simulation is on
par with batch changesets.  Overall, a full historical simulation performs
better than changesets trained in batch.



\input{figures/dit/rq1_bookkeeper}
\input{figures/dit/rq1_mahout}
\input{figures/dit/rq1_openjpa}
\input{figures/dit/rq1_pig}
\input{figures/dit/rq1_tika}
\input{figures/dit/rq1_zookeeper}
\input{figures/dit/rq1_overview}

\input{figures/dit/rq2_bookkeeper}
\input{figures/dit/rq2_mahout}
\input{figures/dit/rq2_openjpa}
\input{figures/dit/rq2_pig}
\input{figures/dit/rq2_tika}
\input{figures/dit/rq2_zookeeper}
\input{figures/dit/rq2_overview}
