# A Modern Thesis Template for the University of Liverpool

A LaTeX thesis template for PhD students at the University of Liverpool. It is based on the [Imperial College PhD Thesis Template](https://github.com/mlnotebook/thesis_template) by Rob Robinson, and has been adapted and extended by [Tudor Jianu](https://github.com/tudorjnu) for Liverpool-specific formatting, modern tooling, and clearer documentation.

The template demonstrates a complete thesis structure with front matter, example chapters, and appendices. The placeholder content is written about the template itself, so it doubles as documentation and a showcase.

[Robinson's finished thesis (the original demonstration of the base template)](https://github.com/mlnotebook/thesis_template/blob/master/Robinson-R-2020-PhD-Thesis.pdf)

## Attribution

If you use this template, include the following in the Declaration section of your thesis:

```latex
The formatting of this thesis is based on the University of Liverpool thesis template maintained by Tudor Jianu at \url{https://github.com/airvlab/thesis-template}, which was adapted from the original thesis template by R. Robinson at \url{https://github.com/mlnotebook/thesis_template}.
```

## License

This adaptation is released under the [MIT License](LICENSE) by Tudor Jianu.
It is a derivative of Rob Robinson's thesis template; the original upstream
repository does not include an explicit license, so the MIT terms apply only
to the modifications and additions made here.

## Using this template with Overleaf

You can fork this repository, import it into Overleaf, and keep the two in sync
while you write. The recommended workflow is:

1. **Fork the repository on GitHub** so you have your own copy under your account.
2. **Import the fork into Overleaf** with *New Project → Import from GitHub*.
3. **Sync changes** with Overleaf's GitHub panel (Push / Pull) or by using
   Overleaf as a Git remote from your local machine.

A detailed step-by-step guide, including conflict resolution and keeping your
fork up to date with upstream fixes, is in [`docs/research/overleaf-sync.md`](docs/research/overleaf-sync.md).

## Build

Compile the template from the repository root:

```bash
make
```

The PDF is written to `build/main.pdf`. Other useful targets:

```bash
make            # build the thesis PDF
make clean      # remove auxiliary files (keep build/main.pdf)
make cleanall   # remove the entire build directory
make test       # check build/main.log for undefined references/citations/missing files
make lint       # run chktex if installed (reports warnings only)
make arxiv      # create arxiv-submission.tar.gz (see below)
make cleanarxiv # remove generated arXiv submission files
make install-hooks # copy the pre-commit hook into .git/hooks/pre-commit
```

The default engine is `pdflatex`. To switch engines, edit `ENGINE := pdflatex` in the `Makefile` to `lualatex` or `xelatex`. The `.latexmkrc` file uses `$pdf_mode = 1` for pdflatex; change it to `4` for lualatex or `5` for xelatex.

## Documentation

- [`docs/packages.md`](docs/packages.md) — a complete inventory of the packages loaded by `class/thesis.cls`, grouped by purpose.
- [`docs/structure.md`](docs/structure.md) — a practical guide to adding chapters, sections, figures, tables, acronyms, references, appendices, and customisation points.
- [`docs/research/overleaf-sync.md`](docs/research/overleaf-sync.md) — how to fork the repository, import it into Overleaf, and sync changes.
- The [Submitting to arXiv](#submitting-to-arxiv) section below explains the one-command `make arxiv` packaging.

## Submitting to arXiv

arXiv's TeX processing runs with `-shell-escape` disabled, and the template uses
`\import` with subdirectories for chapters. To make submission painless, run:

```bash
make arxiv
```

This produces `arxiv-submission.tar.gz`, a fully self-contained archive ready
to upload. The script:

1. Flattens all `\import` / `\subimport` / `\input` calls into a single `main.tex`.
2. Moves `thesis.cls` and the `.bib` files to the submission root.
3. Copies `logo/` assets.
4. Pre-generates a frozen `minted-cache/` so syntax highlighting works even
   though arXiv disables `-shell-escape`.

Upload `arxiv-submission.tar.gz` to arXiv directly; no manual cache generation
or path fixing is required.

To remove the generated submission files:

```bash
make cleanarxiv
```

## Features

* Figures and tables are shown in contrasting coloured boxes.
* Captions have a title and description component via `\mycaption`.
* Chapter headings get their own page with a `cabstract` block.
* Front matter includes epigraph, dedication, declaration, acknowledgements, abstract, lists of figures/tables, and glossary.
* Source code listings in the appendix, included in the table of contents via `minted`.
* Acronyms are shown in the glossary and expand on first use.
* Liverpool logo placement and degree statement on the title page.

## User-defined Commands

Blank page:
* `\newcommand{\blankpage}{\newpage\null\thispagestyle{empty}\newpage}`

Italicized Latin:
* `\newcommand{\eg}{\textit{e.g.}}`
* `\newcommand{\ie}{\textit{i.e.}}`
* `\newcommand{\cf}{\textit{c.f.}}`
* `\newcommand{\etc}{\textit{etc.}}`
* `\newcommand{\etal}{\textit{et al.}}`

Horizontal rule above a paragraph:
* `\newcommand{\aboveparule}{\leavevmode\rule{0.9\textwidth}{0.15ex}}`

New page at each section:
* `\newcommand{\sectionbreak}{\clearpage}`

Caption with title and description (title also appears in the list of figures/tables):
* `\newcommand*\mycaption[2]{\caption[#1]{\textbf{#1:} #2}}`

## Project Structure

```
.
├── main.tex              # document root
├── class/
│   ├── thesis.cls        # custom LaTeX class
│   ├── acronyms.tex      # glossary and acronym definitions
│   └── bibliography/     # BibLaTeX resources
├── preamble/             # front-matter pages
├── chapters/             # example chapters
├── postamble/            # appendices and back matter
├── logo/                 # institutional logos
├── docs/                 # documentation and preview images
├── Makefile              # build automation
└── .latexmkrc            # standalone latexmk config
```

## Preview

All preview images below are auto-generated by `make preview`. They are stored under `docs/images/preview/` and can be tracked with Git LFS by keeping the `.gitattributes` entry in this repository.

<table style="vertical-align: top;">
<tr>
<td>
<b>Title Page</b>

The title page contains a centralized title with aligned authorship data beneath. Two images are added to the top: the University of Liverpool logo and a research group logo.

</td>
<td>
<img src="docs/images/preview/titlepage-01.png" style="width: 100%;" alt="Preview of Title Page">
</td>
</tr>
<tr>
<td>
<b>Table of Contents</b>

The table of contents shows numbered chapters, sections, and the appendices, all formatted by the custom class.

</td>
<td>
<img src="docs/images/preview/toc-08.png" style="width: 100%;" alt="Preview of Table of Contents">
</td>
</tr>
<tr>
<td>
<b>List of Figures and Tables</b>

The front matter continues with automatically generated lists of figures and tables.

</td>
<td>
<img src="docs/images/preview/lists-11.png" style="width: 100%;" alt="Preview of List of Figures and Tables">
</td>
</tr>
<tr>
<td>
<b>Chapter Heading</b>

Chapter headings have their own page with a short abstract in the `cabstract` environment and an optional publication statement.

</td>
<td>
<img src="docs/images/preview/chapter_heading-14.png" style="width: 100%;" alt="Preview of Chapter Heading">
</td>
</tr>
<tr>
<td>
<b>Figures</b>

Figures are wrapped in a coloured frame and captioned with `\mycaption` for a bold title followed by a longer description.

</td>
<td>
<img src="docs/images/preview/figure_box-23.png" style="width: 100%;" alt="Preview of Figure Box">
</td>
</tr>
<tr>
<td>
<b>Tables</b>

<ul>
<li>Tables are wrapped in a subtle frame using the `mdframed` package.</li>
<li>Captions use `\mycaption` with a bold title and a longer description.</li>
</ul>
</td>
<td>
<img src="docs/images/preview/table_box-24.png" style="width: 100%;" alt="Preview of Table">
</td>
</tr>
<tr>
<td>
<b>Source Code</b>

<ul>
<li>Code listings are held in the appendix using `minted`.</li>
<li>Listings are numbered and added to the table of contents.</li>
</ul>
</td>
<td>
<img src="docs/images/preview/code_listing-64.png" style="width: 100%;" alt="Preview of Code Listing">
</td>
</tr>
</table>
