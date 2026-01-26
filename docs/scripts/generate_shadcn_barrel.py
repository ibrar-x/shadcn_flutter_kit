#!/usr/bin/env python3
import json
from pathlib import Path


def load_config(config_path: Path) -> dict:
    if not config_path.exists():
        return {}
    try:
        return json.loads(config_path.read_text())
    except json.JSONDecodeError:
        return {}


def normalize_path(value: str) -> str:
    normalized = value.strip().lstrip("/")
    if normalized.startswith("lib/"):
        normalized = normalized[4:]
    return normalized


def expand_destination(template: str, install_path: str, shared_path: str) -> str:
    return (
        template.replace("{installPath}", install_path)
        .replace("{sharedPath}", shared_path)
        .replace("\\", "/")
    )


def main() -> None:
    docs_root = Path(__file__).resolve().parents[1]
    config = load_config(docs_root / ".shadcn/config.json")
    install_path = normalize_path(config.get("installPath", "lib/ui/shadcn"))
    shared_path = normalize_path(config.get("sharedPath", "lib/ui/shadcn/shared"))

    registry_path = (
        docs_root / "../flutter_shadcn_kit/lib/registry/components.json"
    ).resolve()
    data = json.loads(registry_path.read_text())

    exports = []

    for shared in data.get("shared", []):
        for file in shared.get("files", []):
            destination = file.get("destination")
            if not destination:
                continue
            exports.append(expand_destination(destination, install_path, shared_path))

    for comp in data.get("components", []):
        for file in comp.get("files", []):
            destination = file.get("destination")
            if not destination:
                continue
            exports.append(expand_destination(destination, install_path, shared_path))

    seen = set()
    deduped = []
    for path in exports:
        if path in seen:
            continue
        seen.add(path)
        if path.endswith("README.md") or path.endswith("meta.json"):
            continue
        if path.endswith(".dart"):
            deduped.append(path)

    deduped.sort()

    lines = [
        "// GENERATED FILE - DO NOT EDIT.",
        "// Update via docs/scripts/generate_shadcn_barrel.py.",
        "",
        "export 'package:flutter/material.dart' hide ColorScheme, ThemeData;",
        "export 'package:data_widget/data_widget.dart';",
        "export 'package:gap/gap.dart';",
        "",
    ]
    for path in deduped:
        lines.append(f"export '{path}';")
    lines.append("")

    output_path = docs_root / "lib/shadcn.dart"
    output_path.write_text("\n".join(lines))


if __name__ == "__main__":
    main()
