part of '../../text.dart';


class UnorderedListData {
  final int depth;

  /// Creates an [UnorderedListData].
  const UnorderedListData({this.depth = 0});
}

Widget getBullet(BuildContext context, int depth, double size) {
  return CustomPaint(
    size: Size(size, size),
    painter: _BulletPainter(
      color: DefaultTextStyle.of(context).style.color,
      depth: depth,
    ),
  );
}
