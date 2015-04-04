## Limitations and Assumptions

There are limitations and assumptions in this research that need addressing
upfront.

First, the assumption that a software project using a changeset-based topic
model has a large history. Topic models need a large amount of data for
training, and hence the more history supplied to the model the more accurate it
becomes. There may be solutions to this problem, such as using the software
snapshot after a release in combination with the changesets.

The second assumption follows the first, in that the software repository
history is not changed or re-written after initial training of the topic model.
New version control software, such as Git and Mecurial, allow for history to be
re-written arbitrarily. For instance, a repository may contain work on a
subproject which is then extracted into its own fully-fledged project at a
later point. This has happened to Apache Lucene and Solr projects.

The third assumption is that an optimal configuration exists. Since the models
are seeing a single document at a time, there may be performance issues with
this approach. Previous research use topic models trained in *batch*, i.e.
knowing about all documents ahead of time, and have parameters that need
configuration for optimal performance. Likewise, *online* topic models include
new parameters that also need configuration.

The final assumption is that the topics do not experience topic drifting or
large changes in vocabulary. Solutions towards topic drift
[@Blei-Lafferty_2006] and expanding vocabularies [@Zhai-Boyd-Graber_2013]
suggested by the topic modeling communities may address this issue.

