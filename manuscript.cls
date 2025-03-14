% Author: Vivek Myers <vivek.myers@gmail.com>
% Date: December 30, 2024

\ProvidesClass{manuscript}[2024/12/30 v1.0 simple manuscript class]
\LoadClassWithOptions{article}

\gdef\@enlarge@notice{}
\providecommand{\@noticeshift}{2\baselineskip}
\newcommand{\notice}[1]{%
    \providecommand\@noticebuf{}%
    \expandafter\def\expandafter\@noticebuf\expandafter{\@noticebuf\hbox{#1}}%
    \gdef\@enlarge@notice{\enlargethispage{\@noticeshift}\global\let\@enlarge@notice\relax}%
}
\let\@namesize\Large
\let\@authsize\large

\newskip\@author@stretch
\@author@stretch=\z@ plus 8fill
\DeclareOption{nodist}{\notice{Do not distribute.}}
\DeclareOption{preprint}{\notice{Preprint.}}
\DeclareOption{smallauthors}{%
    \global\let\@namesize\large%
    \global\let\@authsize\normalsize%
    \@author@stretch=\z@ plus 10fill%
}

\ProcessOptions

\RequirePackage{microtype}
\RequirePackage{palatino}
\RequirePackage{fancyhdr}
\RequirePackage[margin=1.25in]{geometry}
\def\ttdefault{lmtt}

\setlength{\paperheight}{11in}
\setlength{\paperwidth}{8.5in}

\widowpenalty=10000
\clubpenalty=10000
\PassOptionsToPackage{sort&compress}{natbib}

\flushbottom\sloppy

\def\maketitle{
    \begingroup%
        \def\thefootnote{\fnsymbol{footnote}}%
        \def\@makefnmark{\hbox to 0pt{$^{\@thefnmark}$\hss}}%
        \long\def\@makefntext##1{\parindent 1em\noindent%
        \hbox to1.8em{\hss $\m@th ^{\@thefnmark}$}##1}%
        \@maketitle\@thanks%
        \@notice%
    \endgroup%
    \setcounter{footnote}{0}%
    \thispagestyle{first}%
}

\newcommand{\@notice}{%
    \begingroup
        \let\thefootnote\relax%
        \@enlarge@notice%
        \ifdefined\@noticebuf%
            \footnotetext{\vbox{\@noticebuf}} %
        \fi%
    \endgroup%
}

\pagestyle{fancy}
\rhead{\@date}
\lhead{\@shorttitle}
\fancypagestyle{first}{\lhead{}\cfoot{}}

\def\@shorttitle{\@title}
\def\shorttitle#1{\gdef\@shorttitle{#1}}

\newenvironment{authorblock}[1]{%
    \@authsize%
    \hspace*{0.5\p@}%
    \begin{tabular}[t]{@{\hskip1\p@}l}%
    \hspace*{-0.5\p@}\vspace{1.5\p@}\@namesize\rule{\z@}{#1}\ignorespaces%
}{%
    \end{tabular}%
}

\def\@maketitle{%
    \vbox{%
        \hsize\textwidth%
        {\LARGE\bfseries\raggedright\@title\par}%
        \newskip\@start@offset%
        \newskip\@abstract@offset%
        \newskip\@extra@offset%
        \newskip\@start@skip%
        \global\@start@skip=20\p@ plus 2\p@%
        \global\@abstract@offset=10\p@ plus 2\p@%
        \global\@start@offset=4\p@ plus 4\p@%
        \global\@extra@offset=24\p@ plus 2\p@%
        \def\and{%
            \end{authorblock}%
            \global\@start@offset=8\p@ plus 4\p@%
            \global\@abstract@offset=14\p@ plus 2\p@%
            \hspace*{2\p@ plus 1fill}%
            \begin{authorblock}{\@extra@offset}%
        }%
        \let\And\and%
        \def\AND{%
            \end{authorblock}%
            \rule{\z@}{\@extra@offset}%
            \global\@start@offset=8\p@ plus 4\p@%
            \global\@abstract@offset=8\p@ plus 2\p@%
            \global\@extra@offset=20\p@ plus 4\p@%
            \cr%
            \begin{authorblock}{\@extra@offset}%
        }%
        \if\relax\@author\relax%
            \vskip 12\p@%
        \else%
            \halign{%
                \hbox to \hsize{##\hspace*{\@author@stretch}}\cr%
                \begin{authorblock}{\@start@skip}\@author\end{authorblock}\cr%
            }%
        \fi%
        \vskip\@start@offset%
    }%
}

\renewenvironment{abstract}{%
    \vskip\@abstract@offset%
    \centerline{\large\bfseries Abstract}%
    \begin{quote}\unskip\smallskip%
}{%
    \par\end{quote}%
    \vspace*{1ex plus 0.5ex minus 0.5ex}%
}%

\def\section{\@startsection{section}{1}{\z@}{-1.5ex plus -0.5ex minus -0.2ex}{1ex plus 0.3ex minus 0.2ex}{\Large\bfseries\raggedright}}
\def\subsection{\@startsection{subsection}{2}{\z@}{-1.2ex plus -0.5ex minus -0.2ex}{0.8ex plus 0.2ex}{\large\bfseries\raggedright}}
\def\subsubsection{\@startsection{subsubsection}{3}{\z@}{-0.75ex plus -0.5ex minus -0.2ex}{0.5ex plus 0.2ex}{\bfseries\raggedright}}
\def\paragraph{\@startsection{paragraph}{4}{\z@}{0.5ex plus 0.5ex minus 0.2ex}{-0.5em}{\normalsize\bfseries\raggedright}}
\def\subparagraph{\@startsection{subparagraph}{5}{\z@}{0.5ex plus 0.5ex minus 0.2ex}{-0.5em}{\normalsize\itshape\raggedright}}

\footnotesep 7pt
\skip\footins 11pt plus 4pt minus 2pt
\def\footnoterule{\kern-3pt \hrule width 12pc \kern 2.6pt }
\setcounter{footnote}{0}

\parindent 0pt
\topsep 4pt plus 1pt minus 2pt
\partopsep 1pt plus 0.5pt minus 0.5pt
\itemsep 2pt plus 1pt minus 0.5pt
\parsep 2pt plus 1pt minus 0.5pt
\parskip .5pc

\leftmargin 3pc
\leftmargini\leftmargin
\leftmarginii 2em
\leftmarginiii 1.5em
\leftmarginiv 1.0em
\leftmarginv .5em

\def\@listi{\leftmargin\leftmargini}
\def\@listii{
    \leftmargin\leftmarginii
	\labelwidth\leftmarginii
    \advance\labelwidth-\labelsep
	\topsep 2pt plus 1pt minus 0.5pt
	\parsep 1pt plus 0.5pt minus 0.5pt
	\itemsep\parsep
}
\def\@listiii{
    \leftmargin\leftmarginiii
	\labelwidth\leftmarginiii
    \advance\labelwidth-\labelsep
	\topsep 1pt plus 0.5pt minus 0.5pt
	\parsep \z@
    \partopsep 0.5pt plus 0pt minus 0.5pt
	\itemsep\topsep
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
	\labelwidth\leftmarginvi\advance\labelwidth-\labelsep
}

\abovedisplayskip 7pt plus 2pt minus5pt
\belowdisplayskip\abovedisplayskip
\abovedisplayshortskip 0pt plus 3pt
\belowdisplayshortskip 4pt plus 3pt minus3pt

