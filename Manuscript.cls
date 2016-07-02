% Manuscript Class for an ETD
% Department of Computer Science
% The University of Alabama
%
% Original by
% Nicholas A. Kraft <nkraft@cs.ua.edu>, <nicholas.a.kraft@us.abb.com>
%
% Modified by
% Christopher S. Corley <cscorley@crimson.ua.edu>

\def\filedate{2014/12/01}
\def\fileversion{v1.1}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{Manuscript}[%
   \filedate\space\fileversion
   Manuscript Class for a UA ETD
   ]

%-- Variable declaration/initialization
%--

%---- Public variables
\renewcommand{\title}[1]{\gdef\ETD@title{#1}}
\renewcommand{\author}[1]{\gdef\ETD@author{#1}}
\renewcommand{\date}[1]{\gdef\ETD@date{#1}}
\newcommand{\submissioninfo}[1]{\gdef\ETD@submissioninfo{#1}}
\newcommand{\thesistype}[1]{\gdef\ETD@thesistype{#1}}
\newcommand{\location}[1]{\gdef\ETD@location{#1}}

\title{---}
\author{---}
\date{---}
\submissioninfo{---}
\thesistype{---}
\location{---}


%---- Private variables
\newcommand{\ETD@draft}{false}


%-- Document Options
%--
\DeclareOption{draft}{%
   \PassOptionsToClass{draft}{report}
   \PassOptionsToPackage{final}{graphicx}
   \PassOptionsToPackage{final}{hyperref}
   \PassOptionsToPackage{final}{listings}
   \renewcommand{\ETD@draft}{true}
}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions

\LoadClass[letterpaper,onecolumn,oneside]{report}

%-- Packages

%---- fonts
\RequirePackage[T1]{fontenc}
\RequirePackage{textcomp}
\RequirePackage{mathptmx}              % roman
\RequirePackage[scaled=0.92]{helvet}   % sans serif
\RequirePackage{courier}               % typewriter
\RequirePackage{pifont}                % Zapf Dingbats

%---- other
\RequirePackage[bottom,hang,stable]{footmisc}
\RequirePackage[caption=false]{subfig}
\RequirePackage[pdftex,dvipsnames]{color}
\RequirePackage[pdftex]{geometry}
\RequirePackage[pdftex]{graphicx}
\RequirePackage[square,longnamesfirst,sort&compress]{natbib}
\RequirePackage{booktabs}
\RequirePackage{calc}
\RequirePackage{comment}
\RequirePackage{fancyhdr}
\RequirePackage{ifthen}
\RequirePackage{indentfirst}
\RequirePackage{lineno}
\RequirePackage{lipsum}
\RequirePackage{listings}
\RequirePackage{longtable}
\RequirePackage{setspace}
\RequirePackage{titlesec}
\RequirePackage{ulem}
\RequirePackage[
,  pdftex
,  letterpaper
,  colorlinks
,  hyperfootnotes
,  linktocpage
,  citecolor=black
,  linkcolor=black
,  urlcolor=black
]{hyperref}

%-- Package Configuration
%--

%---- geometry
\geometry{letterpaper}
\geometry{textwidth=6.5in}
\geometry{textheight=9in}
\geometry{top=1in,left=1in}

%---- fancyhdr
\fancyhf{}
\cfoot{\thepage}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

%---- lineno
\renewcommand{\linenumberfont}{\normalfont\scriptsize\sffamily}
\setlength{\linenumbersep}{2em}

%---- titlesec
\titleformat{\chapter}[display]
   {\centering\normalsize}{\vspace*{0.5\baselineskip}\@chapapp\space\thechapter}{0pt}{\MakeUppercase}
\titleformat{name=\chapter,numberless}[display]
   {\centering\normalsize}{\vspace*{\baselineskip}}{0pt}{\MakeUppercase}
\titleformat{\section}[hang]
   {\normalsize}{\thesection}{1em}{}
\titleformat{\subsection}[hang]
   {\normalsize}{\thesubsection}{1em}{}
\titleformat{\subsubsection}[hang]
   {\itshape\normalsize}{\thesubsubsection}{1em}{}
\titleformat{\paragraph}[runin]
   {\itshape\normalsize}{\theparagraph}{1em}{}
\titlespacing{\chapter}{0pt}{.5in}{*0}
\titlespacing{\section}{0pt}{*0}{*0}
\titlespacing{\subsection}{0pt}{*0}{*0}
\titlespacing{\subsubsection}{0pt}{*0}{*0}
\titlespacing{\paragraph}{0pt}{1.5em}{3em}

%---- ulem
\normalem


%-- Document properties
%--

\AtBeginDocument{%
   \setlength{\footnotemargin}{1em}
   \setlength{\parindent}{0.5in}
   \setcounter{tocdepth}{2}
   \setcounter{secnumdepth}{3}
   \pagestyle{fancy}
   \pagenumbering{roman}
   \widowpenalty=10000
   \clubpenalty=10000
}


%-- Preliminary pages

%---- Title page and copyright page
\renewcommand{\maketitle}[1]{%
   \cleardoublepage
   \thispagestyle{empty}
   \phantomsection
   \vspace*{0.5in}
   \vspace*{\baselineskip}
   \begin{center}
      \begin{spacing}{2.0}
         \MakeUppercase{\ETD@title}\\
         \vspace{\baselineskip}
         by\\
         \MakeUppercase{\ETD@author}\\
         \begin{spacing}{1.0}
            \vspace{\baselineskip}
                \committeemembers
            \vspace{\baselineskip}
         \end{spacing}
         \vspace{\baselineskip}
         \ETD@thesistype\\
         \vspace{\baselineskip}
         \begin{spacing}{1.0}
            \vspace{\baselineskip}
            \ETD@submissioninfo
            \vspace{\baselineskip}
         \end{spacing}
         \vspace{2\baselineskip}
         \ETD@location\\
         \vspace{\baselineskip}
         \ETD@date
         \ifthenelse{\equal{\ETD@draft}{true}}{%
             \\
            \vspace{\baselineskip}
            {\it Draft last updated on \today}
        }{}
      \end{spacing}
   \end{center}

   \cleardoublepage
   \thispagestyle{empty}
   \phantomsection
   \vspace*{\fill}
   \begin{center}
      Copyright\space\ETD@author\space\ETD@date\\
      ALL RIGHTS RESERVED
   \end{center}
}

%---- Abstract
\renewenvironment{abstract}{%
   \cleardoublepage
   \setcounter{page}{2}
   \phantomsection
   \addcontentsline{toc}{chapter}{ABSTRACT}
   \vspace*{0.5in}
   \vspace*{\baselineskip}
   \begin{center}
      ABSTRACT
   \end{center}
   \vspace{-\baselineskip}
   \begin{spacing}{2.0}
}{%
   \end{spacing}
   \cleardoublepage
}

%---- Dedication
\newenvironment{dedication}{%
   \phantomsection
   \addcontentsline{toc}{chapter}{DEDICATION}
   \vspace*{0.5in}
   \vspace*{\baselineskip}
   \begin{center}
      DEDICATION
   \end{center}
   \vspace{-\baselineskip}
   \begin{spacing}{2.0}
}{%
   \end{spacing}
   \cleardoublepage
}

%---- Acknowledgments
\newenvironment{acknowledgments}{%
   \phantomsection
   \addcontentsline{toc}{chapter}{ACKNOWLEDGMENTS}
   \vspace*{0.5in}
   \vspace*{\baselineskip}
   \begin{center}
      ACKNOWLEDGMENTS
   \end{center}
   \vspace{-\baselineskip}
   \begin{spacing}{2.0}
}{%
   \end{spacing}
   \cleardoublepage
}

\newenvironment{abbreviations}{%
   \phantomsection
   \addcontentsline{toc}{chapter}{LIST OF ABBREVIATIONS AND SYMBOLS}
   \vspace*{0.5in}
   \vspace*{\baselineskip}
   \begin{center}
      LIST OF ABBREVIATIONS AND SYMBOLS
   \end{center}
   \vspace{\baselineskip} % used to be -\baselineskip
   \begin{spacing}{1.0}
}{%
   \end{spacing}
   \cleardoublepage
}

%---- Table of Contents
\renewcommand{\tableofcontents}{%
   \phantomsection
   \vspace*{0.5in}
   \vspace*{\baselineskip}
   \begin{center}
      CONTENTS
   \end{center}
   \vspace{-\baselineskip}
   \begin{spacing}{0.5}
      \@starttoc{toc}
   \end{spacing}
   \cleardoublepage
}
\renewcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \setlength\@tempdima{1.5em}%
    \begingroup
      \leavevmode
      \@dottedtocline{1}{0em}{1.4em}{\MakeUppercase{#1}}{#2}
      \penalty\@highpenalty
    \endgroup
  \fi}
\renewcommand*\l@section[2]{
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \setlength\@tempdima{1.5em}%
    \begingroup
      \leavevmode
      \@dottedtocline{1}{1.5em}{2.3em}{{#1}}{#2}
      \penalty\@highpenalty
    \endgroup
  \fi}
\renewcommand*\l@subsection[2]{
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \setlength\@tempdima{1.5em}%
    \begingroup
      \leavevmode
      \@dottedtocline{2}{3.8em}{3.2em}{{#1}}{#2}
      \penalty\@highpenalty
    \endgroup
  \fi}
\renewcommand*\l@figure[2]{
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \setlength\@tempdima{1.5em}%
    \begingroup
      \leavevmode
      \@dottedtocline{1}{1.5em}{2.3em}{{#1}}{#2}
      \penalty\@highpenalty
    \endgroup
  \fi}
\let\l@table\l@figure
\def\ps@tocstart{
   \setlength{\topmargin}{0.5in}
}
\def\ps@toccont{
   \setlength{\topmargin}{-0.5in}
}

%---- List of Tables
\renewcommand{\listoftables}{%
   \phantomsection
   \addcontentsline{toc}{chapter}{LIST OF TABLES}
   \vspace*{0.5in}
   \vspace*{\baselineskip}
   \begin{center}
      LIST OF TABLES
   \end{center}
   \vspace{-\baselineskip}
   \begin{spacing}{0.5}
      \@starttoc{lot}
   \end{spacing}
   \cleardoublepage
}

%---- List of Figures
\renewcommand{\listoffigures}{%
   \phantomsection
   \addcontentsline{toc}{chapter}{LIST OF FIGURES}
   \vspace*{0.5in}
   \vspace*{\baselineskip}
   \begin{center}
      LIST OF FIGURES
   \end{center}
   \vspace{-\baselineskip}
   \begin{spacing}{0.5}
      \@starttoc{lof}
   \end{spacing}
   \cleardoublepage
}

\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
                         \addcontentsline{toc}{chapter}%
                                   {\protect\numberline{\thechapter}#1}%
                    \else
                      \addcontentsline{toc}{chapter}{#1}%
                    \fi
                    \chaptermark{#1}%
                    \if@twocolumn
                      \@topnewpage[\@makechapterhead{#2}]%
                    \else
                      \@makechapterhead{#2}%
                      \@afterheading
                    \fi}

\renewcommand\appendix{\par
  \cleardoublepage
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \setcounter{table}{0}
  \gdef\@chapapp{\appendixname}%
  \gdef\thechapter{\@Alph\c@chapter}
  \renewcommand{\thetable}{A.\arabic{table}}
  \renewcommand{\appendixtocname}{Appendix}
  \addappheadtotoc
  \newpage
  }

%-- Body

\newenvironment{body}{%
   \setcounter{page}{1}
   \pagenumbering{arabic}
   \begin{spacing}{2.0}
      \ifthenelse{\equal{\ETD@draft}{true}}{%
        \renewcommand\linenumberfont{\color{gray}\normalfont\tiny\sffamily}
         \begin{linenumbers}
      }{}
}{%
      \ifthenelse{\equal{\ETD@draft}{true}}{%
         \end{linenumbers}
      }{}
   \end{spacing}
   \cleardoublepage
}

\newcommand{\newtocpage}{%
   \addtocontents{toc}{\protect\newpage\protect\vspace*{-2\baselineskip}}
}

%---- References
\renewenvironment{thebibliography}[1]{%
	\phantomsection
	\addcontentsline{toc}{chapter}{REFERENCES}
	\cleardoublepage
   \vspace*{0.5in}
   \vspace*{\baselineskip}
   \begin{center}
      REFERENCES
   \end{center}
   \list{%
      [\arabic{enumi}]
   }{%
      \settowidth\labelwidth{[#1]}
      \itemsep\baselineskip
      \leftmargin\labelwidth
      \advance\leftmargin\labelsep
      \advance\leftmargin\bibindent
      \itemindent -\bibindent
      \listparindent \itemindent
      \parsep \z@
      \usecounter{enumi}
   }
   \def\newblock{}
   \sloppy
   \sfcode`\.=1000\relax
}{%
	\cleardoublepage
}

\renewcommand{\cite}[1]{\citep{#1}}
\newcommand{\shortcite}[1]{\citeyearpar{#1}}

% vim:syntax=tex
