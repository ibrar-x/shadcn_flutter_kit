part of '../../util.dart';


class CapturedWrapper extends StatefulWidget {
  final CapturedThemes? themes;
  final CapturedData? data;
  final Widget child;

  const CapturedWrapper({
    super.key,
    this.themes,
    this.data,
    required this.child,
  });

  @override
  State<CapturedWrapper> createState() => _CapturedWrapperState();
}
