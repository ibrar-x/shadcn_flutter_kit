part of '../../preview.dart';

/// _PaginationPreviewState defines a reusable type for this registry module.
class _PaginationPreviewState extends State<PaginationPreview> {
/// Stores `_page` state/configuration for this implementation.
  int _page = 1;

  @override
/// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Pagination(
          page: _page,
          totalPages: 10,
          onPageChanged: (value) {
/// Creates a `setState` instance.
            setState(() {
              _page = value;
            });
          },
        ),
      ),
    );
  }
}
