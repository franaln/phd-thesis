\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}[2015/03/22 Thesis class]

% Draft Option
\newif\if@draftmode
\@draftmodefalse
\DeclareOption{draft}{\@draftmodetrue}

%%-- Fallback
\DeclareOption*{
  \ClassWarning{myclass}{Unknown option '\CurrentOption'}
}

%%-- Execute default options
%% \ExecuteOptions{9pt,twoside}
\PassOptionsToClass{10pt,twoside}{book}

%%-- Process given options
\ProcessOptions\relax

%%-- Load base
\LoadClass{book}


%%-- Load additional packages and commands.
%\RequirePackage{etex}
\RequirePackage[final]{microtype}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
%\RequirePackage{lmodern}
\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\RequirePackage{amssymb}
\RequirePackage{bm}
\RequirePackage{tikz}
\RequirePackage{booktabs}
\RequirePackage{titlesec} % to format chapter title pages
\RequirePackage[final]{graphicx}
\RequirePackage[unicode=true]{hyperref}
\RequirePackage{bookmark}
\RequirePackage[spanish]{babel}
\RequirePackage{multirow}
\RequirePackage{pgfplots}
\RequirePackage{xparse}
\RequirePackage{xifthen}
\RequirePackage{tabularx}
\RequirePackage{rotating}
\RequirePackage{accents}
\RequirePackage{enumitem}
\RequirePackage{lineno}

%%-- Additional TeX/LaTeX code...
\usepackage[nodisplayskipstretch]{setspace}
\setstretch{1.2}

% increase headheight to accomodate fancy headers
%% \addtolength{\headheight}{2.5pt}

% minor changes to tables
%%\setlength{\extrarowheight}{2pt}
%% \setlength{\arrayrulewidth}{0.4pt}
%% \setlength{\doublerulesep}{0pt}
%% \setlength{\tabcolsep}{15pt}
\renewcommand{\arraystretch}{1.25}


% enter only chapters and sections in TOC---subsecs as a try
\setcounter{tocdepth}{2}

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
  \RequirePackage[colorinlistoftodos,textsize=footnotesize,textwidth=2.5cm]{todonotes} % draft with TODOs
\else
  \usepackage[disable]{todonotes} % final without TODOs
\fi


% Redefine '/chapter' to always start on an odd page. Should make no difference in singleside mode.
\def\chapter{\cleardoublepage	% Starts new page.
  \thispagestyle{plain}         % Page style of chapter page is 'plain'
  \global\@topnum\z@            % Prevents figures from going at top of page.
  \@afterindentfalse            % Suppresses indent in first paragraph.  Change
  \secdef\@chapter\@schapter}	% to \@afterindenttrue to have indent.

% format chapter title pages
\titleformat{\chapter}
            [display] % shape/type of title
            {} % formatting commands applied to both label and title
            {\centering\resizebox{!}{0.4cm}{\thechapter}} %{\vspace{-2cm} \hfill \large [\sc Cap\'itulo \thechapter]}
            {1cm} % separation between number and chapter title
            {\fontsize{24pt}{22pt}\selectfont\centering\bfseries\sc} % code preceding title. Last cmd can take arg, which is title
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
  \fancyfoot{}
  \fancyfoot[RO,LE]{\thepage}
\else
  \fancyhead{}
  \fancyhead[RO,LE]{}
  \renewcommand{\headrulewidth}{0pt}
  \fancyfoot{}
  \fancyfoot[RO,LE]{\thepage}
\fi

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
  anchorcolor=black,
  pdfpagelayout=OneColumn
}

\RequirePackage[pdftex,paper=a4paper,hmarginratio=1:1,vmarginratio=1:1,scale=0.75,bindingoffset=5mm,
  top=25mm,bottom=25mm,left=25mm,right=25mm]{geometry}

%% \RequirePackage{etoolbox}
%% \makeatletter
%% \patchcmd{\@addmarginpar}{\ifodd\c@page}{\ifodd\c@page\@tempcnta\m@ne}{}{}
%% \makeatother
%% \reversemarginpar

%% \endinput
