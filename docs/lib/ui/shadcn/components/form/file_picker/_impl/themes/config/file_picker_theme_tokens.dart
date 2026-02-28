import 'package:flutter/widgets.dart';

// ═══════════════════════════════════════════════════════════
// COMPONENT THEME TOKENS
// User customization layer (replace this file from website output)
// Defaults intentionally mirror FileUploadDropzoneThemeDefaults
// ═══════════════════════════════════════════════════════════

class FileUploadDropzoneThemeTokens {
  const FileUploadDropzoneThemeTokens({
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.minHeight = 220.0,
    this.icon,
    this.ignoreGlobalScaling = false,
    this.ignoreGlobalRadius = false,
  });

  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double minHeight;
  final Widget? icon;
  final bool ignoreGlobalScaling;
  final bool ignoreGlobalRadius;
}

const fileUploadDropzoneThemeTokens = FileUploadDropzoneThemeTokens();
