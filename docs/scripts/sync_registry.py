#!/usr/bin/env python3
import argparse
import shutil
import subprocess
from pathlib import Path


def run(cmd: list[str], cwd: Path, dry_run: bool) -> None:
    if dry_run:
        print(" ".join(cmd))
        return
    subprocess.run(cmd, cwd=str(cwd), check=True)


def copy_file(source: Path, target: Path, dry_run: bool) -> None:
    if dry_run:
        print(f"copy {source} {target}")
        return
    target.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(source, target)


def main() -> None:
    docs_root = Path(__file__).resolve().parents[1]
    kit_root = (docs_root / "../flutter_shadcn_kit").resolve()
    registry_root = kit_root / "lib/registry"
    docs_registry_root = docs_root / "lib/ui/shadcn"

    parser = argparse.ArgumentParser(
        description="Sync the docs vendored registry mirror from flutter_shadcn_kit/lib/registry."
    )
    parser.add_argument(
        "--registry-root",
        default=str(registry_root),
        help="Canonical registry root to copy from.",
    )
    parser.add_argument(
        "--docs-registry-root",
        default=str(docs_registry_root),
        help="Docs registry mirror destination.",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Print operations without writing files.",
    )
    args = parser.parse_args()

    registry_root = Path(args.registry_root).resolve()
    docs_registry_root = Path(args.docs_registry_root).resolve()
    manifest = registry_root / "manifests/components.json"
    docs_asset_manifest = docs_root / "assets/registry/components.json"

    if not manifest.exists():
        raise SystemExit(f"Missing canonical manifest: {manifest}")

    run(
        [
            "rsync",
            "-a",
            "--delete",
            "--delete-excluded",
            "--exclude=.DS_Store",
            "--exclude=.codex/",
            "--exclude=AGENTS.md",
            "--exclude=graphify-out/",
            f"{registry_root}/",
            f"{docs_registry_root}/",
        ],
        docs_root,
        args.dry_run,
    )
    copy_file(manifest, docs_asset_manifest, args.dry_run)


if __name__ == "__main__":
    main()
