"""Stage only public reading material; do not deploy the repository wholesale."""
import shutil
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
OUTPUT = ROOT / "_site"


def build():
    if OUTPUT.exists():
        shutil.rmtree(OUTPUT)
    OUTPUT.mkdir()
    for name in ("index.html", ".nojekyll"):
        shutil.copyfile(ROOT / name, OUTPUT / name)
    shutil.copytree(ROOT / "assets", OUTPUT / "assets")
    for course in sorted((ROOT / "courses").iterdir()):
        if not course.is_dir():
            continue
        for source in sorted(course.rglob("*")):
            relative = source.relative_to(course)
            if not source.is_file():
                continue
            if relative.as_posix() == "toolkit/.editorconfig":
                # Pages does not serve dotfiles; retain the original in Git and publish a download alias.
                target = OUTPUT / "courses" / course.name / "toolkit" / "editorconfig.txt"
                target.parent.mkdir(parents=True, exist_ok=True)
                shutil.copyfile(source, target)
                continue
            if any(part.startswith(".") for part in relative.parts):
                continue
            # Readers link instructional code/workflows to GitHub, not website downloads.
            if source.suffix in {".cs", ".yml", ".yaml"}:
                continue
            public = (
                len(relative.parts) == 1 and source.suffix in {".html", ".md"}
                or relative.parts[0] in {"chapters", "modules"} and source.suffix == ".md"
                or relative.parts[0] in {"toolkit", "templates"}
            )
            if public:
                target = OUTPUT / "courses" / course.name / relative
                target.parent.mkdir(parents=True, exist_ok=True)
                shutil.copyfile(source, target)
    print(f"Staged {sum(p.is_file() for p in OUTPUT.rglob('*'))} website files in {OUTPUT}")


if __name__ == "__main__":
    build()
