# Introduction

Software developers are often confronted with maintenance tasks that involve
navigation of repositories that preserve large amounts of project history.
Navigating these software repositories can be a time-consuming task, because
their organization can be difficult to understand.  Fortunately, topic models
such as latent Dirichlet allocation (LDA) [@Blei-etal_2003] can help developers
to navigate and understand software repositories by discovering topics (word
distributions) that reveal the thematic structure of the data
[@Linstead-etal_2007; @Thomas-etal_2011; @Hindle-etal_2014].

Program comprehension is a prerequisite to incremental change.  A software
developer tasked with changing a large software system spends effort on program
comprehension activities to gain the knowledge needed to make the change
[@Corbi_1989].  For example, the developer spends effort to understand the
system architecture or to locate the parts of the source code implementing the
feature(s).  For developers who are unfamiliar with the system gaining such
knowledge can be a time-consuming task.  Topic models of source code can help
such developers to understand the system by revealing a latent structure that
is not obvious from the package hierarchy or system documentation
[@Savage-etal_2010].

In software engineering, topic models uncover thematic structure (e.g., topics)
of source code entities grouped by their natural language content (i.e., the
words in their identifiers, comments, and literals).  Such topics often
correspond to the concepts and features implemented by the source code
[@Baldi-etal_2008], and exploring such topics shows promise in helping
developers to understand the entities that make up a system and to understand
how those entities relate [@Kuhn-etal_2007; @Maskeri-etal_2008;
@Savage-etal_2010; @Gethers-etal_2011a].  Recent approaches to exploring
linguistic topics in source code use machine learning techniques that model
correlations among words, such as latent semantic indexing (LSI)
[@Deerwester-etal_1990] and latent Dirichlet allocation (LDA)
[@Blei-etal_2003], and machine learning techniques that also model correlations
among documents, such as Relational Topic Models [@Chang-Blei_2010].

Useful for more than just general program comprehension, topic models of source
code have more concrete applications including: feature location
[@Dit-etal_2011a], bug localization [@Lukins-etal_2008; @Rao-etal_2013],
developer identification [@Kagdi-etal_2012], traceability link recovery
[@Asuncion-etal_2010], and other areas [@Biggers_2012].  Yet, while researchers
have had success in using topic models on source code entities, a fundamental
issue exists with the current approaches.  This issue is that the input
documents used to build a topic model are mutable source code entities, and
will be the motivating point of this work.
