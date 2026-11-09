# Scripts

Run all scripts from the **project root** with `uv run python scripts/<name>.py`.

## generate_cv.py

Reads `_config.yml` and the YAML files in `my-cv-data/`, renders Jinja2 Typst templates from `templates/`, and writes output to `temp_output/` and `docs/`.

```bash
uv run python scripts/generate_cv.py
```

To build a résumé instead, pass a selection file; `resume.typ` is written next to it from `templates/resume.typtemplate`:

```bash
uv run python scripts/generate_cv.py --resume path/to/resume.yml
```

The selection file lists the sections to print, in order; each picks entries by bib key, grant id, or title, or holds Typst text.
See `jdossgollin/application-2026-jpm-climate-advisory/resume.yml` for an example.

`filters.py` in this directory contains the Jinja2 filter functions used by the templates.

## grants_to_excel.py

Exports the grants data from `my-cv-data/grants.yml` to a timestamped Excel file in `temp_output/`.

```bash
uv run python scripts/grants_to_excel.py
```
