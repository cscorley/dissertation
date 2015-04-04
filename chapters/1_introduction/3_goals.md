## Research Goals and Problems {#thesis-goals}

The primary research goal of this proposal is to evaluate the performance and
reliability of topic models built on the source code histories. This will
require configuring and executing studies in different contexts of software
maintenance work, such as feature location and developer identification.

A secondary goal is to create a practical framework for building models that is
usable in different contexts. This will require building a prototype framework
usable by both researchers and practitioners.

Towards achieving these goals, I've identified three core research problems,
defined below.

Research Problem 1 (RP1)
:   How does training a topic model on changesets affect the performance of a
topic-modeling-based feature location techinque?

Research Problem 2 (RP2)
:   How does training a topic model on changesets affect the performance of a
topic-modeling-based developer identification techinque?

Research Problem 3 (RP3)
:   Can a single topic model trained on changesets be effectively used in both
feature location and developer identification techniques?

Essentially, we want to know whether using changesets in a topic-modeling-based
tool is beneficial and whether we can automate different tasks using the same
topic model. RP1 and RP2 target the former, and the latter by RP3.

RP3, of course, is dependent on the results of RP1 and RP2. Should RP1 and RP2
show that changesets are *not* useful in these two contexts, it may appear to
not be worth investigating RP3 further. Even in this case, time spent
validating configurations may give way to improvements in RP1 and RP2.
