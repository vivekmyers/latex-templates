% Author: Vivek Myers <vivek.myers@gmail.com>
% Date: 2024-12-30

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{paper}[2024-08-31 paper class]
\LoadClassWithOptions{article}

\gdef\@enlarge@notice{}
\providecommand{\@noticeshift}{2\baselineskip}
\newcommand{\notice}[1]{%
    \providecommand\@noticebuf{}%
    \expandafter\def\expandafter\@noticebuf\expandafter{\@noticebuf\hbox{#1}}%
    \gdef\@enlarge@notice{\enlargethispage{\@noticeshift}\global\let\@enlarge@notice\relax}%
}
\let\@authsize=\large
\providecommand\@authorspace{\z@ plus 0.75fill}

\DeclareOption{nodist}{\notice{Do not distribute.}}
\DeclareOption{preprint}{\notice{Preprint.}}
\DeclareOption{smallauthors}{%
    \global\let\@authsize\normalsize%
    \def\@authorspace{\z@ plus 0.5fill}
}
\DeclareOption{twocolumn}{
    \setlength{\columnsep}{0.25in}
    \AtBeginDocument{
        \twocolumn
    }
}

\ProcessOptions

\PassOptionsToPackage{sort&compress}{natbib}
\PassOptionsToPackage{linktocpage}{hyperref}

% set page geometry
\RequirePackage[verbose=true,letterpaper]{geometry}
\RequirePackage{microtype}
\RequirePackage{palatino}
\RequirePackage{fancyhdr}
\def\ttdefault{lmtt}

\if@twocolumn
    \newgeometry{
        textheight=9in,
        textwidth=6.75in,
        headheight=12pt,
        headsep=10pt,
        footskip=25pt,
        centering,
    }
\else
    \newgeometry{
        textheight=8.75in,
        textwidth=6.25in,
        headheight=12pt,
        headsep=15pt,
        footskip=25pt,
        centering,
    }
\fi

\pagestyle{fancy}
\fancyhf{}
\fancyhead[C]{\@shorttitle}
\fancyfoot[C]{\thepage}

\def\@shorttitle{\@title}
\def\shorttitle#1{\gdef\@shorttitle{#1}}

\AtBeginDocument{
    \@ifpackageloaded{fullpage}{\PackageWarning{paper}{%
            fullpage package not allowed! Overwriting formatting.%
    }}{}
    \thispagestyle{empty}
}

\widowpenalty=10000
\clubpenalty=10000
\flushbottom
\sloppy

\def\section{\@startsection{section}{1}{\z@}{-1.5ex plus -0.5ex minus -0.2ex}{1ex plus 0.3ex minus 0.2ex}{\Large\bfseries\raggedright}}
\def\subsection{\@startsection{subsection}{2}{\z@}{-1.2ex plus -0.5ex minus -0.2ex}{0.8ex plus 0.2ex}{\large\bfseries\raggedright}}
\def\subsubsection{\@startsection{subsubsection}{3}{\z@}{-0.75ex plus -0.5ex minus -0.2ex}{0.5ex plus 0.2ex}{\bfseries\raggedright}}
\def\paragraph{\@startsection{paragraph}{4}{\z@}{0.5ex plus 0.5ex minus 0.2ex}{-0.5em}{\normalsize\bfseries\raggedright}}
\def\subparagraph{\@startsection{subparagraph}{5}{\z@}{0.5ex plus 0.5ex minus 0.2ex}{-0.5em}{\normalsize\itshape\raggedright}}
\if@twocolumn
    \def\section{\@startsection{section}{1}{\z@}{-0.12in}{0.02in}{\large\bfseries\raggedright}}
    \def\subsection{\@startsection{subsection}{2}{\z@}{-0.10in}{0.01in}{\normalsize\bfseries\raggedright}}
    \def\subsubsection{\@startsection{subsubsection}{3}{\z@}{-0.08in}{0.01in}{\normalsize\scshape\raggedright}}
\fi

\renewcommand{\topfraction}{0.85}
\renewcommand{\bottomfraction}{0.4}
\renewcommand{\textfraction}{0.1}
\renewcommand{\floatpagefraction}{0.7}

\newlength{\@neuripsabovecaptionskip}\setlength{\@neuripsabovecaptionskip}{7\p@}
\newlength{\@neuripsbelowcaptionskip}\setlength{\@neuripsbelowcaptionskip}{\z@}

\setlength{\abovecaptionskip}{\@neuripsabovecaptionskip}
\setlength{\belowcaptionskip}{\@neuripsbelowcaptionskip}

\renewenvironment{table}{
    \setlength{\abovecaptionskip}{\@neuripsbelowcaptionskip}%
    \setlength{\belowcaptionskip}{\@neuripsabovecaptionskip}%
    \@float{table}
}{\end@float}

\setlength{\footnotesep}{7\p@}
\setlength{\skip\footins}{11\p@ \@plus 4\p@ \@minus 2\p@}
\renewcommand{\footnoterule}{\kern-3\p@ \hrule width 12pc \kern 3\p@}
\setcounter{footnote}{0}

\setlength{\parindent}{\z@}
\setlength{\parskip}{5.5\p@}

\setlength{\topsep}{4\p@ \@plus 1\p@ \@minus 2\p@}
\setlength{\partopsep}{1\p@ \@plus 0.5\p@ \@minus 0.5\p@}
\setlength{\itemsep}{2\p@ \@plus 1\p@ \@minus 0.5\p@}
\setlength{\parsep}{2\p@ \@plus 1\p@ \@minus 0.5\p@}
\setlength{\leftmargin}{3pc}
\setlength{\leftmargini}{\leftmargin}
\setlength{\leftmarginii}{2em}
\setlength{\leftmarginiii}{1.5em}
\setlength{\leftmarginiv}{1.0em}
\setlength{\leftmarginv}{0.5em}
\if@twocolumn
    \leftmargin 2em
    \leftmargini\leftmargin
    \leftmarginii 2em
    \leftmarginiii 1.5em
    \leftmarginiv 1.0em
    \leftmarginv 0.5em
    \leftmarginvi 0.5em
    \labelwidth\leftmargini\advance\labelwidth-\labelsep \labelsep 5pt
\fi
\def\@listi{\leftmargin\leftmargini}
\def\@listii{
    \leftmargin\leftmarginii
    \labelwidth\leftmarginii
    \advance\labelwidth-\labelsep
    \topsep 2\p@ \@plus 1\p@ \@minus 0.5\p@
    \parsep 1\p@ \@plus 0.5\p@ \@minus 0.5\p@
    \itemsep\parsep
}
\def\@listiii{
    \leftmargin\leftmarginiii
    \labelwidth\leftmarginiii
    \advance\labelwidth-\labelsep
    \topsep 1\p@ \@plus 0.5\p@ \@minus 0.5\p@
    \parsep \z@
    \partopsep 0.5\p@ \@plus 0\p@ \@minus 0.5\p@
    \itemsep \topsep
}
\def\@listiv{
    \leftmargin\leftmarginiv
    \labelwidth\leftmarginiv
    \advance\labelwidth-\labelsep
}
\def\@listv{
    \leftmargin\leftmarginv
    \labelwidth\leftmarginv
    \advance\labelwidth-\labelsep
}
\def\@listvi{
    \leftmargin\leftmarginvi
    \labelwidth\leftmarginvi
    \advance\labelwidth-\labelsep
}

\providecommand{\maketitle}{}%
\renewcommand{\maketitle}{%
    \par%
    \begingroup%
    \renewcommand{\thefootnote}{\fnsymbol{footnote}}%
    \renewcommand{\@makefnmark}{\hbox to \z@{$^{\@thefnmark}$\hss}}%
    \long\def\@makefntext##1{%
        \parindent 1em\noindent%
        \hbox to 1.8em{\hss $\m@th ^{\@thefnmark}$}##1%
    }%
    \if@twocolumn%
        \twocolumn[\@maketitle\strut]%
    \else%
        \@maketitle%
    \fi%
    \@notice%
    \endgroup%
    \let\maketitle\relax%
}

\newcommand{\@toptitlebar}{%
    \hrule height 1\p@%
    \vskip 0.25in%
    \vskip -\parskip%
}
\newcommand{\@bottomtitlebar}{%
    \vskip 0.27in%
    \vskip -\parskip%
    \if@twocolumn%
        \vskip -0.07in%
    \fi%
    \hrule height 1\p@%
}

\newenvironment{authorbox}[1][24\p@ plus 2\p@]{%
    \@authsize%
    \hspace*{\@authorspace}%
    \begin{tabular}[t]{c}%
    \bfseries\rule{\z@}{#1}\ignorespaces%
}{%
    \end{tabular}%
    \hspace*{\@authorspace}%
}

\renewcommand{\@maketitle}{%
    \vbox{%
        \hsize\textwidth%
        \linewidth\hsize%
        \@toptitlebar%
        \centering%
        {\LARGE\bfseries\@title\par}%
        \@bottomtitlebar%
        \newskip\date@offset%
        \newskip\date@adjust%
        \date@offset=12\p@ plus 2\p@%
        \date@adjust=0\p@%
        \def\and{%
            \end{authorbox}%
            \global\date@offset=21\p@ plus 2\p@%
            \begin{authorbox}%
        }%
        \let\And\and%
        \def\AND{%
            \end{authorbox}%
            \global\date@offset=18\p@ plus 2\p@%
            \global\date@adjust=5\p@ 
            \hspace*{\fill}%
            \linebreak%
            \hspace*{\fill}%
            \begin{authorbox}%
        }%
        \vspace*{0.5ex}%
        \if\relax\@author\relax%
            \vskip 18\p@%
        \else%
            \parbox[t]{\linewidth}{%
                \centering%
                \hspace*{\fill}%
                \begin{authorbox}%
                    \@author%
                \end{authorbox}%
                \hspace*{\fill}%
            }%
        \fi%
        \par%
        \if\relax\@date\relax\else%
            \skip0=\the\dimexpr\date@adjust+\date@offset\relax%
            \vbox{\centering\begin{authorbox}[\skip0]\normalfont\large\@date\end{authorbox}}%
        \fi%
        \vskip 1.5ex plus 1ex minus 0.5ex%
        \par%
    }%
}%

\newcommand{\@notice}{%
    \@enlarge@notice%
    \ifdefined\@noticebuf%
        \footnotetext{\vbox{\@noticebuf}}%
    \fi%
}

\renewenvironment{abstract}%
{%
    \vskip 2ex%
    \centerline%
    {\large\bfseries Abstract}%
    \begin{quote}\unskip\smallskip%
}{%
    \par%
    \end{quote}%
    \vskip 1ex%
}%

\if@twocolumn
    \def\@normalsize{\@setsize\normalsize{11pt}\xpt\@xpt}
    \def\small{\@setsize\small{10pt}\ixpt\@ixpt}
    \def\footnotesize{\@setsize\footnotesize{10pt}\ixpt\@ixpt}
    \def\scriptsize{\@setsize\scriptsize{8pt}\viipt\@viipt}
    \def\tiny{\@setsize\tiny{7pt}\vipt\@vipt}
    \def\large{\@setsize\large{14pt}\xiipt\@xiipt}
    \def\Large{\@setsize\Large{16pt}\xivpt\@xivpt}
    \def\LARGE{\@setsize\LARGE{20pt}\xviipt\@xviipt}
    \def\huge{\@setsize\huge{23pt}\xxpt\@xxpt}
    \def\Huge{\@setsize\Huge{28pt}\xxvpt\@xxvpt}
\fi

