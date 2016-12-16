# State of the Dissertation

## Issues, fixes and improvements

The prior study we did, Corley etal 2015 (ICMSE) used classes and methods from
an existing dataset from Moreno et al 2014 (ICMSE). Unfortunately, there was
only FLT information in this dataset and it was difficult to find any datasets
overlapping both FLT and DIT tasks. So, I rolled my own. This time, was
interested in how this performed at file granularity. This allowed for quicker
experiments because I didn't need to parse source code repeatedly.

I skipped replicating the classes and methods research to this new dataset. It
should entirely be possible for FLT, but DIT would require additional work.
Another problem here is time; I simply ran out of time. I kept finding bugs
during data analysis, and having to restart experiments from scratch. This was
a multi-month cost every time. I eventually started renting 6 dedicated
instances that go 24/7 running the experiments (yay, employment), but this
still cost about 1.5 months.  Restarting has happened about 5 times so far in
2016 alone :-(

Also in the ICSME paper, we weren't really fairly evaluating the approach
because I didn't control for the random number generator (pRNG). It's possible
to get favorable results just by using different seeds. Very few people report
on this, which leads me to believe they're unaware of, or unwilling to
acknowledge, its existence. I've since added seeding the pRNG, which meant
another complete re-execution of all experiments. The upshot is that the
experiments are now 100% reproducible. I also wanted to know: is this just a
good seed value for me? So, I decided to compare the batch models (i.e.,
non-historical) over seeding at values 1-50. So far, early results show the
trend of Changesets performing better than Snapshots with better median and
mean MRR (TODO: stats test). I'd like to add this as another chapter (or
appendix?) because it allows me to reason about cases where the approach may
perform worse because the seed is simply better for one execution. But then
again, time.

I've also discovered issues with online LDA itself. While it is equivalent to
batch LDA with certain parameters, the underlying assumption is still large
amounts of data is available. Large enough for it to converge. However, this
almost never happens with source code in any of the subject systems.
Previously, would just repeat the corpus using the `passes` parameter in
Gensim, which would give us a model more likely to have converged. Batch LDA
has corpus repeating built-in! Batch LDA will repeat the corpus until the
change in the ELBO (aka per word bound, aka perplexity) was little in between
repetitions.  So, while working with Abham Hindle's student, Josh Campbell, he
patched Gensim to allow for this behavior when doing batch training with my
help. (As an aside: this is the same approach used by alternative
implementations of online LDA, such as scikit-learn.)

One other thing Gensim's oLDA (and the original Hoffman implementation) was
missing was learning the hyperparameters \alpha and \eta automatically. Hoffman
mentions it in his paper, but it was left as an exercise for the reader,
apparently. We also got this merged into Gensim proper. I went ahead and added
these 'auto' learning settings to the model configuration sweeps because I was
very interested in how they would compare. I think I may end up dropping the
data related to \eta as there was a bug introduced at some point to it's
implementation.

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
