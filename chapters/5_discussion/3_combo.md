## Combining and Configuring Changeset-based Topic Models {#sec:combo-discussion} 
The results for \crps in Section \ref{sec:combo-results} shows some significant
affects between different configurations of the topic model and corpus
construction.

### \coneq

\input{figures/combo/flt_rq1_all}
\input{figures/combo/dit_rq1_all}

Figures \ref{fig:combo:flt:rq1:all} and \ref{fig:combo:dit:rq1:all} show the
effectiveness measures for across all systems of the optimal and alternate
model configuration of the FLT and DIT tasks, respectfully (figures and data
for individual subject systems are available in Appendix \ref{app:model}).


\bookkeeper has the same configuration for both tasks.

\mahout varies the most for FLT with the highest effect size, but has the least
difference for DIT (can choose whatever is optimal for FLT). 

\openjpa

\pig 

\tika

\zookeeper

Likewise, Figure \ref{fig:combo:flt:rq2:all} and \ref{fig:combo:dit:rq2:all}
show the effectiveness measures for across all systems of the optimal and
alternate corpus construction of the FLT and DIT tasks, respectfully (figures
and data for individual subject systems are available in Appendix
\ref{app:corpus}).



Main takeaway:

In sum, there will always be improvement by hyper-optimizing the configuration
of a topic model and corpus construction.  It would appear okay to reuse the
same model for two tasks, as differences are often by one configuration
parameter and not statistically significant. Corpus construction, however,
would appear to require more consideration towards which task is more important
as there are statistically significant effects between the optimal and
alternate configurations.

<!--
Model:

1. Maximize the number of topics your system can handle
2. 1/K or auto-learned parameters will do just fine unless you have good reason
   to do all of this micro-optimizations
   -->


### \ctwoq

\input{figures/combo/flt_rq2_all}
\input{figures/combo/dit_rq2_all}

Figures \ref{fig:combo:flt:rq2:all} and \ref{fig:combo:dit:rq2:all} show the
effectiveness measures across all systems (figures and data for individual
subject systems are available in Appendix \ref{app:corpus}).

Main takeaway:

There are affects of choosing differing text sources.  It is usually best to
exclude removals.

Corpus:

1. There is a need to choose inputs during corpus construction.
2. Removals seem to usually degrade results, although not dramatically
3. Additions generally improve the results, likely because it was the code
   written that resolved the issue.  Message is the same.
4. Context inclusion seems less impactful, but is generally positive.

