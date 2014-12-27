## Motivation

When modeling a source code repository, the corpus typically represents a
snapshot of the code. That is, a topic model is often trained on a corpus that
contains documents that represent source code entities (e.g., files) from a
particular version of the software. Keeping such a model up-to-date is
expensive, because the frequency and scope of source code changes necessitate
retraining the model on the updated corpus. However, it may be possible to
automate certain maintenance tasks without a model of the complete source code.
For example, when assigning a developer to a change task, a topic model can be
used to associate developers with topics that characterize their previous
changes. In this scenario, a model of the text changed by each developer may be
more useful than a model of the entities changed by each developer.

While using file-based models is a natural fit for program comprehension tasks
such as feature location and bug localization, they still are unable to stay
up-to-date entirely [@Rao_2013]. Additionally, much of the work for assigning
developers to change requests still use source code entities as input and an
array of heuristics to identify a developer [@Kagdi-etal_2012]. These methods
also have the same flaw in that they ultimately rely on source code entities
for information.

To remedy these shortcomings, we propose to use *changesets* in the training of
a topic model. Like @Rao-etal_2013, the motivation of this work is to create
topic models that can be incrementally updated over time. However, unlike
@Rao-etal_2013, we can rely on the source code history itself to build the
model without needing to manually adjust model latent variables. This gains the
benefit of an decrease in query time, but also could lead to a more reliable
model.

The key intuition to this approach is that a topic model algorithm such as
latent Dirichlet allocation or latent semantic indexing can *infer* any given
document's topic proportions regardless of the documents used to train the
model. That is, we can train a model a corpus of changesets and infer the
topics of an entirely different corpus (e.g., source code entities). Further,
now that topic modeling can be done in an online manner [@Hoffman-etal_2010;
@Rehurek_2011], the model can be periodically updated with new changesets as
they enter a source code repository. This implies that a topic model can be
kept up-to-date with the source code as work is being done.

