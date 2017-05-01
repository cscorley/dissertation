## Combining and Configuring Changeset-based Topic Models {#sec:combo-discussion}

Model:

1. Maximize the number of topics your system can handle
2. 1/K or auto-learned parameters will do just fine unless you have good reason
   to do all of this micro-optimizations

Corpus:

1. There is a need to choose inputs during corpus construction.
2. Removals seem to usually degrade results, although not dramatically
3. Additions generally improve the results, likely because it was the code
   written that resolved the issue.  Message is the same.
4. Context inclusion seems less impactful, but is generally positive.


### \coneq

\input{figures/combo/flt_rq1_all}
\input{figures/combo/dit_rq1_all}

It seems OK to reuse the same model, but you can always improve results by
optimizing your configuration per task.

### \ctwoq

\input{figures/combo/flt_rq2_all}
\input{figures/combo/dit_rq2_all}

There are affects of choosing differing text sources.  It is usually best to
exclude removals.
