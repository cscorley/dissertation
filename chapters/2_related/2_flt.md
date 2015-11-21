## Feature Location {#related-flt}

Feature location is the act of identifying the source code entity or entities
that implement a feature [@Rajlich-Wilde_2002].  Bug localization is the
process of identifying source code entities that implement a bug, or an
*unwanted* feature [@Lukins-etal_2010].

The most closely related work is @Rao-etal_2013.  @Rao-etal_2013 also target
the problem of building topic models, introducing an incremental framework for
bug localization.  Although practical, the approach involves using an extended
topic modeler to allow updating, adding, and removing documents from the model
and index post-hoc.  While the approach is essentially equivalent to topic
modeling in batch, @Rao_2013 notes that these algorithm modifications have
limitations and thus models may need to be periodically retrained.

@Dit-etal_2011a provide a taxonomy and survey of feature location in source
code covering the scope of FLTs.  They identify 89 works related to feature
location in their systematic literature survey and extract 7 dimensions for
their taxonomy.  We use the primary dimension, type of analysis, for
categorization purposes.  The different types of analysis are: dynamic, static,
historical, and textual.

Dynamic FLTs use information from a system's execution, such as stack traces
[@Moreno-etal_2014].  Static FLTs instead use semantic information extracted
directly from source code, such as method call graphs [@Saul-etal_2007].
Historical FLTs use mining software repositories to extract meaningful
information, such as in @Cubranic-etal_2005.  Textual FLTs use textual
information extracted from software artifacts, such as source code comments,
identifiers, and literals [@Biggers-etal_2014].  Textual FLTs are the most
closely related category of our work and comprise the remainder of this
section.

Currently, developers rely on tools such as `grep` to find relevant source code
entities.  @Petrenko-etal_2008 develop a `grep`-based FLT.  However,
@Ko-etal_2006 show that developers fail using this type of searching upwards to
88% of the time.  Text retrieval techniques, such as topic modeling, show
promise in remedying this problem [@Marcus-etal_2004].

@Marcus-etal_2004 use an FLT based on Latent Semantic Indexing (LSI)
[@Deerwester-etal_1990] to find concepts based on queries from the user, and
modules within the system in comparison to the dependence graph approach.  They
found that concepts in the code were identifiable with user specified terms and
identifiers as well as an easier build process.  LSI-based FLTs have been
widely used by others [@Poshyvanyk-etal_2006; @Poshyvanyk-Marcus_2007;
@Liu-etal_2007; @Scanniello-Marcus_2011; @Eaddy-etal_2008;
@Cubranic-etal_2005].

@Lukins-etal_2008 introduce an FLT based on latent Dirichlet allocation (LDA)
[@Blei-etal_2003] and find that it outperforms the LSI-based FLT by
@Poshyvanyk-etal_2007.  They use the LDA inference technique to infer the topic
distributions of queries, i.e., bug reports.  Later, they show LDA to be
appropriate for software systems of any size [@Lukins-etal_2010].

@Biggers-etal_2014 investigate the configuration parameters for an LDA-based
FLT.  They show that excluding source code text such as comments and literals
negatively impacts the accuracy of the FLT.  Most importantly, they show that
configuration parameters taken from the machine learning and natural language
processing (NLP) communities are not good choices for software.
@Dit-etal_2011a show the need for better term splitting techniques for software
TR.

@Bassett-Kraft_2013 present new term weighting schemes based on the structural
information available in source code.  Namely, they find that increasing the
weight of method names increases the accuracy of an LDA-based FLT.  A typical
weighting scheme from the NLP communities is term frequency-inverse document
frequency (tf-idf) [@Salton-Buckley_1988].  @Saha-etal_2013 show that using
structural information provides improvement over tf-idf, as well.
@Saha-etal_2014 extend their work to show that improvements using structural
information apply to both Java and C.

Combining textual and static techniques shows improvement over using one or the
other alone.  @Shao-etal_2012 combine LSI with call graph information and find
that the call graph information increases the accuracy over plain LSI.
Likewise, @Ali-etal_2012 use binary class relationships in combination with LSI
and VSM to further improve their FLT.

More recent work has focused on integrating multiple sources of information,
such as in @Revelle-etal_2010 and @Dit-etal_2012.  @Dit-etal_2012 combine
textual, dynamic, and a new category, *mining*, to increase the effectiveness
of FLTs.  @Wang-etal_2013 utilize stack traces by using a Bayesian networks to
adjust the rank of a file based on three features that determine the
probability of the file being buggy.  @Moreno-etal_2014 also use stack traces
with a VSM-based FLT to improve their accuracy of their FLT.

