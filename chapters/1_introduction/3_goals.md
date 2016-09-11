## Research Goals and Problems {#thesis-goals}

The primary research goal of this work is to evaluate the performance and
reliability of topic models built on the source code histories. This will
require configuring and executing studies in different contexts of software
maintenance work, such as feature location and developer identification.

Towards achieving this goal, I've identified three core research problems,
defined below.

### Effectively using software repository history for an online topic-modeling-based feature location technique to remove retraining costs

We investigate the usefulness of using changesets when constructing models
using online LDA for feature location.  Conventional feature location
techniques train models using only the source code in the form of a snapshot of
the source code.  We explore how to train models on the changesets, and then
using that model for inference of a source code snapshot.

### Effectively using software repository history for an online topic-modeling-based developer identification technique to remove retraining costs


Like feature location, many techniques train models using only a source code
snapshot. Developer identification diverges from feature location once a model
is obtained, using that model to find an appropriate developer with a myriad of
different techniques.  We investigate the usefulness of using changesets when
constructing models using online LDA for developer identification.
Conventional feature location techniques train models using only a snapshot of
the source code.  We explore how to train models on the changesets, and then
using that model for inference of an individual developer's word change
history.


### Effectively using a *single* changeset-based topic model for automating different software maintenance tasks

Here, we explore whether we can re-use the same model for different tasks.  In
particular, since topic models are sensitive to parameter selection
[@Biggers-etal_2014], we perform parameter sweeps across both tasks of feature
location and developer identification.  We seek, per project, an optimal
parameter configuration that works well on either task.  Further, as changesets
themselves have different features, such as added, removed, and context lines,
we investigate which seem to be most beneficial to each approach.
