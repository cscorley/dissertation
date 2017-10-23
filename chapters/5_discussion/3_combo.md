## Combining and Configuring Changeset-based Topic Models {#sec:combo-discussion}

The results for \crp in Section \ref{sec:combo-results} shows significant
effects between different configurations of the topic model and corpus
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
model configuration of the FLT and DIT tasks, respectively (figures and data
for individual subject systems are available in Appendix \ref{app:model}).
Likewise, Figure \ref{fig:combo:flt:rq2:all} and \ref{fig:combo:dit:rq2:all}
show the effectiveness measures for across all systems of the optimal and
alternate corpus construction of the FLT and DIT tasks, respectively (figures
and data for individual subject systems are available in Appendix
\ref{app:corpus}).

\input{figures/combo/flt_rq1_all}
\input{figures/combo/dit_rq1_all}
\input{figures/combo/flt_rq2_all}
\input{figures/combo/dit_rq2_all}

With respect to model configuration, some interesting results can be found.
For example, \bookkeeper has the same optimal configuration for both tasks, so
no trade-offs must be made.
\todo{say something nice about other 3 systems}

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

\input{tables/all_corpus_sweep}

To gain insight into whether a particular source is beneficial, or detrimental,
to performance of a task, we can compare MRRs of configurations that include a
source to the same configuration without that particular text source, e.g., for
the additions text source, we can compare configuration $(A,R,C)$, which
includes additions, removals, and context, to configuration $(R,C)$, which
includes removals and context, but excludes additions.  We use this comparison,
in conjunction with the mean reciprocal rank (MRR) and the Wilcoxon signed-rank
test to explore our various text sources.  Table \ref{table:all_corpus_sweep}
summarizes all configurations and their MRRs for each task of all subject
systems.  With our example, we can see that configuration $(A,R,C)$ outperforms
configuration $(R,C)$ for both tasks.  Note that for configurations
with a singular text source, such as $(A)$ for additions, there can be no
comparison made because the exclusion of additions leaves us with the empty
corpus.

Below we discuss these comparisons for both the FLT and DIT tasks.  Each
includes a discussion concerning the comparisons as applied to issues across
all subject systems.  Appendix \ref{app:comparison} contains comparisons tables
for each individual subject system.

#### Additions {#discussion:additions}

\input{tables/versus-wilcox-all-flt-additions}

For all seven possible configuration pairs, as shown in Table
\ref{table:versus-wilcox-all-flt-additions}, additions improve the MRR of all
configurations for FLT.  Two of these results, $(A,C)$ and $(A,M)$ are
statistically insignificant using Wilcoxon and the effect sizes of the
significant five are low, ranging in the teens.  The comparison with removals,
$(A,R)$ and $(R)$, had a notable effect size that nearly doubles the next
largest effect size.  This suggests that including additions in an FLT is not
harmful and may show gains in performance, even when paired with potentially
detrimental sources, such as removals (see following subsection
\ref{discussion:removals}).

\input{tables/versus-wilcox-all-dit-additions}

Table \ref{table:versus-wilcox-all-dit-additions} shows DIT performance
addition inclusion degrades under two configurations: the first, $(A,C,M)$,
being paired with the optimal DIT configuration $(C,M)$, and the second,
$(A,C)$, underperforming the corpus only containing context $(C)$.  Six of
these configurations were significant with effect sizes varying between low
($0.1686$) and moderate ($0.4174$). We note that the top four largest effect
sizes were in favor of including additions.  This suggests that including
additions in an DIT is likely beneficial, but the choice is not necessarily
straight-forward and caution is advised.

#### Context {#discussion:context}

\input{tables/versus-wilcox-all-flt-context}

In Table \ref{table:versus-wilcox-all-flt-context}, we see five out of seven
configuration comparisons favoring context inclusion for the FLT task.
Strikingly, only one out of all comparisons was statistically significant,
$(C,M)$ compared to $(M)$.  Two configurations, $(A,R,C)$ and $(A,C)$, degrade
in performance for the FLT task while all other configurations see
improvements.  For these two, the results were both non-significant and each
MRR spread was low.  Indeed, all MRR spreads were close, with the largest
difference being $0.0525$ between $(R,C,M)$ and $(R,M)$.  This suggests that
for the FLT task, context inclusion is neither notably beneficial nor
detrimental.  We note that, however, the optimal configuration for the FLT,
$(A,C,M)$, includes context, so we cannot advocate for its exclusion.

\input{tables/versus-wilcox-all-dit-context}

For the DIT task, however, we get very different results than for FLT, as shown
in Table \ref{table:versus-wilcox-all-dit-context}.  All seven pairs improve
when context is included, and all seven are statistically significant with
somewhat moderate ($0.2445$) to moderate ($0.4001$) effect sizes.  We also note
that the context text source is included in the optimal configuration for DIT.
Together, this suggests that context is worthwhile for inclusion, which does
not align with our intuitive view for this source.

#### Messages {#discussion:messages}

\input{tables/versus-wilcox-all-flt-message}

We see improvements in the FLT task MRR for nearly all message-including
configurations, except for one configuration. As seen in Table
\ref{table:versus-wilcox-all-flt-message}, the configuration $(A,R,M)$ performs
worse than configuration $(A,R)$ for FLT.  None of the configurations, however,
were statistically significant.  Thus, like the context source, the inclusion
or exclusion of messages is inconclusive under the FLT task and the message
source is included in the optimal FLT configuration $(A,C,M)$.

\input{tables/versus-wilcox-all-dit-message}

Under the DIT task, Table \ref{table:versus-wilcox-all-dit-message}, we again
see only one configuration that does not favor the inclusion of messages:
$(A,C,M)$ compared to $(A,C)$.  However, two of the six in favor of inclusion
were statistically significant, although each has low effect sizes.  Again, the
optimal DIT configuration, $(C,M)$, contain the message text source.  This
aligns with our intuitive view that messages would benefit the model and
suggests they should be included.

<!-- did bookeeper perf degrade when adding message source because of
     duplication in changes.txt ? -->

#### Removals {#discussion:removals}

\input{tables/versus-wilcox-all-flt-removals}

Table \ref{table:versus-wilcox-all-flt-removals} shows the Wilcoxon test
results of removal inclusion and exclusion for FLT.  We see that there is only
one statistically significant result, and that it favors the intuitive view of
excluding removals.  Only two of the other six results also favor exclusion.
However, it is notable that removals are not included in the optimal FLT
configuration.  This suggests that, under the FLT, it is largely inconclusive
whether removals should be included or excluded.

\input{tables/versus-wilcox-all-dit-removals}

We see many more significant results for the DIT task, as shown in Table
\ref{table:versus-wilcox-all-dit-removals}.  Including removals had a negative
impact for five of the configuration pairs, all of which were significant with
low ($0.1162$) to moderate ($0.4621$) effect sizes.  Two of the configuration
comparisons favored inclusion of removals, with one being statistically
significant with a somewhat low effect size of $0.1847$.  As in the FLT task,
again removals do not make an appearance in the optimal configuration.  This
suggests that removals should be used with caution, and also aligns with our
intuitive view that we would expect them to be harmful.

