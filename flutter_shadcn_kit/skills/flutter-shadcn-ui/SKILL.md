---
name: flutter-shadcn-ui
description: >
  Builds production-ready Flutter UI components from the shadcn-flutter registry and
  automates component install, dependency resolution, theming, and asset setup. Use when
  adding or updating shadcn components, configuring themes/tokens, installing fonts or
  icons, managing the flutter_shadcn_cli, or troubleshooting registry, config, or
  installation issues in Flutter projects.
compatibility: >
  Requires Flutter/Dart tooling and flutter_shadcn_cli. Network access is needed for
  remote registry queries, upgrades, and asset downloads.
---

# Flutter Shadcn UI Skill

Build beautiful, production-ready Flutter UI components using the shadcn-flutter component registry through the CLI.

## When to Use

- Adding or updating shadcn components in a Flutter app
- Managing shared theming, tokens, and component dependencies
- Installing or troubleshooting `flutter_shadcn_cli`
- Setting up typography and icon assets used by the registry

## Inputs to Confirm

- Project root path and Flutter package name (if not obvious)
- Desired install paths (`installPath`, `sharedPath`)
- Theme choice and class prefix (if the project has conventions)
- Whether to use a local registry or the default remote registry

## Quick Start

### 0. Install CLI (if not present)

```bash
# Install CLI from pub.dev
dart pub global activate flutter_shadcn_cli

# Verify installation and check version
flutter_shadcn version

# Check for available updates
flutter_shadcn version --check

# Upgrade to latest version
flutter_shadcn upgrade
```

**CLI Management:**
- `flutter_shadcn version` - Show current installed version
- `flutter_shadcn version --check` - Check pub.dev for newer versions
- `flutter_shadcn upgrade` - Automatically upgrade to latest version
- `flutter_shadcn upgrade --force` - Force reinstall even if already latest

### 1. Initialize a Flutter Project

```bash
# Interactive mode (asks questions)
flutter_shadcn init

# Non-interactive with defaults
flutter_shadcn init --yes

# Specify all options
flutter_shadcn init --yes \
  --install-path lib/ui/shadcn \
  --shared-path lib/ui/shadcn/shared \
  --prefix App \
  --theme modern-minimal
```

**What it does:**
- Sets up component installation paths
- Creates shared utilities (theme, tokens, form helpers)
- Installs required dependencies (data_widget, gap)
- Configures your chosen theme (42 presets available)

### 2. Add Components

```bash
# Add single component
flutter_shadcn add button

# Add multiple components (resolves dependencies automatically)
flutter_shadcn add button dialog form

# Preview before installing
flutter_shadcn dry-run button
flutter_shadcn add button  # Install after preview
```

**Key features:**
- Auto-resolves component dependencies (e.g., menu → popover → overlay)
- Updates pubspec.yaml automatically
- Validates installation with schema

### 3. Browse & Search

```bash
# List all components by category
flutter_shadcn list

# Search for components
flutter_shadcn search "form input"

# Get detailed component info
flutter_shadcn info button
```

### 4. Manage Themes

```bash
# View available themes (42 presets)
flutter_shadcn theme --list

# Apply a theme
flutter_shadcn theme modern-minimal

# Reapply current theme after changes
flutter_shadcn sync
```

### 5. Install Assets

```bash
# Install typography fonts + icon fonts
flutter_shadcn assets --all

# Install only specific asset types
flutter_shadcn assets --fonts
flutter_shadcn assets --icons
```

## Core Concepts

### Component Structure

Each component has:
- **Files**: Component implementation (*.dart)
- **Shared files**: Common utilities reused across components (tokens, extensions, primitives)
- **Dependencies**: Required packages and other components
- **Platform steps**: Optional iOS/Android configuration

### Installation Paths

- **Install path** (e.g., `lib/ui/shadcn/components/control/button/`): Where components are installed
- **Shared path** (e.g., `lib/ui/shadcn/shared/theme/`): Common utilities all components use
- **Config file** (`.shadcn/config.json`): Stores project settings

### Theme System

42 built-in themes including:
- `modern-minimal` - Clean, subtle appearance
- `cosmic-night` - Dark mode with vibrant accents
- `glass-morphism` - Frosted glass aesthetic
- And 39 more presets

All themes include light/dark variants. Change themes anytime—colors propagate to all components.

## Common Tasks

### Add a Complete Form

```bash
flutter_shadcn add form form_field input checkbox button
```

This resolves all dependencies automatically:
- Copies form, form_field, input, checkbox, button component files
- Installs shared form helpers (FormControl, FormValueSupplier)
- Adds required pubspec dependencies
- Updates config manifest

### Build a Navigation Menu

```bash
flutter_shadcn add menu popover overlay button
```

### Create a Data Table UI

```bash
flutter_shadcn add table button dropdown
```

### Set Up Icons + Typography

```bash
flutter_shadcn init --install-fonts --install-icons
# Or after init:
flutter_shadcn assets --all
```

## Advanced Usage

### Custom Registry Paths

```bash
# Use local development registry
flutter_shadcn add button --registry local --registry-path /path/to/registry

# Use remote CDN with custom URL
flutter_shadcn add button --registry remote --registry-url https://cdn.example.com
```

### Dry Run Before Installing

```bash
flutter_shadcn dry-run button dialog
```

Shows:
- Dependency graph
- Files to be copied
- pubspec.yaml changes
- Post-install steps

### Remove Components Safely

```bash
# Remove component (checks for dependent components)
flutter_shadcn remove button

# Force remove (bypass dependency checks)
flutter_shadcn remove button --force

# Remove all components
flutter_shadcn remove --all
```

### Diagnose Issues

```bash
flutter_shadcn doctor
```

Validates:
- Configuration file integrity
- Installed components schema
- Path accessibility
- Registry connectivity
- Cache status

### Install Skills for AI Models

Deploy component-building workflows to your AI tools:

```bash
# Interactive skill installation
flutter_shadcn install-skill

# Install specific skill to specific model
flutter_shadcn install-skill --skill my-skill --model .claude

# List installed skills
flutter_shadcn install-skill --list
```

Auto-discovers AI model folders: `.claude/`, `.gpt4/`, `.cursor/`, `.gemini/`

### Check CLI Version & Upgrade

```bash
# Show current CLI version
flutter_shadcn version

# Check for available updates
flutter_shadcn version --check

# Upgrade to latest version from pub.dev
flutter_shadcn upgrade

# Force upgrade even if already on latest
flutter_shadcn upgrade --force
```

**When to upgrade:**
- After seeing update notification from `version --check`
- When new components or features are released
- To fix bugs in previous versions
- Before starting new projects to use latest improvements

## Configuration

### `.shadcn/config.json` Fields

```json
{
  "installPath": "lib/ui/shadcn",
  "sharedPath": "lib/ui/shadcn/shared",
  "theme": "modern-minimal",
  "classPrefix": "App",
  "registryMode": "remote",
  "registryUrl": "https://cdn-url.com",
  "platformTargets": {
    "ios.infoPlist": "ios/Runner/Info.plist"
  }
}
```

### After Editing Manually

```bash
# Reapply configuration
flutter_shadcn sync
```

## Registry File Formats

### Understanding `index.json`

Lightweight registry index listing components:
- Component name, description, tags, category
- Installation command for each component
- Minimal metadata for fast discovery (list, search, info commands)
- Cached locally to reduce network requests

### Understanding `components.json`

Full registry manifest with:
- Component file locations
- Shared file dependencies
- pubspec dependencies
- Platform-specific configuration
- Post-install steps

Used by: `add`, `remove`, `dry-run`

### Custom Component Metadata

Components expose:
- **API**: Constructors and callbacks with signatures
- **Examples**: Minimal usage code snippets
- **Dependencies**: Required packages and shared utilities
- **Related components**: Similar or complementary components

View with: `flutter_shadcn info <component>`

## Command Reference

See [the command reference](references/commands.md) for complete command documentation with file mappings and usage examples.

## Examples

See [the examples guide](references/examples.md) for usage snippets and component setup patterns.

## Troubleshooting & Best Practices

See [the troubleshooting guide](references/troubleshooting.md) for common issues and fixes.
See [the best practices guide](references/best_practices.md) for recommended workflows.

## Registry Schemas

For advanced registry management:
- **index.schema.json**: Lightweight component discovery schema
- **components.schema.json**: Full registry manifest schema  
- **shared.schema.json**: Shared utilities dependency schema

See [the schema reference](references/schemas.md) for detailed schema documentation.

## Next Steps

- **Learn more**: `flutter_shadcn --help`
- **Component browser**: `flutter_shadcn list` to explore all available components
- **Try it**: `flutter_shadcn add button` to install your first component
- **Design system**: Apply a theme: `flutter_shadcn theme`
- **Extend**: Create custom components by studying installed component structure
