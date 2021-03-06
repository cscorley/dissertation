## Feature Location {#sec:related-flt}

Feature location is the act of identifying the source code entity or entities
that implement a feature [@Rajlich-Wilde_2002].  Bug localization is the
process of identifying source code entities that implement a bug, or an
*unwanted* feature [@Lukins-etal_2010].  Feature location is a frequent and
fundamental activity for a developer tasked with changing a software system.
Whether a change task involves adding, modifying, or removing a feature, a
developer cannot complete the task without first locating the source code that
implements the feature or where the feature is to be implemented and used.
Often, an approach for feature location technique (FLT) interchangeable for a
bug localization  technique (BLT).

The most closely related work to this work is @Rao-etal_2013.  @Rao-etal_2013
also target the problem of building topic models, introducing an incremental
framework for bug localization.  Although practical, the approach involves
using an extended topic modeler to allow updating, adding, and removing
documents from the model and index post-hoc.  While the approach is essentially
equivalent to topic modeling in batch, @Rao_2013 notes that these algorithm
modifications have limitations and thus models may need to be periodically
retrained.

@Dit-etal_2013a provide a taxonomy and survey of feature location in source
code covering the scope of FLTs.  They identify 89 works related to feature
location in their systematic literature survey and extract 7 dimensions for
their taxonomy.  I use the primary dimension, type of analysis, for
categorization purposes.  The different types of analysis are: dynamic, static,
historical (mining), and textual.

Dynamic FLTs use information from a system's execution, such as stack traces
[@Moreno-etal_2014].  Static FLTs instead use semantic information extracted
directly from source code, such as method call graphs [@Saul-etal_2007].
Historical FLTs use software repository mining to extract meaningful
information, such as in @Cubranic-etal_2005.  Textual FLTs use textual
information extracted from software artifacts, such as source code comments,
identifiers, and literals [@Biggers-etal_2014].  Textual FLTs are the most
closely related category of my work and comprise the remainder of this
section.

Currently, developers rely on tools such as `grep` to find relevant source code
entities.  @Petrenko-etal_2008 develop a `grep`-based FLT.  However,
@Ko-etal_2006 show that developers fail using this type of searching upwards to
88% of the time.  Text retrieval techniques, such as topic modeling, show
promise in remedying this problem [@Marcus-etal_2004].

@Marcus-etal_2004 use an FLT based on Latent Semantic Indexing (LSI)
[@Deerwester-etal_1990] to find concepts based on queries from the user, and
modules within the system.  They found that concepts in the code were
identifiable with user specified terms and identifiers as well as an easier
build process.  LSI-based FLTs have been widely used by others
[@Poshyvanyk-etal_2006; @Poshyvanyk-Marcus_2007; @Liu-etal_2007;
@Scanniello-Marcus_2011; @Eaddy-etal_2008; @Cubranic-etal_2005].

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
@Dit-etal_2011 show the need for better term splitting techniques for software
TR.

@Bassett-Kraft_2013 explore new term weighting schemes based on the structural
information available in source code.  Namely, they find that increasing the
weight of method names increases the accuracy of an LDA-based FLT.  A typical
weighting scheme from the NLP communities is term frequency-inverse document
frequency (tf-idf) [@Salton-Buckley_1988].  @Saha-etal_2013 show that using
structural information provides improvement over tf-idf, as well.
@Saha-etal_2014 extend their work to show that improvements using structural
information apply to both Java and C.  @Zhou-etal_2017 show that a
parts-of-speech weighting method, with a particular focus on the nouns,
increases the accuracy of a BLT.

@Eddy-etal_2017 extend @Bassett-Kraft_2013 to include new weighting schemes,
which consider a method's documentation comments, parameter names,
implementation comments (i.e., inline comments), and the variables within the
method, as well as a class' name, documentation comments, and field names
within the class.  Their findings conclude that the context of a method (i.e.,
the containing class) may be beneficial to a method-level FLT.

Combining textual and static techniques shows improvement over using one or the
other alone.  @Shao-etal_2012 combine LSI with call graph information and find
that the call graph information increases the accuracy over plain LSI.
Likewise, @Ali-etal_2012 use binary class relationships in combination with LSI
and VSM to further improve their FLT.

More recent work has focused on integrating multiple sources of information.
@Dit-etal_2012 combine textual, dynamic, and a new category, *mining*, to
increase the effectiveness of FLTs.  @Wang-etal_2013 utilize stack traces by
using a Bayesian networks to adjust the rank of a file based on three features
that determine the probability of the file being buggy.  @Moreno-etal_2014 also
use stack traces with a VSM-based FLT to improve their accuracy of their FLT.
@Youm-etal_2017 combine changesets, stack traces, bug reports, and source code
for their VSM-based BLT.

@Sisman-Kak_2013 present work on an automatic query reformulation approach for
changing a user's query to achieve better ranking in their BLT.
@Chaparro-etal_2017 performed manual coding of queries in order to generate
reduced queries that improve the accuracy of various baseline TR-based
approaches [@Just-etal_2014, @Moreno-etal_2014, @Wong-etal_2014,
@Mills-etal_2017] on average of 147%.
