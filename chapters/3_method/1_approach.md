## Modeling Changeset Topics

In this section we describe our approach to a modeling changeset topics and how
we apply them for feature location and developer identification.

![Constructing a search engine with snapshots\label{fig:snapshot-flt}](figures/snapshot-flt.pdf)

![Constructing a search engine from changesets\label{fig:changeset-flt}](figures/changeset-flt.pdf)

### Approach overview

The overall difference in our approach and the standard approach
described in Section \ref{sec:related-general} is minimal.  For example,
compare Figures \ref{fig:snapshot-flt} and \ref{fig:changeset-flt}.  In the
changeset approach, we only need to replace the training documents while the
remainder of the approach remains the same.

The changeset-based approach requires two types of document extraction: a
corpus at a point of interest, or snapshot, and every changeset in the source
code history leading up to the same point of interest.  The left side of Figure
\ref{fig:changeset-flt} illustrates the dual-document extraction approach.

The document extraction process for the snapshot remains the same as covered in
Section \ref{sec:related-general}, but may be modified to fit the task
required.  The document extractor for the changesets parses each changeset for
the removed, added, and context lines.  From there, the text extractor
tokenizes each line.  The same preprocessor transformations occur for both
snapshot and changeset corpora.  This helps ensure that the snapshot vocabulary
is a subset of the changeset vocabulary [@Corley-etal_2014].

The right side of Figure \ref{fig:changeset-flt} illustrates the retrieval
process.  The key intuition to our approach is that a topic model such as LDA
or LSI can infer *any* document's topic proportions regardless of the documents
used to train the model.  This is also what determining the topic proportions
of a user-created query has relied on in traditional TM-based FLTs or DITs.
Likewise, so are other unseen documents.  In our approach, the seen documents
are changesets and the unseen documents are the source code entities of the
snapshot.

We train a topic model on the changeset corpus and use the model to
index the snapshot corpus.  Note that we never construct an index of the
changeset documents used to train the model.  We only use the changesets to
continuously update the topic model and only use the snapshot for indexing.

To leverage the online functionality of the topic models, we can also intermix
the model training, indexing, and retrieval steps.  First, we initialize a
model in online mode.  We update the model with new changesets whenever a
developer makes a new commit.  That is, with changesets, we incrementally
update a model and can query it at any moment.  This allows for a *historical
simulation* of how a changeset-based approach would perform in a realistic
scenario.

#### Feature Location with Changeset Topics {#sec:flt-approach}

Application of the constructed changeset-based topic model for feature location
does not require any more work than described above.  The snapshot we will
index is a release version, and we have two options for this:  the release
source code package or the state of the source code repository at the commit
tagged with the corresponding release identifier.  We choose the latter option
to ensure that the vocabulary of the indexed corpus is a subset of the modeled
corpus [@Corley-etal_2014], although the former option is entirely possible.

#### Developer Identification with Changeset Topics {#sec:dit-approach}

![Developer identification using changesets\label{fig:changeset-triage}](figures/changeset-triage.pdf)

Application of the constructed changeset-based topic model for developer
identification varies slightly from the general approach, as seen in Figure
\ref{fig:changeset-triage}.  Following @Matter-etal_2009, each developer has
their own document, or profile, consisting of all changesets they have
committed to the source code repository.  That is, the snapshot in this case is
a corpus of developer documents that consists of all lines a particular
developer has changed.  As with our FLT, this ensures that each developer
profile indexed is a subset of the modeled corpus.

<!-- TODO better off in config section?
 There may be weighting
schemes to this [@Shokripour-etal_2013], such as only considering words which
they have added or removed, while ignoring context words, but we do not
investigate that at this time.
-->

#### Combining and Configuring Changeset-based Topic Models {#sec:combo-approach}

![Combining changeset-based feature location and developer identification
\label{fig:changeset-combo}](figures/changeset-combo.pdf)

The changeset topic modeling approach requires three types of document
extraction: one for the snapshot of the state of source code at a commit of
interest, such as a tagged release; one for every changeset in the source
code history leading up to that commit; and a developer profile of all lines
each individual developer changed in their changesets.  The left side of Figure
\ref{fig:changeset-combo} illustrates the tri-document extraction approach.

The document extraction process for snapshot and changeset corpora remain the
same as covered in Section \ref{sec:flt-approach}.  The document extraction
process for the corpus of developer profiles remains the same as covered in
Section \ref{sec:dit-approach}.

The right side of Figure \ref{fig:changeset-combo} illustrates the retrieval
process.  For brevity, the queries and ranking do not appear in the diagram, as
they remain the same as described for each search engine in their respective
sections, Sections \ref{sec:flt-approach} and \ref{sec:dit-approach}.  We train
a topic model on the changeset corpus and construct search engines for each
task separately.  In the source code search engine we build an index from the
snapshot corpus.  In the developer search engine we build an index from the
developer corpus.

### Why changesets?

We choose to train the model on changesets, rather than another source of
information, because they represent what we are primarily interested in:
program features.  A single changeset gives us a view of an addition, removal,
or modification of a single feature.  A developer may, to some degree,
comprehend what a changeset accomplishes by examining it, much like examining a
source file \needcite.

While a snapshot corpus has documents that represent a program, a changeset
corpus has documents that represent *programming*.  If we consider every
changeset affecting a particular source code entity, then we gain a
sliding-window view of that source code entity over time and the contexts in
which those changes took place.  Figure \ref{fig:sliding} shows an example,
where green areas denote text added and red areas denote text removed in that
changeset.  Here, the summation of all changes affecting a class over its
lifetime would approximate the same words in its current version.

\input{figures/sliding_window_example}

Changeset topic modeling is akin to summarizing code snippets with machine
learning [@Ying-Robillard_2013], where in our case a changeset gives a
snippet-like view of the code required to complete a task.  Additionally,
@Vasa-etal_2007 observe that code rarely changes as software evolves.  The
implication is that the topic modeler will see changesets containing the same
source code entity only a few times -- perhaps only once.  We note that the
initial commit of a file is the entire file at the time, conceptually much like
a snapshot.  Since topic modeling a snapshot only sees an entity once, topic
modeling a changeset can miss no information.

Using changesets also implies that the topic model may gain some noisy
information from these additional documents, especially when considering
removals.  However, @Vasa-etal_2007 also observe that code is less likely to be
removed than it is to be changed.  This implies that the noisy information
would likely remain in both snapshot-based models and changeset-based models.

Indeed, it would appear desirable to remove changesets from the model that are
old and no longer relevant.  Online LDA already accounts for this by increasing
the influence newer documents have on the model, thereby decaying the affect of
the older documents on the model.

