#!/usr/bin/env python3
import argparse
import json
import subprocess
from pathlib import Path


def load_component_ids(components_path: Path) -> list[str]:
    data = json.loads(components_path.read_text())
    components = data.get("components", [])
    seen = set()
    ids = []
    for comp in components:
        comp_id = comp.get("id")
        if not comp_id or comp_id in seen:
            continue
        seen.add(comp_id)
        ids.append(comp_id)
    ids.sort()
    return ids


def chunk(items: list[str], size: int) -> list[list[str]]:
    return [items[i : i + size] for i in range(0, len(items), size)]


def run(cmd: list[str], cwd: Path, dry_run: bool) -> None:
    if dry_run:
        print(" ".join(cmd))
        return
    subprocess.run(cmd, cwd=str(cwd), check=True)


def main() -> None:
    docs_root = Path(__file__).resolve().parents[1]
    default_registry = (
        docs_root / "../flutter_shadcn_kit/lib/registry/components.json"
    ).resolve()
    local_cli = (
        docs_root / "../../shadcn_flutter_cli/bin/flutter_shadcn.dart"
    ).resolve()

    parser = argparse.ArgumentParser(
        description="Install registry components into the docs app using flutter_shadcn."
    )
    parser.add_argument(
        "--registry",
        default=str(default_registry),
        help="Path to registry/components.json",
    )
    parser.add_argument(
        "--batch-size",
        type=int,
        default=12,
        help="Number of components per flutter_shadcn add command",
    )
    parser.add_argument(
        "--skip-init",
        action="store_true",
        help="Skip flutter_shadcn init",
    )
    parser.add_argument(
        "--reinstall",
        action="store_true",
        help="Remove all installed components before init/add",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Print commands without executing",
    )
    args = parser.parse_args()

    registry_path = Path(args.registry).resolve()
    registry_root = registry_path.parent.resolve()
    component_ids = load_component_ids(registry_path)

    cli_base = ["dart", "run", str(local_cli)]

    if args.reinstall:
        run(
            [*cli_base, "remove", "--all"],
            cwd=docs_root,
            dry_run=args.dry_run,
        )

    if not args.skip_init:
        run(
            [
                *cli_base,
                "init",
                "--yes",
                "--all",
                "--install-path",
                "lib/ui/shadcn",
                "--shared-path",
                "lib/ui/shadcn/shared",
                "--include-meta",
                "--include-preview",
                "--dev",
                "--dev-path",
                str(registry_root),
            ],
            cwd=docs_root,
            dry_run=args.dry_run,
        )

        # init --all already installs every component.
        return

    for batch in chunk(component_ids, args.batch_size):
        run(
            [
                *cli_base,
                "add",
                *batch,
                "--registry",
                "local",
                "--registry-path",
                str(registry_root),
            ],
            cwd=docs_root,
            dry_run=args.dry_run,
        )


if __name__ == "__main__":
    main()
