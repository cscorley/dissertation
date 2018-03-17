## Threats to Validity {#sec:threats}

My studies have limitations that impact the validity of my findings, as well
as my ability to generalize them. I describe some of these limitations and
their impacts.

### Construct Validity

Threats to construct validity concern measurements accurately reflecting the
features of interest.  A possible threat to construct validity is the
benchmarks.  Errors in the datasets could result in inaccurate effectiveness
measures.  The dataset creation technique closely follows that of other
researchers [@Dit-etal_2013; @Revelle-etal_2010; @Moreno-etal_2014].
Additionally, datasets extracted source code entities automatically from
changesets, previous work shows this approach is on par with manual extraction
[@Corley-etal_2011].

### Internal Validity

Threats to internal validity include possible defects in the tool chain and
possible errors in the execution of the study procedure, the presence of which
might affect the accuracy of the results and the conclusions I draw from them.
I controlled for these threats by testing the  tool chain and by assessing the
quality of the data.  Because I applied the same tool chain to all subject
systems, any errors are systematic and are unlikely to affect the results
substantially.

Another threat to internal validity pertains to the value of parameters such as
$K$ that I selected for all models trained.  I decided that the snapshot- and
changeset-based approaches should have the same parameters to help facilitate
evaluation and comparison.  I argue that the study is not about selecting the
best parameters, but to show that the snapshot-based approach is reasonable.

Further, since LDA implementations such as Gensim rely heavily on randomly
initialized matrices, I have determined a certain threat with respect to this
model initialization.  I control for this by ensuring each model created uses
the same initial state.  This is achieved by running each experiment in
isolation and using a uniform random seed value of $1$ on the system's
pseudo-random number generator.

### External Validity

Threats to external validity concern the extent to which I can generalize the
results.  The subjects of the study comprise six open source projects in Java,
so I cannot generalize the results to systems implemented in other languages.
However, the systems are of different sizes, are from different domains, and
have characteristics in common with those of systems developed in industry.

### Conclusion Validity

Threats to conclusion validity concern the choice of measurements and how those
choices impact the evaluation and conclusion.  I chose to use mean reciprocal
rank (MRR), but I could have also used mean average precision (MAP) instead.
I chose the former because it lends itself to being paired with the Wilcoxon
signed-rank test as both rely on the same input data.  I also chose the former
to establish a baseline that can be used to compare my approach against prior
work in the field [@Dit-etal_2013a].
