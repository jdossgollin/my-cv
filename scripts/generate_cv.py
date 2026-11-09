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
BIB_FILE = os.path.join("my-papers", "my-papers.bib")

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


def load_publications(bib_file):
    """Group .bib entries into numbered publication lists, newest first, numbered in reverse."""
    with open(bib_file, "r") as f:
        entries = parse_bib(f.read())
    publications = {}
    for section, types in PUBLICATION_TYPES.items():
        papers = []
        for e in entries:
            if e["type"] not in types:
                continue
            f = e["fields"]
            papers.append({
                "key": e["key"],
                "type": e["type"],
                "authors": format_authors(f.get("author", "")),
                "title": clean_latex(f.get("title", "")),
                "venue": clean_latex(f.get("journaltitle") or f.get("booktitle") or f.get("eprinttype") or ""),
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
            "papers": load_publications(BIB_FILE),
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


RESUME_TEMPLATE = "resume.typtemplate"
NUMBER_WORDS = {2: "two", 3: "three", 4: "four", 5: "five"}


def _pick(entries, wanted, *fields):
    """Return the one entry whose value in any of `fields` equals `wanted`; fail loudly otherwise."""
    hits = [e for e in entries if any(e.get(f) == wanted for f in fields)]
    if len(hits) != 1:
        sys.exit(f"Résumé selection {wanted!r} matched {len(hits)} entries on {fields}; it must match exactly one.")
    return hits[0]


def _dollars(amount):
    return f"\\${amount:,}"


def _resume_authors(authors, limit=7):
    """Long author lists keep the first author, James, and the last author, with ellipses between."""
    if len(authors) <= limit:
        return authors
    gap = {"name": "…", "role": ""}
    me = next(i for i, a in enumerate(authors) if a["role"] == "self")
    keep = [authors[0]]
    if me > 1:
        keep.append(gap)
    if 0 < me < len(authors) - 1:
        keep.append(authors[me])
    if me < len(authors) - 2:
        keep.append(gap)
    return keep + [authors[-1]]


def _resume_grant(entries):
    """One grant line from one or more awards with the same title (e.g. annual renewals)."""
    first = entries[0]
    amounts = [int(e["total_award"]) for e in entries if e.get("total_award")]
    if len(entries) > 1:
        amount = f"{_dollars(sum(amounts))} across {NUMBER_WORDS[len(entries)]} awards"
    elif first.get("subaward_from"):
        amount = f"Full grant {_dollars(int(first['total_project']))}; Rice subaward {_dollars(amounts[0])}"
    else:
        amount = _dollars(amounts[0]) if amounts else ""
    return {
        **first,
        "amount": amount,
        "start": min(e["start"] for e in entries),
        "end": max(e["end"] for e in entries),
    }


def build_resume(cv, selection_file):
    """Render a résumé from a per-application selection file; write the .typ next to it.

    The selection file's `sections:` list is the document: each section has an optional
    `title` and `note`, then content keys rendered in the order written, then optional
    nested `sections:`. See RESUME_PARTS for the content keys.
    """
    with open(selection_file) as f:
        sel = yaml.safe_load(f)
    d = cv.data
    papers = [p for group in d["papers"].values() for p in group]
    grants = d["grants_contracts"]["proposals"]
    talks = d["invited_talks"] + d["workshop_presentations"]

    def awards_for(institution, awards):
        lines = []
        for item in (awards or {}).get(institution, []):
            # An item is a title, a list of titles for one line, or {title: ..., org: ...} to shorten the org
            org = item.get("org") if isinstance(item, dict) else None
            item = item["title"] if isinstance(item, dict) else item
            titles = item if isinstance(item, list) else [item]
            picked = [_pick(d["awards"], t, "title") for t in titles]
            lines.append({
                "titles": titles,
                "org": org or ("" if institution in picked[0]["org"] else picked[0]["org"]),
                "years": ", ".join(sorted(a["year"] for a in picked)),
            })
        return lines

    def appointments(names, block):
        groups = {}
        for a in (_pick(d["appointments"], n, "dept") for n in names):
            groups.setdefault(a["organization"], []).append(a)
        return [{"org": o, "roles": r, "awards": awards_for(o, block.get("awards"))} for o, r in groups.items()]

    def education(degrees, block):
        groups = {}
        for e in d["education"]:
            if e["degree"] in degrees:
                groups.setdefault(e["university"], []).append(e)
        return [{"org": o, "degrees": r, "awards": awards_for(o, block.get("awards"))} for o, r in groups.items()]

    def teaching(codes, block):
        out = []
        for code in codes:
            offerings = [t for t in d["teaching"] if t["course"] == code]
            if not offerings:
                sys.exit(f"Résumé selection {code!r} matched no course.")
            latest = max(offerings, key=lambda t: t["year"])
            out.append({**latest, "years": ", ".join(sorted({t["year"] for t in offerings}))})
        return out

    def reviewing(examples, block):
        """`true` for counts only, or a list of journal names from review.yml to name as examples."""
        reviews = d["review_activities"]
        return {
            "journals": sum(r["type"] == "journal" for r in reviews),
            "examples": [_pick(reviews, j, "name")["name"] for j in examples] if isinstance(examples, list) else [],
            "external": [r["name"] for r in reviews if r["type"] == "external"],
            "funders": [r["name"] for r in reviews if r["type"] == "funding"],
        }

    def grant_lines(items, block):
        return [
            _resume_grant([_pick(grants, i, "id") for i in (item if isinstance(item, list) else [item])])
            for item in items
        ]

    def publications(keys, block):
        return [{**p, "authors": _resume_authors(p["authors"])} for p in (_pick(papers, k, "key") for k in keys)]

    parts = {
        "text": lambda v, b: v,  # Typst markup, inserted as is
        "entries": lambda v, b: v,  # Typst markup, [entry, date] pairs
        "appointments": appointments,
        "education": education,
        "talks": lambda v, b: [_pick(talks, t, "title", "event") for t in v],
        "media": lambda v, b: [_pick(d["media_coverage"], t, "title") for t in v],
        "languages": lambda v, b: [_pick(d["languages"], t, "language") for t in v],
        "teaching": teaching,
        "service": lambda v, b: [_pick(d["professional_service"], t, "organization", "program") for t in v],
        "reviewing": reviewing,
        "grants": grant_lines,
        "publications": publications,
    }

    def resolve(block):
        unknown = set(block) - set(parts) - {"title", "note", "awards", "sections", "dates", "dois"}
        if unknown:
            sys.exit(f"Résumé section {block.get('title')!r} has unknown keys {sorted(unknown)}; known: {sorted(parts)}.")
        return {
            "title": block.get("title"),
            "note": block.get("note") or "",
            "custom_note": "note" in block,
            "dates": block.get("dates", True),
            "dois": block.get("dois", True),
            "parts": [{"kind": k, "data": parts[k](v, block)} for k, v in block.items() if k in parts],
            "sections": [resolve(b) for b in block.get("sections") or []],
        }

    funded = [g for g in grants if g["status"] in ("active", "complete") and g.get("total_award")]
    resume = {
        **sel,
        "sections": [resolve(b) for b in sel["sections"]],
        "total_millions": sum(int(g["total_award"]) for g in funded) / 1e6,
        "pi_millions": sum(int(g["total_award"]) for g in funded if g["my_role"] == "PI") / 1e6,
    }
    out = Path(selection_file).with_suffix(".typ")
    out.write_text(cv.render_typ(RESUME_TEMPLATE, resume=resume))
    print(f"Generated {out}")


def main():
    import argparse
    import shutil

    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--resume", metavar="SELECTION_YML",
                        help="build only a résumé from this selection file, written next to it as .typ")
    args = parser.parse_args()

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
    if args.resume:
        build_resume(cv, args.resume)
        return

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
