#!/usr/bin/env python3
import argparse
import json
import re
from pathlib import Path


def read_package_name(pubspec_path: Path) -> str:
    if not pubspec_path.exists():
        return "docs"
    for line in pubspec_path.read_text().splitlines():
        stripped = line.strip()
        if stripped.startswith("name:"):
            return stripped.split(":", 1)[1].strip() or "docs"
    return "docs"


def snake_to_pascal(value: str) -> str:
    parts = re.split(r"[_\-]+", value)
    return "".join(part[:1].upper() + part[1:] for part in parts if part)


def load_components(components_path: Path) -> list[dict]:
    data = json.loads(components_path.read_text())
    components = data.get("components", [])
    seen = set()
    output = []
    for comp in components:
        comp_id = comp.get("id")
        if not comp_id or comp_id in seen:
            continue
        seen.add(comp_id)
        output.append(
            {
                "id": comp_id,
                "name": comp.get("name") or comp_id,
                "description": comp.get("description") or "Component preview.",
                "category": comp.get("category") or "uncategorized",
            }
        )
    output.sort(key=lambda item: (item["category"], item["id"]))
    return output


def read_cli_config(config_path: Path) -> dict:
    if not config_path.exists():
        return {}
    try:
        return json.loads(config_path.read_text())
    except json.JSONDecodeError:
        return {}


def normalize_install_path(value: str) -> str:
    if not value:
        return "lib/ui/shadcn"
    normalized = value.strip().lstrip("/")
    if not normalized.startswith("lib/"):
        normalized = f"lib/{normalized}"
    return normalized


def escape_dart_string(value: str) -> str:
    return value.replace("\\", "\\\\").replace("'", "\\'").replace("\n", "\\n")


def build_page_content(
    package_name: str,
    component_id: str,
    display_name: str,
    description: str,
    preview_import: str | None,
    preview_class: str | None,
) -> str:
    class_name = f"{snake_to_pascal(component_id)}DocsPage"
    safe_display_name = escape_dart_string(display_name)
    safe_description = escape_dart_string(description)
    lines = [
        "// GENERATED FILE - DO NOT EDIT.",
        "// Update via docs/scripts/generate_component_pages.py.",
        "",
        "import 'package:flutter/material.dart';",
        f"import 'package:{package_name}/pages/docs/component_page.dart';",
    ]
    if preview_import:
        lines.append(preview_import)
    lines.append("")
    lines.append(f"class {class_name} extends StatelessWidget {{")
    lines.append(f"  const {class_name}({{super.key}});")
    lines.append("")
    lines.append("  @override")
    lines.append("  Widget build(BuildContext context) {")
    lines.append("    return ComponentPage(")
    lines.append(f"      name: '{component_id}',")
    lines.append(f"      displayName: '{safe_display_name}',")
    lines.append(f"      description: '{safe_description}',")
    lines.append("      children: [")
    if preview_class:
        lines.append(f"        const {preview_class}(),")
    else:
        lines.append(
            "        const Center(child: Text('Preview not available.')),")
    lines.append("      ],")
    lines.append("    );")
    lines.append("  }")
    lines.append("}")
    lines.append("")
    return "\n".join(lines)


def generate_pages(
    docs_root: Path,
    components: list[dict],
    components_dir: Path,
    package_name: str,
    install_path: str,
    dry_run: bool,
) -> None:
    components_root = docs_root / install_path / "components"
    import_base = install_path[4:] if install_path.startswith("lib/") else install_path
    components_dir.mkdir(parents=True, exist_ok=True)

    page_entries = []
    imports = []
    for comp in components:
        comp_id = comp["id"]
        display_name = comp["name"]
        preview_path = components_root / comp_id / "preview.dart"
        preview_class = None
        preview_import = None
        if preview_path.exists():
            preview_class = f"{snake_to_pascal(comp_id)}Preview"
            preview_import = (
                f"import 'package:{package_name}/{import_base}/components/{comp_id}/preview.dart';"
            )

        content = build_page_content(
            package_name=package_name,
            component_id=comp_id,
            display_name=display_name,
            description=comp["description"],
            preview_import=preview_import,
            preview_class=preview_class,
        )
        output_path = components_dir / f"{comp_id}_page.dart"
        if dry_run:
            continue
        output_path.write_text(content)
        imports.append(
            f"import 'package:{package_name}/pages/docs/components/{comp_id}_page.dart';"
        )
        page_entries.append(
            f"  '{comp_id}': (context) => const {snake_to_pascal(comp_id)}DocsPage(),"
        )

    if dry_run:
        return

    index_path = components_dir / "component_pages.dart"
    index_lines = [
        "// GENERATED FILE - DO NOT EDIT.",
        "// Update via docs/scripts/generate_component_pages.py.",
        "",
        "import 'package:flutter/material.dart';",
        *imports,
        "",
        "final Map<String, WidgetBuilder> componentPageBuilders = {",
        *page_entries,
        "};",
        "",
    ]
    index_path.write_text("\n".join(index_lines))


def update_progress(progress_path: Path, components: list[dict]) -> None:
    if not progress_path.exists():
        return

    lines = progress_path.read_text().splitlines()
    header = "## Component pages"
    try:
        start_index = lines.index(header)
    except ValueError:
        return

    end_index = len(lines)
    for i in range(start_index + 1, len(lines)):
        if lines[i].startswith("## "):
            end_index = i
            break

    existing = {}
    checkbox_pattern = re.compile(r"^- \[(?P<mark>[ xX])\].*\(`(?P<id>[^`]+)`\)")
    for line in lines[start_index + 1:end_index]:
        match = checkbox_pattern.match(line.strip())
        if not match:
            continue
        existing[match.group("id")] = match.group("mark").lower() == "x"

    new_lines = []
    for comp in components:
        comp_id = comp["id"]
        mark = "x" if existing.get(comp_id, False) else " "
        line = f"- [{mark}] {comp['name']} (`{comp_id}`) - {comp['category']}"
        new_lines.append(line)

    updated = lines[: start_index + 1] + [""] + new_lines + lines[end_index:]
    progress_path.write_text("\n".join(updated) + "\n")


def main() -> None:
    docs_root = Path(__file__).resolve().parents[1]
    default_registry = docs_root / "../flutter_shadcn_kit/lib/registry/components.json"

    parser = argparse.ArgumentParser(
        description="Generate docs component pages and sync progress.")
    parser.add_argument(
        "--registry",
        default=str(default_registry),
        help="Path to components.json",
    )
    parser.add_argument(
        "--docs-root",
        default=str(docs_root),
        help="Docs app root (contains pubspec.yaml)",
    )
    parser.add_argument(
        "--components-dir",
        default="lib/pages/docs/components",
        help="Output directory for generated component pages",
    )
    parser.add_argument(
        "--no-progress",
        action="store_true",
        help="Skip updating PROGRESS.md",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Do not write files",
    )
    args = parser.parse_args()

    docs_root_path = Path(args.docs_root).resolve()
    registry_path = Path(args.registry).resolve()
    components_dir = docs_root_path / args.components_dir

    components = load_components(registry_path)
    package_name = read_package_name(docs_root_path / "pubspec.yaml")

    config = read_cli_config(docs_root_path / ".shadcn/config.json")
    install_path = normalize_install_path(config.get("installPath", "lib/ui/shadcn"))

    generate_pages(
        docs_root=docs_root_path,
        components=components,
        components_dir=components_dir,
        package_name=package_name,
        install_path=install_path,
        dry_run=args.dry_run,
    )

    if not args.no_progress:
        update_progress(docs_root_path / "PROGRESS.md", components)


if __name__ == "__main__":
    main()
