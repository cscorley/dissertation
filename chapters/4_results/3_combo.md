## RP3: Combining and Configuring Changeset-based Topic Models {#sec:combo-results}

In this section, we will describe the results of the study outlined in Section
\ref{sec:combo-methodology}.

\cone asks whether a single topic model can be used for more than a single
task, specifically for feature location and developer identification. Tables
\ref{table:all_model_sweep} and \ref{table:all_corpus_sweep} show the summary
results over all subject systems for model construction and corpus
construction, respectively.  In the tables, we bold entries where the MRR is
highest for each of the two tasks and also highlight the row of the
configuration used throughout this dissertation.  Our goal is not to find which
configuration works best for each system and task, but rather to determine
whether one configuration is *capable* of producing acceptable results for both
tasks.

\todo{repeat the following test against each system, construct wilcoxon table?}

\newcommand{\optimalFLTmodel}{optimal model for FLT ($K=500$, $\alpha=2/K$, $\eta=auto$)}
\newcommand{\optimalDITmodel}{optimal model for DIT ($K=500$, $\alpha=5/K$, $\eta=auto$)}

\newcommand{\optimalFLTcorpus}{optimal corpus for FLT (additions, context, message)}
\newcommand{\optimalDITcorpus}{optimal corpus for DIT (context, message)}

When we consider all systems together for model construction (Table
\ref{table:all_model_sweep}), the both tasks perform best when $K=500$ and
$\eta=auto$, but differ when it comes to $\alpha$. FLT prefers the lower alpha,
$2/K$, while DIT is best with the highest alpha, $5/K$.  A Wilcoxon rank-sum
test reveals that the \optimalFLTmodel is statistically significant ($p<0.01$)
compared to the alternate with an effect size low at $r=0.2181$.  Likewise, a
Wilcoxon rank-sum test reveals that the \optimalDITmodel is not statistically
significant ($p=0.2262$) compared to the alternate.  This suggests that the DIT
is less sensitive to parameter changes, allowing the user to select the model
configuration that works best for FLT.

\attn{i think this is probably due to the less actual ranks possible}

When we consider all systems together for corpus construction (Table
\ref{table:all_corpus_sweep}), the both tasks perform best when including the
context and message, but differ when it comes to including additions. FLT
prefers additions to be included, while DIT does not.  Neither task performs
best when removals are included.  A Wilcoxon rank-sum test reveals that the
\optimalFLTcorpus is statistically significant ($p<0.01$) compared to the
alternate with an effect size of $r=0.1273$.  Likewise, a Wilcoxon rank-sum
test also reveals that the \optimalDITcorpus is statistically significant
($p<0.01$) compared to the alternate with an effect size of $r=0.2580$.  This
suggests that correct corpus construction plays a somewhat important role in
both tasks, but the effect of choosing an alternate over the optimal is low.


\ctwo asks what portions of a changeset are most critical for performance of
different tasks, specifically for feature location and developer
identification.  Table \ref{table:all_corpus_sweep} shows the summary results
over all subject systems. As in \cone, our goal is not to find which
configuration works best for each system and task, but rather to determine
whether a particular text source affects the tasks.

As seen in the results for \cone, the results for the corpus construction sweep
vary across systems and tasks.  Importantly, there does not seem to be any
particular configuration that is shared between systems or tasks.  For all
subject systems, both tasks perform best when including changeset context and
message text sources. FLT sees a slight increase in MRR ($0.0546$) when the
additions text source is included, while DIT slightly decreases in MRR
($0.038$).

\input{tables/combo_friedman_results}

Tables \ref{table:combo-friedman-flt} and \ref{table:combo-friedman-dit} show
the Friedman test results for FLT and DIT, respectively.  The Friedman test of
all subject systems shows significance for both FLT ($p < 0.01$) and DIT ($p <
0.01$), indicating a difference between configurations for each task.
Likewise, the Friedman test for each individual system shows significance for
both FLT ($p < 0.01$) and DIT ($p < 0.01$), with two exceptions.  The two
non-significant exceptions were \mahout FLT task with $p=0.4802$ and \tika DIT
task with $p=0.0578$.

A post-hoc test was conducted using Wilcoxon rank-sum test with Holm correction
for each possible configuration pairing (105 tests).  For combined
effectiveness measures of all subject systems, 49 pairs were statistically
significant at $p<0.01$ for the FLT task.  Similarly, for the DIT task,
combined results of all subject systems contains 86 pairs that are
statistically significant at $p<0.01$.

\todo{output the wilcoxon significant counts to the friedman results tables?}


