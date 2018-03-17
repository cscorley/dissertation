## Combining and Configuring Changeset-based Topic Models {#sec:combo-results}

In this section, I describe the results of the study outlined in Section
\ref{sec:combo-methodology}.

\cone asks whether a single topic model can be used for more than a single
task, specifically for feature location and developer identification. Tables
\ref{table:combo-flt-model-sweep-wilcox} and
\ref{table:combo-dit-model-sweep-wilcox} show the summary results over all
subject systems for model construction for the FLT and DIT tasks, respectively,
while Tables \ref{table:combo-flt-corpus-sweep-wilcox} and
\ref{table:combo-dit-corpus-sweep-wilcox} show the summary corpus construction
for each respective task (figures and data for all subject systems are
available in Appendices \ref{app:model} and \ref{app:corpus}).  The goal is not
to find which configuration works best for each system and task, but rather to
determine whether one configuration is *capable* of producing acceptable
results for both tasks.

\input{tables/landscape_model_sweep_wilcox}
\input{tables/landscape_corpus_sweep_wilcox}

\newcommand{\optimalFLTmodel}{optimal model for FLT ($K=500$, $\alpha=2/K$, $\eta=auto$)\xspace{}}
\newcommand{\optimalDITmodel}{optimal model for DIT ($K=500$, $\alpha=5/K$, $\eta=auto$)\xspace{}}

\newcommand{\optimalFLTcorpus}{optimal corpus for FLT (additions, context, message)\xspace{}}
\newcommand{\optimalDITcorpus}{optimal corpus for DIT (context, message)\xspace{}}

When I consider all systems together for model construction (Tables
\ref{table:combo-flt-model-sweep-wilcox} and
\ref{table:combo-dit-model-sweep-wilcox}), the both tasks perform best when
$K=500$ and $\eta=auto$, but differ when it comes to $\alpha$. FLT prefers the
lower alpha, $2/K$, while DIT is best with the highest alpha, $5/K$.  A
Wilcoxon rank-sum test reveals that the \optimalFLTmodel is statistically
significant ($p<0.01$) compared to the alternate with an effect size low at
$r=0.2181$.  Likewise, a Wilcoxon rank-sum test reveals that the
\optimalDITmodel is not statistically significant ($p=0.2262$) compared to the
alternate.  This suggests that the DIT is less sensitive to parameter changes,
allowing the user to select the model configuration that works best for FLT.

When I consider all systems together for corpus construction (Tables
\ref{table:combo-flt-corpus-sweep-wilcox} and
\ref{table:combo-dit-corpus-sweep-wilcox}), the both tasks perform best when
including the context and message, but differ when it comes to including
additions. FLT prefers additions to be included, while DIT does not.  Neither
task performs best when removals are included.  A Wilcoxon rank-sum test
reveals that the \optimalFLTcorpus is statistically significant ($p<0.01$)
compared to the alternate with an effect size of $r=0.1273$.  Likewise, a
Wilcoxon rank-sum test also reveals that the \optimalDITcorpus is statistically
significant ($p<0.01$) compared to the alternate with an effect size of
$r=0.2580$.  This suggests that correct corpus construction plays a somewhat
important role in both tasks, but the effect of choosing an alternate over the
optimal is low.

\ctwo asks what portions of a changeset are most critical for performance of
different tasks, specifically for feature location and developer
identification.  As in \cone, the goal is not to find which configuration works
best for each system and task, but rather to determine whether a particular
text source affects the tasks.  Tables \ref{table:combo-friedman-flt} and
\ref{table:combo-friedman-dit} show the Friedman test results for FLT and DIT,
respectively.

\input{tables/combo_friedman_results}

As seen in the results for \cone, the results for the corpus construction sweep
vary across systems and tasks.  Importantly, there does not seem to be any
particular configuration that is shared between systems or tasks.  For all
subject systems, both tasks perform best when including changeset context and
message text sources. FLT sees a slight increase in MRR ($0.0546$) when the
additions text source is included, while DIT slightly decreases in MRR
($0.038$).

The Friedman test of all subject systems shows significance for both FLT ($p <
0.01$) and DIT ($p < 0.01$), indicating a difference between configurations for
each task.  Likewise, the Friedman test for each individual system shows
significance for both FLT ($p < 0.01$) and DIT ($p < 0.01$), with two
exceptions.  The two non-significant exceptions were \mahout FLT task with
$p=0.4802$ and \tika DIT task with $p=0.0578$.

A post-hoc test was conducted using Wilcoxon rank-sum test with Holm correction
for each possible configuration pairing (105 tests).  For combined
effectiveness measures of all subject systems, 49 pairs were statistically
significant at $p<0.01$ for the FLT task.  Similarly, for the DIT task,
combined results of all subject systems contains 86 pairs that are
statistically significant at $p<0.01$.

To summarize, in \cone I found that the same topic model can be used in more
than one context, though more optimal configurations may exist on a per-context
basis.  In \ctwo I find that there are significant differences when choosing
from the possible elements of a changeset for corpus construction.
