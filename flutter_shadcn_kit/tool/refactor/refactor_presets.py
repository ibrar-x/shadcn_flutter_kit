#!/usr/bin/env python3
"""
Refactors preset_themes.dart by:
1. Extracting preset data (id, name, colors, tokens)
2. Rebuilding with factory pattern to reduce from 9999 → ~2000 lines
"""

import re
import json
from pathlib import Path

# Path to the old file (the one with all 42 presets)
OLD_FILE = Path('/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit/flutter_shadcn_kit/lib/registry/shared/theme/preset_themes.dart')
OUTPUT_FILE = Path('/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit/flutter_shadcn_kit/lib/registry/shared/theme/preset_themes_refactored.dart')

def extract_int(m: str):
    """Convert hex color string in Dart format to Python int."""
    if m.startswith('0x'):
        return int(m, 16)
    return None

def extract_presets():
    """Parse the old preset_themes.dart file and extract all presets."""
    content = OLD_FILE.read_text()
    
    # Split by RegistryThemePreset( to find each preset block
    preset_blocks = re.split(r'\n\s*RegistryThemePreset\(', content)
    if not preset_blocks:
        return []
    
    presets = []
    for block in preset_blocks[1:]:  # Skip header
        # Extract id (simple regex)
        id_match = re.search(r"id:\s*'([^']+)'", block)
        if not id_match:
            continue
        
        preset_id = id_match.group(1)
        
        # Extract name
        name_match = re.search(r"name:\s*'([^']+)'", block)
        preset_name = name_match.group(1) if name_match else preset_id
        
        # Extract light and dark ColorScheme blocks
        light_match = re.search(r'light:\s*const ColorScheme\((.*?)\),\s*dark:', block, re.DOTALL)
        dark_match = re.search(r'dark:\s*const ColorScheme\((.*?)\),\s*lightTokens:', block, re.DOTALL)

        if not (light_match and dark_match):
            continue
        
        light_colors = _parse_color_scheme(light_match.group(1))
        dark_colors = _parse_color_scheme(dark_match.group(1))
        
        # Extract tokens (light and dark)
        light_tokens = _parse_tokens(block.split('lightTokens:')[1].split('darkTokens:')[0])
        dark_tokens = _parse_tokens(block.split('darkTokens:')[1].split('),\n  ),')[0])
        
        presets.append({
            'id': preset_id,
            'name': preset_name,
            'light': light_colors,
            'dark': dark_colors,
            'lightTokens': light_tokens,
            'darkTokens': dark_tokens,
        })
    
    return presets

def _parse_color_scheme(block: str) -> dict:
    """Extract color fields from a ColorScheme block."""
    colors = {}
    # Match: fieldName: Color(0xHHHHHHHH),
    pattern = r'(\w+):\s*Color\((0x[0-9A-Fa-f]{8})\)'
    for match in re.finditer(pattern, block):
        color_name = match.group(1)
        color_value = match.group(2)
        colors[color_name] = color_value
    return colors

def _parse_tokens(block: str) -> dict:
    """Extract token fields (radius, fonts, spacing)."""
    tokens = {}
    
    # Extract radius
    radius_match = re.search(r'radius:\s*([\d.]+)', block)
    if radius_match:
        tokens['radius'] = float(radius_match.group(1))
    
    # Extract spacing base
    spacing_match = re.search(r'SpacingScale\(([\d.]+)\)', block)
    if spacing_match:
        tokens['spacingBase'] = float(spacing_match.group(1))
    
    # Extract fonts
    for font_type in ['fontSans', 'fontSerif', 'fontMono']:
        font_match = re.search(rf'{font_type}:\s*"([^"]*)"', block)
        if font_match:
            tokens[font_type] = font_match.group(1)
    
    return tokens

def generate_refactored():
    """Generate the refactored preset_themes.dart with factories."""
    presets = extract_presets()
    
    lines = []
    
    # Header
    lines.append('// GENERATED CODE - DO NOT MODIFY BY HAND.')
    lines.append('// Run `dart run tool/generate_theme_presets.dart` to refresh.')
    lines.append('// ignore_for_file: prefer_const_constructors')
    lines.append('')
    lines.append('import \'dart:ui\';')
    lines.append('')
    lines.append('import \'package:flutter/painting.dart\';')
    lines.append('')
    lines.append('import \'color_scheme.dart\';')
    lines.append('import \'theme.dart\';')
    lines.append('')
    lines.append('/// RegistryThemePresetTokens defines a reusable type for this registry module.')
    lines.append('class RegistryThemePresetTokens {')
    lines.append('  final double radius;')
    lines.append('  final SpacingScale spacing;')
    lines.append('  final TrackingScale tracking;')
    lines.append('  final ShadowScale shadows;')
    lines.append('  final String? fontSans;')
    lines.append('  final String? fontSerif;')
    lines.append('  final String? fontMono;')
    lines.append('')
    lines.append('  RegistryThemePresetTokens({')
    lines.append('    required this.radius,')
    lines.append('    required this.spacing,')
    lines.append('    required this.tracking,')
    lines.append('    required this.shadows,')
    lines.append('    this.fontSans,')
    lines.append('    this.fontSerif,')
    lines.append('    this.fontMono,')
    lines.append('  });')
    lines.append('')
    lines.append('  /// Derived density values based on preset spacing scale.')
    lines.append('  Density get density => Density.fromSpacingScale(spacing);')
    lines.append('}')
    lines.append('')
    lines.append('/// RegistryThemePreset defines a reusable type for this registry module.')
    lines.append('class RegistryThemePreset {')
    lines.append('  final String id;')
    lines.append('  final String name;')
    lines.append('  final ColorScheme light;')
    lines.append('  final ColorScheme dark;')
    lines.append('  final RegistryThemePresetTokens lightTokens;')
    lines.append('  final RegistryThemePresetTokens darkTokens;')
    lines.append('')
    lines.append('  RegistryThemePreset({')
    lines.append('    required this.id,')
    lines.append('    required this.name,')
    lines.append('    required this.light,')
    lines.append('    required this.dark,')
    lines.append('    required this.lightTokens,')
    lines.append('    required this.darkTokens,')
    lines.append('  });')
    lines.append('}')
    lines.append('')
    lines.append('// ============================================================================')
    lines.append('// Common Shadow Scales')
    lines.append('// ============================================================================')
    lines.append('')
    lines.append('/// Standard light shadow.')
    lines.append('final _shadowLightStandard = ShadowScale(')
    for shadow_type in ['shadow2xs', 'shadowXs', 'shadowSm', 'shadow', 'shadowMd', 'shadowLg', 'shadowXl', 'shadow2xl']:
        lines.append(f'  {shadow_type}: const [BoxShadow(offset: Offset(0, 4), blurRadius: 8, spreadRadius: -1, color: Color(0x1A000000))],')
    lines.append(');')
    lines.append('')
    lines.append('/// Standard dark shadow.')
    lines.append('final _shadowDarkStandard = ShadowScale(')
    for shadow_type in ['shadow2xs', 'shadowXs', 'shadowSm', 'shadow', 'shadowMd', 'shadowLg', 'shadowXl', 'shadow2xl']:
        lines.append(f'  {shadow_type}: const [BoxShadow(offset: Offset(20.5, 16.5), blurRadius: 25.5, spreadRadius: -30, color: Color(0x12000000))],')
    lines.append(');')
    lines.append('')
    lines.append('/// Soft light shadow.')
    lines.append('final _shadowLightSoft = ShadowScale(')
    for shadow_type in ['shadow2xs', 'shadowXs', 'shadowSm', 'shadow', 'shadowMd', 'shadowLg', 'shadowXl', 'shadow2xl']:
        lines.append(f'  {shadow_type}: const [BoxShadow(offset: Offset(1, 2), blurRadius: 5, spreadRadius: 1, color: Color(0x0F000000))],')
    lines.append(');')
    lines.append('')
    lines.append('// ============================================================================')
    lines.append('// Factory Helpers')
    lines.append('// ============================================================================')
    lines.append('')
    lines.append('RegistryThemePresetTokens _lightTokens({')
    lines.append('  double radius = 0.5,')
    lines.append('  double spacingBase = 4,')
    lines.append('  ShadowScale? shadows,')
    lines.append('  String? fontSans,')
    lines.append('  String? fontSerif,')
    lines.append('  String? fontMono,')
    lines.append('}) =>')
    lines.append('    RegistryThemePresetTokens(')
    lines.append('      radius: radius,')
    lines.append('      spacing: SpacingScale(spacingBase),')
    lines.append('      tracking: TrackingScale(normal: 0),')
    lines.append('      shadows: shadows ?? _shadowLightStandard,')
    lines.append('      fontSans: fontSans,')
    lines.append('      fontSerif: fontSerif,')
    lines.append('      fontMono: fontMono,')
    lines.append('    );')
    lines.append('')
    lines.append('RegistryThemePresetTokens _darkTokens({')
    lines.append('  double radius = 0.5,')
    lines.append('  double spacingBase = 3.84,')
    lines.append('  ShadowScale? shadows,')
    lines.append('  String? fontSans,')
    lines.append('  String? fontSerif,')
    lines.append('  String? fontMono,')
    lines.append('}) =>')
    lines.append('    RegistryThemePresetTokens(')
    lines.append('      radius: radius,')
    lines.append('      spacing: SpacingScale(spacingBase),')
    lines.append('      tracking: TrackingScale(normal: 0),')
    lines.append('      shadows: shadows ?? _shadowDarkStandard,')
    lines.append('      fontSans: fontSans,')
    lines.append('      fontSerif: fontSerif,')
    lines.append('      fontMono: fontMono,')
    lines.append('    );')
    lines.append('')
    lines.append('// ============================================================================')
    lines.append('// Presets List')
    lines.append('// ============================================================================')
    lines.append('')
    lines.append('final List<RegistryThemePreset> registryThemePresets = [')
    
    for preset in presets:
        lines.append('  RegistryThemePreset(')
        lines.append(f'    id: \'{preset["id"]}\',')
        lines.append(f'    name: \'{preset["name"]}\',')
        
        # Light ColorScheme
        lines.append('    light: const ColorScheme(')
        lines.append('      brightness: Brightness.light,')
        for color_name, color_value in preset['light'].items():
            lines.append(f'      {color_name}: Color({color_value}),')
        lines.append('    ),')
        
        # Dark ColorScheme
        lines.append('    dark: const ColorScheme(')
        lines.append('      brightness: Brightness.dark,')
        for color_name, color_value in preset['dark'].items():
            lines.append(f'      {color_name}: Color({color_value}),')
        lines.append('    ),')
        
        # Light Tokens
        lines.append('    lightTokens: _lightTokens(')
        light_tokens = preset['lightTokens']
        if light_tokens.get('radius') and light_tokens.get('radius') != 0.5:
            lines.append(f"      radius: {light_tokens['radius']},")
        if 'fontSans' in light_tokens:
            lines.append(f"      fontSans: \"{light_tokens['fontSans']}\",")
        if 'fontSerif' in light_tokens:
            lines.append(f"      fontSerif: \"{light_tokens['fontSerif']}\",")
        if 'fontMono' in light_tokens:
            lines.append(f"      fontMono: \"{light_tokens['fontMono']}\",")
        lines.append('    ),')
        
        # Dark Tokens
        lines.append('    darkTokens: _darkTokens(')
        dark_tokens = preset['darkTokens']
        if dark_tokens.get('radius') and dark_tokens.get('radius') != 0.5:
            lines.append(f"      radius: {dark_tokens['radius']},")
        if dark_tokens.get('spacingBase') and dark_tokens.get('spacingBase') != 3.84:
            lines.append(f"      spacingBase: {dark_tokens['spacingBase']},")
        if 'fontSans' in dark_tokens:
            lines.append(f"      fontSans: \"{dark_tokens['fontSans']}\",")
        if 'fontSerif' in dark_tokens:
            lines.append(f"      fontSerif: \"{dark_tokens['fontSerif']}\",")
        if 'fontMono' in dark_tokens:
            lines.append(f"      fontMono: \"{dark_tokens['fontMono']}\",")
        lines.append('    ),')
        
        lines.append('  ),')
    
    lines.append('];')
    lines.append('')
    
    return '\n'.join(lines)

if __name__ == '__main__':
    print("Extracting presets from old file...")
    refactored = generate_refactored()
    OUTPUT_FILE.write_text(refactored)
    
    old_lines = OLD_FILE.read_text().split('\n')
    new_lines = refactored.split('\n')
    
    print(f"✓ Refactored preset_themes.dart")
    print(f"  Old: {len(old_lines)} lines")
    print(f"  New: {len(new_lines)} lines")
    print(f"  Reduction: {100 * (1 - len(new_lines)/len(old_lines)):.1f}%")
    print(f"  Output: {OUTPUT_FILE}")
