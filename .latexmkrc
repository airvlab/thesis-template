# Standalone latexmk configuration for the thesis template.
# This file mirrors the behavior of the Makefile so `latexmk` can be run
# directly (e.g., `latexmk main.tex`) without needing `make`.

# ---------------------------------------------------------------------------
# Engine selection
# ---------------------------------------------------------------------------
# $pdf_mode chooses the default TeX engine used by latexmk:
#   0 = do not produce PDF
#   1 = pdflatex (default for this template; arXiv-safe)
#   4 = lualatex
#   5 = xelatex
# To switch engines, change the number below to 4 or 5. Keep pdflatex (1)
# if you plan to submit to arXiv, because arXiv does not support LuaLaTeX
# and disables -shell-escape.
$pdf_mode = 1;


# ---------------------------------------------------------------------------
# Output directory
# ---------------------------------------------------------------------------
# $out_dir redirects all generated files (PDF, aux, log, fls, fdb, etc.)
# into a dedicated build directory, keeping the project root clean and matching
# the Makefile's BUILD_DIR variable.
$out_dir = 'build';

# ---------------------------------------------------------------------------
# Shell escape
# ---------------------------------------------------------------------------
# $shell_escape allows external programs to be called from LaTeX. This is
# required by the minted package so it can invoke pygmentize for source-code
# syntax highlighting. Set to 0 for fully sandboxed or arXiv submissions.
$shell_escape = 1;

# ---------------------------------------------------------------------------
# Glossary generation
# ---------------------------------------------------------------------------
# The thesis uses the glossaries package for acronyms. latexmk needs a custom
# dependency to run makeglossaries on the .glo files that pdflatex produces.
add_cus_dep('glo', 'gls', 0, 'makegls');
add_cus_dep('acn', 'acr', 0, 'makegls');
sub makegls {
    my ($base_name, $path) = fileparse( @_ );
    my $ret = system("makeglossaries -d \"$path\" \"$base_name\"");
    return $ret;
}

# Ensure latexmk reruns after glossary files change.
$clean_ext .= ' %R.ist %R.glg %R.gls %R.glo %R.acn %R.acr %R.alg';
