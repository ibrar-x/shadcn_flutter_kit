part of '../../theme.dart';

abstract class ComponentThemeData {
  /// Creates a [ComponentThemeData].
  const ComponentThemeData();
}

/// An inherited widget that provides component-specific theme data.
///
/// Allows components to provide custom theme data that overrides or extends
/// the global theme. The type parameter `T` specifies the theme data type.
///
/// Example:
/// ```dart
/// ComponentTheme<ButtonTheme>(
///   data: ButtonTheme(backgroundColor: Colors.blue),
///   child: MyButton(),
/// )
/// ```
