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

%%-- Additional TeX/LaTeX code...
\renewcommand\baselinestretch{1.2}
\pdfpagewidth=\the\paperwidth
\pdfpageheight=\the\paperheight

%-- Draft mode

\if@draftmode
\RequirePackage[centering,marginparwidth=2.5cm]{geometry}
\RequirePackage[colorinlistoftodos,textsize=footnotesize,textwidth=2.5cm]{todonotes} % draft with TODOs
\RequirePackage{etoolbox}
\newcommand{\itodo}[1]{\todo[inline]{#1}}
\else
\usepackage[disable]{todonotes} % final without TODOs
\setlength{\marginparwidth}{2cm}
\fi

\newcommand{\draftheading}%
{
  % compute the time in hours and minutes
  % make new variables \timehh and \timemm
  \newcount\timehh\newcount\timemm
  \timehh=\time
  \divide\timehh by 60 \timemm=\time
  \count255=\timehh\multiply\count255 by -60 \advance\timemm by \count255
  % put in header
  \markboth%
  {\hspace*{\fill}{\protect\small\bf \fbox{DRAFT $\cdot$ \today}}
  }%
  {%
    {\protect\small\bf \fbox{DRAFT $\cdot$ \today}}
    \hspace*{\fill}}
  %
  \pagestyle{myheadings}
}

\AtBeginDocument{
  % Add draft heading and line numbers
  \if@draftmode
  \linenumbers \draftheading
  \fi
}

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
\fancyhead{}
\fancyhead[RO,LE]{\chaptername}
\fancyfoot{}
\fancyfoot[RE,LO]{\thepage}


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
      anchorcolor=green
    }

    \RequirePackage[pdftex,paper=a4paper,hmarginratio=1:1,
      vmarginratio=1:1,scale=0.75,width=150mm,top=25mm,bottom=25mm,bindingoffset=6mm]{geometry}
    \hypersetup{pdfpagelayout=OneColumn}
\fi


\makeatletter
\patchcmd{\@addmarginpar}{\ifodd\c@page}{\ifodd\c@page\@tempcnta\m@ne}{}{}
\makeatother
\reversemarginpar

\endinput
