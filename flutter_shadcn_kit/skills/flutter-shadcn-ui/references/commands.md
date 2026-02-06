# Flutter Shadcn CLI - Complete Commands Reference

## Command Categories

### Discovery Commands
- `list` - Browse all components
- `search` - Find components by keyword
- `info` - Get detailed component information

### Setup Commands
- `init` - Initialize a Flutter project for shadcn
- `assets` - Install typography and icon fonts
- `platform` - Configure platform-specific file paths

### Component Management
- `add` - Install components with dependency resolution
- `remove` - Remove components safely
- `dry-run` - Preview installation before committing

### Configuration
- `theme` - Apply color themes (42 presets)
- `sync` - Reapply configuration after manual changes
- `doctor` - Validate project setup and diagnose issues

### Skills & Extensibility
- `install-skill` - Deploy component workflows to AI models

### Utility Commands
- `version` - Show CLI version and check for updates
- `upgrade` - Upgrade CLI to latest version
- `feedback` - Submit feedback or report issues via GitHub

---

## Discovery Commands

### `list`

List all available components from registry, grouped by category.

**Syntax:**
```bash
flutter_shadcn list [OPTIONS]
flutter_shadcn list --refresh
flutter_shadcn list --verbose
```

**Options:**
- `--refresh` - Force cache refresh (ignore 24-hour staleness)
- `--verbose` - Show detailed output
- `--registry local` - Use local registry
- `--registry remote` - Use remote CDN (default)
- `--registry-path <path>` - Custom local registry path
- `--registry-url <url>` - Custom remote URL

**Output Format:**
```
Category: Layout
  • button         - Interactive click element
  • badge          - Highlight and labeling element
  
Category: Form
  • input          - Text input field
  • checkbox       - Boolean selection
```

**Files Used:**
- `.shadcn/config.json` - Registry configuration
- `registry/index.json` or remote equivalent - Component index
- `~/.flutter_shadcn/cache/<id>/index.json` - Cached index (24-hour staleness)

---

### `search`

Search components by name, description, tags, or keywords with relevance ranking.

**Syntax:**
```bash
flutter_shadcn search <query> [OPTIONS]
flutter_shadcn search "form input"
flutter_shadcn search button --verbose
```

**Options:**
- `--refresh` - Force cache refresh
- `--verbose` - Show relevance scores
- `--registry local|remote` - Choose registry
- `--registry-path <path>` - Custom local path
- `--registry-url <url>` - Custom remote URL

**Example:**
```bash
$ flutter_shadcn search form
Results (relevance):
  • form        (score: 95) - Form wrapper with validation
  • form_field  (score: 85) - Individual form field
  • input       (score: 70) - Text input field
```

**Files Used:**
- `.shadcn/config.json` - Registry mode
- `registry/index.json` - Search source
- `~/.flutter_shadcn/cache/<id>/index.json` - Cached results

---

### `info`

Display detailed component information including API, examples, and dependencies.

**Syntax:**
```bash
flutter_shadcn info <component> [OPTIONS]
flutter_shadcn info button
flutter_shadcn info button --verbose
```

**Options:**
- `--verbose` - Show complete API signatures
- `--refresh` - Force cache update
- `--registry local|remote` - Choose registry

**Output Includes:**
- Component description
- Tags and category
- API (constructors, callbacks, properties)
- Minimal usage example with code
- Dependencies (pubspec packages + shared utilities)
- Related components

**Example:**
```bash
$ flutter_shadcn info button
Button Component

Description: Interactive clickable button with variants

Tags: interactive, form

API:
  • ShadButton({required String label, VoidCallback? onPressed})
  • Property: enabled (bool)
  • Callback: onPressed (VoidCallback)

Example:
  ShadButton(
    label: 'Click me',
    onPressed: () => print('Clicked'),
  )

Dependencies:
  Pubspec: gap ^2.0.0
  Shared: color_extensions, theme_tokens
```

**Files Used:**
- `.shadcn/config.json` - Registry configuration
- `registry/index.json` - Cached component metadata
- `~/.flutter_shadcn/cache/<id>/index.json` - Cached details

---

## Setup Commands

### `init`

Initialize a Flutter project to use shadcn components.

**Syntax:**
```bash
# Interactive mode (recommended first time)
flutter_shadcn init

# Non-interactive with defaults
flutter_shadcn init --yes

# Fully specified
flutter_shadcn init --yes \
  --install-path lib/ui/shadcn \
  --shared-path lib/ui/shadcn/shared \
  --prefix App \
  --theme modern-minimal
```

**Options:**
- `--yes` - Skip all prompts, use defaults
- `--install-path <path>` - Where to install components (default: `lib/ui/shadcn`)
- `--shared-path <path>` - Where to install shared utilities (default: `lib/ui/shadcn/shared`)
- `--prefix <class>` - Class prefix for widgets (e.g., "App" → "AppButton")
- `--theme <name>` - Theme preset (see `theme --list`)
- `--include-meta` - Include meta.json with component metadata
- `--include-readme` - Include README.md with setup notes
- `--include-preview` - Include preview.dart example file
- `--install-fonts` - Install typography fonts
- `--install-icons` - Install icon fonts

**What it creates:**
```
.shadcn/
  └── config.json (project configuration)
lib/ui/shadcn/
  ├── shared/
  │   ├── theme/
  │   │   ├── color_scheme.dart (theme colors)
  │   │   └── preset_theme_data.dart (42 presets)
  │   ├── tokens/ (design tokens)
  │   ├── utils/ (extensions and utilities)
  │   └── form/ (form helpers)
  └── components.json (installed component manifest)
```

**Files Modified:**
- `pubspec.yaml` - Adds data_widget, gap dependencies

**Example:**
```bash
$ flutter_shadcn init --yes --theme cosmic-night --prefix App
✓ Created .shadcn/config.json
✓ Created lib/ui/shadcn/shared/
✓ Installed core dependencies
✓ Applied theme: cosmic-night
✓ Ready to add components!
```

---

### `assets`

Manage typography fonts and icon fonts for the project.

**Syntax:**
```bash
flutter_shadcn assets --list              # Show available assets
flutter_shadcn assets --all               # Install all fonts
flutter_shadcn assets --fonts             # Typography only
flutter_shadcn assets --icons             # Icons only
```

**Options:**
- `--list` - Show available typography and icon sets
- `--all` - Install all assets
- `--fonts` - Install typography fonts only
- `--icons` - Install icon fonts only

**Available Assets:**
- **Typography**: Inter, Roboto, Open Sans, Playfair Display, etc.
- **Icons**: Material Icons, Feather, Tabler, Remixicon, Heroicons, etc.

**Files Modified:**
- `pubspec.yaml` - Adds font declarations
- `assets/fonts/` - Copies font files

**Example:**
```bash
$ flutter_shadcn assets --all
✓ Installed Inter (typography)
✓ Installed Material Icons (1,200+ icons)
✓ Updated pubspec.yaml
✓ Fonts ready to use!
```

---

### `platform`

Configure platform-specific file paths for components that need native configuration.

**Syntax:**
```bash
flutter_shadcn platform --list                    # Show current targets
flutter_shadcn platform --set <key>=<path>        # Set custom path
flutter_shadcn platform --reset <key>             # Reset to default
flutter_shadcn platform --reset-all               # Reset all
```

**Common Platform Targets:**
```bash
ios.infoPlist                    # iOS info config
ios.podfile                      # Cocoapods dependencies
android.gradle                   # Android gradle config
windows.config                   # Windows configuration
macos.infoPlist                  # macOS info config
```

**Example:**
```bash
$ flutter_shadcn platform --list
Current Targets:
  ios.infoPlist    → ios/Runner/Info.plist
  android.gradle   → android/app/build.gradle
  macos.infoPlist  → macos/Runner/Info.plist

$ flutter_shadcn platform --set ios.infoPlist=ios/Runner/Custom.plist
✓ Updated iOS target

$ flutter_shadcn platform --reset-all
✓ Reset all to defaults
```

**Files Modified:**
- `.shadcn/config.json` - Stores platform overrides

---

## Component Management

### `add`

Install one or more components with automatic dependency resolution.

**Syntax:**
```bash
flutter_shadcn add <component> [<component2> ...]
flutter_shadcn add button
flutter_shadcn add button dialog form
flutter_shadcn add --all
```

**Options:**
- `--all` - Add every available component
- `--force` - Ignore dependency errors
- `--verbose` - Show detailed installation steps
- `--registry local|remote` - Choose registry
- `--registry-path <path>` - Custom local registry
- `--registry-url <url>` - Custom remote URL

**Dependency Resolution:**
```bash
$ flutter_shadcn add menu
Resolving dependencies:
  • menu → popover (required)
  • popover → overlay (required)
Installing:
  1. overlay (3 files)
  2. popover (4 files)
  3. menu (5 files)
✓ Installed 3 components, 12 files
```

**What happens:**
1. Resolves component dependencies recursively
2. Copies component files to install path
3. Copies missing shared utilities
4. Updates pubspec.yaml with required packages
5. Validates installation with schema
6. Updates local manifest (components.json)

**Files Modified:**
- `<installPath>/components/<category>/<component>/` or `<installPath>/composites/<group>/<name>/` - New component/composite files (mirrors registry layout)
- `<sharedPath>/` - New shared utilities
- `pubspec.yaml` - New package dependencies
- `<installPath>/components.json` - Updated manifest

**Examples:**
```bash
# Add single
$ flutter_shadcn add button
✓ Installed button (2 files, 1 dependency)

# Add multiple (resolves dependencies together)
$ flutter_shadcn add form input checkbox
✓ Installed 3 components (5 shared dependencies)

# Check before adding
$ flutter_shadcn dry-run form
# Review output, then:
$ flutter_shadcn add form
```

---

### `remove`

Safely remove components, checking for dependents and cleaning unused shared files.

**Syntax:**
```bash
flutter_shadcn remove <component> [<component2> ...]
flutter_shadcn remove button
flutter_shadcn remove button dialog
flutter_shadcn remove --all
```

**Options:**
- `--force` - Force removal (skip dependency checks)
- `--verbose` - Show what's being deleted
- `--all` - Remove every component

**Dependency Checking:**
```bash
$ flutter_shadcn remove popover
ERROR: popover is required by:
  • menu (depends on popover)
  • select (depends on popover)

Use --force to remove anyway, but menu and select will break.
```

**What happens:**
1. Checks if other installed components depend on this component
2. Prompts for confirmation if dependencies found
3. Deletes component files
4. Removes unused shared files
5. Updates pubspec.yaml (removes unused packages)
6. Cleans empty parent directories
7. Updates manifest

**Files Modified:**
- `<installPath>/components/<category>/<component>/` or `<installPath>/composites/<group>/<name>/` - Deleted
- `<sharedPath>/` - Unused files deleted
- `pubspec.yaml` - Removed unused dependencies
- `<installPath>/components.json` - Removed manifest entry

**Examples:**
```bash
$ flutter_shadcn remove button
✓ Removed button (2 files)
✓ Cleaned up shared files

$ flutter_shadcn remove popover
ERROR: popover is required by menu, select

$ flutter_shadcn remove popover --force
✓ Force removed popover
⚠ Warning: menu, select may be broken
```

---

### `dry-run`

Preview what would be installed without modifying anything.

**Syntax:**
```bash
flutter_shadcn dry-run <component> [<component2> ...]
flutter_shadcn dry-run button
flutter_shadcn dry-run button dialog form
flutter_shadcn dry-run --all
```

**Options:**
- `--verbose` - Show complete dependency graph
- `--all` - Preview all components
- `--registry local|remote` - Choose registry

**Output Shows:**
- Dependency tree with visual hierarchy
- Component files to be copied (count)
- Shared files needed (count)
- pubspec.yaml changes (packages to add)
- Asset and font installations
- Platform-specific steps
- Post-install notes

**Example:**
```bash
$ flutter_shadcn dry-run menu
Preview: menu installation

Dependencies:
  ├── overlay (core)
  ├── popover
  └── menu

Files:
  • Component files: 12
  • Shared files: 5
  • Platform steps: iOS (1)

Pubspec changes:
  + flutter_animate: ^4.0.0
  + get_it: ^7.0.0

Post-install:
  1. Run flutter pub get
  2. Restart your IDE

Ready to install? Run: flutter_shadcn add menu
```

**Files Used (Read-only):**
- `.shadcn/config.json` - Project settings
- `registry/components.json` - Component metadata
- `registry/shared/` - Shared file definitions

---

## Configuration

### `theme`

Apply color themes to the project. Choose from 42 built-in presets or apply custom themes.

**Syntax:**
```bash
flutter_shadcn theme --list              # Show all themes
flutter_shadcn theme                     # Interactive mode
flutter_shadcn theme <theme-name>        # Apply specific theme
```

**Options:**
- `--list` - Show all 42 available themes
- `--verbose` - Show detailed theme info
- `--apply-file <path>` - Apply custom JSON theme (experimental)
- `--apply-url <url>` - Apply custom URL theme (experimental)

**Available Themes:**

Modern themes: modern-minimal, modern-vibrant, modern-monochrome
Dark themes: cosmic-night, midnight-blue, forest-dark
Glass themes: glass-morphism, glassmorphism-dark
Material: material-3-light, material-3-dark
Pastels: pastel-dream, soft-pastels, candy-colors
Gradient: gradient-ocean, gradient-sunset, gradient-forest
And 27 more...

**What it does:**
1. Reads theme colors from `preset_theme_data.dart`
2. Updates `<sharedPath>/theme/color_scheme.dart` with colors
3. All components automatically inherit the new theme
4. Stores selection in `.shadcn/config.json` for future syncs

**Files Modified:**
- `<sharedPath>/theme/color_scheme.dart` - Theme colors
- `.shadcn/config.json` - Current theme reference

**Examples:**
```bash
# List themes
$ flutter_shadcn theme --list
Available Themes (42):
  • modern-minimal (light/dark)
  • cosmic-night (light/dark)
  • glass-morphism (light/dark)
  ... [39 more]

# Apply theme interactively
$ flutter_shadcn theme
? Select a theme: (use arrow keys)
❯ modern-minimal
  cosmic-night
  glass-morphism
  ...
✓ Applied: cosmic-night

# Apply specific theme
$ flutter_shadcn theme glass-morphism
✓ Applied glass-morphism to all components
```

---

### `sync`

Reapply configuration changes from `.shadcn/config.json` to the project.

**Syntax:**
```bash
flutter_shadcn sync
```

**When to use:**
- After manually editing `.shadcn/config.json`
- After moving project folders
- After changing install paths
- To reapply current theme

**What it does:**
1. Reads `.shadcn/config.json`
2. Reapplies current theme colors
3. Validates paths are accessible
4. Reorganizes files if paths changed
5. Updates path-dependent references

**Files Modified:**
- `<sharedPath>/theme/color_scheme.dart` - Reapplies theme

**Example:**
```bash
$ flutter_shadcn sync
✓ Validated configuration
✓ Reapplied theme: cosmic-night
✓ Verified paths and files
✓ Project synced
```

---

### `doctor`

Validate project setup and diagnose issues.

**Syntax:**
```bash
flutter_shadcn doctor
flutter_shadcn doctor --verbose
```

**Options:**
- `--verbose` - Show detailed diagnostics

**Checks:**
- `.shadcn/config.json` validity and accessibility
- `<installPath>/components.json` schema validation
- Configured paths exist and are accessible
- Installed component integrity
- Registry configuration and connectivity
- Cache staleness and size
- Platform target availability

**Example Output:**
```bash
$ flutter_shadcn doctor
✓ Configuration: Valid (.shadcn/config.json)
✓ Install path: lib/ui/shadcn (accessible)
✓ Shared path: lib/ui/shadcn/shared (accessible)
✓ Manifest: Valid schema (3 components)
✓ Registry: Remote (connected)
✓ Cache: 24 hours old (1.2 MB)

No issues detected!
```

**With issues:**
```bash
$ flutter_shadcn doctor
✓ Configuration: Valid
✗ Install path: Missing (lib/ui/shadcn)
⚠ Manifest: 1 component with missing files

Run 'flutter_shadcn sync' to reorganize files.
```

---

## Skills & Extensibility

### `install-skill`

Deploy component-building workflows to AI models (.claude, .gpt4, .cursor, .gemini, etc.).

**Syntax:**
```bash
flutter_shadcn install-skill                      # Interactive
flutter_shadcn install-skill --skill <name>       # Specify skill
flutter_shadcn install-skill --list                # Show installed
flutter_shadcn install-skill --uninstall <skill>  # Remove skill
```

**Options:**
- `--skill <name>` - Skill to install
- `--model <folder>` - Target AI model folder (e.g., `.claude`, `.gpt4`)
- `--skills-url <url>` - Custom skills repository
- `--list` - List installed skills by model
- `--uninstall <skill>` - Remove skill from model
- `--verbose` - Show installation details

**Auto-discovered AI Model Folders:**
- `.claude/` - Claude (Anthropic)
- `.gpt4/` - GPT-4 (OpenAI)
- `.cursor/` - Cursor
- `.gemini/` - Gemini (Google)
- `.other/` - Other AI tools

**Example:**
```bash
$ flutter_shadcn install-skill
Available skills:
  1. component-builder
  2. theme-designer
  3. widget-expert

Select models to install to:
  1. .claude (Claude)
  2. .gpt4 (GPT-4)
  3. .cursor (Cursor)

? Select skill: 1
? Select models (comma-separated): 1,2,3
✓ Installed component-builder to:
  - .claude/
  - .gpt4/
  - .cursor/

$ flutter_shadcn install-skill --list
Installed Skills:
  .claude/
    • component-builder
    • theme-designer
  .gpt4/
    • component-builder
```

**What it does:**
1. Auto-discovers AI model folders in project root
2. Lists available skills from registry
3. Installs skill files to selected models
4. Creates or updates skill metadata per model
5. Tracks installed skills for future reference

**Files Created:**
- `<model>/<skill-name>/` - Skill installation directory
- `<model>/<skill-name>/SKILL.md` - Skill definition
- `<model>/<skill-name>/references/` - Skill references
- `<model>/<skill-name>/scripts/` - Skill scripts

---

## Utility Commands

### `version`

Display CLI version and optionally check for updates.

**Syntax:**
```bash
flutter_shadcn version
flutter_shadcn version --check
```

**Options:**
- `--check` - Check pub.dev for available updates
- `--help, -h` - Show help message

**Example:**
```bash
$ flutter_shadcn version
flutter_shadcn version 0.1.8

$ flutter_shadcn version --check
Current version: 0.1.8
Latest version: 0.1.8
✓ You're on the latest version!
```

**Auto-Update Notifications:**
The CLI automatically checks for updates once per 24 hours on every command execution. If a newer version is available, you'll see a notification banner.

---

### `upgrade`

Upgrade the CLI to the latest version from pub.dev.

**Syntax:**
```bash
flutter_shadcn upgrade
flutter_shadcn upgrade --force
```

**Options:**
- `--force, -f` - Force upgrade even if already on latest version
- `--help, -h` - Show help message

**Example:**
```bash
$ flutter_shadcn upgrade
✓ Checking for updates...
✓ Downloading version 0.1.9...
✓ Successfully upgraded to 0.1.9!
```

**What it does:**
1. Checks pub.dev for latest version
2. Compares with current version
3. Runs `dart pub global activate flutter_shadcn_cli`
4. Confirms successful upgrade
5. Provides manual steps if automatic upgrade fails

---

### `feedback`

Submit feedback, report bugs, or request features via GitHub.

**Syntax:**
```bash
# Interactive mode (menu-driven)
flutter_shadcn feedback

# Non-interactive mode (one-command)
flutter_shadcn feedback --type <type> --title "Title" --body "Description"
```

**Options:**
- `--type, -t` - Feedback type: `bug`, `feature`, `docs`, `question`, `performance`, `other`
- `--title` - Issue title
- `--body` - Issue description/body
- `--help, -h` - Show help message

**Feedback Types:**
1. 🐛 **bug** - Report crashes, errors, or unexpected behavior
2. ✨ **feature** - Request new components or enhancements
3. 📖 **docs** - Suggest documentation improvements
4. ❓ **question** - Ask usage questions or request help
5. ⚡ **performance** - Report slow builds or runtime issues
6. 💡 **other** - Share general feedback and suggestions

**GitHub CLI Integration:**

The command automatically detects if [GitHub CLI](https://cli.github.com/) (`gh`) is installed and authenticated:

- **With `gh` CLI**: Creates issue directly in terminal (no browser needed)
- **Without `gh` CLI**: Opens browser with pre-filled issue template
- **Authentication**: Run `gh auth login` to set up GitHub CLI

**Interactive Example:**
```bash
$ flutter_shadcn feedback
💬 Feedback & Support

Select feedback type:
  🐛 1. Report a bug
  ✨ 2. Request a feature
  📖 3. Documentation improvement
  ❓ 4. Ask a question
  ⚡ 5. Performance issue
  💡 6. Other feedback

❯ Select feedback type (1-6): 2

Title (brief summary): Add filter component
Description (press Enter twice when done):
Should have filter bar and display sections

✓ Creating issue via GitHub CLI...
✓ Issue created successfully! ✨

https://github.com/ibrar-x/shadcn_flutter_kit/issues/42
```

**Non-Interactive Example:**
```bash
$ flutter_shadcn feedback \
  --type feature \
  --title "Add filter component" \
  --body "Should have filter bar and display sections for filtering data"

✓ Creating issue via GitHub CLI...
✓ Issue created successfully! ✨

https://github.com/ibrar-x/shadcn_flutter_kit/issues/42
```

**What it does:**
1. Interactive: Shows menu of feedback types
2. Collects title and description (or uses flags)
3. Builds GitHub issue with type-specific template
4. Auto-fills environment info (CLI version, OS, Dart SDK)
5. **If `gh` CLI available**: Creates issue directly via `gh issue create`
6. **Otherwise**: Opens browser with pre-filled GitHub issue
7. Applies appropriate labels (bug, enhancement, docs, etc.)

**Templates by Type:**
- **Bug**: Steps to reproduce, expected vs actual behavior, environment details, error messages
- **Feature**: Problem statement, proposed solution, use cases, API examples, alternatives
- **Documentation**: Location, current state, suggested improvement, why it matters
- **Question**: Question, context, what was tried, related commands, expected outcome
- **Performance**: Impact metrics, reproduction steps, environment details, measurements
- **Other**: Category checkboxes, details, suggestions

**Files Used:**
- None (creates GitHub issue remotely)
- Auto-includes: CLI version, OS, Dart SDK version

**Setup GitHub CLI (Optional):**
```bash
# Install GitHub CLI (https://cli.github.com/)
# macOS
brew install gh

# Authenticate
gh auth login

# Verify
gh auth status
```

Once authenticated, `flutter_shadcn feedback` will create issues directly without opening a browser!

---

## Global Options

### `--registry`

Specify which registry to use (local or remote).

```bash
flutter_shadcn add button --registry local --registry-path ./my-registry
flutter_shadcn add button --registry remote --registry-url https://cdn.example.com
```

### `--verbose`

Show detailed output for debugging.

```bash
flutter_shadcn add button --verbose
```

### `--yes`

Skip all prompts, use defaults (init only).

```bash
flutter_shadcn init --yes
```

### `--experimental`

Enable experimental features.

```bash
flutter_shadcn --experimental theme --apply-file custom-theme.json
```

---

## File Reference Quick Guide

| File | Used By | Purpose |
|------|---------|---------|
| `.shadcn/config.json` | All commands | Project settings, paths, theme, registry |
| `registry/index.json` | list, search, info | Lightweight component index |
| `registry/components.json` | add, remove, dry-run | Full component metadata |
| `<installPath>/components.json` | add, remove, doctor | Installed components manifest |
| `pubspec.yaml` | init, add, remove, assets | Package dependencies |
| `<sharedPath>/theme/color_scheme.dart` | theme, sync | Current theme colors |
| `~/.flutter_shadcn/cache/` | list, search, info, doctor | Cached indices |
