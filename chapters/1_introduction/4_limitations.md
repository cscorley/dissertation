## Limitations and Assumptions

There are various limitations and assumptions in this research that need to be
addressed upfront.

First, the assumption is made that a software project using a changeset-based
topic model has a large history. Topic models need a substantial amount of data
for training, and hence the more history supplied to the model the more
accurate it becomes. There may be solutions to this problem, such as using
the software snapshot after a release in combination with the changesets.

The second assumption follows the first, in that the software repository
history is not changed or re-written after initial training of the topic model.
New version control software, such as Git and Mecurial, allow for history to be
re-written arbitrarily. For instance, a repository may contain work on a
subproject which is then extracted into it's own fully-fledged project at a
later point. This has happened in the case of the Apache Lucene and Solr
projects.

The third assumption is that an optimal configuration exists. Since the models
are only seeing a single document at a time, there may be performance issues
with this approach. Previously, topic models were trained in *batch*, i.e.
knowing about all documents ahead of time, and have many parameters that need
to be configured for optimal performance. Likewise, *online* topic models
include additional parameters that also need to be configured.

Finally, there is an assumption about the topics of a software project itself.
The assumption is that the topics do not experience topic drifting or large
changes in vocabulary. Solutions towards topic drift [@Blei-Lafferty_2006] and
expanding vocabularies [@Zhai-Boyd-Graber_2013] have been suggested by the
topic modeling communities which may address this issue.

