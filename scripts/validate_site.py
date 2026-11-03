"""Check local HTML/Markdown links, assets, anchor targets and source-code URLs."""
import html
import re
import sys
from functools import lru_cache
from html.parser import HTMLParser
from pathlib import Path
from urllib.parse import unquote, urlsplit

ROOT = Path(__file__).resolve().parents[1]
REPO_PREFIX = "https://github.com/vygantas-meskauskis/learning-library/"
PAGES_PREFIX = "https://vygantas-meskauskis.github.io/learning-library/"
OLD_URL = re.compile(r"https://(?:github\.com/vygantas-meskauskis|vygantas-meskauskis\.github\.io)/(?:cloud-native-dotnet|becoming-ai-native-designer|ai-native-design-lead-course)(?:[/#.]|$)")


class Document(HTMLParser):
    def __init__(self, content):
        super().__init__(convert_charrefs=True)
        self.ids = set()
        self.links = []
        self.feed(content)

    def handle_starttag(self, tag, attrs):
        attrs = dict(attrs)
        if "id" in attrs:
            self.ids.add(attrs["id"])
        for attribute in ("href", "src"):
            if attribute in attrs:
                self.links.append(attrs[attribute])


def markdown_ids(content):
    ids, counts = set(), {}
    content = re.sub(r"```.*?```", "", content, flags=re.S)
    for heading in re.findall(r"^#{1,6}\s+(.+)", content, re.M):
        slug = re.sub(r"[^\w\- ]", "", heading.lower()).replace(" ", "-")
        number = counts.get(slug, 0)
        counts[slug] = number + 1
        ids.add(slug + (f"-{number}" if number else ""))
    return ids


@lru_cache(maxsize=None)
def anchor_ids(path):
    body = path.read_text(encoding="utf-8")
    return Document(body).ids if path.suffix == ".html" else markdown_ids(body)


def validate(base):
    errors = []
    checked = 0
    files = [base / "index.html"] + sorted((base / "courses").rglob("*"))
    if base == ROOT:
        files += [ROOT / "README.md", ROOT / "MIGRATION.md"]
    for path in files:
        if not path.is_file() or path.suffix not in {".html", ".md"}:
            continue
        if "sample" in path.relative_to(base).parts:
            continue
        content = path.read_text(encoding="utf-8")
        if OLD_URL.search(content):
            errors.append(f"{path.relative_to(base)}: obsolete source URL")
        if path.suffix == ".html":
            links = Document(content).links
        else:
            prose = re.sub(r"```.*?```", "", content, flags=re.S)
            links = re.findall(r"!?\[[^\]]*\]\(([^)\s]+)(?:\s+\"[^\"]*\")?\)", prose)
        for link in links:
            link = html.unescape(link)
            github = link.startswith(REPO_PREFIX)
            if github:
                relative = link[len(REPO_PREFIX):]
                if not relative.startswith(("blob/main/", "tree/main/")):
                    continue
                link = relative.split("/", 2)[2]
                target_base = ROOT
            elif link.startswith(PAGES_PREFIX):
                link = link[len(PAGES_PREFIX):]
                target_base = base
            else:
                parsed = urlsplit(link)
                if parsed.scheme or parsed.netloc:
                    continue
                target_base = path.parent
                if link.startswith("/"):
                    errors.append(f"{path.relative_to(base)}: root-absolute URL {link}")
                    continue
            parsed = urlsplit(link)
            target = (target_base / unquote(parsed.path)).resolve() if parsed.path else path
            if target.is_dir():
                if github:
                    checked += 1
                    continue
                target /= "index.html"
            checked += 1
            if not target.is_file():
                errors.append(f"{path.relative_to(base)}: missing {link}")
                continue
            if parsed.fragment and target.suffix in {".html", ".md"}:
                ids = anchor_ids(target)
                if unquote(parsed.fragment) not in ids:
                    errors.append(f"{path.relative_to(base)}: missing anchor {link}")
    if errors:
        raise SystemExit("\n".join(errors))
    print(f"Validated {checked} internal links/assets/anchors in {base}")


if __name__ == "__main__":
    validate((ROOT / sys.argv[1]).resolve() if len(sys.argv) > 1 else ROOT)
