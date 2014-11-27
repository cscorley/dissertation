# Proposed work

In this chapter, I outline the proposed work and methodologies to be used for
each.

## Approach

1. Build model from changesets
2. *Do not* infer a $\theta_{changesets}$
3. Infer a $\theta_{files}$ and $\theta_{developers}$
4. On a new commit, repeat step 2 *only on the changed document*

## Primary studies

### Feature location {#featurelocationstudy}

#### Motivation
#### Background
#### Proposal

- Defer this to bug localization since that's what the datasets really
  are?

### Traceability link recovery {#traceabilitystudy}

#### Motivation
#### Background
#### Proposal


### Developer identification {#developeridentificationstudy}

#### Motivation

Software features are functionalities that
are defined by requirements and
are accessible to developers and users.
Software change is continual, because
new features must be added to meet revised requirements,
existing features must be enhanced to satisfy increased expectations, and
defective features (i.e., bugs) must be removed to achieve intended behavior.
Changes to a software system are proposed by developers or users,
who submit change requests to the project issue tracker.
Change requests are sometimes called issue reports, and
specific kinds of change requests include
feature requests, enhancement requests, and bug reports.

Triaging a change request involves several steps that can be completed
either by a single person or by a team of developers in a triage meeting.
How triage occurs differs from team to team, but the general steps
required are as follows. First, the triager(s) must see if the request has
enough information to be considered. It is marked as a duplicate if the
request already exists. After it is confirmed that the request is new
and has enough information, a decision must be made if and how soon it
will be completed based on its severity, frequency, risk, and other
factors. Finally, the triager assigns a request to the developer.
Ultimately, the goal of triage is deciding priority of the request and
assignment to the developer that is best suited to complete the change
request.

Triaging is a common and difficult task. Triage is even more difficult
on projects where developer teams are large or geographically
distributed [@Herbsleb-etal:2001]. A project member triaging
a change request will need to consider several factors in order to
correctly assign the change request to a set of developers with
appropriate expertise [@McDonald-Ackerman:1998]. Triaging requires
contextual knowledge about the product, team structure, individual
expertise, workload balance, and development schedules in order to
correctly assign a change request.

Triaging can be a time consuming and error prone process when done
manually. If a change request was assigned in error, it will need to be
reassigned to the appropriate developer. Jeong et
al. [@Jeong-etal:2009] found that reassignment occurs between
37\%--44\% of the time and introduces an average of 50 days delay in
completing the request. Automated support for triaging helps to decrease
change request time-to-triage and to correct, or prevent, human error.

McDonald and Ackerman [@McDonald-Ackerman:1998] show that there are two
expertise finding problems: identification and selection. In
a semiautomated system, expertise identification is automated, and
suggests an expert for selection. In a fully-automated system, the
expert is identified and selected for assignment to the change request.
Anvik [@Anvik-etal:2006] notes that a fully-automated approach may
not be feasible given the amount of contextual knowledge required for
triage.

#### Background
#### Proposal

## Supporting studies

### Corpora of software histories

### Implementing topic models with growing vocabulary


