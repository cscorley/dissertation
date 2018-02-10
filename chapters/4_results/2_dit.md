## Developer Identification {#sec:dit-results}

In this section, we describe the results of the study outlined in Section
\ref{sec:dit-methodology}.

\input{tables/triage_rq1}

\done asks how well a topic model trained on changesets performs compared to
one trained on source code entities.  Table \ref{table:triage_rq1} summarizes
the results of each subject system.  In the table, we bold which of the two
MRRs is greater.  Since our goal is to show that training with changesets is
just as good, or better than, training on snapshots, we only care about
statistical significance when the MRR is in favor of snapshots.  While
statistical significance in favor of changesets is desirable, statistical
*insignificance* between snapshots and changesets is acceptable and also
desirable as it showcases that the changeset approach is on par with snapshots.
For example, with respect to \done, \openjpa is a favorable case for changesets
as it has a higher MRR, along with statistical significance ($p < 0.01$) and a
notably large effect size ($0.3642$).  Likewise, \tika displays a favorable
case for snapshots in terms of higher MRR, but does not achieve statistical
significance and is hence is not a definite unfavorable case.

We note an improvement in MRR for only 2 of the 6 systems when using
changesets.  \pig is the only system with an MRR in favor of snapshots that is
also statistically significant at $p < 0.01$ with an effect size of $0.64$.
Comparing all systems at once by combining all effectiveness measures,
snapshots show slight MRR improvement over changesets with statistical
significance.  This suggests that the changeset-based DIT is not on par with
snapshot-based DIT.

\input{tables/triage_rq2}

\dtwo asks how well a TM-based DIT would perform as it were to be used in
real-time.  This is a much closer evaluation of an DIT to it being used in an
actual development environment.  Table \ref{table:triage_rq2} summarizes the
results of each subject system.  In each of the tables, we bold which of the
two MRRs is greater.  Again, since our goal is to show that temporal
considerations must be given during DIT evaluation, we only care about
statistical significance when the MRR is in favor of batch.

There is an improvement in favor of historical simulation in MRR for only 1 of
the 6 systems, which is statistically significant at $p<0.01$.  Two of the 5
results in favor of batch changesets were statistically significant.  We note
that \pig, in favor of snapshots over batch changesets with statistical
significance for \done, is statistically significant in favor of historical
simulation over batch changesets for \dtwo.

Comparing all systems at once by combining all effectiveness measures,
batch changesets performs better than a full historical simulation, but is not
statistically significant.  This suggests that under historical simulation, the
accuracy of the DIT will fluctuate as a project evolves, which may indicate a
more accurate evaluation is possible with a historical simulation.  This aligns
with the result we see for FLT in the previous section.

To summarize, in \done we found changeset-based DITs are *not* as accurate as
snapshot-based DITs.  We find in \dtwo historical simulation reveals that the
accuracy of the changeset-based DIT is inconsistent as a project evolves, and
is lower than indicated by batch evaluation.
