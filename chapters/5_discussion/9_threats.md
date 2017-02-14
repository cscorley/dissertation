## Threats to Validity {#sec:threats}

Our studies have limitations that impact the validity of our findings, as well
as our ability to generalize them. We describe some of these limitations and
their impacts.

#### Construct Validity

Threats to construct validity concern measurements accurately reflecting the
features of interest.  A possible threat to construct validity is our
benchmarks.  Errors in the datasets could result in inaccurate effectiveness
measures.  Our dataset creation technique closely follows that of other
researchers [@Dit-etal_2013; @Revelle-etal_2010; @Moreno-etal_2014].
Additionally, datasets extracted source code entities automatically from
changesets, previous work shows this approach is on par with manual extraction
[@Corley-etal_2011].

#### Internal Validity

Threats to internal validity include possible defects in our tool chain and
possible errors in our execution of the study procedure, the presence of which
might affect the accuracy of our results and the conclusions we draw from them.
We controlled for these threats by testing our tool chain and by assessing the
quality of our data.  Because we applied the same tool chain to all subject
systems, any errors are systematic and are unlikely to affect our results
substantially.

Another threat to internal validity pertains to the value of parameters such as
$K$ that we selected for all models trained.  We decided that the snapshot- and
changeset-based approaches should have the same parameters to help facilitate
evaluation and comparison.  We argue that our study is not about selecting the
best parameters, but to show that our snapshot-based approach is reasonable.

Further, since LDA implementations such as Gensim rely heavily on randomly
initialized matrices, we have determined a certain threat with respect to this
model initialization.  We control for this by ensuring each model created uses
the same initial state.  This is achieved by running each experiment in
isolation and using a uniform random seed value of $1$ on the system's
pseudo-random number generator.

#### External Validity

Threats to external validity concern the extent to which we can generalize our
results.  The subjects of our study comprise six open source projects in Java,
so we cannot generalize our results to systems implemented in other languages.
However, the systems are of different sizes, are from different domains, and
have characteristics in common with those of systems developed in industry.


#### Conclusion Validity

Threats to conclusion validity concern our choice of measurements and how those
choices impact our evaluation and conclusion.  We chose to use mean reciprocal
rank (MRR), but we could have also used mean average precision (MAP) instead.
We chose the former because it lends itself to being paired with the Wilcoxon
signed-rank test as both rely on the same input data.

\todo{write something better than "this is what everyone does"}
