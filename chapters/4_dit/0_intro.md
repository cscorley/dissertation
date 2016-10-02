# Developer Identification {#chap:dit}

Developer identification is a triaging activity in which a team member
identifies a list of developers that are most apt to complete a change request
and assigning one or more of those developers to the task
[@McDonald-Ackerman_1998].  @Begel-etal_2010 show that developers need help
finding expertise within their organization *more than they need help finding
source code elements*.  In this chapter, we outline an approach using online
topic models for developer identification.  First, we describe our motivation
and background in Sections \ref{sec:dit-motivation} and
\ref{sec:dit-background}, respectively.  We then describe our study design in
Section \ref{sec:dit-design}.  Finally, we describe the results of the study
(Section \ref{sec:dit-results}) and discuss them in detail (Section
\ref{sec:dit-discussion}).


## Motivation {#sec:dit-motivation}

Software features are functionalities defined by requirements and are
accessible to developers and users.  Software change is continual, because
revised requirements lead to new features, increasing expectations lead to
feature enhancements, achieving intended behavior leads to removal of defective
features (i.e., bugs).  Users and developers propose change requests to the
project issue tracker.  Change requests are sometimes called issue reports, and
specific kinds of change requests include feature requests, enhancement
requests, and bug reports.

Triaging a change request involves steps completed either by a single person or
by a team of developers in a triage meeting.  How triage occurs differs from
team to team, but the general steps required are as follows.  First, the
triager(s) must see if the request has enough information for consideration.
The triager marks the request as a duplicate if the request already exists
elsewhere in the tracker or was previously completed.  After confirming that
the request is new and has enough information, the triager decides whether the
request will be completed, and how soon it will be completed, based on its
severity, frequency, risk, and other factors.  Finally, the triager assigns a
request to the developer.  Ultimately, the goal of triage is deciding priority
of the request and assignment to the developer that is best suited to complete
the change request.

Triaging is a common and difficult task.  Triage is even more difficult on
projects where developer teams are large or geographically distributed
[@Herbsleb-etal_2001].  Triaging requires contextual knowledge about the
product, team structure, individual expertise, workload balance, and
development schedules in order to correctly assign a change request.  A project
member triaging a change request will need to consider these factors in order
to correctly assign the change request to a set of developers with appropriate
expertise [@McDonald-Ackerman_1998].

Triaging can be a time consuming and error prone process when done manually.  A
triager reassigns a change request assigned in error to a different developer,
or the original developer reassigns the request themselves.  @Jeong-etal_2009
found that reassignment occurs between 37%--44% of the time and introduces an
average of 50 days delay in completing the request.  Automated support for
triaging helps to decrease change request time-to-triage and to correct, or
prevent, human error.

@McDonald-Ackerman_1998 show that there are two expertise finding problems:
identification and selection.  In a semi-automated system, the system
automatically identifies and suggests an expert for assignment.  In a
fully-automated system, the system identifies and assigns a developer to the
change request.  @Anvik-etal_2006 notes that a fully-automated approach may not
be feasible given the amount of contextual knowledge required for triage.

## Background {#sec:dit-background}

Location-based techniques are a common developer identification technique and
build upon feature location techniques.  We refer the reader to Section
\ref{sec:flt-background} for a background on how a typical feature location
techniques works.

We use an FLT to identify a ranked list of source code entities related to a
particular task.  Using ownership knowledge about the identified entities, we
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
