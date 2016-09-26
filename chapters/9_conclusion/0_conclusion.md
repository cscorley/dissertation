# Conclusion {#chap:conclusion}

welp, here's what went well/wrong, and what to try next.



## Discussion {#sec:conclusion-discussion}

\todo{these comments need to be re-written...}

\todo{explain difference between batch algo and online}
\todo{explain why you must repeat corpora to use online for batch}
\todo{explain why you must repeat corpora to get a converged model online}
On using LDA...

However, LDA is known to get "stuck" in local minima [@Binkley-etal_2014] due
to its non-convexity.  Evaluating and comparing techniques based on single runs
does not show whether one is somehow better or more effective than another.  In
order to accurately judge an approach in comparison to another, we must run
multiple experiments to show that one approach typically scores higher than
another.  This allows for us to eliminate outlier results in order to create a
more fair comparison.


[@Huo-etal_2014] finds differences in bug reports (i.e., the queries) written
by experts vs non-experts.  The found statistically significant differences in
all four of their tests while evaluating the VSM-based FLT [@Zhou-etal_2012],
but only one for their DIT, a technique inspired by @Anvik-etal_2006.

## Future Work {#sec:conclusion-future}

TODO:

- Need to look at closer at online parameters
- Replicate to a "temporal" snapshot evaluation -- will take time
- Replicate to other online models -- LSI, D2V when possible
- Language models (trained on N Java projects) vs single-project models
- This work allows for models to take in streams of data, e.g., from Github, to
create models that can be used in general cases.
- Dependencies: update a model with text from dependencies as they are updated

## Last Words {#sec:conclusion-final}

