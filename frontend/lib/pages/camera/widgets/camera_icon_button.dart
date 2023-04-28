import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/utils/app_colors.dart';

class CameraIconButton extends StatelessWidget {
  final IconData? icon;
  final VoidCallback? onPressed;
  const CameraIconButton({
    Key? key,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: CustomPaint(
        size: const Size(40, 40),
        painter: _CircleBlurPainter(
          circleWidth: 2.0,
          blurSigma: 1.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            color: AppColors.youWhite,
          ),
        ),
      ),
    );
  }
}

class _CircleBlurPainter extends CustomPainter {
  _CircleBlurPainter({required this.circleWidth, required this.blurSigma});

  final double circleWidth;
  final double blurSigma;

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = Paint()
      ..color = Colors.black.withOpacity(0.6)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = circleWidth;
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, line);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
