# Introduction {#chap:intro}

Software features are functionalities defined by requirements and accessible to
developers and users.  Software change is continual, because revised
requirements lead to new features, increasing expectations lead to feature
enhancements, and achieving intended behavior leads to removal of defective
features (i.e., bugs).  This software maintenance and evolution is driven by
users, project managers, and developers requesting changes.  Specific kinds of
change requests include feature requests, enhancement requests, and bug
reports.  Each change request requiring a code change is assigned to a
developer to implement.

A developer assigned to a change request must first understand what a program
does and how the program is implemented, i.e., program comprehension is a
prerequisite to incremental change [@Corbi_1989].  For example, the developer
spends effort to understand the system architecture or to locate the parts of
the source code implementing the feature(s).  For developers who are unfamiliar
with the system, gaining such knowledge can be a time-consuming task
[@Mueller-etal_2000].  One approach to assisting building program comprehension
is to use text retrieval techniques [@Lukins-etal_2008].

Developer identification is the process of determining which developer has
appropriate expertise [@McDonald-Ackerman_1998].  That is, it is the process of
finding a developer that already has the prerequisite knowledge of the software
system.  Indeed, developers need help finding expertise within their
organization *more than they need help finding source code elements*
[@Begel-etal_2010].  Unfortunately, developer identification can be an
error-prone and time-consuming process when completed manually.
@Jeong-etal_2009 found that change request reassignment occurs between 37%-44%
of the time and introduces an average delay of 50 days until the request is
completed.  It is imperative that a request is assigned to the best-fit
developer the first time.  There are a myriad of approaches to this problem
[@Shokripour-etal_2013], many of which are based, at least in part, on text
retrieval techniques [@Kagdi-etal_2012].

One text retrieval technique is topic modeling.  In software engineering,
topic models uncover thematic structure (e.g., topics) of source code entities
grouped by their natural language content (i.e., the words in their
identifiers, comments, and literals).  Such topics often correspond to the
concepts and features implemented by the source code [@Baldi-etal_2008], and
exploring such topics shows promise in helping developers to understand the
entities that make up a system and to understand how those entities relate
[@Kuhn-etal_2007; @Maskeri-etal_2008; @Savage-etal_2010; @Gethers-etal_2011a].
Recent approaches to exploring linguistic topics in source code use machine
learning techniques that model correlations among words, such as latent
semantic indexing (LSI) [@Deerwester-etal_1990] and latent Dirichlet allocation
(LDA) [@Blei-etal_2003], and machine learning techniques that also model
correlations among documents, such as Relational Topic Models
[@Chang-Blei_2010].

Useful for more than just general program comprehension, topic models of source
code have concrete applications including: feature location [@Dit-etal_2013a],
bug localization [@Lukins-etal_2008; @Rao-etal_2013], developer identification
[@Kagdi-etal_2012], traceability link recovery [@Asuncion-etal_2010], and other
areas [@Biggers_2012].  Yet, while researchers have had success in using topic
models on source code entities for a variety of applications, a fundamental
issue exists with the current approaches:  topic modeling algorithms typically
assume the input is comprised of immutable documents, while source code entities
are mutable.  This conflict in assumptions is the motivating point of this work.

<!--
Topic models of source code can help such developers to understand the
system by revealing a latent structure that is not obvious from the package
hierarchy or system documentation [@Savage-etal_2010].
-->

<!--
Software developers are often confronted with maintenance tasks that involve
navigation of repositories that preserve large amounts of project history.
Navigating these software repositories can be a time-consuming task, because
their organization can be difficult to understand, especially when the
organization evolves over time.  Fortunately, topic models such as latent
Dirichlet allocation (LDA) [@Blei-etal_2003] can help developers to navigate
and understand software repositories by discovering topics (word distributions)
that reveal the thematic structure of the data [@Linstead-etal_2007;
@Thomas-etal_2011; @Hindle-etal_2014].
-->
