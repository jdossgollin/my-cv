"""
This script builds the CV file from a template
"""

import os
import sys
import re
from pathlib import Path
import filters  # filters for Jinja
import jinja2
import yaml

# definitions
CONFIG_FILE = "_config.yml"
TEMPLATE_DIR = "templates"
TEMP_OUTPUT_DIR = "temp_output"
DOCS_DIR = "docs"
# my-papers.bib is synced from Zotero; papers-in-progress.bib holds unpublished work
BIB_FILES = [os.path.join("my-papers", "my-papers.bib"), "papers-in-progress.bib"]

# Template configurations
TEMPLATES = {
    "full_cv": {
        "template": "cv.typtemplate",
        "output_typ": "Doss-Gollin-CV.typ",
        "output_pdf": "Doss-Gollin-CV.pdf",
        "copy_to_docs": True,  # This goes to GitHub Pages
    },
}

# Publication list sections, by BibLaTeX entry type. Other types (thesis, report) are omitted.
PUBLICATION_TYPES = {
    "preprints": {"misc", "online"},
    "articles": {"article"},
    "conference": {"inproceedings"},
}
SELF_NAME = ("Doss-Gollin", "J")
# Rice advisee co-authors, highlighted with a dagger
ADVISEES = {("Lu", "Y"), ("Schmeltzer", "K")}


def parse_bib(text):
    """Split a .bib file into entries of {type, key, fields}, keeping field values raw."""
    field_start = re.compile(r"\s*(\w+)\s*=\s*")
    bare_value = re.compile(r"[^,}]*")
    entries = []
    for m in re.finditer(r"@(\w+)\s*\{([^,]+),", text):
        pos, fields = m.end(), {}
        while fm := field_start.match(text, pos):
            pos = fm.end()
            if text[pos] == "{":
                start, level = pos + 1, 0
                while True:
                    level += {"{": 1, "}": -1}.get(text[pos], 0)
                    pos += 1
                    if level == 0:
                        break
                value = text[start : pos - 1]
            else:
                bm = bare_value.match(text, pos)
                value, pos = bm.group().strip(), bm.end()
            fields[fm.group(1).lower()] = value
            pos = re.compile(r"\s*,?").match(text, pos).end()
        entries.append({"type": m.group(1).lower(), "key": m.group(2).strip(), "fields": fields})
    return entries


def clean_latex(value):
    """Turn a BibLaTeX field value into plain text (the .bib stores accents as Unicode)."""
    for old, new in (("\\&", "&"), ("\\%", "%"), ("\\_", "_"), ("\\,", " "), ("~", " ")):
        value = value.replace(old, new)
    return re.sub(r"\s+", " ", value.replace("{", "").replace("}", "")).strip()


def initials(given):
    """'Francisco de Assis' -> 'F. d. A.'; 'Jean-Pierre' -> 'J.-P.'"""
    return " ".join("-".join(part[0] + "." for part in word.split("-") if part) for word in given.split())


def parse_name(raw):
    """Return (family, given) from 'Family, Given' or the extended 'family=..., given=..., prefix=...' form."""
    if "family=" in raw:
        parts = dict(re.findall(r"(\w+)=([^,]*)", raw))
        family = clean_latex(parts["family"])
        if "prefix" in parts:
            family = clean_latex(parts["prefix"]) + " " + family
        return family, clean_latex(parts.get("given", ""))
    family, _, given = raw.partition(",")
    return clean_latex(family), clean_latex(given)


def format_authors(field):
    """List of {name, role} with role 'self', 'advisee', or '' for highlighting."""
    authors = []
    for raw in re.split(r"\s+and\s+", field):
        family, given = parse_name(raw)
        # Match on family name and first initial, as biblatex-publist does
        key = (family, given[:1])
        role = "self" if key == SELF_NAME else "advisee" if key in ADVISEES else ""
        authors.append({"name": f"{family}, {initials(given)}" if given else family, "role": role})
    return authors


def load_publications(bib_files):
    """Group .bib entries into numbered publication lists, newest first, numbered in reverse."""
    entries = []
    for bib_file in bib_files:
        with open(bib_file, "r") as f:
            entries += parse_bib(f.read())
    publications = {}
    for section, types in PUBLICATION_TYPES.items():
        papers = []
        for e in entries:
            if e["type"] not in types:
                continue
            f = e["fields"]
            papers.append({
                "type": e["type"],
                "authors": format_authors(f.get("author", "")),
                "title": clean_latex(f.get("title", "")),
                "venue": clean_latex(f.get("journaltitle") or f.get("booktitle") or ""),
                "doi": f.get("doi", ""),
                "url": f.get("url", ""),
                "year": (f.get("date") or f.get("year", ""))[:4],
                "sortname": clean_latex(f.get("author", "")),
            })
        # BibLaTeX sorting=ydnt: year descending, then author, then title
        papers.sort(key=lambda p: (-int(p["year"] or 0), p["sortname"], p["title"]))
        for i, paper in enumerate(papers):
            paper["number"] = len(papers) - i
        publications[section] = papers
    return publications


class CV(object):
    """
    Build CV in Typst format from YAML and BibTeX inputs
    """

    def __init__(self, config_file, filters=None, templates=None):

        self.filters = filters
        # read config file
        with open(config_file, "r") as f:
            config = yaml.load(f, Loader=yaml.BaseLoader)

        # read in section data files
        sections = [
            {
                "title": k["title"],
                "entries": yaml.load(
                    open(os.path.join(config["paths"]["yaml_path"], k["file"]), "r"),
                    Loader=yaml.BaseLoader,
                ),
            }
            for k in config["sections"]
        ]

        # also load section data directly by key name for easier template access
        section_data = {}
        for k in config["sections"]:
            # Convert section titles to lowercase keys with underscores
            key_name = k["title"].lower().replace(" ", "_").replace("and_", "")
            section_data[key_name] = yaml.load(
                open(os.path.join(config["paths"]["yaml_path"], k["file"]), "r"),
                Loader=yaml.BaseLoader,
            )

        # combine personal, sectional data, and publication data
        self.data = {
            "person": config["person"],
            "paths": config["paths"],
            "publications": config["publications"],
            "papers": load_publications(BIB_FILES),
            "sections": sections,
            **section_data,  # Add direct section access
        }

        # load templates
        templates = {} if templates is None else templates
        self.loader = jinja2.loaders.DictLoader(templates)

    @property
    def jenv_md(self):
        """
        Set up HTML/Markdown Jinja environment
        """
        loader = jinja2.loaders.ChoiceLoader(
            [
                self.loader,
                jinja2.FileSystemLoader(
                    str(Path(__file__).resolve().parent.parent / "templates")
                ),
            ]
        )
        jenv = jinja2.Environment(loader=loader)
        for f in self.filters:
            jenv.filters[f.__name__] = f
        return jenv

    @property
    def jenv_typ(
        self,
    ):
        """
        Set up Typst environment
        """
        loader = jinja2.ChoiceLoader(
            [self.loader, jinja2.FileSystemLoader(TEMPLATE_DIR)]
        )
        jenv = jinja2.Environment(loader=loader)
        # define new delimiters to avoid conflicts with Typst braces and brackets
        jenv.block_start_string = "((*"
        jenv.block_end_string = "*))"
        jenv.variable_start_string = "((("
        jenv.variable_end_string = ")))"
        jenv.comment_start_string = "((="
        jenv.comment_end_string = "=))"
        for f in self.filters:
            jenv.filters[f.__name__] = f
        return jenv

    def render_typ(self, template, **kwargs):
        return self.jenv_typ.get_template(template).render(data=self.data, **kwargs)

    def copy_pdfs_to_docs(self):
        """Copy specified PDFs from temp to docs after Typst compilation"""
        import shutil

        for template_name, config in TEMPLATES.items():
            if config["copy_to_docs"]:
                temp_pdf = os.path.join(TEMP_OUTPUT_DIR, config["output_pdf"])
                docs_pdf = os.path.join(DOCS_DIR, config["output_pdf"])
                if os.path.exists(temp_pdf):
                    shutil.copy2(temp_pdf, docs_pdf)
                    print(f"Copied {config['output_pdf']} to docs/")


def main():
    import shutil

    my_filters = [
        filters.escape_typst,
        filters.select_by_attr_name,
        filters.sort_by_attr,
        filters.sort_first_year,
        filters.extract_year,
        filters.trim_university,
        filters.format_collaborators,
    ]

    cv = CV(CONFIG_FILE, filters=my_filters)

    # Create output directories
    if not os.path.isdir(TEMP_OUTPUT_DIR):
        os.mkdir(TEMP_OUTPUT_DIR)
    if not os.path.isdir(DOCS_DIR):
        os.mkdir(DOCS_DIR)

    # Generate all templates
    for template_name, config in TEMPLATES.items():
        print(f"Generating {template_name}...")

        # Generate Typst file in temp directory
        temp_typ_path = os.path.join(TEMP_OUTPUT_DIR, config["output_typ"])
        with open(temp_typ_path, "w") as f:
            f.write(cv.render_typ(config["template"]))

        # Copy to docs if specified
        if config["copy_to_docs"]:
            docs_typ_path = os.path.join(DOCS_DIR, config["output_typ"])
            shutil.copy2(temp_typ_path, docs_typ_path)
            print(f"  Copied {config['output_typ']} to docs/")

        print(f"  Generated {temp_typ_path}")


if __name__ == "__main__":
    main()
