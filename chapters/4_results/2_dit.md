## RP2: Developer Identification {#sec:dit-results}

In this section, we will describe the results of the study outlined in Section
\ref{sec:dit-methodolody}.

\input{tables/triage_rq1}

\done asks how well a topic model trained on changesets performs against one
trained on source code entities.  Table \ref{table:triage_rq1} summarizes the
results of each subject system.  In the table, we bold which of the two MRRs is
greater.  Since our goal is to show that training with changesets is just as
good, or better than, training on snapshots, we only care about statistical
significance when the MRR is in favor of snapshots.  Statistical significance
in favor of changesets is desirable.  Statistical *insignificance* between
snapshots and changesets is acceptable and also desirable as it showcases that
the changeset approach is on par with snapshots.

We note an improvement in MRR for only 2 of the 6 systems when using
changesets.  Comparing all systems at once, snapshots show slight MRR
improvement over changesets with statistical significance.  \pig is the only
system with an MRR in favor of snapshots that is also statistically significant
at $p < 0.01$.  For \pig, however, the difference in MRR is negligible (2.54%).
This suggests that changeset-based TMs are on par with snapshot-based TMs,
albeit barely.

\input{tables/triage_rq2}

\dtwo asks how well a simulation of using a topic model would perform as it
were to be used in real-time.  This is a much closer evaluation of an DIT to it
being used in an actual development environment.  Table \ref{table:triage_rq2}
summarizes the results of each subject system.  In each of the tables, we bold
which of the two MRRs is greater.  Again, since our goal is to show that
temporal considerations must be given during DIT evaluation, we only care about
statistical significance when the MRR is in favor of batch.

There is an improvement in favor of historical simulation in MRR for only 1 of
the 6 systems, which is statistically significant at $p<0.01$.  Two of the 5
results in favor of batch changesets were statistically significant, with the
last system.  Overall, batch changesets performs better than a full historical
simulation, but is not statistically significant.  This suggests that under
historical simulation, the accuracy of the DIT will fluctuate slightly as a
project evolves, but will be mostly negligible.
