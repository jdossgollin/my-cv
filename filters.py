"""
Filters for printing TeX and Markdown to jinja templates.
See http://flask.pocoo.org/snippets/55/ for more info.
"""

import re

LATEX_SUBS = (
    (re.compile(r'\\'), r'\\textbackslash'),
    (re.compile(r'([#%&{}])'), r'\\\1'),
    (re.compile(r'~'), r'\~{}'),
    (re.compile(r'\^'), r'\^{}'),
    (re.compile(r'^"'), r"``"),
    (re.compile(r'"$'), r"''"),
    (re.compile(r'\.\.\.+'), r'\\ldots')
)


def escape_tex(value):
    """
    Escape TeX special characters
    """
    newval = value
    for pattern, replacement in LATEX_SUBS:
        newval = pattern.sub(replacement, newval, re.MULTILINE)
    return newval


def select_by_attr_name(array, attr, value):
    for d in array:
        if d[attr] == value:
            return d


def sort_by_attr(array, attr, reverse=False):
    if type(attr) is list:
        sorted_array = sorted(array, key=lambda x: tuple(str(x[a]) for a in attr), reverse=reverse)
    else:
        sorted_array = sorted(array, key=lambda x: str(x[a] for a in attr), reverse=reverse)
    return sorted_array


def sort_first_year(array, attr, reverse=False):
    return sorted(array, key=lambda x: int(re.findall(r'^\d{4}', str(x[attr]))[0]), reverse=reverse)


def extract_year(date_str):
    """
    Extract year from date string (supports YYYY-MM-DD, YYYY-MM, or YYYY formats)
    """
    if not date_str:
        return ""
    year_match = re.findall(r'^\d{4}', str(date_str))
    return year_match[0] if year_match else str(date_str)


def trim_university(name):
    """
    Remove "University" from university names for more concise display
    e.g., "Rice University" -> "Rice", "Columbia University" -> "Columbia"
    """
    if not name:
        return ""
    return re.sub(r'\s+University$', '', name)


def format_collaborators(collaborators: list[dict], my_role: str) -> str:
    """Format collaborator list for CV display.

    Returns a string like "PI: Elke Weber, with Robert Keohane and Sara Constantino"
    or just "with Name1, Name2, and Name3" when there's no separate PI to call out.
    """
    if not collaborators:
        return ""

    # Separate PI(s) from others
    pis = [c for c in collaborators if c.get("role") == "PI"]
    others = [c for c in collaborators if c.get("role") != "PI"]

    parts = []

    if pis and my_role != "PI":
        # Call out PI(s) when you're not a PI yourself
        pi_names = _join_names([c["name"] for c in pis])
        parts.append(f"PI: {pi_names}")
        if others:
            other_names = _join_names([c["name"] for c in others])
            parts.append(f"with {other_names}")
    else:
        # You're PI — list everyone (including other PIs) as "with"
        all_names = _join_names([c["name"] for c in collaborators])
        if all_names:
            parts.append(f"with {all_names}")

    return ", ".join(parts)


def _join_names(names: list[str]) -> str:
    """Join names with Oxford comma: 'A', 'A and B', 'A, B, and C'."""
    if len(names) == 0:
        return ""
    if len(names) == 1:
        return names[0]
    if len(names) == 2:
        return f"{names[0]} and {names[1]}"
    return ", ".join(names[:-1]) + f", and {names[-1]}"
