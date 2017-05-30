## Combining and Configuring Changeset-based Topic Models {#sec:combo-discussion}

The results for \crp in Section \ref{sec:combo-results} shows significant
affects between different configurations of the topic model and corpus
construction.

### \coneq

In \cone, we ask whether it is feasible to use a single model for two tasks,
FLT and DIT.  We explore this question from two directions: the input to the
model, i.e., corpus construction, and the model configuration itself.  Each of
these directions contains choices that every application must make to train an
optimal model for the application's task.  However, to choose an optimal model
for two tasks, then some trade-offs must be considered and made.

Figures \ref{fig:combo:flt:rq1:all} and \ref{fig:combo:dit:rq1:all} show the
effectiveness measures for across all systems of the optimal and alternate
model configuration of the FLT and DIT tasks, respectfully (figures and data
for individual subject systems are available in Appendix \ref{app:model}).
Likewise, Figure \ref{fig:combo:flt:rq2:all} and \ref{fig:combo:dit:rq2:all}
show the effectiveness measures for across all systems of the optimal and
alternate corpus construction of the FLT and DIT tasks, respectfully (figures
and data for individual subject systems are available in Appendix
\ref{app:corpus}).

\input{figures/combo/flt_rq1_all}
\input{figures/combo/dit_rq1_all}
\input{figures/combo/flt_rq2_all}
\input{figures/combo/dit_rq2_all}

With respect to model configuration, some interesting results can be found.
For example, \bookkeeper has the same optimal configuration for both tasks, so
the no trade-offs must be made. \todo{say something nice about other 3 systems}

\mahout varied the most for FLT with the highest effect size, but has the least
difference for DIT, indicating that the application should defer to the FLT
configuration as DIT does not significantly suffer from this decision.  Figures
\ref{fig:combo:flt:rq1:mahout} and \ref{fig:combo:dit:rq1:mahout} show the
effectiveness measures of \mahout and showcase a unique property: if outliers
were to be excluded, the performance of DIT would be in favor of the alternate
configuration, i.e., both tasks could have the same optimal configuration.

\input{figures/combo/flt_rq1_mahout}
\input{figures/combo/dit_rq1_mahout}

Likewise, \openjpa varied the most for DIT with the highest effect size, but
did not have large effect size for FLT, again with the alternate FLT not
significantly suffering from choosing the optimal DIT configuration.  Figures
\ref{fig:combo:flt:rq1:openjpa} and \ref{fig:combo:dit:rq1:openjpa} show the
effectiveness measures of \openjpa and showcase's the same property as \mahout,
but for FLT performance.

\input{figures/combo/flt_rq1_openjpa}
\input{figures/combo/dit_rq1_openjpa}

For all subject systems, however, we do have a statistical significant result
when comparing the optimal FLT to it's alternate configuration (DIT optimal).
However, the effect size is not large and the difference in MRR insignificant,
indicating there are some queries which perform well in the optimal FLT
configuration but not in the alternate FLT configuration, and vice versa.
Interestingly, the configurations only vary by the choice for $\alpha$, while
number of topics ($K$) and $\eta$ are equal.

With respect to corpus construction, the choice of source text becomes more
critical than model parameters.  For two systems, \mahout and \pig, the
configurations have no overlapping sources, e.g., \mahout optimal FLT includes
context and messages, while optimal DIT only includes additions.  For \pig and
\zookeeper, there does not seem to be a easy choice as both tasks will lose
significant amounts of performance if one task is preferred over the other.

Surprisingly, \bookkeeper had the most interesting result, with an
insignificant difference between the FLT optimal and alternate, while DIT
performance had significant impact with a high effect size.  Figures
\ref{fig:combo:flt:rq2:bookkeeper} and \ref{fig:combo:dit:rq2:bookkeeper} show
the effectiveness measures of \bookkeeper, of which shows little to no outliers
for DIT.  The two configurations only vary by exclusion of line removals, and
seem to advocate for their exclusion for best performance.

\input{figures/combo/flt_rq2_bookkeeper}
\input{figures/combo/dit_rq2_bookkeeper}

\todo{dit seemed to be the task impacted more by corpus selection}

In sum, there will always be improvement by hyper-optimizing the configuration
of a topic model and corpus construction.  It would appear okay to reuse the
same model for two tasks, as differences are often by one configuration
parameter and not statistically significant. Corpus construction, however,
would appear to require more consideration towards which task is more important
as there are statistically significant effects between the optimal and
alternate configurations.

### \ctwoq

As we saw in \cone, it seems feasible to use a single model for two tasks, but
the choice of corpus construction seems most critical. In \ctwo, we explore
further just how critical those choices may be.

\todo{'Intuitive view' of which text source vs results. Why they may differ}

\todo{which source has the most negative impact? most positive?}


Main takeaway:

There are affects of choosing differing text sources.  It is usually best to
exclude removals.

Corpus:

1. There is a need to choose inputs during corpus construction.
2. Removals seem to usually degrade results, although not dramatically
3. Additions generally improve the results, likely because it was the code
   written that resolved the issue.  Message is the same.
4. Context inclusion seems less impactful, but is generally positive.

