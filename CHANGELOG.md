# Changelog

All notable changes to this thesis template are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- One-command arXiv submission packaging via `make arxiv`.
- Frozen `minted-cache/` generation so arXiv builds keep syntax highlighting without `-shell-escape`.
- Overleaf sync guide at `docs/research/overleaf-sync.md`.
- `make test` target to check the build log for common problems.
- `make lint` target to run `chktex` when it is installed.
- `make install-hooks` target to copy the provided pre-commit hook into `.git/hooks/`.
- `scripts/pre-commit.sh` to run `make test` before each commit.
- `.gitattributes` entry for preview PNGs so they can be tracked with Git LFS.
- README links to the arXiv workflow and Overleaf guide.
- Tutorial wording in Chapter~3 to help users replace placeholder content.
- Richer bibliography examples demonstrating `\cite`, `\citeauthor`, `\citeyear`, and `\fullcite`.
- Accessibility hints for figures and PDF links.

### Changed

- Renamed `class/bibliography/abreviations.bib` to `class/bibliography/abbreviations.bib` and registered it in `class/thesis.cls`.
- Improved engine-switching comments in `Makefile` and `.latexmkrc`.

### Fixed

- Duplicate and contradictory package options in `class/thesis.cls`.
- `tablenotes` syntax in `chapters/ch4_customisation/tables/main_table.tex`.
- Minted relative paths in appendix code listings.

## [1.0.0] - 2025-10-27

### Added

- Initial release of the generalised University of Liverpool thesis template.
- Self-documenting chapter structure showcasing packages, figures, tables, listings, and customisation.
- `Makefile`, `.latexmkrc`, and `scripts/prepare_arxiv.py` for reproducible builds and arXiv submission.
- `README.md`, `docs/packages.md`, and `docs/structure.md`.
- MIT license for Tudor Jianu's adaptation, with attribution to Rob Robinson's original template.
