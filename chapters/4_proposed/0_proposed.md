# Proposed work

In this chapter, I outline the proposed work and methodologies to be used for
each. First, I will give a brief reasoning to why I believe changesets will
work. Second, I will cover work on the application of topic models for feature
location. I will follow up with work on the application of topic models for
developer identification. Finally, I will discuss an approach which can use a
singular topic model for both of these tasks.


## Why changesets?

We choose to train the model on changesets, rather than another source of
information, because they also represent what we are primarily interested in:
program features.  A single changeset gives us a view of an addition, removal,
or modification of a single feature.  A developer can to some degree comprehend
what a changeset accomplishes by examining it, much like examining a source
file.

While a snapshot corpus has documents that represent a program, a changeset
corpus has documents that represent programming.  If we consider every
changeset affecting a particular source code entity, then we gain a
sliding-window view of that source code entity over time and the contexts those
changes was performed in. An example is shown in Figure \ref{fig:sliding},
where green areas denote text added and red areas denote text removed in that
changeset. Here, the summation of all changes affecting a class over it's
lifetime would approximate the same words in it's current version.

![Changesets over time approximate a
Snapshot\label{fig:sliding}](figures/sliding_window_example.pdf)

Changeset topic modeling is akin to summarizing code snippets with machine
learning [@Ying-Robillard_2013], where in our case a changeset gives a
snippet-like view of the code required to complete a task. For example, in
Figure \ref{fig:diff}, we can see the entire method being changed when the
context lines are considered.

Additionally, @Vasa-etal_2007 observe that code rarely changes as software
evolves. The implication is that the topic modeler will see changesets
containing the same source code entity only a few times, perhaps only once.
Since topic modeling a snapshot only sees an entity once, topic modeling a
changeset can miss no information.

Using changesets also implies that the topic model may gain some noisy
information from these additional documents, especially removals.  However,
@Vasa-etal_2007 also observe that code is less likely to be removed than it is
to be changed. This implies that the noisy information would likely remain in
both snapshot-based models and changeset-based models.

Indeed, it appears desirable to remove changesets from the model that are old
and no longer relevant. There would be no need for this because online LDA
already contains features for increasing the influence newer documents have on
the model, thereby decaying the affect of the older documents on the model.


