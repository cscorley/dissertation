# Conclusion {#chap:conclusion}

In this work, we...

This work explores a changeset-based approach and evaluates the approach
against the state-of-the-art snapshot-based topic model search engine in two
contexts: feature location and developer identification.  We investigate the
performance of a changeset-based model in a historical simulation, wherein we
see how a stream of changes would impact issue queries closer to real time.
Finally, we discuss an approach for using a singular topic model for both of
these tasks and consider configuration needs of such a multi-tasked model.

For \frp, feature location, we found that...
Also methods, classes...  [@Corley-etal_2015]

We found for developer identification, in \drp, that...

Finally, in \crp, we explore whether using the same changeset-based model for
two different tasks is feasible and what configuration considerations might
need to be taken to construct a successful model.

On using LDA...


## Future Work {#sec:conclusion-future}

TODO:

- Need to look at closer at online parameters
    - Windowing: how much "lag" is acceptable in a historical simulation, e.g.,
      can we use a standard sized mini-batch and still remain robust?
- Replicate to a "temporal" snapshot evaluation -- will take time
- Replicate to other online models -- LSI, D2V when possible
- Language models (trained on N Java projects) vs single-project models
- Streaming models: This work allows for models to take in streams of data,
  e.g., from Github, to create models that can be used in general cases.
- Dependencies: update a model with text from dependencies as they are updated
- Need to investigate why failures happen (my feeling is that they fail because
  the goldsets are bad -- e.g., the files changed by an issue were not in the
  corpus at query time)

- Randomness and runs:
    - However, LDA is known to get "stuck" in local minima [@Binkley-etal_2014]
      due to its non-convexity.  Evaluating and comparing techniques based on
      single runs does not show whether one is somehow better or more effective
      than another.  In order to accurately judge an approach in comparison to
      another, we must run multiple experiments to show that one approach
      typically scores higher than another.  This allows for us to eliminate
      outlier results in order to create a more fair comparison.

- [@Huo-etal_2014] finds differences in bug reports (i.e., the queries) written
  by experts vs non-experts.  The found statistically significant differences
  in all four of their tests while evaluating the VSM-based FLT
  [@Zhou-etal_2012], but only one for their DIT, a technique inspired by
  @Anvik-etal_2006.

    

## Last Words {#sec:conclusion-final}

