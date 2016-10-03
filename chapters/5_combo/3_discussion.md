## Discussion {#sec:combo-discussion}


### \coneq

In Table \ref{table:bookkeeper_model_sweep}, we see that \bookkeeper performs
best for each task with 500 topics (i.e., $K = 500$) and an automatically
learned $\alpha$. The FLT performs better with $\eta = 1/K$, while the DIT
performs better at $\eta = 2/K$. However, each configuration's other task does
not suffer from large performance drops. For example, the optimal FLT
configuration, $K=500, \alpha=auto, \eta=1/K$, does not lose much performance
for the DIT.

\mahout shows a different set of optimal parameters, as seen in Table
\ref{table:mahout_model_sweep}. Here, the DIT performs best with $K=500,
\alpha=auto, \eta=auto$, while the FLT performs best with $K=500, \alpha=5/K,
\eta=auto$. However, unlike \bookkeeper, performance for the FLT drops by half
($MRR=0.1705$) for the optimal DIT configuration. Likewise, the DIT performance
also drops for the optimal FLT configuration.

<!--
As \bookkeeper has optimal configurations for both FLT and DIT, there is no
choice to make.

\input{figures/combo/flt_rq1_bookkeeper}
\input{figures/combo/dit_rq1_bookkeeper}
-->

\input{figures/combo/flt_rq1_mahout}
\input{figures/combo/dit_rq1_mahout}

\input{figures/combo/flt_rq1_openjpa}
\input{figures/combo/dit_rq1_openjpa}

\input{figures/combo/flt_rq1_pig}
\input{figures/combo/dit_rq1_pig}

\input{figures/combo/flt_rq1_tika}
\input{figures/combo/dit_rq1_tika}

\input{figures/combo/flt_rq1_zookeeper}
\input{figures/combo/dit_rq1_zookeeper}

### \ctwoq


\input{figures/combo/flt_rq2_bookkeeper}
\input{figures/combo/dit_rq2_bookkeeper}

\input{figures/combo/flt_rq2_mahout}
\input{figures/combo/dit_rq2_mahout}

\input{figures/combo/flt_rq2_openjpa}
\input{figures/combo/dit_rq2_openjpa}

\input{figures/combo/flt_rq2_pig}
\input{figures/combo/dit_rq2_pig}

\input{figures/combo/flt_rq2_tika}
\input{figures/combo/dit_rq2_tika}

\input{figures/combo/flt_rq2_zookeeper}
\input{figures/combo/dit_rq2_zookeeper}
