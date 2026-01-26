#!/usr/bin/env python3
import argparse
import json
import os
from pathlib import Path


def to_snake(name: str) -> str:
    out = []
    prev_lower = False
    for ch in name.strip().replace("-", " ").replace("/", " "):
        if ch.isspace():
            if out and out[-1] != "_":
                out.append("_")
            prev_lower = False
            continue
        if ch.isupper() and prev_lower:
            out.append("_")
        out.append(ch.lower())
        prev_lower = ch.islower()
    return "".join(out).strip("_")


def to_title(name: str) -> str:
    parts = [p for p in name.replace("_", " ").replace("-", " ").split() if p]
    return " ".join(p.capitalize() for p in parts)


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Scaffold a new registry component and update components.json."
    )
    parser.add_argument("name", help="Component name (e.g. feature_carousel)")
    parser.add_argument(
        "--category",
        required=True,
        help="Registry category (e.g. display, form, layout, overlay)",
    )
    parser.add_argument("--description", default="", help="Short description")
    args = parser.parse_args()

    component_id = to_snake(args.name)
    category = to_snake(args.category)
    title = to_title(component_id)
    description = (
        args.description.strip()
        or f"{title} component for the registry."
    )

    repo_root = Path(__file__).resolve().parents[2]
    registry_root = repo_root / "lib/registry"
    components_root = registry_root / "components"
    comp_dir = components_root / category / component_id
    comp_dir.mkdir(parents=True, exist_ok=True)

    # Scaffold files
    (comp_dir / "README.md").write_text(
        f"# {title}\n\n{description}\n",
        encoding="utf-8",
    )

    (comp_dir / "meta.json").write_text(
        json.dumps(
            {
                "id": component_id,
                "name": title,
                "description": description,
                "category": category,
                "tags": [category, component_id],
                "dependencies": {"pubspec": {}, "shared": [], "components": []},
            },
            indent=2,
            ensure_ascii=True,
        )
        + "\n",
        encoding="utf-8",
    )

    main_dart = comp_dir / f"{component_id}.dart"
    if not main_dart.exists():
        main_dart.write_text(
            "import 'package:flutter/material.dart';\n\n"
            f"class {''.join(p.capitalize() for p in component_id.split('_'))}"
            " extends StatelessWidget {\n"
            "  const "
            f"{''.join(p.capitalize() for p in component_id.split('_'))}"
            "({super.key});\n\n"
            "  @override\n"
            "  Widget build(BuildContext context) {\n"
            "    return const SizedBox.shrink();\n"
            "  }\n"
            "}\n",
            encoding="utf-8",
        )

    preview_dart = comp_dir / "preview.dart"
    if not preview_dart.exists():
        preview_dart.write_text(
            "import 'package:flutter/material.dart' as m;\n\n"
            f"import '{component_id}.dart';\n\n"
            f"class {''.join(p.capitalize() for p in component_id.split('_'))}"
            "Preview extends m.StatelessWidget {\n"
            "  const "
            f"{''.join(p.capitalize() for p in component_id.split('_'))}"
            "Preview({super.key});\n\n"
            "  @override\n"
            "  m.Widget build(m.BuildContext context) {\n"
            "    return const m.SizedBox.shrink();\n"
            "  }\n"
            "}\n",
            encoding="utf-8",
        )

    # Update components.json in registry and docs assets copy
    rel_files = []
    for root, dirs, files in os.walk(comp_dir):
        dirs.sort()
        files.sort()
        for name in files:
            rel_files.append(
                Path(root).joinpath(name).relative_to(comp_dir).as_posix()
            )
    rel_files.sort()

    entry = {
        "id": component_id,
        "name": title,
        "description": description,
        "category": category,
        "tags": [category, component_id],
        "files": [
            {
                "source": f"registry/components/{category}/{component_id}/{rel}",
                "destination": f"{{installPath}}/components/{category}/{component_id}/{rel}",
            }
            for rel in rel_files
        ],
        "shared": [],
        "dependsOn": [],
        "pubspec": {"dependencies": {}},
        "assets": [],
        "postInstall": [],
    }

    for json_path in [
        registry_root / "components.json",
        repo_root / "../docs/assets/registry/components.json",
    ]:
        if not json_path.exists():
            continue
        data = json.loads(json_path.read_text())
        comps = [c for c in data.get("components", []) if c.get("id") != component_id]
        comps.append(entry)
        data["components"] = comps
        json_path.write_text(json.dumps(data, indent=2, ensure_ascii=True) + "\n")

    print(f"Created {category}/{component_id} in registry.")


if __name__ == "__main__":
    main()
