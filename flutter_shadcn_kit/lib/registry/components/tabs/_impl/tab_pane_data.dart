part of '../tabs.dart';

class TabPaneData<T> extends SortableData<T> {
  /// Creates a [TabPaneData] wrapper for tab content.
  ///
  /// Wraps the provided data for use in sortable tab pane operations.
  ///
  /// Parameters:
  /// - [data] (T): The data to associate with this tab item
  const TabPaneData(super.data);
}

/// Builder function for creating tab child widgets from tab pane data.
///
/// Takes the build context, tab data, and index to create a TabChild widget
/// that represents the visual appearance of each tab button.
///
/// Parameters:
/// - [context] (BuildContext): Build context for theme access
/// - [item] (`TabPaneData<T>`): The data for this specific tab
/// - [index] (int): Zero-based index of this tab in the list
///
/// Returns: A [TabChild] widget for the tab button
