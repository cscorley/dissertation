## Discussion {#sec:combo-discussion}

In Table \ref{table:bookkeeper_model_sweep}, we see that BookKeeper performs
best for each task with 500 topics (i.e., $K = 500$) and an automatically
learned $\alpha$. The FLT performs better with $\eta = 1/K$, while the DIT
performs better at $\eta = 2/K$. However, each configuration's other task does
not suffer from large performance drops. For example, the optimal FLT
configuration, $K=500, \alpha=auto, \eta=1/K$, does not lose much performance
for the DIT.

Mahout shows a different set of optimal parameters, as seen in Table
\ref{table:mahout_model_sweep}. Here, the DIT performs best with $K=500,
\alpha=auto, \eta=auto$, while the FLT performs best with $K=500, \alpha=5/K,
\eta=auto$. However, unlike BookKeeper, performance for the FLT drops by half
($MRR=0.1705$) for the optimal DIT configuration. Likewise, the DIT performance
also drops for the optimal FLT configuration.

### \coneq


### \ctwoq
