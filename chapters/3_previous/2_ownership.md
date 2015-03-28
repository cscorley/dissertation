
## Modeling ownership {#icpc2012}

This section discusses the work in @Corley-etal_2012.

In @Corley-etal_2012 we conducted an exploratory study on modeling the
ownership of snapshot topics. We wanted to know whether contributors own topics
rather than just source code entities (i.e., classes). Towards this goal, we
posed two research questions:

RQ1
:    Do classes that belong to the same topic have similar ownership
characteristics?

RQ2
:   Do similar topics have similar ownership characteristics?

To answer these questions, we conducted an exploratory study on 10 subject
systems. The 10 subjects of our study --- Apache Ant, ArgoUML, CAROL, Google
Web Toolkit, iText, Jabref, Jedit, JHotDraw, Subversive, and Vuze --- varied in
language, size and application domain.

![Ownership topic modeling \label{fig:icpc2012}](figures/icpc2012.pdf)

Our document extraction process is shown on the left side of Figure
\ref{fig:icpc2012} and our modeling generation is shown on the right side. We
extract documents from the latest revision of each subject system. We build a
Pachinko Allocation Model (PAM) [@Li-McCallum_2006] out of this corpus. PAM is
a topic model that extends LDA to model topics, or subtopics, and their
supertopics. Using PAM allows us to compare documents by their topics, but also
compare the topics themselves by their supertopics.

We also constructed a vector-based ownership model in order to answer our
research questions. For each class in the subject system, we mined the source
code repository for how many times each developer changed that particular
class. From this we can get an *ownership profile*, a vector that describes
which developers changed the class most often (i.e., the owners).

For each topic extracted, we looked at the ownership profiles of the top
classes in that topic. We found that the classes in the same topic tend to have
similar ownership profiles. We also looked at the supertopics by aggregating
the ownership profiles of classes in each topic and found that supertopics tend
to have similar ownership as well.

In sum, we find found that metrics such as ownership profiles, which are widely
used [@Bird-etal_2011; @Kagdi-etal_2012; @Mockus-Weiss_2000;
@Mockus-Herbsleb_2002] to identify owners of source code entities, could also
be used to identify owners of topics and supertopics.

<!--

We constructed the following ownership model in order to answer our research
questions. A *class* is a source code entity that has a core responsibility.
Changes by developers can be traced to specific classes. A developer who
commits (to a Subversion repository) a change to a class is a *contributor* to
the class. A class $c$ has a set of contributors $O(c) = \{o_1, \ldots, o_m\}$.
A *system* is a set of classes $C = \{c_1, \ldots, c_n\}$, and a system $C$ has
a set of contributors: $O(C)=\displaystyle\bigcup\limits_{c \in C}{O(c)}$

The *ownership profile* for a class is a mathematical vector of length $|O(C)|$
that describes the frequency of changes to the class by each contributor to the
system. That is, each cell in the vector corresponds to a contributor and
contains the number of changes made to the class by that contributor. For
example, consider class `Foo` in a system with five contributors. Assume that
Developer 1 has changed `Foo` twice, Developer 2 has changed `Foo` once,
Developer 4 has changed `Foo` sixteen times, and Developer 5 has changed `Foo`
twelve times. The ownership profile for `Foo` is the five dimensional vector:
$<2,1,0,16,12>$.

The ownership profile for a topic (i.e., for a four-level PAM subtopic) is a
vector of length $|O(C)|$. It equals the vector sum of the ownership profiles
for the classes that belong to the topic. That is, a topic is a cluster of
classes, each of which has an ownership profile. We sum those profiles to model
the ownership of the topic. For example, consider a topic containing three
classes in a system with five contributors. Assume that the first class has
ownership profile $<4,32,9,0,0>$, the second class has ownership profile
$<0,2,0,0,0>$, and the third class has ownership profile $<1,0,0,2,2>$. The
ownership profile for the topic is $<5,34,9,2,2>$.

-->
