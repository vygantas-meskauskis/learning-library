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
            if not source.is_file() or any(part.startswith(".") for part in relative.parts):
                # The toolkit's editorconfig is a deliberate downloadable helper.
                if relative.as_posix() != "toolkit/.editorconfig":
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
