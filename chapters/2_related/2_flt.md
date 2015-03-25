
## Feature location {#related-flt}


Feature location is the act of identifying the source code entity or entities
that implement a feature [@Rajlich-Wilde_2002].  Bug localization can be
seen as the process of identifying source code entities that implement an
*unwanted* feature [@Lukins-etal_2010].

The most closely related work is @Rao-etal_2013. Rao et al. also target the
problem of building topic models, introducing an incremental framework for bug
localization.  Although practical, the approach involves using an extended
topic modeler to allow updating, adding, and removing documents from the model
and index post-hoc.  While the approach is essentially equivalent to topic
modeling in batch, @Rao_2013 notes that these algorithm modifications have
limitations and thus models may need to be periodically retrained.

@Dit-etal_2011a provide a taxonomy and survey of feature location in source
code covering the scope of FLTs.  They identify 89 works related to feature
location in their systematic literature survey and extract 7 dimensions for
their taxonomy.  The primary dimension, type of analysis, can be used for
categoization purposes and consists of four categories: dynamic, static,
historical, and textual.

Dynamic FLTs use information from a system's execution, such as stack traces
[@Moreno-etal_2014].  Static FLTs instead use semantic information extracted
directly from source code, such as method call graphs [@Saul-etal_2007].
Historical FLTs use mining software repositories to extract meaningful
information, such as in @Cubranic-etal_2005.  Textual FLTs use textual
information extracted from software artifacts, such as source code comments,
identifiers, and literals [@Biggers-etal_2014]. Textual FLTs are the most
closely related category of our work and comprise the remainder of this
section.

Currently, developers rely on tools such as `grep` to find relevant source code
entities. @Petrenko-etal_2008 develop a `grep`-based FLT. However,
@Ko-etal_2006 show that developers fail using this type of searching upwards to
88% of the time.  Text retrieval techniques, such as topic modeling, show
promise in remedying this problem [@Marcus-etal_2004].

@Marcus-etal_2004 use an FLT based on Latent Semantic Indexing (LSI)
[@Deerwester-etal_1990] to find concepts based on queries from the user, and
modules within the system in comparison to the dependence graph approach. They
found that concepts in the code were able to be identified with user specified
terms and identifiers as well as an easier build process. LSI-based FLTs have
been widely used by many others [@Poshyvanyk-etal_2006;
@Poshyvanyk-Marcus_2007; @Liu-etal_2007; @Scanniello-Marcus_2011;
@Eaddy-etal_2008; @Cubranic-etal_2005].

@Lukins-etal_2008 introduce an FLT based on LDA and find that it outperforms an
LSI-based FLT. 
@Lukins-etal_2010

@Biggers-etal_2014 investigate the various configuration parameters for an
LDA-based FLT.

@Bassett-Kraft_2013 find that using structural term weighting increases the
performance of an LDA-based FLT.


<!--
### Textual
-->

@Wilson_2010
@Poshyvanyk-Marcus_2007
@Gay-etal_2009

@Shepherd-etal_2006
@Hill-etal_2009
@Abebe-etal_2009


<!--
### Static & Textual
-->

@Zhao-etal_2006
@Hill-etal_2007
@Shao-etal_2012

<!--
### Dynamic & Textual
-->

@Liu-etal_2007
@Poshyvanyk-etal_2007

<!--
### Dynamic & Static & Textual
-->

@Eaddy-etal_2008

<!--
### Other
-->

@Ratanotayanon-etal_2010

<!--
### TBD
-->

@Dit-etal_2011
@Rajlich-Wilde_2002
@Revelle-etal_2010
@Scanniello-Marcus_2011
