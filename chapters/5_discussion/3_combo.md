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
the choice of corpus construction seems most critical.  In \ctwo, we explore
further just how critical those choices may be.  Indeed, we see in our results
in Section \ref{sec:combo-results} that choice of text source is significant in
all but one subject system for each task, or two insignificant results.

Our changeset corpus sweep was completed on four elements: additions $(A)$
context $(C)$, messages $(M)$, and removals $(R)$.  Figure \ref{fig:diff} shows
these four elements.  Intuitively, it makes sense to always include additions,
as they represent the new words (code) that represent the code that was being
worked on at that moment.  Likewise, the message is also an intuitive inclusion
as it contains words that describe the change itself in natural language, which
may help the model learn words more likely to be used in queries.  It may not
make sense, however, to include both context and removals during corpus
construction as they would increase noise of certain words, e.g., over valuing
words that have already appeared in additions over and over again, as in
context words, and duplicating value of words that have already appeared in
additions when they are no longer valid, as in removed words.

\todo{update git diff example with message}

\input{tables/all_corpus_sweep}

To gain insight into whether a particular source is detrimental to the
performance, we can compare MRRs of configurations that include a source to the
same configuration without that particular text source, e.g., for the additions
text source, we can compare configuration $(A, R, C)$, which includes
additions, removals, and context, to configuration $(R, C)$, which includes
removals and context.  Table \ref{table:all_corpus_sweep} shows all
configurations and their MRRs for each task of all subject systems.  With our
example, we can see that configuration $(A, R, C)$ outperforms configuration
$(R, C)$ for both tasks.  Indeed, for all seven possible configuration pairs,
as shown in Table \ref{table:versus-wilcox-all-flt-additions}, additions
improve the MRR of all configurations for FLT.  Table
\ref{table:versus-wilcox-all-dit-additions} shows DIT performance degrades
under two configurations; one of the two, $(A, C, M)$, being the optimal DIT
configuration $(C, M)$, and the other configuration, $(A, C)$, underperforming
the corpus only containing context $(C)$.

\input{tables/versus-wilcox-all-flt-additions}
\input{tables/versus-wilcox-all-dit-additions}

For the context text source, we see a similar result as additions in Tables
\ref{table:versus-wilcox-all-flt-context} and
\ref{table:versus-wilcox-all-dit-context}.  For DIT, all seven pairs improve
when context is included.  Two configurations, $(A, R, C)$ and $(A, C)$,
degrade in performance for the FLT task while all other configurations see
improvements.  We also note that the context text source is included in both
optimal configurations.  Together, this suggests that context is worthwhile for
inclusion, which does not align with our intuitive view for this source.

\input{tables/versus-wilcox-all-flt-context}
\input{tables/versus-wilcox-all-dit-context}

For messages, we see improvements in MRR for nearly all including
configurations, except for one configuration in each task. As seen in Table
\ref{table:versus-wilcox-all-flt-message}, the configuration $(A, R, M)$
performs worse than configuration $(A, R)$ for FLT.  The DIT configuration $(A,
C, M)$ worse than the configuration $(A, C)$ (Table
\ref{table:versus-wilcox-all-dit-message}).  Again, both optimal configurations
contain the message text source.  This aligns with our intuitive view that
messages would benefit the model and suggests they would be included.

<!-- did bookeeper perf degrade when adding message source because of
     duplication in changes.txt ? -->

\input{tables/versus-wilcox-all-flt-message}
\input{tables/versus-wilcox-all-dit-message}

The removal text source, however, is the only source that performs generally
worse when included.  Tables \ref{table:versus-wilcox-all-flt-removals} and
\ref{table:versus-wilcox-all-dit-removals} show the Wilcoxon test results of
removal inclusion and exclusion for FLT and DIT, respectively.  Overall, for 7
of the configuration pairs, including removals had a negative impact, while
only 6 of the configuration pairs had a positive impact.  Neither of the
optimal configurations include removals.  This suggests that removals should be
used with caution, and also aligns with our intuitive view that we would expect
them to be harmful.

\input{tables/versus-wilcox-all-flt-removals}
\input{tables/versus-wilcox-all-dit-removals}

In sum, there are affects of choosing differing text sources, as shown in
results Section \ref{sec:combo-results}.  It is usually best to exclude
removals and include additions, context, and messages.  This tends to match our
intuitive view that removals would be detrimental to the performance of our FLT
and DIT.

<!--
Corpus:

1. There is a need to choose inputs during corpus construction.
2. Removals seem to usually degrade results, although not dramatically
3. Additions generally improve the results, likely because it was the code
   written that resolved the issue.  Message is the same.
4. Context inclusion seems less impactful, but is generally positive.
-->


