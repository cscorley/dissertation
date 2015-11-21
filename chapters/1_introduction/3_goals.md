## Research Goals and Problems {#thesis-goals}

The primary research goal of this proposal is to evaluate the performance and
reliability of topic models built on the source code histories. This will
require configuring and executing studies in different contexts of software
maintenance work, such as feature location and developer identification.

Towards achieving this goal, I've identified three core research problems,
defined below.

### Research Problem 1 (RP1):  Effectively using software repository history for an online topic-modeling-based feature location technique to remove retraining costs

We investigate the usefulness of using changesets when constructing models
using online LDA for feature location.  Conventional feature location
techniques train models using only the source code in the form of a snapshot of
the source code.  We explore how to train models on the changesets, and then
using that model for inference of a source code snapshot.

### Research Problem 2 (RP2):   Effectively using software repository history for an online topic-modeling-based developer identification technique to remove retraining costs


Like feature location, many techniques train models using only a source code
snapshot. Developer identification diverges from feature location once a model
is obtained, using that model to find an appropriate developer with a myriad of
different techniques.  We investigate the usefulness of using changesets when
constructing models using online LDA for developer identification.
Conventional feature location techniques train models using only a snapshot of
the source code.  We explore how to train models on the changesets, and then
using that model for inference of an individual developer's word change
history.


### Research Problem 3 (RP3):   Effectively using a *single* changeset-based topic model for automating different software maintenance tasks

Essentially, we want to know whether using changesets in a topic-modeling-based
tool is beneficial and whether we can automate different tasks using the same
topic model. RP1 and RP2 target the former, and the latter by RP3.

RP3, of course, is dependent on the results of RP1 and RP2. Should RP1 and RP2
show that changesets are *not* useful in these two contexts, it may appear to
not be worth investigating RP3 further. Even in this case, time spent
validating configurations may give way to improvements in RP1 and RP2.
