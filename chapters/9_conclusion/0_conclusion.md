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
of feature location and developer identification. What other untapped resources
might be available?  We show changesets are yet another viable resource
researchers and practitioners should be taking advantage of for the feature
location task.  For example, future work includes investigating along with the
message text source, whether code reviews are valuable to model performance.
Our results also show that research remains not only in improving accuracies of
FLTs and DITs, but also in solving the practical aspects of building FLTs and
DITs that are robust *and* agile enough to keep up with fast-changing software.

Future work includes deploying this approach in a development environment.
Since the source code to our approach is online, we encourage other researchers
to investigate this future work as well.  We also would like to expand the
simulation parts of this study to include both snapshots and changesets.  It
would be particularly useful to compare results between batch snapshots and
simulated snapshots.

Additional future work exists in regard to configuration.  In a changeset it may
be desirable to parse further for source code entities using island grammar
parsing [@Moonen_2001].  It may also be desirable to only use portions of the
changeset, such as only using added or removed lines, or extracting changes
between the abstract syntax trees [@Fluri-etal_2007].  Most importantly, like
previous work [@Biggers-etal_2014], it would be wise to further investigate the
effects of the two online LDA variables, $\tau_0$ and $\kappa$.  We leave these
options for future work.


TODO:

- Developer corpus during sweep was only ACR, did not sweep
- Need to look at closer at online parameters
    - Windowing: how much "lag" is acceptable in a historical simulation, e.g.,
      can we use a standard sized mini-batch and still remain robust?
- Replicate to a "temporal" snapshot evaluation -- will take time
- Replicate to other online models -- LSI, D2V when possible
- How does DIT perform with insider knowledge of people joining/leaving group?
- maybe exclude? -- Streaming models: This work allows for models to take in
  streams of data, e.g., from Github, to create models that can be used in
  general cases.
- Dependencies: update a model with text from dependencies as they are updated
    - call site inclusion aka @Bassett-Kraft_2015
- Code reviews of changes?
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
- Goldset quality
    - @Huo-etal_2014 finds differences in bug reports (i.e., the queries)
      written by experts vs non-experts.  The found statistically significant
      differences in all four of their tests while evaluating the VSM-based FLT
      [@Zhou-etal_2012], but only one for their DIT, a technique inspired by
      @Anvik-etal_2006.


