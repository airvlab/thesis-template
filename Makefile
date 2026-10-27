# Makefile for the LaTeX thesis template.
# This file orchestrates building the thesis from main.tex using latexmk.
# All user-facing configuration is exposed via variables at the top so the
# build process can be understood and modified without touching the rules.

# ---------------------------------------------------------------------------
# User-configurable variables
# ---------------------------------------------------------------------------

# MAIN: the root LaTeX source file. This is the single entry point of the
# thesis and is passed as the last argument to latexmk.
MAIN := main.tex

# PDF: the path to the generated PDF. It lives under the build directory
# because latexmk is configured with -outdir=$(BUILD_DIR).
PDF := build/main.pdf

# ENGINE: selects the TeX engine used by latexmk.
# Supported values:
#   pdflatex  -> latexmk -pdf  (default)
#   lualatex  -> latexmk -lualatex
#   xelatex   -> latexmk -xelatex
# PDFLaTeX is the default because it is supported by arXiv, works in
# restricted/sandboxed environments, and matches the explicit pdftex driver
# option used by xcolor. Switching engines is a one-line change: edit the
# line below to ENGINE := lualatex or ENGINE := xelatex and the rest of the
# Makefile will adapt automatically. Note that arXiv currently does not
# support LuaLaTeX and disables -shell-escape; if you plan to submit there,
# stick with pdflatex and pre-generate any minted cache.
ENGINE := pdflatex

# ENGINE_FLAG: the latexmk flag that corresponds to the selected engine.
# This is derived from ENGINE; do not edit it directly.
ifeq ($(ENGINE),pdflatex)
    ENGINE_FLAG := -pdf
else ifeq ($(ENGINE),lualatex)
    ENGINE_FLAG := -lualatex
else ifeq ($(ENGINE),xelatex)
    ENGINE_FLAG := -xelatex
else
    $(error Unknown engine '$(ENGINE)'. Use pdflatex, lualatex, or xelatex.)
endif

# BUILD_DIR: directory where all generated files (PDF, aux, log, out, etc.)
# are placed. Keeping outputs in a dedicated directory leaves the project
# root clean and makes cleanup simple.
BUILD_DIR := build

# LATEXMK_OPTS: extra options passed to every latexmk invocation.
#   -shell-escape        : allows the minted package to run pygmentize
#                          for source-code syntax highlighting.
#   -outdir=$(BUILD_DIR) : redirects all generated files into build/.
#   -pdflatex="..."      : runs makeglossaries on the generated .glo files
#                          between pdflatex passes so the acronym glossary
#                          is populated automatically.
LATEXMK_OPTS := -shell-escape -outdir=$(BUILD_DIR) \
    -pdflatex="pdflatex -shell-escape -output-directory=$(BUILD_DIR) -interaction=nonstopmode %O %S" \
    -use-make

# PREVIEW_DIR: directory where preview PNGs are written. These images are
# embedded in README.md to showcase the template output.
PREVIEW_DIR := docs/images/preview

# PREVIEW_PAGES: list of page numbers to capture. The labels are used as
# filenames. Format: <filename>=<page>.
PREVIEW_PAGES := \
    titlepage=1 \
    toc=8 \
    lists=11 \
    chapter_heading=14 \
    figure_box=23 \
    table_box=24 \
    code_listing=64

# PREVIEW_TOOL: command used to convert PDF pages to PNGs. Requires
# poppler utils (pdftoppm) or ImageMagick (convert).
PREVIEW_TOOL := pdftoppm

# GLSS: glossary tool used by latexmk. If you change this, keep it in sync
# with the .latexmkrc file.
GLS := makeglossaries

# ARXIV_DIR: directory containing the flattened arXiv submission.
ARXIV_DIR := arxiv-submission

# ---------------------------------------------------------------------------
# Targets
# ---------------------------------------------------------------------------

# all: default target. Running 'make' (or 'make all') builds the thesis PDF.
.PHONY: all
all: $(PDF)

# $(PDF): rule that compiles main.tex into a PDF using latexmk with the
# configured engine and output directory. Because the thesis class uses the
# glossaries package, latexmk is told to use its own makeglossaries custom
# dependency via -use-make.
$(PDF): $(MAIN)
	latexmk $(ENGINE_FLAG) $(LATEXMK_OPTS) $(MAIN)

# preview: rebuilds the PDF and extracts showcase PNGs for README.md.
# It uses pdftoppm to render individual pages at 150 DPI. Existing PNGs in
# $(PREVIEW_DIR) are replaced.
.PHONY: preview
preview: $(PDF)
	@mkdir -p $(PREVIEW_DIR)
	@rm -f $(PREVIEW_DIR)/*.png
	@for entry in $(PREVIEW_PAGES); do \
	    name=$${entry%%=*}; page=$${entry#*=}; \
	    echo "Generating preview: $(PREVIEW_DIR)/$${name}-$$page.png"; \
	    $(PREVIEW_TOOL) -png -f $$page -l $$page -r 150 $(PDF) $(PREVIEW_DIR)/$${name}; \
	done
	@echo "Previews generated in $(PREVIEW_DIR)/"

# arxiv: prepares and archives a self-contained arXiv submission. The script
# flattens all imports, moves the class and bibliography to the submission root,
# copies logos, pre-generates a frozen minted cache, and produces a
# $(ARXIV_DIR).tar.gz file ready for upload.
.PHONY: arxiv
arxiv: $(PDF)
	python3 scripts/prepare_arxiv.py

# cleanarxiv: removes the flattened submission directory and tarball.
.PHONY: cleanarxiv
cleanarxiv:
	rm -rf $(ARXIV_DIR) $(ARXIV_DIR).tar.gz

# test: checks build/main.log for undefined references/citations, missing
# files, and overfull boxes. Run after `make` to catch common problems.
.PHONY: test
test: $(PDF)
	python3 scripts/test_build.py

# lint: runs chktex on all LaTeX source files if chktex is installed.
# The warning count is reported but does not fail the build, because
# many warnings are stylistic choices made intentionally by the template.
.PHONY: lint
lint:
	@which chktex > /dev/null 2>&1 || (echo "chktex not installed; skipping lint." && exit 0)
	@which chktex > /dev/null 2>&1 && (find . -path ./build -prune -o -path ./arxiv-submission -prune -o -name '*.tex' -print -o -name '*.cls' -print | xargs chktex -q 2>&1 | tee /tmp/chktex-warnings.txt; echo "chktex warnings: $$(wc -l < /tmp/chktex-warnings.txt)")

# install-hooks: copies scripts/pre-commit.sh into .git/hooks/pre-commit
# so that `make test` runs before each commit.
.PHONY: install-hooks
install-hooks:
	cp scripts/pre-commit.sh .git/hooks/pre-commit
	chmod +x .git/hooks/pre-commit
	@echo "Pre-commit hook installed."

# clean: removes auxiliary files generated during compilation inside the
# build directory (logs, aux files, fls, fdb, etc.). The PDF is preserved.
# Any stray root-level auxiliary files are also removed.
.PHONY: clean
clean:
	latexmk -c -outdir=$(BUILD_DIR) $(MAIN)
	rm -f main.aux main.bbl main.bcf main.blg main.fdb_latexmk main.fls \
	      main.lof main.log main.lot main.out main.run.xml main.toc \
	      main.acn main.acr main.glo main.glsdefs main.ist main.glg main.gls \
	      main.lol main.pyg
	rm -rf _minted _minted-*

# cleanall: aggressive clean. Removes the entire build directory and any
# remaining auxiliary files or PDF in the project root. Use this for a
# completely fresh build.
.PHONY: cleanall
cleanall:
	latexmk -C -outdir=$(BUILD_DIR) $(MAIN)
	rm -rf $(BUILD_DIR)
	rm -f main.pdf main.aux main.bbl main.bcf main.blg main.fdb_latexmk main.fls \
	      main.lof main.log main.lot main.out main.run.xml main.toc \
	      main.acn main.acr main.glo main.glsdefs main.ist main.glg main.gls \
	      main.lol main.pyg
	rm -rf _minted _minted-*
