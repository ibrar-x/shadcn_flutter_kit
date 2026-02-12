part of '../../tabs.dart';

/// Type alias for `TabBuilder` used by public or internal APIs.
typedef TabBuilder =
    Widget Function(BuildContext context, List<Widget> children);

/// Builder function for creating individual tab child widgets.
///
/// Parameters:
/// - [context] (`BuildContext`): build context
/// - [data] (`TabContainerData`): tab container data
/// - [child] (`Widget`): child widget to wrap
///
/// Returns: `Widget` — the wrapped child widget
typedef TabChildBuilder =
    Widget Function(BuildContext context, TabContainerData data, Widget child);

/// Container widget for managing multiple tabs.
///
/// Provides tab selection and content display with customizable builders.
