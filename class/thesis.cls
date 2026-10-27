\ProvidesClass{class/thesis}[thesis]


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% BASE CLASS %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Build on the standard report class with 12pt body text.
\LoadClass[12pt]{report}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PAGE SETUP %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% A4 paper with uniform 2.6cm margins.
\RequirePackage[a4paper, margin=2.6cm]{geometry}

% Custom headers and footers.
\RequirePackage{fancyhdr}

% Configure page style: chapter/section marks in headers, author/title/page in footer.
\newcommand{\setupfancyhdr}{
	\pagestyle{fancy}  % Set fancy page style

	% Clear any existing header and footer
	\fancyhead{}
	\fancyfoot{}

	% Customize chapter and section marks (use ## instead of # in class files)
	\renewcommand{\chaptermark}[1]{\markboth{##1}{}}
	\renewcommand{\sectionmark}[1]{\markright{##1}}

	% Define header layout
	\fancyhead[L]{\nouppercase{\rightmark}}    % Left header: Section title
	\fancyhead[R]{\nouppercase{\itshape\leftmark}}  % Right header: Chapter title

	% Define footer layout
	% NOTE: Replace the placeholder author and title below with your own details.
	\fancyfoot[L]{A. N. Candidate} % Left footer: Author name
	\fancyfoot[C]{\itshape A Modern Thesis Template for the University of Liverpool} % Center footer: Document title
	\fancyfoot[R]{\thepage} % Right footer: Page number

	% Ensure sufficient head height to avoid warnings
	\setlength{\headheight}{14.5pt}
}

% Apply the custom page style at the start of the document.
\AtBeginDocument{\setupfancyhdr}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FONTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Linux Libertine for body text and matching math fonts.
\RequirePackage[tt=false]{libertine}
\RequirePackage{libertinust1math}
\RequirePackage[T1]{fontenc}

% Highlight inline code snippets with a subtle gray background.
\let\oldtexttt\texttt
\renewcommand{\texttt}[1]{\colorbox{gray!15}{\textcolor{black}{\small\oldtexttt{#1}}}}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% COLORS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% pdftex driver is kept for engine compatibility; named colors are available via dvipsnames.
\RequirePackage[pdftex, dvipsnames]{xcolor}

% Brand and hyperlink colors.
\definecolor{primary}{HTML}{145680}
\definecolor{LinkColor}{HTML}{145680}
\definecolor{CiteColor}{HTML}{801456}
\definecolor{UrlColor}{HTML}{568014}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% HYPERLINKS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Colored clickable links and PDF bookmarks. Bookmarks are enabled and opened by default.
\RequirePackage[
	colorlinks,
	breaklinks=true,
	bookmarksopen=true,
	hypertexnames=true,
	linkcolor=LinkColor,
	citecolor=CiteColor,
	urlcolor=UrlColor,
	pdfdisplaydoctitle=true,
]{hyperref}

% Improved PDF bookmark handling; keep URL font consistent with surrounding text.
\RequirePackage{bookmark}
\urlstyle{same}

% Hyperref setup: make sure PDF links are accessible.
\hypersetup{
    pdfdisplaydoctitle=true,
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PARAGRAPH %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% No paragraph indentation; add vertical space instead and fill the last line.
\RequirePackage[parfill]{parskip}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ENUMERATION %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Fine-grained control over list formatting and very deep nesting limits.
\RequirePackage{enumitem}
\setlistdepth{2000}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% TABLE OF CONTENTS %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Deeper control over ToC entries.
\RequirePackage{titletoc}
\setcounter{tocdepth}{2}       % Show up to subsection in ToC
\setcounter{secnumdepth}{3}    % Number up to subsection

% Horizontal rule used around the printed table of contents.
\newcommand{\tocrule}{\bigskip\noindent\rule{\textwidth}{0.8pt}\smallskip}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FIGURES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Sub-figures, multi-column layouts, landscape pages, and image inclusion.
\RequirePackage{subfig, multicol, lscape, graphicx}

% Framed environments drawn with TikZ; reused for figures and tables.
\RequirePackage[framemethod=tikz]{mdframed}

% Extra box alignment options for included graphics.
\RequirePackage[export]{adjustbox}

% Keep floats inside their section to avoid figures drifting too far.
\RequirePackage[section, below]{placeins}

\makeatletter
% Flush floats to the top of float pages.
\setlength{\@fptop}{0pt}
\makeatother

% Redefine figure environment to wrap contents in a subtle framed box.
\let\originalfigure=\figure
\let\endoriginalfigure=\endfigure
\renewenvironment{figure}[1][]{
	\begin{originalfigure}[#1]
		\begin{mdframed}
			[
				linewidth=1.25pt,
				linecolor=black!80,
				backgroundcolor=black!2,
			]
				}{
		\end{mdframed}
	\end{originalfigure}
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CAPTIONS  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Small bold labels with a period separator; table captions are expected above the table.
\RequirePackage[
	font=small,
	labelfont=bf,
	hypcap=false,
	tableposition=above,
	labelsep=period,
	% margin=1em,
	% textformat=period,
]{caption}

% Short caption helpers: store the short version in the LoF/LoT and prefix the long caption.
\newcommand*\mycaption[2]{\caption[#1]{\textbf{#1:} #2}}
\newcommand*\mycaptionof[3]{\captionof{#1}[#2]{\textbf{#2:} #3}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TABLES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Rich table support: auto-width columns, rules, multi-row/cell, long tables, and notes.
\RequirePackage{tabularx, booktabs, multirow, makecell, longtable, threeparttable}

% Keep default table header font, tighten column spacing, and slightly increase row height.
\renewcommand\theadfont{}
\setlength{\tabcolsep}{5pt}
\renewcommand{\arraystretch}{1.1}

% Redefine table environment to wrap contents in a subtle framed box (matching figures).
\let\originaltable=\table
\let\endoriginaltable=\endtable
\renewenvironment{table}[1][]{
	\begin{originaltable}[#1]
		\begin{mdframed}[
				linewidth=1.25pt,
				linecolor=black!80,
				backgroundcolor=black!2,
			]
				}{
		\end{mdframed}
	\end{originaltable}
}

% Redefine tabular to use a smaller font size while preserving the original environment.
\let\originaltabular=\tabular
\let\endoriginaltabular=\endtabular
\renewenvironment{tabular}[1][]{
	\bgroup
	\footnotesize
	\originaltabular[#1]
}{
	\endoriginaltabular
	\egroup
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% MINIPAGE AND CUSTOM BOX %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% A minipage wrapped in the same subtle frame used for figures/tables.
\newenvironment{framedminipage}[2][t]{%
	\vspace{1em}
	\begin{mdframed}[
			linewidth=1.25pt,
			linecolor=black!80,
			backgroundcolor=black!2,
		]
		\begin{minipage}[#1]{#2}
			}{%
		\end{minipage}
	\end{mdframed}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MATH %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Core math typesetting, split-level fractions, SI units, and symbol fonts.
\RequirePackage{amsmath, xfrac, siunitx, pifont}

% siunitx configuration: threshold-based exponents, grouped digits, and font matching.
\sisetup{
	separate-uncertainty = true,       % Display uncertainty separately
	round-pad = true,                  % Remove additional padding
	table-auto-round = true,
	table-alignment-mode = format,
	retain-zero-uncertainty = true,
	group-separator = {,},
	detect-all = true,
	group-minimum-digits = 4,
	exponent-mode = threshold,
	exponent-thresholds = -4:4,
	mode = match,
	text-family-to-math = true,
	text-series-to-math = true,
	propagate-math-font = true
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CODE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Syntax-highlighted code listings using a separate float type.
\RequirePackage[newfloat]{minted}

% Rename the list of listings for the thesis.
\renewcommand*{\listlistingname}{List of Source Code}

% Default minted style: line numbers, single frame, light background, and broken long lines.
\setminted{
	linenos,
	firstline=1,
	% baselinestretch=0.8,
	frame=single,
	bgcolor=black!2,
	breaklines=true,
	fontsize=\scriptsize\selectfont
}
\usemintedstyle{vs}

% Environment for a listing that spans multiple pages (caption setup only).
\newenvironment{longlisting}{\captionsetup{type=listing, justification=raggedright, singlelinecheck=false}}{}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% REFERENCES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% English localization, smart quotes, patching utilities, and clever references.
\RequirePackage[english]{babel}
\RequirePackage{csquotes, xpatch, fancyref}

% Glossaries with acronym support and an entry in the table of contents.
\RequirePackage[toc, acronym]{glossaries}

% Biber-backed bibliography in IEEE style with back-references and name limits.
\RequirePackage[
	backend=biber,
	natbib=true,
	backref=true,
	style=ieee,
	citestyle=ieee,
	url=false,
	maxcitenames=3,
	mincitenames=1,
	maxbibnames=99,
]{biblatex}
\DefineBibliographyStrings{english}{
	andothers = {\mkbibemph{et\addabbrvspace al\adddot}}
}

% Load the thesis bibliography databases.
\addbibresource{class/bibliography/short.bib}
\addbibresource{class/bibliography/main.bib}
\addbibresource{class/bibliography/my_papers.bib}
\addbibresource{class/bibliography/abbreviations.bib}

% Print author names as family-given.
\DeclareNameAlias{author}{family-given}
\DeclareNameAlias{default}{family-given}

% Initialize glossaries processing (only one call is needed for the whole class).
\makeglossaries


% Environment tools used to build the local bibliography environment.
\RequirePackage{etoolbox, environ}

% Local bibliography environment for a self-contained reference section.
\NewEnviron{localbib}{%
	\begin{refsection}
		\begin{refcontext}
			\BODY
			\printbibliography[heading=none]
		\end{refcontext}
	\end{refsection}
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TITLES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Custom chapter/section formatting with access to the full title text.
\RequirePackage[explicit]{titlesec}

% Line spacing and epigraphs.
\RequirePackage{setspace, epigraph}

% Micro-typographic adjustments to reduce overfull boxes.
\RequirePackage[
	expansion=true,
	protrusion=true,
	tracking=true,
	nopatch=footnote
]{microtype}

% Center epigraphs under chapter titles.
\renewcommand{\epigraphflush}{center}

% Section title rendered as a shaded box spanning the text width.
\newcommand{\colorsection}[1]{
	\colorbox{black!10}{\parbox{\dimexpr\textwidth-2\fboxsep}{\thesection \hspace*{0.5em} #1 \vspace{0.01em}}}
}

% Section and subsection formatting with decreasing font sizes and a horizontal rule after subsections.
\titleformat{\section}[hang]{\bfseries\fontsize{22pt}{22pt}\selectfont}{}{-8pt}{\colorsection{#1}\vspace*{-1em}}
\titleformat{\subsection}{\bfseries\fontsize{16pt}{16pt}\selectfont}{\thesubsection}{1em}{#1}[\hrule height 0.8pt]
\titleformat{\subsubsection}{\bfseries\fontsize{14pt}{14pt}\selectfont}{\thesubsubsection}{1em}{#1}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% CUSTOM LISTING REFS %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Teach fancyref to recognize listing labels (\fref{lst:...}) and format references.

\newcommand*{\fancyreflstlabelprefix}{lst}

% Main format for \Fref{lst:...} and \fref{lst:...}.
\frefformat{main}{\fancyreflstlabelprefix}
{\MakeUppercase{\freflstname}\fancyrefdefaultspacing#1#2}
\Frefformat{main}{\fancyreflstlabelprefix}
{\MakeUppercase{\Freflstname}\fancyrefdefaultspacing#1#2}
\Frefformat{main}{\fancyreflstlabelprefix}{Listing~#1}
\frefformat{main}{\fancyreflstlabelprefix}{listing~#1}

% Vario format used by \Fref and \fref when a page reference is included.
\frefformat{vario}{\fancyreflstlabelprefix}
{\MakeUppercase{\freflstname}\fancyrefdefaultspacing#1#2}
\Frefformat{vario}{\fancyreflstlabelprefix}
{\MakeUppercase{\Freflstname}\fancyrefdefaultspacing#1#2}
\Frefformat{vario}{\fancyreflstlabelprefix}{Listing~#1 on page #2}
\frefformat{vario}{\fancyreflstlabelprefix}{listing~#1 on page #2}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% CHAPTER HEADINGS %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Custom chapter title layout using internal LaTeX macros.
\makeatletter

% Thick horizontal rule used to separate the chapter number from the title.
\def\thickhrule{\leavevmode \leaders \hrule height 0.25ex \hfill \kern \z@}

% Reserved positioning command (currently unused; intended for future centering experiments).
\def\position{\centering}

% Numbered chapter heading: "Chapter N" line, rule, then title.
\renewcommand{\@makechapterhead}[1]{%
	\vspace*{2\p@}% Space before chapter heading
	{%
		\vfill\parindent \z@%
		{\vfill\raggedright\LARGE {\fontsize{20pt}{20pt}\selectfont Chapter \thechapter}}% Chapter number
		\par\nobreak
		{\thickhrule}% Horizontal rule
		\vspace*{1\p@}% Small vertical space
		\interlinepenalty\@M% Prevent page breaks
		\par\nobreak
		\vspace*{1\p@}% Small vertical space
		{\raggedright\bfseries\fontsize{26pt}{26pt}\selectfont {#1}\par\nobreak}% Chapter title
		\par\nobreak
		\vspace*{1\p@}% Small vertical space
	}%
	\vskip 10\p@% Space after chapter heading
}

% Unnumbered chapter heading (e.g., Acknowledgments, Dedication): rule then title.
\def\@makeschapterhead#1{%
	\vspace*{2\p@}% Space before chapter heading
	{%
		\parindent \z@%
		{\thickhrule}% Horizontal rule
		\par\nobreak
		\vspace*{1\p@}% Small vertical space
		\interlinepenalty\@M% Prevent page breaks
		\par\nobreak
		\vspace*{1\p@}% Small vertical space
		{\raggedright\bfseries\fontsize{26pt}{26pt}\selectfont {#1}\par\nobreak}% Chapter title
		\par\nobreak
		\vspace*{1\p@}% Small vertical space
	}%
	\vskip 10\p@% Space after chapter heading
}

\makeatother

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% CHAPTER ABSTRACT %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Indented italic abstract block at the start of a chapter.
\newenvironment{cabstract}
{
	\list{}{%
		\setlength{\leftmargin}{1cm}
		\setlength{\rightmargin}{\leftmargin}%
	}%
	\itshape\item\relax
}
{\par\vspace{1cm}}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% COMMANDS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Utility macros used across the thesis.
\newcommand{\blankpage}{\newpage\null\thispagestyle{empty}\newpage}
\newcommand{\eg}{\textit{e.g.}}
\newcommand{\ie}{\textit{i.e.}}
\newcommand{\cf}{\textit{c.f.}}
\newcommand{\etc}{\textit{etc.}}
\newcommand{\etal}{\textit{et al.}}
\newcommand{\aboveparrule}{\leavevmode\rule{0.9\textwidth}{0.15ex}}
\newcommand{\sectionbreak}{\clearpage}
\newcommand{\cmark}{\ding{51}}
\newcommand{\xmark}{\ding{55}}
\newcommand{\highlight}[1]{\textbf{\textcolor{primary}{#1}}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% OTHERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Placeholder text, in-document calculations, and sideways figures/tables.
\RequirePackage{lipsum, calc}
\RequirePackage[figuresleft]{rotating}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% Custom Figure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Side-by-side figure layout with adjustable left/right width ratio (default 0.5/0.5 minus 1em gap).
\newenvironment{sidebysidefigures}[1][0.5]{%
	\begin{figure}[htbp]
		\centering
		% Left minipage width as a fraction of \textwidth.
		\def\leftwidth{#1\textwidth}%
		% Right minipage width fills the remaining space minus the 1em gap.
		\def\rightwidth{\dimexpr\textwidth-#1\textwidth-1em\relax}%
		}{%
	\end{figure}
}

% Left-hand minipage inside sidebysidefigures; adds the 1em horizontal gap after it.
\newenvironment{leftfigure}[1][t]{%
	\begin{minipage}[#1]{\leftwidth}%
		\vspace{0pt}%
		}{%
	\end{minipage}%
	\hspace{1em}%
}

% Right-hand minipage inside sidebysidefigures.
\newenvironment{rightfigure}[1][t]{%
	\begin{minipage}[#1]{\rightwidth}%
		\vspace{0pt}%
		}{%
	\end{minipage}%
}
