## RP1: Feature Location {#sec:flt-results}

In this section, we will describe the results of the study outlined in Section
\ref{sec:flt-methodology}.

\input{tables/feature_location_rq1}

\fone asks how well a topic model trained on changesets performs against one
trained on source code entities.  Table \ref{table:feature_location_rq1}
summarizes the results of each subject system when evaluated at the file-level.
In the table, we bold which of the two MRRs is greater.  Since our goal is to
show that training with changesets is just as good, or better than, training on
snapshots, we only care about statistical significance when the MRR is in favor
of snapshots.  That is, statistical significance in favor of changesets is
desirable.  However, statistical *insignificance* between snapshots and
changesets is acceptable and also desirable as it showcases that the changeset
approach is on par with snapshots.  For example, with respect to \fone,
\openjpa is a favorable case for changesets as it has a higher MRR, along with
statistical significance ($p < 0.01$) and a notably large effect size
($0.3867$).  Likewise, \tika displays a favorable case for snapshots in terms
of higher MRR, but does not achieve statistical significance and is hence is
not a definite unfavorable case.

We note an improvement in MRR for 4 of the 6 systems when using changesets.
\mahout is the only system with an MRR in favor of snapshots and statistically
significant at $p < 0.01$ with the greatest effect size of all systems
($0.4556$).  For \mahout, however, the difference in MRR is negligible (2.54%).
Comparing all systems at once by combining all effectiveness measures,
changesets show slight MRR improvement over snapshots with statistical
significance.  This suggests that changeset-based TMs are on par with
snapshot-based TMs, and for the majority of systems, the better choice.

\input{tables/feature_location_rq2}

\ftwo asks how well a simulation of using a topic model would perform as it
were to be used in real-time.  This is a much closer evaluation of an FLT to it
being used in an actual development environment.  Table
\ref{table:feature_location_rq2} summarizes the results of each subject system
when evaluated at the file-level.  In each of the tables, we bold which of the
two MRRs is greater.  Again, since our goal is to show that temporal
considerations must be given during FLT evaluation, we only care about
statistical significance when the MRR is in favor of batch.

There is an improvement in favor of historical simulation in MRR for only 1 of
the 6 systems, which is not statistically significant at $p=0.96$.  Four of the
5 results in favor of batch changesets were statistically significant, with the
last system, \tika, insignificant at $p=0.03$.  Overall, batch-trained
changeset-based TMs perform better than a full historical simulation with
statistical significance.  This suggests that under historical simulation, the
accuracy of the FLT will fluctuate as a project evolves, which may indicate a
more accurate evaluation is possible with a historical simulation.
