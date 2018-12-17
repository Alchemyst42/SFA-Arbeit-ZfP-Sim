%% spezidoc.cls -- documentclass for ASGSPEZ
%% Copyright (C) 2015 Frank Thiemicke (14frthie@asgspez.de)
%%
%% This program is free software; you can redistribute it and/or
%% modify it under the terms of the GNU General Public License
%% as published by the Free Software Foundation; version 2
%% of the License.
%%
%% This program is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU General Public License for more details.
%%
%% You should have received a copy of the GNU General Public License
%% along with this program; if not, write to the Free Software
%% Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

%% basic properties
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{spezidoc}[2016/03/28 Standard spezi-documents]

%% package requirements
\RequirePackage{ifthen}
\RequirePackage{xifthen}
\RequirePackage[ngerman]{babel}
\RequirePackage[utf8]{inputenc}
\RequirePackage{datetime}

%% elementary components
\newcounter{spezidoc@type}
\newboolean{spezidoc@reducespace}
\setboolean{spezidoc@reducespace}{false}
\newboolean{spezidoc@stylepage}
\setboolean{spezidoc@stylepage}{false}
\newcounter{spezidoc@tmpYear}
\setcounter{spezidoc@tmpYear}{\year}
\newcommand{\spezidoc@monthofabgabe}{\monthname[\month]}

%% class options
\DeclareOption{projektarbeit}{\setcounter{spezidoc@type}{1}}
\DeclareOption{infoparbeit}{\setcounter{spezidoc@type}{2}}
\DeclareOption{semiarbeit}{\setcounter{spezidoc@type}{3}}
\DeclareOption{reducespace}{\setboolean{spezidoc@reducespace}{true}}
\DeclareOption{stylepage}{\setboolean{spezidoc@stylepage}{true}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

%% basic requirements and processing
\LoadClass[a4paper,titlepage,12pt]{article}
\RequirePackage[left=2.5cm,right=2.5cm,top=2.5cm,bottom=2cm]{geometry}
\RequirePackage{perpage}
\RequirePackage[absolute]{textpos}
\RequirePackage[compact]{titlesec}
\RequirePackage{tocloft}
\RequirePackage{pifont}
\RequirePackage{hyperref}

%% design elements
\newcommand{\HRule}{\rule{\linewidth}{0.1cm}}
\newcommand{\SHRule}{\rule{\linewidth}{0.05cm}}

%% auxiliary booleans
\newboolean{spezidoc@sfbFemale}
\newboolean{spezidoc@fbOneFemale}
\newboolean{spezidoc@fbTwoFemale}
\newboolean{spezidoc@abFemale}
\newboolean{spezidoc@scFemale}
\newboolean{spezidoc@scMale}

%% storage commands
\newcommand{\spezidoc@tmptyparbeit}{%
	\ifnum\value{spezidoc@type}=1%
		{Projektarbeit Klassenstufe 9}%
	\else%
		\ifnum\value{spezidoc@type}=2%
			{Projektarbeit Informatik Klassenstufe 10}%
		\else%
			{Seminarfacharbeit Klassenstufe 11/12}%
		\fi%
	\fi%
}
\newcommand{\spezidoc@tmpaussenbetreuer}{}
\newcommand{\spezidoc@tmpseminarfachbetreuer}{}
\newcommand{\spezidoc@tmpfachbetreuerone}{}
\newcommand{\spezidoc@tmpfachbetreuertwo}{}
\newcommand{\spezidoc@tmpvschuelerone}{}
\newcommand{\spezidoc@tmpnschuelerone}{}
\newcommand{\spezidoc@tmpcschuelerone}{}
\newcommand{\spezidoc@tmpvschuelertwo}{}
\newcommand{\spezidoc@tmpnschuelertwo}{}
\newcommand{\spezidoc@tmpcschuelertwo}{}
\newcommand{\spezidoc@tmpvschuelerthree}{}
\newcommand{\spezidoc@tmpnschuelerthree}{}
\newcommand{\spezidoc@tmpcschuelerthree}{}
\newcommand{\spezidoc@tmpdate}{}

%% renewal of existing commands and customizations
\renewcommand{\footnotesize}{\tiny}%
\renewcommand{\contentsname}{Gliederung}%
\parindent0pt\setlength{\parskip}{\baselineskip}%
\titlespacing{\section}{0em}{0em}{-.7\baselineskip}%
\titlespacing{\subsection}{0em}{-.4\baselineskip}{-.6\baselineskip}%
\titlespacing{\subsubsection}{0em}{-.4em}{-.4em}%
\titleformat{\section}[block]{\Large\bfseries}{\thesection\quad}{0pt}{}%
\titleformat{\subsection}[block]{\large\bfseries}{\thesubsection~~}{0pt}{}%
\titleformat{\subsubsection}[block]{\normalsize\bfseries}{\thesubsubsection~}{0pt}{}%
\def\labelitemi{\raise-.5pt\hbox{\ding{226}}}%
\def\labelitemii{\raise.75pt\hbox{$\bullet$}}%
\def\labelitemiii{\hbox{$\circ$}}%
\def\labelitemiv{\hbox{--}}%
\MakePerPage{footnote}%
\sloppy%

%% 'real' commands (set temp vars)
\newcommand{\HerrFrau}[2]{%
	\ifthenelse{#2}{#1in}{#1}%
}
\newcommand{\aussenbetreuer}[2][false]{%
	\setboolean{spezidoc@abFemale}{#1}%
	\renewcommand{\spezidoc@tmpaussenbetreuer}{#2}%
}
\newcommand{\seminarfachbetreuer}[2][false]{%
	\setboolean{spezidoc@sfbFemale}{#1}%
	\renewcommand{\spezidoc@tmpseminarfachbetreuer}{#2}%
}
\newcommand{\fachbetreuerone}[2][false]{%
	\setboolean{spezidoc@fbOneFemale}{#1}%
	\renewcommand{\spezidoc@tmpfachbetreuerone}{#2}%
}
\newcommand{\fachbetreuertwo}[2][false]{%
	\setboolean{spezidoc@fbTwoFemale}{#1}%
	\renewcommand{\spezidoc@tmpfachbetreuertwo}{#2}%
}
\newcommand{\schuelerone}[3]{%
	\renewcommand{\spezidoc@tmpvschuelerone}{#1}%
	\renewcommand{\spezidoc@tmpnschuelerone}{#2}%
	\renewcommand{\spezidoc@tmpcschuelerone}{#3}%
}
\newcommand{\schuelertwo}[3]{%
	\renewcommand{\spezidoc@tmpvschuelertwo}{#1}%
	\renewcommand{\spezidoc@tmpnschuelertwo}{#2}%
	\renewcommand{\spezidoc@tmpcschuelertwo}{#3}%
}
\newcommand{\schuelerthree}[3]{%
	\renewcommand{\spezidoc@tmpvschuelerthree}{#1}%
	\renewcommand{\spezidoc@tmpnschuelerthree}{#2}%
	\renewcommand{\spezidoc@tmpcschuelerthree}{#3}%
}
\newcommand{\mitmaedchen}[1]{\setboolean{spezidoc@scFemale}{#1}}
\newcommand{\mitjungen}[1]{\setboolean{spezidoc@scMale}{#1}}

%% commands influencing document (design and content)
\newcommand{\maketitlepage}{% titlepage according to Handreichung
	\begin{titlepage}%
		\pagestyle{empty}%
		\begin{center}%
		\vspace*{\fill}%
			\textsc{\normalsize Albert-Schweitzer-Gymnasium Erfurt\\\spezidoc@tmptyparbeit\\Schuljahr~%
				\if\ifnum\month>8 T\else\ifnum\month=8 T\else F\fi\fi T%
					\the\year/{\stepcounter{spezidoc@tmpYear}}\the\value{spezidoc@tmpYear}%
				\else%
					{\addtocounter{spezidoc@tmpYear}{-1}}\the\value{spezidoc@tmpYear}/\the\year%
				\fi%
			}\\[0.5cm]%
			\HRule\\[0.5cm]%
			\textsc{\Huge\@title}\\[0.2cm]%
			\HRule\\[0.5cm]%
			\begin{tabular}[t]{ll}%
				\ifthenelse{\equal{\spezidoc@tmpaussenbetreuer}{}}{$\!$}{%
					\HerrFrau{Außenbetreuer}{\boolean{spezidoc@abFemale}}: & ~\,\spezidoc@tmpaussenbetreuer\\[0.2cm]
				}
				\ifthenelse{\value{spezidoc@type}=2}{$\!$}{%
					\HerrFrau{Seminarfachbetreuer}{\boolean{spezidoc@sfbFemale}}: & \, \spezidoc@tmpseminarfachbetreuer\\[0.2cm]%
				}%
				\HerrFrau{Fachbetreuer}{\boolean{spezidoc@fbOneFemale}}: & \, \spezidoc@tmpfachbetreuerone\\[0.2cm]%
				\ifthenelse{\equal{\spezidoc@tmpfachbetreuertwo}{}}{}{%
					\HerrFrau{Fachbetreuer}{\boolean{spezidoc@fbTwoFemale}}: & \, \spezidoc@tmpfachbetreuertwo\\[0.2cm]%
				}%
				\ifthenelse{\value{spezidoc@type}=2}{%
					\HerrFrau{Informatikbetreuer}{\boolean{spezidoc@sfbFemale}}: & \, \spezidoc@tmpseminarfachbetreuer\\[0.2cm]%
				}{}%
				\ifspezidoc@scFemale\ifspezidoc@scMale{SchülerInnen}\else{Schülerinnen}\fi\else%
					{Schüler}%
				\fi : & \begin{tabular}[t]{ll}%
					\spezidoc@tmpnschuelerone,~\spezidoc@tmpvschuelerone & (\spezidoc@tmpcschuelerone)\\%
					\spezidoc@tmpnschuelertwo,~\spezidoc@tmpvschuelertwo & (\spezidoc@tmpcschuelertwo)%
					\ifthenelse{\equal{\spezidoc@tmpvschuelerthree}{}}{\\[0.5cm]}{%
						\\\spezidoc@tmpnschuelerthree,~\spezidoc@tmpvschuelerthree & (\spezidoc@tmpcschuelerthree)\\[0.5cm]%
					}%
				\end{tabular}%
			\end{tabular}%
			\\\SHRule\\[0.5cm]%
			\begin{tabular}[t]{ll}%
				Abgabe im: & \spezidoc@monthofabgabe~%
				\if\ifnum\month>8 T\else\ifnum\month=8 T\else F\fi\fi T%
					2018%
				\else%
					{\stepcounter{spezidoc@tmpYear}}\the\value{spezidoc@tmpYear}%
				\fi\\[0.2cm]%
				Abgabe am: & Spezialschulteil für Mathematik/Naturwissenschaften/Informatik\\[0.1cm]%
				\, & am Staatlichen Gymnasium \glqq Albert Schweitzer\grqq\\[0.1cm]%
				\, & Vilniuser Straße 17a\\[0.1cm]%
				\, & 99089 Erfurt%
			\end{tabular}%
		\vfill%
		\end{center}%
	\end{titlepage}%
}
\newcommand{\eidesstattlicheerklaerung}{% Eidesstattliche Erklärung
	\clearpage\section*{Eidesstattliche Erklärung}
	{\normalfont\normalsize Hiermit versichern die Unterzeichnenden respektive die Autoren dieser Arbeit eides\-stattlich, dass jegliche Inhalte aus eigener Urheberschaft stammen oder unter den angegebenen Quellen zu finden sind. Die aus diesen Quellen direkt oder indirekt übernommenen Formulierungen und Inhalte sind unter Angabe eines Quellenverweises gekennzeichnet.}\\[2cm]
	\ifthenelse{\equal{\spezidoc@tmpvschuelerthree}{}}{%
		\rule{5cm}{1pt}\hfill\rule{5cm}{1pt}\\
		\spezidoc@tmpvschuelerone~\spezidoc@tmpnschuelerone~(\spezidoc@tmpcschuelerone)\hfill\spezidoc@tmpvschuelertwo~\spezidoc@tmpnschuelertwo~(\spezidoc@tmpcschuelertwo)
	}{%
		\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}*3c@{}}
			\rule{4.9cm}{1pt} & \rule{4.9cm}{1pt} & \rule{4.9cm}{1pt}\\
			\spezidoc@tmpvschuelerone~\spezidoc@tmpnschuelerone~(\spezidoc@tmpcschuelerone) & \spezidoc@tmpvschuelertwo~\spezidoc@tmpnschuelertwo~(\spezidoc@tmpcschuelertwo) & \spezidoc@tmpvschuelerthree~\spezidoc@tmpnschuelerthree~(\spezidoc@tmpcschuelerthree)
		\end{tabular*}
	}%
}

%% environments
\newenvironment{quellen}[1][Literaturverzeichnis]{%
	\clearpage%
	\addcontentsline{toc}{section}{#1}%
	\renewcommand{\refname}{#1}%
	\begin{thebibliography}{9999}%
}{\end{thebibliography}}
\newenvironment{thesenpapier}[1][\the\day.~\month@ngerman~\the\year]{
	\clearpage%
	\thispagestyle{empty}
	\setboolean{spezidoc@stylepage}{false}
	\renewcommand{\spezidoc@tmpdate}{#1}
	\renewcommand{\footnotesize}{
		\@setfontsize\footnotesize\@xpt\@xiipt
		\abovedisplayskip 10\p@ \@plus2\p@ \@minus5\p@
		\abovedisplayshortskip \z@ \@plus3\p@
		\belowdisplayshortskip 6\p@ \@plus3\p@ \@minus3\p@
		\def\@listi{\leftmargin\leftmargini
			\topsep 6\p@ \@plus2\p@ \@minus2\p@
			\parsep 3\p@ \@plus2\p@ \@minus\p@
			\itemsep \parsep}%
		\belowdisplayskip \abovedisplayskip
	}
	\footnotesize
	\begin{minipage}{.475\textwidth}\begin{tabular}{ll}
		\ifspezidoc@scFemale %
			\ifspezidoc@scMale%
				{SchülerInnen}%
			\else%
				{Schülerinnen}%
			\fi%
		\else%
			{Schüler}%
		\fi : & \,\\
		~~~\spezidoc@tmpnschuelerone,~\spezidoc@tmpvschuelerone & (\spezidoc@tmpcschuelerone)\\%
		~~~\spezidoc@tmpnschuelertwo,~\spezidoc@tmpvschuelertwo & (\spezidoc@tmpcschuelertwo)%
		\ifthenelse{\equal{\spezidoc@tmpvschuelerthree}{}}{\\}{%
			\\~~~\spezidoc@tmpnschuelerthree,~\spezidoc@tmpvschuelerthree & (\spezidoc@tmpcschuelerthree)\\%
		}%
	\end{tabular}\end{minipage}
	\begin{minipage}{.5\textwidth}\begin{tabular}{ll}
		\ifthenelse{\equal{\spezidoc@tmpaussenbetreuer}{}}{\vspace{-\quad}}{%
			\HerrFrau{Außenbetreuer}{\boolean{spezidoc@abFemale}}: & ~\,\spezidoc@tmpaussenbetreuer\\
		}
		\HerrFrau{Seminarfachbetreuer}{\boolean{spezidoc@sfbFemale}}: & \, \spezidoc@tmpseminarfachbetreuer\\%
		\HerrFrau{Fachbetreuer}{\boolean{spezidoc@fbOneFemale}}: & \, \spezidoc@tmpfachbetreuerone\\%
		\ifthenelse{\equal{\spezidoc@tmpfachbetreuertwo}{}}{}{%
			\HerrFrau{Fachbetreuer}{\boolean{spezidoc@fbTwoFemale}}: & \, \spezidoc@tmpfachbetreuertwo\\%
		}%
	\end{tabular}\end{minipage}
	\begin{center}Thesenpapier zur Verteidigung der~\spezidoc@tmptyparbeit~am #1\huge{\textbf{$\;$\\\@title}}\\[0.4cm]\footnotesize Spezialschulteil für Mathematik/Naturwissenschaften/Informatik\\am Staatlichen Gymnasium \glqq Albert Schweitzer\grqq Erfurt \end{center}
	\normalsize\vspace{.3cm}
	\begin{enumerate}
}{
	\end{enumerate}%
	\setlength{\TPHorizModule}{1mm}%
	\setlength{\TPVertModule}{1mm}%
	\begin{textblock}{29}(29,286)%
		\hbox to\headwidth{%
			\fancy@reset\@fancyvbox\footskip{%
				\footrule\hbox{%
					\rlap{\parbox[t]{\headwidth}{%
						\raggedright\tiny \spezidoc@tmpdate}%
					}\hfill%
					\parbox[t]{\headwidth}{\centering\tiny \copyright\,%
						\ifthenelse{\equal{\spezidoc@tmpvschuelerthree}{}}{%
							\spezidoc@tmpvschuelerone~\spezidoc@tmpnschuelerone~und~\spezidoc@tmpvschuelertwo~\spezidoc@tmpnschuelertwo%
						}{%
							\StrLeft{\spezidoc@tmpvschuelerone}{1}[\flone]%
							\StrLeft{\spezidoc@tmpvschuelertwo}{1}[\fltwo]%
							\StrLeft{\spezidoc@tmpvschuelerthree}{1}[\flthree]%
							\flone.~\spezidoc@tmpnschuelerone,~\fltwo.~\spezidoc@tmpnschuelertwo~und~\flthree.~\spezidoc@tmpnschuelerthree%
						}%
					}\hfill%
					\llap{\parbox[t]{\headwidth}{\raggedleft\tiny \@title}}%
				}%
			}%
		}%
	\end{textblock}%
}

%% option post-processing
\ifthenelse{\value{spezidoc@type}=2}{%
	\RequirePackage{listings}
	\RequirePackage{color}
	\definecolor{default}{rgb}{0,0,0.2}
	\definecolor{darkblue}{rgb}{0,0,0.6}
	\definecolor{comm}{rgb}{0,0.6,0}
	\definecolor{numbers}{rgb}{0.25,0.25,0.25}
	\definecolor{str}{rgb}{1,0,0}
	\definecolor{bggray}{rgb}{0.97,0.97,0.97}
	\definecolor{frgray}{rgb}{0.6,0.6,0.6}
	\definecolor{orange}{rgb}{1,0.65,0}
	\lstset{ %
		backgroundcolor=\color{bggray},  basicstyle=\texttt\footnotesize, breakatwhitespace=true, breaklines=true, captionpos=b,
		commentstyle=\color{comm}, deletekeywords={...}, escapeinside={(*@}{@*)}, extendedchars=true, frame=shadowbox, frameround=ffff,
		framexleftmargin=5mm, keepspaces=true, keywordstyle=\color{blue}, morekeywords={...}, numbers=left, numbersep=7pt,
		numberstyle=\tiny\color{numbers}, numberblanklines=true, stepnumber=1, numberfirstline=true, rulecolor=\color{frgray}, showspaces=false,
		showstringspaces=false, showtabs=true, showlines=false, stringstyle=\color{str}, tab=\textcolor{orange}{\rightarrowfill}, tabsize=4,
		title=\lstname, caption=\lstname, aboveskip=-0.5\baselineskip, belowskip=0\baselineskip,
		literate={á}{{\'a}}1 {é}{{\'e}}1 {í}{{\'i}}1 {ó}{{\'o}}1 {ú}{{\'u}}1 {Á}{{\'A}}1 {É}{{\'E}}1 {Í}{{\'I}}1 {Ó}{{\'O}}1 {Ú}{{\'U}}1
		 	{à}{{\`a}}1 {è}{{\`e}}1 {ì}{{\`i}}1 {ò}{{\`o}}1 {ù}{{\`u}}1 {À}{{\`A}}1 {È}{{\'E}}1 {Ì}{{\`I}}1 {Ò}{{\`O}}1 {Ù}{{\`U}}1
		 	{ä}{{\"a}}1 {ë}{{\"e}}1 {ï}{{\"i}}1 {ö}{{\"o}}1 {ü}{{\"u}}1 {Ä}{{\"A}}1 {Ë}{{\"E}}1 {Ï}{{\"I}}1 {Ö}{{\"O}}1 {Ü}{{\"U}}1
			{â}{{\^a}}1 {ê}{{\^e}}1 {î}{{\^i}}1 {ô}{{\^o}}1 {û}{{\^u}}1 {Â}{{\^A}}1 {Ê}{{\^E}}1 {Î}{{\^I}}1 {Ô}{{\^O}}1 {Û}{{\^U}}1
			{œ}{{\oe}}1 {Œ}{{\OE}}1 {æ}{{\ae}}1 {Æ}{{\AE}}1 {ß}{{\ss}}1 {ç}{{\c c}}1 {Ç}{{\c C}}1 {ø}{{\o}}1 {å}{{\r a}}1 {Å}{{\r A}}1
			{€}{{\EUR}}1 {£}{{\pounds}}1
	}
}{}
\ifthenelse{\boolean{spezidoc@reducespace}}{% smaller spaces
	\RequirePackage{enumitem}%
	\parindent0pt\parsep0pt\itemsep0pt%
	\renewcommand{\cftsecafterpnum}{}%
	\setlist[itemize]{noitemsep,nolistsep,leftmargin=.75cm}%
	\setlist[enumerate]{noitemsep,nolistsep,leftmargin=.75cm}%
}{}
\ifthenelse{\boolean{spezidoc@stylepage}}{
	\RequirePackage{fancyhdr}%
	\RequirePackage{xstring}%
	\renewcommand{\footrulewidth}{0.005mm}%
	\renewcommand{\headrulewidth}{0.005mm}%
	\fancypagestyle{spezidoc}{
		\fancyhf{}%
		\fancyfoot[R]{\footnotesize \thepage}%
		\fancyfoot[L]{\footnotesize \the\day.~\month@ngerman~\the\year}%
		\fancyfoot[C]{\footnotesize \copyright\,%
			\ifthenelse{\equal{\spezidoc@tmpvschuelerthree}{}}{%
				\spezidoc@tmpvschuelerone~\spezidoc@tmpnschuelerone~und~\spezidoc@tmpvschuelertwo~\spezidoc@tmpnschuelertwo%
			}{%
				\StrLeft{\spezidoc@tmpvschuelerone}{1}[\flone]%
				\StrLeft{\spezidoc@tmpvschuelertwo}{1}[\fltwo]%
				\StrLeft{\spezidoc@tmpvschuelerthree}{1}[\flthree]%
				\flone.~\spezidoc@tmpnschuelerone,~\fltwo.~\spezidoc@tmpnschuelertwo~und~\flthree.~\spezidoc@tmpnschuelerthree%
			}%
		}
		\fancyhead[L]{\footnotesize \@title}%
		\fancyhead[R]{\footnotesize\spezidoc@tmptyparbeit}%
	}
	\pagestyle{spezidoc}%
	\tocloftpagestyle{spezidoc}%
}{}
