\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}[2015/03/22 Thesis class]

% Draft Option
\newif\if@draftmode
\@draftmodefalse
\DeclareOption{draft}{\@draftmodetrue}

% Print/Online option
\newif\if@printmode
\@printmodefalse
\DeclareOption{print}{\@printmodetrue}

%%-- Fallback
\DeclareOption*{
  \ClassWarning{myclass}{Unknown option '\CurrentOption'}
}

%%-- Execute default options
\ExecuteOptions{a4paper,12pt,twoside}

%%-- Process given options
\ProcessOptions\relax

%%-- Load base
\LoadClass{book}

%%-- Load additional packages and commands.
\RequirePackage[final]{microtype}
\RequirePackage[utf8]{inputenc}
\RequirePackage{lineno}
\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\RequirePackage{bm}
\RequirePackage{tikz}
\RequirePackage{booktabs}
\RequirePackage{titlesec} % to format chapter title pages
\RequirePackage[final]{graphicx}
\RequirePackage[unicode=true]{hyperref}
\RequirePackage[spanish]{babel}
\RequirePackage{multirow}
\RequirePackage{pgfplots}
\RequirePackage{xparse}
\RequirePackage{xifthen}
\RequirePackage{tabularx}
\RequirePackage{rotating}
\RequirePackage{accents}


%%-- Additional TeX/LaTeX code...
\renewcommand\baselinestretch{1.2}
\pdfpagewidth=\the\paperwidth
\pdfpageheight=\the\paperheight

% increase headheight to accomodate fancy headers
\addtolength{\headheight}{2.5pt}

% minor changes to tables
%%\setlength{\extrarowheight}{2pt}
\setlength{\arrayrulewidth}{0.4pt}
\setlength{\doublerulesep}{0pt}
\setlength{\tabcolsep}{6pt}
\renewcommand{\arraystretch}{1.05}

% enter only chapters and sections in TOC---subsecs as a try
\setcounter{tocdepth}{1}

% enume\rate down to subsections
\setcounter{secnumdepth}{2}

\def\chaptername{Capítulo}
\addto\captionsspanish{\renewcommand{\tablename}{Tabla}}
\def\bibname{Bibliografía}
\addto\captionsspanish{\renewcommand{\bibname}{Bibliografía}}
\def\figurename{Figura}

\spanishdecimal{.}
\linespread{1.25}


%-- Draft mode
\if@draftmode
\RequirePackage[centering,marginparwidth=2.5cm]{geometry}
\RequirePackage[colorinlistoftodos,textsize=footnotesize,textwidth=2.5cm]{todonotes} % draft with TODOs
\else
\usepackage[disable]{todonotes} % final without TODOs
\setlength{\marginparwidth}{2cm}
\fi

% Add  line numbers
%% \AtBeginDocument{
%%   \if@draftmode
%%   \linenumbers
%%   \fi
%% }

% Redefine '/chapter' to always start on an odd page. Should make no difference in singleside mode.
\def\chapter{\cleardoublepage	% Starts new page.
  \thispagestyle{plain}         % Page style of chapter page is 'plain'
  \global\@topnum\z@            % Prevents figures from going at top of page.
  \@afterindentfalse            % Suppresses indent in first paragraph.  Change
  \secdef\@chapter\@schapter}	% to \@afterindenttrue to have indent.

% format chapter title pages
\definecolor{gray75}{gray}{0.75}
\newcommand{\hsp}{\hspace{20pt}}
%%\titleformat{\chapter}[hang]{\Huge\bfseries}{\thechapter\hsp\textcolor{gray75}{$|$ }\hsp}{0pt}{\Huge\bfseries}
\titleformat{\chapter}
            [display] % shape/type of title
            {} % formatting commands applied to both label and title
            {\centering\resizebox{!}{0.4cm}{\thechapter}} %{\vspace{-2cm} \hfill \large [\sc Cap\'itulo \thechapter]}
            {1cm} % separation between number and chapter title
            {\fontsize{6cm}{1em}\selectfont \sc\centering} % code preceding title. Last cmd can take arg, which is title
            []  % everything inside [] comes after the title

\titleformat{\part}
            [display]
            {\centering\fontsize{10cm}{1em}\selectfont\sc}
            {Parte \thepart}
            {1cm}
            {}
            []

\RequirePackage{tocloft}
\renewcommand{\cftpartfont}{\sc Parte }

\RequirePackage{fancyhdr}
\pagestyle{fancy}
\if@draftmode
\fancyhead{}
\fancyhead[RO,LE]{{\bf \fbox{DRAFT $\cdot$ \today}}}
\renewcommand{\headrulewidth}{0pt}
\else
\fancyhead{}
\fancyhead[RO,LE]{\chaptername}
\fancyfoot{}
\fancyfoot[RE,LO]{\thepage}
\fi

\if@printmode
% For Print version
    \hypersetup{
      final=true,
      plainpages=false,
      pdfstartview=FitV,
      pdftoolbar=true,
      pdfmenubar=true,
      bookmarksopen=true,
      bookmarksnumbered=true,
      breaklinks=true,
      linktocpage,
      colorlinks=true,
      linkcolor=black,
      urlcolor=black,
      citecolor=black,
      anchorcolor=black
    }

    \RequirePackage[pdftex,paper=a4paper,hmarginratio=1:1,
      vmarginratio=1:1,scale=0.75,bindingoffset=5mm]{geometry}
    \hypersetup{pdfpagelayout=OneColumn}
\else
    % For PDF Online version
    \hypersetup{
      final=true,
      plainpages=false,
      pdfstartview=FitV,
      pdftoolbar=true,
      pdfmenubar=true,
      bookmarksopen=true,
      bookmarksnumbered=true,
      breaklinks=true,
      linktocpage,
      colorlinks=true,
      linkcolor=blue,
      urlcolor=blue,
      citecolor=blue,
      anchorcolor=green,
      pdfpagelayout=OneColumn
    }

    %% \RequirePackage[pdftex,paper=a4paper,hmarginratio=1:1,
    %%   vmarginratio=1:1,scale=0.75,width=150mm,top=25mm,bottom=25mm,bindingoffset=6mm]{geometry}
\fi

\RequirePackage{etoolbox}
\makeatletter
\patchcmd{\@addmarginpar}{\ifodd\c@page}{\ifodd\c@page\@tempcnta\m@ne}{}{}
\makeatother
\reversemarginpar

\endinput
