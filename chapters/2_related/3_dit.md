
## Developer identification {#related-triage}

In this section we survey the literature on developer identification.
As noted by @Shokripour-etal_2013, there are two broad categories of work in
this area: activity-based approaches and location-based approaches. An
activity-based approach uses information gained from a developers *activity*,
e.g., which change requests they have worked on in the past. Location-based
approaches resemble a feature location technique in that they rely on source
code entity information to derive a developer, e.g., which developer has worked
on the related classes in the past?

#### Activity-based Approaches

@Mockus-Herbsleb_2002 present Expertise Browser to locate expertise. Code
changes were analysed for Experience Atoms (EA), which represent the smallest
unit of experience. Developer expertise is based on the number EAs in a certain
domain or file.

@Cubranic-Murphy_2004 propose a machine learning approach that uses text
categorization on change request descriptions. The approach is validated on the
open source system Eclipse and obtains 30% precision. Cubranic and Murphy also
report on heuristics used for classification of change requests.
@Anvik-etal_2006 also use machine learning in an approach for semi-automated
triage by using change request history to learn which requests a developer
changes.

@Anvik-Murphy_2007 conduct an empirical evaluation of two approaches for
recommending: one that uses software repository mining, and one that uses
change request repository mining. The evaluation finds that the software
repository approach has higher precision, but lower recall than the change
request repository approach.

@Canfora-Cerulo_2006a propose an information retrieval-based approach that
indexes the textual description of previously resolved change requests. The
developers themselves are considered documents, with descriptions of completed
change requests representing their document. 
@Matter-etal_2009 take a slightly different approach and extract developer
documents from source code history. The history-based document measures how
active a developer is with a set of words in a VSM.

@Linstead-etal_2007a report on the use of Author-Topic modeling
[@Steyvers-etal_2004] on the Eclipse. The Author-Topic model augments existing
topic modeling [@Blei-etal_2003] to model the distribution of authors over
topics in addition to topics over documents.  @Linstead-etal_2007a use bug
reports to attribute authorship to a single version of Eclipse (3.0).  The
topics allow for comparison of developers based on their contributions to a
topic, which could be applied to change request assignment.

@Guo-etal_2011 report on a large-scale analysis of bug reassignment in
Microsoft Windows Vista operating system project. The study finds five primary
reasons for reassignment: finding the root cause, expertise identification, low
quality reports, difficulty in determining a proper fix, and workload balance.
These reasons suggest considerations in triage that can potentially improve
assignment. The study also validates previous observations [@Guo-etal_2010]
that reassignment is not always harmful, but can be beneficial in finding the
best developer to complete a request.

@Somasundaram-Murphy_2012 propose an approach combining LDA with a machine
learning algorithm for automated change request categorization. Improving
categorization of change requests shows potential benefits to triaging change
requests by reducing the space of expertise that requires to be considered.
Knowing which component a request belongs to provides two benefits: a component
which needs fixing is recommended, reducing the time-to-fix of a report
[@Guo-etal_2011], and only members of the team associated with the component
need consideration for recommendation.  The paper reports a comparative study
on three variations of categorization approaches and finds LDA improves
categorization over other approaches [@Anvik-etal_2006].

@Jeong-etal_2009 use a Markov chain-based learning algorithm that considers
bug reassignment information. Using their bug reassignment model, they reduce
the possibility of a bug being reassigned by ensuring it is assigned to the
correct developer the first time. They also show that a bug being reassigned
increases the time until the bug being fixed is upwards of 100 days.
@Bhattacharya-etal_2012 further employ this idea using different learning
algorithms incrementally improves triaging bugs the first time.

#### Location-based approaches

@McDonald-Ackerman_2000 present a heuristic-based recommender system named
Expertise Recommender. The heuristics used in the recommender were identified
in a previous industrial study [@McDonald-Ackerman_1998] on how developers
locate expertise. The Expertise Recommender considers developers' expertise
profile based on who last changed a module, who is closest to the requester in
the organization, and how connected the requester and expert are based on
social network analysis.

@Fritz-etal_2007 investigate whether a programmer's activity indicates
knowledge of code in an empirical study on nineteen professional Java
programmers. They study finds that the frequency and recency of interaction is
an indicator of the expertise a developer has on portions of code. They also
report on interviews with developers, finding several other indicators that may
improve expertise models based on source code interaction. The indicators
include authorship, role of source code, and the programmer's task being
performed.

@Minto-Murphy_2007 propose an approach implemented in a tool named Emergent
Expertise Locator. The approach is based on using the matrices to produce
requirements coordination by @Cataldo-etal_2006. The matrices represent file
dependency, or how often pairs of files are changed together, and file
authorship, or how often a developer changes a file.  The tool is evaluated on
the history of three open source projects: Bugzilla, Eclipse, and Firefox. The
results are compared to the approach by @McDonald-Ackerman_2000, and are found
to have higher precision and recall.

@Kagdi-etal_2008 present a tool named xFinder to mine developer contributions
in order to recommend a ranked list of developers for a change. The tool
measures the similarity of vectors consisting of the number of commits to a
file, the number of workdays spent on a file, and the most recent workday on
the file. To find an appropriate developer for a file, similarity between each
developer's vector and the file vector is measured. This combination of mining
and information retrieval has been adopted by several researchers
[@Kagdi-etal_2012; @Hossen-etal_2014]. Further, @Bird-etal_2011 finds that
measuring ownership in this way correlates low ownership with post-release
defects.

@Rahman-Devanbu_2011 use the provenance features of Git to track the ownership
of individual lines of source code.  They then study the impacts of ownership
and experience on software quality by comparing the ownership and experience
characteristics of "implicated code" (lines of code changed to fix bugs) to
those of "normal code." This paper reports that strong ownership by a single
developer is associated with implicated code and that lack of specialized
experience on a particular file is associated with implicated code in that
file. This suggests that the best suited developer for change requests is the
developer with the most ownership (i.e., expertise).

@Ma-etal_2009 evaluate the proposed approach by @Schuler-Zimmermann_2008. The
paper proposes a approach of six heuristics: two based on implementation
expertise and four based on usage expertise. The results show
usage-expertise-based recommendations have an accuracy comparable to
implementation-based recommendations.

@Linares-Vasquez-etal_2012 present an approach that does not require mining the
software history nor a learning from previously completed change requests.
Using the author indicated in source code comments with an LSI-based FLT, they
are able to identify the correct developer. @Hossen-etal_2014 extend this
approach to also include change proneness to adjust the rank of relevant source
code entities before selecting a developer.

@Weissgerber-etal_2007 present three visualization techniques that can help a
triager identify the developer most appropriate for a task.
@Bortis-VanderHoek_2013 present an approach that tags bugs to help developers
explore relevant bugs. @Tamrawi-etal_2011 present an incremental DIT approach
based on fuzzy sets. Like @Bassett-Kraft_2013, @Shokripour-etal_2013 show that
using a term weighting scheme increases the accuracy of an DIT.
