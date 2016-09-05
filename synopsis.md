# State of the Dissertation

## Issues, fixes and improvements

The prior study we did, Corley etal 2015 (ICMSE) used classes and methods.  It
turned out to work OK, but we weren't really fairly evaluating the approach
because I didn't control for the pRNG.  I've since added seeding the pRNG,
which means a complete re-execution of all experiments.

I was interested in how this performed at file granularity.  However, this
required a new dataset of subject systems because I could not (at the time)
find one that had file-level information.  I spent some time revamping
collection of a few Java projects because they were used in other research
(namely Moreno etal 2014), but extending this to other languages is left for
future work.

I skipped replicating the classes and methods research to this new dataset.  It
should entirely be possible for FLT, but DIT would require additional work.
Another problem here is time; I simply ran out of time.  I kept finding bugs
during data analysis, such as the aforementioned random seed problem, and
having to restart experiments from scratch.  This was a multi-month cost every
time.  I eventually started renting 6 dedicated instances that go 24/7 running
the experiments (yay, employment), but this still cost about 1.5 months.
Restarting has happened about 5 times so far :-(

While I was waiting for data to generate, I expanded on the pRNG issue.  Very
few people report on this, which leads me to believe they're unaware of, or
unwilling to acknowledge, its existence.  I also wanted to know: is this just a
good seed value for me?  So, I decided to compare the batch models (i.e.,
non-historical) over seeding at values 1-50.  So far, early results show the
trend of Changesets performing better than Snapshots with better median and
mean MRR (TODO: stats test).  I'm considering adding this as another chapter
because it allows me to reason about cases where the approach can fail.

I've also discovered issues with online LDA itself.  While it is equivalent to
batch LDA with certain parameters, the underlying assumption is still large
amounts of data is available.  Large enough for it to converge.  However, this
almost never happens with source code in any of the subject systems.  Hence, we
previously would just repeat the corpus using the `passes` parameter in Gensim,
which would give us a model more likely to have converged.

Batch LDA has corpus repeating built-in!  LDA will repeat the corpus until the
change in the ELBO (aka per word bound, aka perplexity) was little in between
repetitions.  So, while working with Abham Hindle's student, Josh Campbell, he
patched Gensim to allow for this behavior when doing batch training with my
help. (As an aside: this is the same approach used by alternative
implementations of online LDA, such as scikit-learn.)

One other thing Gensim's oLDA (and the original Hoffman implementation) was
missing was learning the hyperparameters \alpha and \eta automatically.
Hoffman mentions it in his paper, but it was left as an exercise for the
reader, apparently.  Josh graciously implemented this, and we got this merged
into Gensim proper.  I went ahead and added these 'auto' learning settings to
the model configuration sweeps because I was very interested in how they would
compare.

# Storyline

1. Introduction
    An introduction to the problem of model obsolescence.

    Terminology, RP, and organization of the thesis.

    Why changesets?

2. Background
    - Text Retrieval
    - Text Retrieval Models
    - Text Retrieval in Software
    - Feature Location
    - Developer Identification
    - Configuration??
3. Feature Location
4. Developer Identification
5. Combining & Configuration
6. Random seed evaluation
9. Conclusion
    - Future work
    - Last words


Each study chapter should stand on its own, with the exception of the
background chapter.  The sections are standard as:
    - Introduction
    - Methodology
    - Results
    - Discussion
    - Threats
