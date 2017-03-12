## old Developer Identification

Developer identification is a triaging activity in which a team member
identifies a list of developers that are most apt to complete a change request
and assigning one or more of those developers to the task
[@McDonald-Ackerman_1998].  @Begel-etal_2010 show that developers need help
finding expertise within their organization *more than they need help finding
source code elements*.  In this second, we outline an approach using online
topic models for developer identification.  First, we describe our motivation
and background in Sections \ref{sec:dit-motivation} and
\ref{sec:dit-background}, respectively.  We then describe our study design in
Section \ref{sec:dit-design}.  Finally, we describe the results of the study
(Section \ref{sec:dit-results}) and discuss them in detail (Section
\ref{sec:dit-discussion}).


### Background {#sec:dit-background}

Location-based techniques are a common developer identification technique and
build upon feature location techniques.  We refer the reader to Section
\ref{sec:flt-background} for a background on how a typical feature location
techniques works.

We can use an FLT to identify a ranked list of source code entities related to
a particular task.  Using ownership knowledge about the identified entities, we
can choose an appropriate developer to complete the task.  For example, if the
FLT identifies the file `foo.py` as the most related entity, then we would want
to know about the maintainer, or owner, of `foo.py`.  There are multiple ways
to determine the ownership of a source code entity [@Bird-etal_2011;
@Kagdi-etal_2012; @Corley-etal_2012; @Hossen-etal_2014].

A simple, example ownership metric is the number of times a developer has
committed changes to a file.  That is, if over the software history Johanna
modified `foo.py` 20 times, while Heather only has 5 modifications to `foo.py`,
then we consider Johanna as the owner of `foo.py`.  Here, we would assign all
tasks related to `foo.py` to Johanna.


