import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../view_models/silo_view_model.dart';

class SiloPainter extends CustomPainter {
  final double radius;
  final double cylinderHeight;
  final double hopperHeight;
  final bool isDarkMode;
  final SiloDimension focusedDimension;

  SiloPainter({
    required this.radius,
    required this.cylinderHeight,
    required this.hopperHeight,
    required this.isDarkMode,
    this.focusedDimension = SiloDimension.none,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);

    // Scale factor to fit the silo in the canvas
    final totalPhysicalHeight = cylinderHeight + hopperHeight + 0.8;
    final scale = (size.height * 0.7) / totalPhysicalHeight;

    final pxRadius = radius * scale;
    final pxCylinderHeight = cylinderHeight * scale;
    final pxHopperHeight = hopperHeight * scale;
    final pxRoofHeight = 0.5 * scale;

    final paint = Paint()
      ..color = AppTheme.primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final fillPaint = Paint()
      ..color = AppTheme.primaryColor.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    final siloPath = Path();

    // Starting from the top of the roof
    final topY = center.dy - (pxCylinderHeight / 2) - pxRoofHeight;

    // Roof
    siloPath.moveTo(center.dx, topY);
    siloPath.lineTo(center.dx - pxRadius, center.dy - (pxCylinderHeight / 2));
    siloPath.lineTo(center.dx + pxRadius, center.dy - (pxCylinderHeight / 2));
    siloPath.close();

    // Body (Cylinder)
    final bodyRect = Rect.fromLTRB(
      center.dx - pxRadius,
      center.dy - (pxCylinderHeight / 2),
      center.dx + pxRadius,
      center.dy + (pxCylinderHeight / 2),
    );
    siloPath.addRect(bodyRect);

    // Hopper
    siloPath.moveTo(center.dx - pxRadius, center.dy + (pxCylinderHeight / 2));
    siloPath.lineTo(
      center.dx,
      center.dy + (pxCylinderHeight / 2) + pxHopperHeight,
    );
    siloPath.lineTo(center.dx + pxRadius, center.dy + (pxCylinderHeight / 2));

    // Draw shadows/fills
    canvas.drawPath(siloPath, fillPaint);
    canvas.drawPath(siloPath, paint);

    // Support legs
    final legPaint = Paint()
      ..color = isDarkMode ? Colors.white38 : Colors.black38
      ..strokeWidth = 2.0;

    canvas.drawLine(
      Offset(center.dx - pxRadius, center.dy + (pxCylinderHeight / 2)),
      Offset(
        center.dx - pxRadius,
        center.dy + (pxCylinderHeight / 2) + pxHopperHeight + 20,
      ),
      legPaint,
    );
    canvas.drawLine(
      Offset(center.dx + pxRadius, center.dy + (pxCylinderHeight / 2)),
      Offset(
        center.dx + pxRadius,
        center.dy + (pxCylinderHeight / 2) + pxHopperHeight + 20,
      ),
      legPaint,
    );

    // Dimension LINES (No text, text is in SiloCanvas)

    // RADIUS Line (from center to right edge)
    final radiusHighlight = focusedDimension == SiloDimension.radius;
    final radiusLinePaint = Paint()
      ..color = radiusHighlight ? Colors.orange : AppTheme.accentColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = radiusHighlight ? 3.5 : 1.5;

    canvas.drawLine(
      Offset(center.dx, center.dy + (pxCylinderHeight / 2)),
      Offset(center.dx + pxRadius, center.dy + (pxCylinderHeight / 2)),
      radiusLinePaint,
    );

    // Ticks for radius
    canvas.drawLine(
      Offset(center.dx, center.dy + (pxCylinderHeight / 2) - 5),
      Offset(center.dx, center.dy + (pxCylinderHeight / 2) + 5),
      radiusLinePaint,
    );
    canvas.drawLine(
      Offset(center.dx + pxRadius, center.dy + (pxCylinderHeight / 2) - 5),
      Offset(center.dx + pxRadius, center.dy + (pxCylinderHeight / 2) + 5),
      radiusLinePaint,
    );

    // CYLINDER HEIGHT Line (left side)
    final h1Highlight = focusedDimension == SiloDimension.cylinderHeight;
    final h1Paint = Paint()
      ..color = h1Highlight
          ? Colors.orange
          : (isDarkMode ? Colors.white38 : Colors.black26)
      ..style = PaintingStyle.stroke
      ..strokeWidth = h1Highlight ? 3.5 : 1.0;

    canvas.drawLine(
      Offset(center.dx - pxRadius - 15, center.dy - (pxCylinderHeight / 2)),
      Offset(
        center.dx - pxRadius - 15,
        center.dy + (pxCylinderHeight / 2) - 2,
      ), // 2px gap from bottom
      h1Paint,
    );

    // HOPPER HEIGHT Line (left side, below h1)
    final h2Highlight = focusedDimension == SiloDimension.hopperHeight;
    final h2Paint = Paint()
      ..color = h2Highlight
          ? Colors.orange
          : (isDarkMode ? Colors.white38 : Colors.black26)
      ..style = PaintingStyle.stroke
      ..strokeWidth = h2Highlight ? 3.5 : 1.0;

    canvas.drawLine(
      Offset(
        center.dx - pxRadius - 15,
        center.dy + (pxCylinderHeight / 2) + 2,
      ), // 2px gap from top
      Offset(
        center.dx - pxRadius - 15,
        center.dy + (pxCylinderHeight / 2) + pxHopperHeight,
      ),
      h2Paint,
    );
  }

  @override
  bool shouldRepaint(covariant SiloPainter oldDelegate) {
    return oldDelegate.radius != radius ||
        oldDelegate.cylinderHeight != cylinderHeight ||
        oldDelegate.hopperHeight != hopperHeight ||
        oldDelegate.isDarkMode != isDarkMode ||
        oldDelegate.focusedDimension != focusedDimension;
  }
}
