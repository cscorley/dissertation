Information Retrieval in Software Maintenance
=============================================


Software developers are often confronted with maintenance tasks that 
involve navigation of repositories that preserve vast amounts of project 
history.
 Navigating these software repositories can be a time-consuming task, 
 because their organization can be difficult to understand.
 Fortunately, topic models such as \abbr{LDA}{latent Dirichlet 
 allocation}\scite{Blei-etal:2003} can help developers to navigate and 
 understand software repositories by discovering topics (word 
 distributions) that reveal the thematic structure of the 
 data\scite{Linstead-etal:2007,Thomas-etal:2011,Hindle_etal:2012}.


When modeling a source code repository, the corpus typically represents 
a snapshot of the code.
That is, a topic model is often trained on a corpus that contains 
documents that represent files from a particular version of the 
software.
Keeping such a model up-to-date is expensive, because the frequency and 
scope of source code changes necessitate retraining the model on the 
updated corpus.
However, it may be possible to automate certain maintenance tasks 
without a model of the complete source code.
For example, when assigning a developer to a change task, a topic model 
can be used to associate developers with topics that characterize their 
previous changes.
In this scenario, a model of the changesets created by each developer 
may be more useful than a model of the files changed by each developer.
Moreover, as a typical changeset is smaller than a typical file, a 
changeset-based model is less expensive to keep current than a 
file-based model.

Toward the goal of automating software maintenance tasks using 
changeset-based models, in this paper we qualitatively compare topic 
models trained on corpora of changesets to those trained on files.
 For our comparison we consider vocabulary measures, which indicate 
 whether term distributions in the changeset corpora match those in the 
 file corpora, and topic 
 distinctness\scite{Wei-etal:2010,Thomas-etal:2011,Chuang-etal:2012}, 
 which measures how distinct one topic in a model is from another.
 Models with higher topic distinctness values are desirable, because 
 distinct topics are more useful in differentiating among the documents 
 in a corpus than are similar topics.


Motivation
==========

Research goals
==============

Outline
========

In this proposal...
