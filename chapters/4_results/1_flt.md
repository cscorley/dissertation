## Feature Location {#results-flt}

In this section, we will describe the results of the study outlined in Section
\ref{method-flt}.

\input{tables/feature_location_rq1}

RQ 3.3.1 asks how well a topic model trained on changesets performs against one
trained on source code entities.  Table \ref{table:feature_location_rq1}
summarizes the results of each subject system when evaluated at the file-level.
In the table, we bold which of the two MRRs is greater.  Since our goal is to
show that training with changesets is just as good, or better than, training on
snapshots, we only care about statistical significance when the MRR is in favor
of snapshots.

We note no improvement in MRR for any 6 systems when using changesets.
However, only 1 of the 6 systems with MRR in favor of snapshots were
statistically significant at $p < 0.01$.  Hence, snapshots topics do not seem
to improve performance over changeset models for 5 of the 6 systems.  Overall,
snapshots perform better than changesets.

\input{tables/feature_location_rq2}

RQ 3.3.2 asks how well a simulation of using a topic model would perform as it
were to be used in real-time.  This is a much closer evaluation of an FLT to it
being used in an actual development environment.  Table
\ref{table:feature_location_rq2} summarizes the results of each subject system
when evaluated at the file-level.  In each of the tables, we bold which of the
two MRRs is greater.  Again, since our goal is to show that temporal
considerations must be given during FLT evaluation, we only care about
statistical significance when the MRR is in favor of batch.

There is an improvement in MRR for only 1 of the 6 systems, which is not
statistically significant at $p<0.01$.  Four of the 5 results are in favor of
batch changesets, were statistically significant, with the fifth system, Tika,
close.  Overall, batch changesets performs better than a full historical
simulation.

