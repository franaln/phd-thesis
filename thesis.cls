\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}[2015/03/22 Thesis class]

%%-- Book options

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
\ExecuteOptions{a4paper,12pt}

%%-- Process given options
\ProcessOptions\relax

%%-- Load base
\LoadClass{book}

%%-- Load additional packages and commands.
\RequirePackage[final]{microtype}
\RequirePackage[latin1]{inputenc}
\RequirePackage{lineno}
\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\RequirePackage{tikz}
\RequirePackage{booktabs}
\RequirePackage{titlesec} % to format chapter title pages
\RequirePackage{graphicx}
\RequirePackage[unicode=true]{hyperref}
\RequirePackage[spanish]{babel}

%%-- Additional TeX/LaTeX code...

\renewcommand\baselinestretch{1.2}

\pdfpagewidth=\the\paperwidth
\pdfpageheight=\the\paperheight


%-- Draft mode

%% todo notes
%% \if@draftmode
%% \usepackage[colorinlistoftodos,textsize=tiny,textwidth=2.5cm]{todonotes} % draft with TODOs
%% \else
%% \usepackage[disable]{todonotes} % final without TODOs
%% \fi
%% \presetkeys{todonotes}{color=yellow!40}{} %%,linecolor=blue!40,bordercolor=blue!40}{}
\newcommand{\todo}[1]{{\color{red!60}(#1)}}

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
  % --- Left mark
  {\hspace*{\fill}{\protect\small\bf \fbox{DRAFT}}
    \hspace*{\fill}
    \protect\makebox[0pt][r]{\protect\small\sl\today. \ifnum\timehh<10 0\fi\number\timehh:\ifnum\timemm<10 0\fi\number\timemm}
  }%--- right mark
  {\protect\makebox[0pt][l]{\protect\small\sl\today. \ifnum\timehh<10 0\fi\number\timehh:\ifnum\timemm<10 0\fi\number\timemm}
    \hspace*{\fill}
    {\protect\small\bf \fbox{DRAFT}}
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
%% \def\chapter{\cleardoublepage	% Starts new page.
%%   \thispagestyle{plain}         % Page style of chapter page is 'plain'
%%   \global\@topnum\z@            % Prevents figures from going at top of page.
%%   \@afterindentfalse            % Suppresses indent in first paragraph.  Change
%%   \secdef\@chapter\@schapter}	% to \@afterindenttrue to have indent.

% format chapter title pages
\titleformat{\chapter}
            [display] % shape/type of title
            {} % formatting commands applied to both label and title
            {\centering\resizebox{!}{0.4cm}{\thechapter}} %{\vspace{-2cm} \hfill \large [\sc Cap\'itulo \thechapter]}
            {1cm} % separation between number and chapter title
            {\fontsize{6cm}{1em}\selectfont \sc\centering} % code preceding title. Last cmd can take arg, which is title
            []  % everything inside [] comes after the title

%\setlength{\marginparwidth}{2cm}

\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhead{}
\fancyhead[RO,LE]{\chaptername} %Thesis Title}
\fancyfoot{}
\fancyfoot[RE,LO]{\thepage}
%\fancyfoot[CO,CE]{Chapter \thechapter}


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

\endinput
