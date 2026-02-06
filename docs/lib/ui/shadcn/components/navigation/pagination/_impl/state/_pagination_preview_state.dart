part of '../../preview.dart';

class _PaginationPreviewState extends State<PaginationPreview> {
  int _page = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Pagination(
          page: _page,
          totalPages: 10,
          onPageChanged: (value) {
            setState(() {
              _page = value;
            });
          },
        ),
      ),
    );
  }
}
