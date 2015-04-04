
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

Figure \ref{fig:icpc2012} shows our document extraction process on the left
side and our modeling generation on the right side. We extract documents from
the latest revision of each subject system. We build a Pachinko Allocation
Model (PAM) [@Li-McCallum_2006] out of this corpus. PAM is a topic model that
extends LDA to model topics, or subtopics, and their supertopics. Using PAM
allows us to compare documents by their topics, but also compare the topics
themselves by their supertopics.

We also constructed a vector-based ownership model in order to answer our
research questions. For each class in the subject system, we mined the source
code repository for the number of times each developer changed that particular
class. From this we can get an *ownership profile*, a vector that describes
which developers changed the class most often (i.e., the owners).

For each topic extracted, we looked at the ownership profiles of the top
classes in that topic. We found that the classes in the same topic tend to have
similar ownership profiles. We also looked at the supertopics by aggregating
the ownership profiles of classes in each topic and found that supertopics tend
to have similar ownership as well.

In sum, we find found that metrics such as ownership profiles, which are widely
used [@Bird-etal_2011; @Kagdi-etal_2012; @Mockus-Weiss_2000;
@Mockus-Herbsleb_2002] to identify owners of source code entities, are also
useful for identifying owners of topics and supertopics.
