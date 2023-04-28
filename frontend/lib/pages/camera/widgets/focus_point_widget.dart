import 'package:flutter/material.dart';

class FocusPointWidget extends StatelessWidget {
  const FocusPointWidget({
    Key? key,
    required this.size,
    required this.color,
  }) : super(key: key);

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: kThemeAnimationDuration,
      builder: (_, double opacity, __) => TweenAnimationBuilder(
        tween: Tween<double>(begin: 1.5, end: 1),
        curve: Curves.easeOutBack,
        duration: const Duration(milliseconds: 400),
        builder: (_, double scale, __) => Opacity(
          opacity: opacity,
          child: Transform.scale(
            scale: scale,
            child: SizedBox.fromSize(
              size: Size.square(size),
              child: CustomPaint(
                painter: _FocusPointPainter(size: size, color: color, radius: 2, strokeWidth: 2),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FocusPointPainter extends CustomPainter {
  const _FocusPointPainter({
    required this.size,
    required this.color,
    this.radius = 2,
    this.strokeWidth = 2,
  }) : assert(size > 0);

  final double size;
  final double radius;
  final double strokeWidth;
  final Color color;

  Radius get _circularRadius => Radius.circular(radius);

  @override
  void paint(Canvas canvas, Size size) {
    final Size dividedSize = size / 3;
    final double lineLength = dividedSize.width - radius;
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = color
      ..strokeWidth = strokeWidth;

    final Path path = Path()
      ..moveTo(0, dividedSize.height)
      ..relativeLineTo(0, -lineLength)
      ..relativeArcToPoint(Offset(radius, -radius), radius: _circularRadius)
      ..relativeLineTo(lineLength, 0)
      ..relativeMoveTo(dividedSize.width, 0)
      ..relativeLineTo(lineLength, 0)
      ..relativeArcToPoint(Offset(radius, radius), radius: _circularRadius)
      ..relativeLineTo(0, lineLength)
      ..relativeMoveTo(0, dividedSize.height)
      ..relativeLineTo(0, lineLength)
      ..relativeArcToPoint(Offset(-radius, radius), radius: _circularRadius)
      ..relativeLineTo(-lineLength, 0)
      ..relativeMoveTo(-dividedSize.width, 0)
      ..relativeLineTo(-lineLength, 0)
      ..relativeArcToPoint(Offset(-radius, -radius), radius: _circularRadius)
      ..relativeLineTo(0, -lineLength)
      ..relativeMoveTo(0, -dividedSize.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_FocusPointPainter oldDelegate) {
    return oldDelegate.size != size || oldDelegate.radius != radius;
  }
}
