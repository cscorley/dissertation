# Conclusion {#chap:conclusion}

This work explores a changeset-based approach and evaluates the approach
against the state-of-the-art snapshot-based topic model search engine in two
contexts: feature location and developer identification.  We investigate the
performance of a changeset-based model in a historical simulation, wherein we
see how a stream of changes would impact issue queries closer to real time.
Finally, we discuss an approach for using a singular topic model for both of
these tasks and consider configuration needs of such a multi-tasked model.

For \frp, feature location, we addressed two research questions regarding the
performance of a TM-based FLT trained on changesets.  First, we compare a batch
TM-based FLT trained on the changesets of a project's history to one trained on
the snapshot of source code entities.  We found that changesets can perform as
well as or better than snapshots.  Second, we compare a batch TM-based FLT
trained on changesets to a historical simulation of a TM-based FLT trained on
the same changesets over time.  We show that the historical simulation more
accurately portrays how a FLT would execute in a real environment.  This study
extended @Corley-etal_2015 to the file-level granularity, where we found
similar results for methods and classes.

We found for developer identification, in \drp, an analogous conclusion as in
\frps.  Again, we compare a batch TM-based FLT trained on the changesets of a
project's history to one trained on the snapshot of source code entities and
find the former performs as well as the latter.  Next, we compare a batch
TM-based FLT trained on changesets to a historical simulation of a TM-based DIT
trained on the same changesets over time.  We show that the historical
simulation more accurately portrays how a DIT would execute in a real
environment.  We also see under historical simulation results that show less
fluctuation for DIT than FLT, though some fluctuation does exist.

Finally, in \crp, we explore whether using the same changeset-based model for
two different tasks is feasible and what configuration considerations might
need to be taken to construct a successful model.  We found that the same model
can be reused for two tasks, so long as trade-offs can be made.  It will always
be possible to optimize parameters and inputs for a particular task and subject
system, but our study suggests it is possible to have acceptable performance
across tasks.  However, we found there were significant effects in corpus
construction, which will require more careful consideration when choosing to
optimize for a task.

My personal perspective from industry is as follows.  First, search tools,
i.e., feature location tools, aren't used by developers because they often
aren't needed, even in large systems.  However, the caveat to this is that the
system I've encountered are generally modular and abstracted properly enough to
mitigate this issue.  I would like to see more work towards feature location as
applied to poorly engineered systems, which may face new problems.  Rather, I
see feature location tools being more useful for feature discovery for external
users and stakeholders, who are often not aware of internal system
implementation details or progress.

I do believe there is much more usefulness in a developer identification tool.
Anecdotally, I often have the need to find other developers to gain perspective
as to *why* a system behaves a certain way.  Additionally, often it seems that
external users and stakeholders need to be able to quickly find a developer to
gain similar perspectives.  The conundrum we currently find ourselves in is
that the typical DIT will ultimately rely on an FLT or variant thereof.  Hence,
while I see the most impact in industry with improving DITs, there will also be
a need to continue to work towards improving FLTs and the insights gained will
impact both.

Our results encourage the idea that there is still much to explore in the area
of feature location and developer identification.  What other untapped
resources might be available?  We show changesets are yet another viable
resource researchers and practitioners should be taking advantage of for the
feature location task.  For example, future work includes investigating
whether, along with the message text source, code reviews are valuable.
Likewise, it may also be beneficial to begin including changes to other systems
the subject system is dependent on, as call-site inclusion may benefit the
model [@Bassett-Kraft_2013].

Our results also show that research remains not only in improving accuracies of
FLTs and DITs, but also in solving the practical aspects of building FLTs and
DITs that are robust *and* agile enough to keep up with fast-changing software.
This includes work not just with topic models, such as LDA, but promising deep
learning models, such as Doc2Vec [@Corley-etal_2015a].  We hope future work
with deep learning models includes extension of our historical simulation work
once more of these deep learning algorithms can be updated online, instead of
in batch.

Additional future work exists in regard to configuration.  In a changeset it
may be desirable to parse further for source code entities using island grammar
parsing [@Moonen_2001].  As shown, it is desirable to only use portions of the
changeset, hence extracting changes between the abstract syntax trees
[@Fluri-etal_2007] may be just as fruitful for gaining more precise changesets.
The experiments explored in this work were non-exhaustive.  For example, our
corpus construction sweep for DIT only included a sweep of the model corpus,
i.e., the source changesets, but not of the indexed corpus, i.e.  the developer
profile corpus, which was only the default configuration of $(A, R, C)$.  Most
importantly, like previous work [@Biggers-etal_2014], it would be wise to
further investigate the two online LDA variables, $\tau_0$ and $\kappa$, to
measure their effect on our historical simulation.

We also would like to expand the historical simulation parts of this study to
include both snapshots and changesets, as it would be useful to compare results
between batch snapshots and simulated snapshots.  We did not conduct a
historical evaluation of the snapshot approaches due to the brute-force nature
of the approach increasing the amount of time the experiment would take.  In
this future work, a new model would be constructed for each issue at the time
of the query, rather than a single model constructed at the end of a release
cycle.  Performing a historical snapshot experiment would also likely decrease
the number of failures that occur during query-time, as the model and index
would be more representative of the code that that time.  However, there has
yet to be an in-depth study, to our best knowledge, of why failures occur in
the snapshot approach.

\todo{confirm 12 failures} We found that during our DIT evaluation, we had 12
query failures.  This was due to ....  Future work towards resolving these
failures could include integrating "insider knowledge" about when new members
join a team or project.  This sort of insight could also boost DIT performance
once members that have left a team or project are no longer being recommended.

Finally, a closer look at the experimental approach used in modern FLT and DIT
is needed, in particular how models vary with different random starting states.
We have observed it possible to change the result of an experiment by simply
re-running the experiment without setting a random seed, i.e., without setting
a random seed before an experiment the results are not reproducible.  Topic
models, like LDA, are known to get "stuck" in local minima [@Binkley-etal_2014]
due to its non-convexity.  Evaluating and comparing techniques based on single
runs does not show whether one is somehow better or more effective than
another.  In order to accurately judge an approach in comparison to another, we
must run multiple experiments to show that one approach typically scores higher
than another.  This allows for us to eliminate outlier results in order to
create a more fair comparison.
