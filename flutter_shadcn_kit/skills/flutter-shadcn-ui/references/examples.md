# Flutter Shadcn CLI - Practical Examples

Real-world workflows and solutions for common tasks.

---

## Example 1: Building a Complete Login Form

### Requirements
- Text input fields
- Checkbox for "Remember me"
- Submit button
- Form validation and error handling

### Step 1: Preview dependencies

```bash
$ flutter_shadcn dry-run form input checkbox button
Preview: form, input, checkbox, button installation

Dependency tree:
  ├── form (requires form_helpers)
  ├── input (requires color_extensions, theme_tokens)
  ├── checkbox (requires color_extensions, theme_tokens)
  └── button (requires gap package)

Shared utilities needed:
  • form_control.dart (form field control)
  • form_value_supplier.dart (form state management)
  • color_extensions.dart (color utilities)
  • theme_tokens.dart (theme colors)

Pubspec changes:
  + data_widget: ^2.0.0
  + gap: ^2.0.0
  + flutter: (sdk)

Files to install: 12
Shared files: 8

Ready to proceed? Run: flutter_shadcn add form input checkbox button
```

### Step 2: Install components

```bash
$ flutter_shadcn add form input checkbox button
✓ Resolved dependencies: 4 components, 0 conflicts
✓ Copied 12 component files
✓ Installed 8 shared utilities
✓ Updated pubspec.yaml (2 new dependencies)
✓ Updated components.json

Run 'flutter pub get' to download dependencies
```

### Step 3: Use in code

```dart
import 'package:flutter/material.dart';
import 'package:shadcn_flutter/form.dart';
import 'package:shadcn_flutter/input.dart';
import 'package:shadcn_flutter/checkbox.dart';
import 'package:shadcn_flutter/button.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailControl = FormControl<String>();
  final passwordControl = FormControl<String>();
  final rememberControl = FormControl<bool>(initialValue: false);

  @override
  void dispose() {
    emailControl.dispose();
    passwordControl.dispose();
    rememberControl.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    // Validate and submit
  }

  @override
  Widget build(BuildContext context) {
    return ShadForm(
      controls: [emailControl, passwordControl, rememberControl],
      child: Column(
        children: [
          ShadInput(
            control: emailControl,
            label: 'Email',
            placeholder: 'user@example.com',
          ),
          SizedBox(height: 16),
          ShadInput(
            control: passwordControl,
            label: 'Password',
            obscureText: true,
          ),
          SizedBox(height: 16),
          ShadCheckbox(
            control: rememberControl,
            label: 'Remember me',
          ),
          SizedBox(height: 24),
          ShadButton(
            label: 'Sign In',
            onPressed: _handleSubmit,
          ),
        ],
      ),
    );
  }
}
```

---

## Example 2: Building a Data Dashboard

### Requirements
- Cards to display metrics
- Tables for data display
- Charts/graphs
- Filter controls
- Responsive layout

### Step 1: Identify needed components

```bash
$ flutter_shadcn search "table"
Results:
  • table (97%) - Data table component
  • data_grid (85%) - Advanced data grid

$ flutter_shadcn search "card"
Results:
  • card (98%) - Container with shadow and border
  
$ flutter_shadcn search "chart"
Results:
  • chart (92%) - Line, bar, pie charts
  
$ flutter_shadcn search "filter"
Results:
  • select (89%) - Dropdown select control
  • filter_button (76%) - Filter trigger button
```

### Step 2: Preview full dashboard setup

```bash
$ flutter_shadcn dry-run card table chart select button
Preview: card, table, chart, select, button installation

Dependencies:
  └── card
  └── table
  └── chart (requires flutter_charts)
  └── select (requires popover, overlay)
  └── button

Total components: 8 (including dependencies)
Total files: 45
Shared utilities: 12
New pubspec deps: flutter_charts, popover, overlay

Estimated project size change: +2.5MB
```

### Step 3: Install

```bash
$ flutter_shadcn add card table chart select button
✓ Installed 8 components
✓ Added flutter_charts, popover, overlay to pubspec.yaml
```

### Step 4: Build dashboard

```dart
import 'package:flutter/material.dart';
import 'package:shadcn_flutter/card.dart';
import 'package:shadcn_flutter/table.dart';
import 'package:shadcn_flutter/chart.dart';
import 'package:shadcn_flutter/select.dart';

class DashboardView extends StatefulWidget {
  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  String selectedPeriod = 'month';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Filter row
          Row(
            children: [
              ShadSelect(
                value: selectedPeriod,
                onChanged: (value) {
                  setState(() => selectedPeriod = value ?? 'month');
                },
                items: [
                  ('week', 'Week'),
                  ('month', 'Month'),
                  ('year', 'Year'),
                ],
              ),
            ],
          ),
          SizedBox(height: 32),
          
          // Metrics row
          Row(
            children: [
              _MetricCard(label: 'Total Users', value: '12,543'),
              SizedBox(width: 16),
              _MetricCard(label: 'Revenue', value: '\$45,231'),
              SizedBox(width: 16),
              _MetricCard(label: 'Growth', value: '+23%'),
            ],
          ),
          SizedBox(height: 32),
          
          // Chart
          ShadCard(
            child: Column(
              children: [
                Text('Revenue Trend', style: Theme.of(context).textTheme.headlineSmall),
                SizedBox(height: 24),
                ShadLineChart(data: revenueData),
              ],
            ),
          ),
          SizedBox(height: 32),
          
          // Data table
          ShadCard(
            child: ShadTable(
              columns: ['Name', 'Email', 'Amount', 'Status'],
              rows: tableData,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String label;
  final String value;

  const _MetricCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      child: Column(
        children: [
          Text(label, style: Theme.of(context).textTheme.bodySmall),
          SizedBox(height: 8),
          Text(value, style: Theme.of(context).textTheme.headlineSmall),
        ],
      ),
    );
  }
}
```

---

## Example 3: Theme Customization Workflow

### Task: Try different themes for a project

```bash
# List all themes
$ flutter_shadcn theme --list
Available Themes (42):
  1. modern-minimal    (light/dark)
  2. cosmic-night      (light/dark)
  3. glass-morphism    (light/dark)
  4. material-3-light  (light/dark)
  5. pastel-dream      (light/dark)
  ... [37 more]

# Apply theme 1 (modern-minimal)
$ flutter_shadcn theme modern-minimal
✓ Applied modern-minimal

# Test in your app...
# (all components automatically inherit theme)

# Try theme 2
$ flutter_shadcn theme cosmic-night
✓ Applied cosmic-night

# Like it? Keep it. Restore previous?
$ flutter_shadcn theme modern-minimal
```

### Under the hood

When you apply a theme:
1. CLI reads theme colors from `preset_theme_data.dart`
2. Updates `<sharedPath>/theme/color_scheme.dart` with specific colors
3. All components import `color_scheme.dart` and use these colors
4. Changes are instant (no component reinstalls needed)

Example `color_scheme.dart` after theme application:

```dart
import 'package:flutter/material.dart';

/// Theme: cosmic-night
/// Applied: 2024-02-04 10:30:00
class AppColorScheme {
  static const primary = Color(0xFF6366F1);      // Indigo
  static const primaryContainer = Color(0xFF312E81);
  static const secondary = Color(0xFF8B5CF6);    // Purple
  static const secondaryContainer = Color(0xFF4C1D95);
  static const surface = Color(0xFF0F172A);
  static const surfaceContainer = Color(0xFF1E293B);
  static const error = Color(0xFFEF4444);
  static const errorContainer = Color(0xFF7F1D1D);
  
  // ... 30+ more color definitions
}
```

All components use these centrally:

```dart
Container(
  color: AppColorScheme.primary,  // Uses theme color
  child: Text(
    'Themed Text',
    style: TextStyle(
      color: AppColorScheme.onPrimary,
    ),
  ),
)
```

---

## Example 4: Managing a Large Component Collection

### Scenario
You've installed 30 components but need to clean up for a new feature focus.

### Step 1: List what's installed

```bash
$ flutter_shadcn list  # Shows all available
# vs
$ cat lib/ui/shadcn/components.json  # Shows what you have
```

### Step 2: Preview removals

```bash
# Check if anything depends on 'dropdown'
$ flutter_shadcn doctor --verbose
✓ All 30 components valid

# Try removing something
$ flutter_shadcn remove dropdown
✓ dropdown removed
✓ No dependent components broken
✓ Removed 1 file
```

### Step 3: Clean up related components

```bash
# Remove a tree of components
$ flutter_shadcn remove popover overlay menu
Checking dependencies:
  ✓ popover is required by: select, dropdown_menu
  
# Force remove all three
$ flutter_shadcn remove popover overlay menu --force
⚠ Warning: select and dropdown_menu may be broken

# Remove those too
$ flutter_shadcn remove select dropdown_menu
✓ Removed 3 components
```

### Step 4: Validate cleanup

```bash
$ flutter_shadcn doctor
✓ Configuration valid
✓ 27 components remain
✓ No orphaned shared files
✓ pubspec.yaml cleaned
```

---

## Example 5: Installing AI Skills for Development

### Task: Set up component building skills for Claude, ChatGPT, and Cursor

```bash
# Interactive mode (recommended)
$ flutter_shadcn install-skill

Available skills:
  1. component-builder     - Build new components from scratch
  2. theme-designer        - Design custom themes
  3. widget-expert         - Component usage and patterns
  4. form-builder          - Build complex forms
  5. responsive-designer   - Mobile/responsive layout

? Select a skill: 1
? Select AI models to install to:
  1. .claude     (Claude)
  2. .gpt4       (GPT-4)
  3. .cursor     (Cursor)
  4. .gemini     (Gemini)

Enter numbers (comma-separated): 1,2,3

Installing component-builder to:
  ✓ .claude/
  ✓ .gpt4/
  ✓ .cursor/
```

### What gets installed

For each model folder, you get:

```
.claude/
├── component-builder/
│   ├── SKILL.md           # Skill definition with full workflow
│   ├── references/
│   │   ├── flutter-shadcn-cli.md      # CLI documentation
│   │   ├── component-structure.md     # How to build components
│   │   ├── examples.md                # Real component examples
│   │   └── best-practices.md          # Design patterns
│   └── scripts/
│       └── validate-component.py      # Helper scripts

.gpt4/
├── component-builder/    # Same structure for GPT-4

.cursor/
├── component-builder/    # Same structure for Cursor
```

### Using the skill

Now when you use Claude with your project:

```
User: "Build me a new RatingComponent that shows 1-5 stars"

Claude: [accesses skill]
I'll create a new component for you. Based on the flutter_shadcn registry, 
let me follow the component structure and best practices...

[Creates component following skill guidelines]
```

### List installed skills

```bash
$ flutter_shadcn install-skill --list
Installed Skills:
  .claude/
    • component-builder (v1.0)
    • theme-designer (v1.0)
  .gpt4/
    • component-builder (v1.0)
  .cursor/
    • component-builder (v1.0)
    • widget-expert (v1.0)
```

---

## Example 6: Handling Dependency Issues

### Scenario: You want to add 'menu' but it has complex dependencies

```bash
$ flutter_shadcn dry-run menu
Preview: menu installation

Dependency chain:
  menu
    └── popover
        └── overlay
            └── portal

Files: 18
New packages: flutter_animate (^4.0.0)

Conflicts: None detected

$ flutter_shadcn add menu
✓ Resolving dependencies...
  1. portal (2 files)
  2. overlay (3 files)
  3. popover (4 files)
  4. menu (5 files)
✓ Installed 4 components, 12 files
✓ Added flutter_animate to pubspec.yaml
```

### Understanding the dependency graph

```dart
// menu depends on popover
// popover depends on overlay
// overlay depends on portal
// (portal has no dependencies)

// When you add menu, CLI automatically adds all:
flutter_shadcn add menu
// Installs: menu + popover + overlay + portal

// If you try to remove popover while menu is installed:
flutter_shadcn remove popover
ERROR: popover is required by menu

// You must remove in order (dependents first):
flutter_shadcn remove menu popover
✓ Now both removed
```

---

## Example 7: Registry Configuration

### Using a local development registry

You're developing new components locally:

```bash
# First time: specify path
$ flutter_shadcn add button --registry local --registry-path ./shadcn-registry

# Store as default
# (Stored in .shadcn/config.json for future commands)

# Future commands use stored path automatically
$ flutter_shadcn add input
✓ Using local registry: ./shadcn-registry
```

### Using a custom remote CDN

```bash
$ flutter_shadcn add button \
  --registry remote \
  --registry-url https://cdn.mycompany.com/shadcn-flutter

# Stored in .shadcn/config.json
# Future commands use this URL
```

### Switching registries

```bash
# Check current
$ cat .shadcn/config.json
{
  "registryMode": "remote",
  "registryUrl": "https://cdn.mycompany.com/..."
}

# Switch to local for development
$ flutter_shadcn add button --registry local --registry-path ./local-registry

# Check updated
$ cat .shadcn/config.json
{
  "registryMode": "local",
  "registryPath": "./local-registry"
}
```

---

## Example 8: Troubleshooting Installation Issues

### Issue: Component not found

```bash
$ flutter_shadcn add datepicker
ERROR: Component 'datepicker' not found

# Solution 1: Search for similar
$ flutter_shadcn search date
Results:
  • date_picker (92%) - Interactive date selection
  • date_range_picker (85%) - Date range selection
  • calendar (78%) - Calendar widget

$ flutter_shadcn add date_picker

# Solution 2: Refresh cache
$ flutter_shadcn list --refresh
```

### Issue: Dependency conflict

```bash
$ flutter_shadcn add my_component
ERROR: Dependency conflict detected
  my_component requires: gap ^3.0.0
  Already installed: gap ^2.0.0

# Options:
# 1. Upgrade existing
$ flutter pub upgrade gap

# 2. Check component compatibility
$ flutter_shadcn info my_component
# (Shows minimum dependencies)

# 3. Force install (may break other components)
$ flutter_shadcn add my_component --force
```

### Issue: Broken installation state

```bash
$ flutter_shadcn doctor
✗ Configuration valid but path mismatch
✗ 2 components missing files
✗ Manifest inconsistency detected

# Solution: Sync
$ flutter_shadcn sync
✓ Reapplied configuration
✓ Verified all files
✓ Project recovered
```

---

## Best Practices Summary

### Always preview first
```bash
flutter_shadcn dry-run <component>  # See what will happen
flutter_shadcn add <component>      # Then install
```

### Understand dependencies
```bash
flutter_shadcn info <component>     # See what it needs
flutter_shadcn doctor               # Validate setup
```

### Clean up regularly
```bash
flutter_shadcn remove --force <unused>
flutter_shadcn doctor               # Check for orphans
```

### Keep config under version control
```bash
# Version these in git:
.shadcn/config.json
lib/ui/shadcn/components.json
pubspec.yaml

# Don't version actual component files:
# (they're generated from registry)
lib/ui/shadcn/components/control/button/
lib/ui/shadcn/components/form/input/
lib/ui/shadcn/composites/animation/timeline_animation/
lib/ui/shadcn/shared/theme/
# etc. - regenerate with 'add' commands
```

### Test theme changes
```bash
flutter_shadcn theme --list         # See options
flutter_shadcn theme <theme-name>   # Try it
flutter_shadcn sync                 # Revert if needed
```
