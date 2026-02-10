import 'package:flutter/material.dart' as m;

import '../outlined_container/outlined_container.dart';
import 'flex.dart';

class FlexPreview extends m.StatelessWidget {
  const FlexPreview({super.key});

  @override
  m.Widget build(m.BuildContext context) {
    return m.Scaffold(
      body: m.SingleChildScrollView(
        padding: const m.EdgeInsets.all(24),
        child: m.Center(
          child: m.ConstrainedBox(
            constraints: const m.BoxConstraints(maxWidth: 700),
            child: m.Column(
              crossAxisAlignment: m.CrossAxisAlignment.start,
              children: const [
                m.Text(
                  'Paint Order Example 1',
                  style: m.TextStyle(
                    fontSize: 16,
                    fontWeight: m.FontWeight.w600,
                  ),
                ),
                m.SizedBox(height: 12),
                PaintOrderExample1(),
                m.SizedBox(height: 24),
                m.Text(
                  'Paint Order Example 2',
                  style: m.TextStyle(
                    fontSize: 16,
                    fontWeight: m.FontWeight.w600,
                  ),
                ),
                m.SizedBox(height: 12),
                PaintOrderExample2(),
                m.SizedBox(height: 24),
                m.Text(
                  'Paint Order Example 3',
                  style: m.TextStyle(
                    fontSize: 16,
                    fontWeight: m.FontWeight.w600,
                  ),
                ),
                m.SizedBox(height: 12),
                PaintOrderExample3(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PaintOrderExample1 extends m.StatelessWidget {
  const PaintOrderExample1({super.key});

  @override
  m.Widget build(m.BuildContext context) {
    return OutlinedContainer(
      width: 300,
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          m.Transform.translate(
            offset: const m.Offset(20, 0),
            child: m.Container(
              width: 80,
              height: 80,
              decoration: m.BoxDecoration(
                color: m.Colors.blue,
                borderRadius: m.BorderRadius.circular(8),
              ),
              child: const m.Center(
                child: m.Text(
                  'Below',
                  style: m.TextStyle(color: m.Colors.white),
                ),
              ),
            ),
          ),
          PaintOrder(
            paintOrder: 1,
            child: m.Transform.translate(
              offset: const m.Offset(-20, 0),
              child: m.Container(
                width: 80,
                height: 80,
                decoration: m.BoxDecoration(
                  color: m.Colors.red,
                  borderRadius: m.BorderRadius.circular(8),
                ),
                child: const m.Center(
                  child: m.Text(
                    'On Top',
                    style: m.TextStyle(color: m.Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PaintOrderExample2 extends m.StatefulWidget {
  const PaintOrderExample2({super.key});

  @override
  m.State<PaintOrderExample2> createState() => _PaintOrderExample2State();
}

class _PaintOrderExample2State extends m.State<PaintOrderExample2> {
  final List<int> _paintOrders = [0, 0, 0];
  int _topIndex = 0;

  @override
  m.Widget build(m.BuildContext context) {
    final colors = [m.Colors.red, m.Colors.green, m.Colors.blue];
    return OutlinedContainer(
      width: 350,
      height: 180,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < 3; i++)
                PaintOrder(
                  paintOrder: _paintOrders[i],
                  child: m.Transform.translate(
                    offset: m.Offset((i - 1) * -30.0, 0),
                    child: m.GestureDetector(
                      onTap: () =>
                          setState(() => _paintOrders[i] = ++_topIndex),
                      child: m.Container(
                        width: 80,
                        height: 80,
                        decoration: m.BoxDecoration(
                          color: colors[i],
                          borderRadius: m.BorderRadius.circular(8),
                          boxShadow: [
                            m.BoxShadow(
                              color: m.Colors.black.withAlpha(64),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: m.Center(
                          child: m.Text(
                            'Card ${i + 1}',
                            style: const m.TextStyle(color: m.Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const m.SizedBox(height: 16),
          const m.Text('Tap a card to bring it to front'),
        ],
      ),
    );
  }
}

class PaintOrderExample3 extends m.StatefulWidget {
  const PaintOrderExample3({super.key});

  @override
  m.State<PaintOrderExample3> createState() => _PaintOrderExample3State();
}

class _PaintOrderExample3State extends m.State<PaintOrderExample3> {
  final List<int> _paintOrders = [0, 0, 0];
  int _topIndex = 0;

  @override
  m.Widget build(m.BuildContext context) {
    final colors = [m.Colors.red, m.Colors.green, m.Colors.blue];
    return OutlinedContainer(
      width: 350,
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          m.SizedBox(
            width: 200,
            height: 120,
            child: Stack(
              clipBehavior: m.Clip.none,
              children: [
                for (int i = 0; i < 3; i++)
                  Positioned(
                    left: i * 50.0,
                    top: i * 20.0,
                    paintOrder: _paintOrders[i],
                    child: m.GestureDetector(
                      onTap: () =>
                          setState(() => _paintOrders[i] = ++_topIndex),
                      child: m.Container(
                        width: 80,
                        height: 80,
                        decoration: m.BoxDecoration(
                          color: colors[i],
                          borderRadius: m.BorderRadius.circular(8),
                          boxShadow: [
                            m.BoxShadow(
                              color: m.Colors.black.withAlpha(64),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: m.Center(
                          child: m.Text(
                            'Card ${i + 1}',
                            style: const m.TextStyle(color: m.Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const m.SizedBox(height: 16),
          const m.Text('Tap a card to bring it to front'),
        ],
      ),
    );
  }
}
