#!/usr/bin/env python3
import argparse
import subprocess
from pathlib import Path


def run(cmd: list[str], cwd: Path) -> None:
    subprocess.run(cmd, cwd=str(cwd), check=True)


def main() -> None:
    docs_root = Path(__file__).resolve().parents[1]

    parser = argparse.ArgumentParser(
        description="Install components and regenerate docs pages.")
    parser.add_argument(
        "--skip-install",
        action="store_true",
        help="Skip flutter_shadcn install step",
    )
    parser.add_argument(
        "--skip-generate",
        action="store_true",
        help="Skip docs page generation step",
    )
    parser.add_argument(
        "--skip-barrel",
        action="store_true",
        help="Skip shadcn.dart barrel generation",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Print commands without executing",
    )
    args, unknown = parser.parse_known_args()

    if args.dry_run:
        if not args.skip_install:
            print("python3 scripts/install_components.py", *unknown)
        if not args.skip_generate:
            print("python3 scripts/generate_component_pages.py")
        if not args.skip_barrel:
            print("python3 scripts/generate_shadcn_barrel.py")
        return

    if not args.skip_install:
        run(["python3", "scripts/install_components.py", *unknown], docs_root)

    if not args.skip_generate:
        run(["python3", "scripts/generate_component_pages.py"], docs_root)

    if not args.skip_barrel:
        run(["python3", "scripts/generate_shadcn_barrel.py"], docs_root)


if __name__ == "__main__":
    main()
