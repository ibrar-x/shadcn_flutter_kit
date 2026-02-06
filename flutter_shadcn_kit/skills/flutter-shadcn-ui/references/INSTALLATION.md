# Flutter Shadcn Skill - Installation & Deployment

This guide explains how to install and use the flutter-shadcn-ui skill with your AI tools.

---

## What This Skill Does

The **flutter-shadcn-ui** skill provides comprehensive knowledge for building beautiful, production-ready Flutter UI components using the shadcn-flutter registry. It enables AI models to:

1. **Understand the CLI** - Complete command reference and workflows
2. **Design components** - Best practices and patterns for component creation
3. **Manage projects** - Configuration, themes, dependencies
4. **Troubleshoot issues** - Diagnostics and common solutions
5. **Install components** - Dependency resolution and smart installation
6. **Submit feedback** - Report bugs, request features, ask questions via interactive GitHub integration

The skill works with **any AI model**: Claude, ChatGPT, Cursor, Gemini, and others.

---

## Installation Methods

### Method 1: Using flutter_shadcn CLI (Recommended)

If you have the `flutter_shadcn` CLI installed:

```bash
# Interactive installation
flutter_shadcn install-skill

# Or direct installation
flutter_shadcn install-skill --skill flutter-shadcn-ui --model .claude

# List installed skills
flutter_shadcn install-skill --list
```

This automatically:
- Detects AI model folders (`.claude/`, `.gpt4/`, `.cursor/`, etc.)
- Installs skill files to each model
- Creates proper skill structure

### Method 2: Manual Installation

If you don't have the CLI or prefer manual installation:

#### For Claude

```bash
# Create Claude skill folder
mkdir -p .claude/flutter-shadcn-ui

# Copy skill files
cp SKILL.md .claude/flutter-shadcn-ui/
cp -r references/ .claude/flutter-shadcn-ui/
cp -r scripts/ .claude/flutter-shadcn-ui/  # (if included)
```

#### For ChatGPT (Custom GPT)

1. Create custom GPT at https://chat.openai.com/gpts/editor
2. Upload files:
   - SKILL.md as instructions
   - references/ files as knowledge
3. Name: "Flutter Shadcn UI Builder"
4. Description: "Build beautiful Flutter UI components"

#### For Cursor

```bash
# Create Cursor skill folder
mkdir -p .cursor/flutter-shadcn-ui

# Copy skill files
cp SKILL.md .cursor/flutter-shadcn-ui/
cp -r references/ .cursor/flutter-shadcn-ui/
```

#### For Other Models

Replace the folder name with your model's standard folder:
- Gemini: `.gemini/`
- Anthropic Claude: `.claude/`
- Local LLMs: `.local-llm/` or custom

---

## Skill Structure

After installation, you'll have:

```
<model-folder>/flutter-shadcn-ui/
├── SKILL.md                           # Main skill definition
├── references/
│   ├── commands.md                    # Complete CLI commands reference
│   ├── schemas.md                     # Registry schema documentation
│   └── examples.md                    # Practical examples & workflows
└── scripts/                           # (Optional) Helper scripts
    └── validate-component.py          # Component validation
```

### File Purposes

| File | Purpose | When Used |
|------|---------|-----------|
| **SKILL.md** | Quick start guide + core concepts | Always loaded first |
| **commands.md** | Complete CLI command reference | When implementing CLI workflows |
| **schemas.md** | Registry schema documentation | When working with component structure |
| **examples.md** | Practical real-world examples | When solving specific tasks |

---

## First-Time Setup

### Step 1: Verify Installation

After installing, test the skill by asking your AI:

```
"What Flutter Shadcn components would you recommend for building a login form?"
```

The AI should respond with component suggestions using information from the skill.

### Step 2: Initialize Your Project

Tell your AI:

```
"Initialize a new Flutter project for shadcn components with the cosmic-night theme 
and install paths at lib/ui/shadcn"
```

Expected response: CLI command suggestions like:
```bash
flutter_shadcn init --yes \
  --install-path lib/ui/shadcn \
  --shared-path lib/ui/shadcn/shared \
  --theme cosmic-night
```

### Step 3: Add Your First Component

Ask:

```
"I want to build a sign-up form with email, password, and checkbox. 
What components should I install?"
```

Expected response: Component recommendations with:
```bash
flutter_shadcn add form input checkbox button
```

---

## Using the Skill

### Discovery Queries

Ask the AI anything about available components:

```
"What UI components are available?"
"Find me a data table component"
"Show me examples of form components"
"What's needed to build a dashboard?"
```

### Implementation Queries

Ask for implementation help:

```
"Build me a login form component using shadcn"
"How do I create a custom theme?"
"Create a responsive navbar"
"Build a theme switcher"
```

### Troubleshooting

Ask for diagnostics:

```
"My installation seems broken. How do I diagnose?"
"I'm getting a dependency conflict. How to resolve?"
"Theme isn't applying. What's wrong?"
```

### CLI Help

Ask about commands:

```
"How do I remove components safely?"
"What does 'dry-run' show?"
"How to preview dependencies?"
"Install components to AI models?"
```

---

## Advanced Usage

### Custom Workflows

The skill supports custom workflows:

```
"Create a complete E-commerce product page with:
- Product image gallery
- Rating component
- Buy button
- Related products section

Suggest components and show me the code."
```

### Theme Customization

```
"I want a custom theme with these colors:
- Primary: #6366F1 (indigo)
- Secondary: #8B5CF6 (purple)
- Background: #0F172A (dark)

How do I apply this?"
```

### Performance Optimization

```
"I'm building a large app. Which components should I prioritize 
to keep the initial build size small?"
```

---

## Updating the Skill

### Check for Updates

When new features are added to flutter_shadcn CLI:

```bash
# Get latest skill
flutter_shadcn install-skill --skill flutter-shadcn-ui --refresh

# Or download latest from registry
```

### Manual Update

To update manually:

```bash
# Backup old version
mv .claude/flutter-shadcn-ui .claude/flutter-shadcn-ui.bak

# Install new version
mkdir -p .claude/flutter-shadcn-ui
cp <new-skill>/SKILL.md .claude/flutter-shadcn-ui/
cp -r <new-skill>/references/ .claude/flutter-shadcn-ui/
```

---

## Troubleshooting

### Skill Not Responding

**Problem:** AI doesn't know about shadcn components

**Solution:**
1. Verify files are in correct folder structure
2. Check `.claude/` or `.gpt4/` folder permissions
3. Restart your AI application
4. Reinstall with `flutter_shadcn install-skill --skill flutter-shadcn-ui`

### Outdated Information

**Problem:** AI suggests non-existent commands or components

**Solution:**
1. Refresh registry cache: `flutter_shadcn list --refresh`
2. Update skill: `flutter_shadcn install-skill --refresh`
3. Verify skill file dates match registry version

### Conflict with Other Skills

**Problem:** Information conflicts between skills

**Solution:**
1. Check skill folder names (should be unique)
2. Don't duplicate SKILL.md files
3. Keep only active skills in model folders
4. Remove conflicting skills: `flutter_shadcn install-skill --uninstall <skill>`

---

## Platform-Specific Notes

### Claude / Anthropic

Skills installed via `.claude/` folder are accessible whenever Claude runs in that project directory.

```bash
.claude/flutter-shadcn-ui/
├── SKILL.md
└── references/
```

### ChatGPT / Custom GPT

Upload skill files when creating custom GPT:
1. Go to https://chat.openai.com/gpts/editor
2. Upload SKILL.md in "Instructions" section
3. Upload reference files in "Knowledge" section
4. Save and test

### Cursor

Cursor reads from `.cursor/` folder automatically:

```bash
.cursor/flutter-shadcn-ui/
├── SKILL.md
└── references/
```

### Gemini

Use `.gemini/` folder (similar to Claude):

```bash
.gemini/flutter-shadcn-ui/
├── SKILL.md
└── references/
```

### Local LLMs (Ollama, LM Studio)

Create custom folder based on your setup:

```bash
.local-llm/flutter-shadcn-ui/
# or
.ollama/flutter-shadcn-ui/
# or
.my-llm/flutter-shadcn-ui/
```

---

## Integration Examples

### With CI/CD

Use the skill in automated workflows:

```yaml
# .github/workflows/component-validation.yml
name: Component Validation
on: [push]

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Validate components
        run: |
          flutter_shadcn doctor
          flutter_shadcn list --refresh
```

### With Documentation

Generate docs using the skill:

```bash
# Ask AI to generate component docs
# (uses skill knowledge to create comprehensive docs)
```

### With Code Generation

AI can use skill knowledge to generate boilerplate:

```
"Generate a complete CRUD component set with:
- List view
- Detail view
- Edit form
- Delete confirmation"
```

AI uses skill knowledge to structure components properly.

---

## Best Practices

### 1. Keep Skills Updated

Regularly check for updates:
```bash
flutter_shadcn install-skill --list
# Check version dates against registry
```

### 2. Test New Features

When trying new commands:
```bash
flutter_shadcn dry-run <component>  # Preview first
flutter_shadcn add <component>       # Then install
```

### 3. Document Custom Workflows

If you create custom workflows, document them:
```bash
# Save workflow in project docs
mkdir -p docs/workflows
echo "Our login form workflow:" > docs/workflows/login-form.md
```

### 4. Version Control Skills

Keep skill installation tracked:
```bash
# Commit skill installation
git add .claude/flutter-shadcn-ui/
git add .shadcn/config.json
git commit -m "Add flutter-shadcn-ui skill and CLI config"
```

### 5. Share Skills with Team

Share skill with your team:
```bash
# In team repository
mkdir -p team-skills/flutter-shadcn-ui
cp -r /path/to/skill/* team-skills/flutter-shadcn-ui/

# Team members install with
flutter_shadcn install-skill --skills-path team-skills/
```

---

## Support & Resources

### Getting Help

If you encounter issues:

1. **Check documentation**: See `references/` files for detailed info
2. **Run diagnostics**: `flutter_shadcn doctor`
3. **Check examples**: See `references/examples.md` for common patterns
4. **Ask your AI**: "I'm having trouble with [issue]. How do I fix it?"

### Contributing

To improve the skill:

1. Test thoroughly in your projects
2. Document new patterns you discover
3. Share feedback on what works well
4. Report any outdated information

### Feedback

Send feedback to the flutter_shadcn team:

```bash
flutter_shadcn --feedback "Skill suggestion: ..."
```

---

## Compatibility

This skill is compatible with:

- **Flutter**: 3.0.0+
- **Dart**: 3.0.0+
- **flutter_shadcn CLI**: 1.0.0+
- **AI Models**: Claude, ChatGPT, Cursor, Gemini, and others
- **Platforms**: iOS, Android, Web, macOS, Windows, Linux

---

## License

The flutter-shadcn-ui skill is distributed as-is for use with the flutter_shadcn registry and CLI.

Check the registry repository for complete licensing information.
