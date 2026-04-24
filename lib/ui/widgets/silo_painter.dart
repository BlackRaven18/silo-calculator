import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../view_models/silo_view_model.dart';

class SiloPainter extends CustomPainter {
  final double radius;
  final double cylinderHeight;
  final double hopperHeight;
  final double fillLevel;
  final double scale;
  final bool isDarkMode;
  final SiloDimension focusedDimension;

  SiloPainter({
    required this.radius,
    required this.cylinderHeight,
    required this.hopperHeight,
    required this.fillLevel,
    required this.scale,
    required this.isDarkMode,
    this.focusedDimension = SiloDimension.none,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);

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

    // --- GRAIN FILL DRAWING ---
    final fillBottomY = center.dy + (pxCylinderHeight / 2) + pxHopperHeight;
    final totalPxHeight = pxCylinderHeight + pxHopperHeight;
    final fillTopY = fillBottomY - (totalPxHeight * fillLevel);

    canvas.save();
    canvas.clipPath(siloPath);

    final grainPaint = Paint()
      ..color = const Color(0xFFB8860B).withValues(alpha: 0.8)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTRB(
        center.dx - pxRadius,
        fillTopY,
        center.dx + pxRadius,
        fillBottomY,
      ),
      grainPaint,
    );
    canvas.restore();

    // Fill level line
    final fillLinePaint = Paint()
      ..color = Colors.blue.withValues(alpha: 0.8)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    _drawDashedLine(
      canvas,
      center.dx - pxRadius - 40,
      center.dx + pxRadius + 40,
      fillTopY,
      fillLinePaint,
    );

    final guidingLinePaint = Paint()
      ..color = isDarkMode ? Colors.white10 : Colors.black12
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final cylinderTopY = center.dy - (pxCylinderHeight / 2);

    _drawDashedLine(
      canvas,
      center.dx - pxRadius,
      center.dx + pxRadius,
      cylinderTopY + (pxCylinderHeight / 3),
      guidingLinePaint,
    );
    _drawDashedLine(
      canvas,
      center.dx - pxRadius,
      center.dx + pxRadius,
      cylinderTopY + (2 * pxCylinderHeight / 3),
      guidingLinePaint,
    );

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
        oldDelegate.fillLevel != fillLevel || // Added
        oldDelegate.isDarkMode != isDarkMode ||
        oldDelegate.focusedDimension != focusedDimension;
  }

  void _drawDashedLine(
    Canvas canvas,
    double x1,
    double x2,
    double y,
    Paint paint,
  ) {
    const dashWidth = 8.0;
    const dashSpace = 6.0;
    double startX = x1;
    while (startX < x2) {
      canvas.drawLine(Offset(startX, y), Offset(startX + dashWidth, y), paint);
      startX += dashWidth + dashSpace;
    }
  }
}
