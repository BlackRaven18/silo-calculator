import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/silo_view_model.dart';
import 'silo_painter.dart';
import 'silo_input_chip.dart';

class SiloCanvas extends StatelessWidget {
  const SiloCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SiloViewModel>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        final center = Offset(
          constraints.maxWidth / 2,
          constraints.maxHeight / 2,
        );

        final totalPhysicalHeight = vm.cylinderHeight + vm.hopperHeight + 0.8;
        final scale = (constraints.maxHeight * 0.7) / totalPhysicalHeight;

        final pxRadius = vm.radius * scale;
        final pxCylinderHeight = vm.cylinderHeight * scale;
        final pxHopperHeight = vm.hopperHeight * scale;

        return Stack(
          children: [
            // The Drawing
            Positioned.fill(
              child: CustomPaint(
                painter: SiloPainter(
                  radius: vm.radius,
                  cylinderHeight: vm.cylinderHeight,
                  hopperHeight: vm.hopperHeight,
                  isDarkMode: isDark,
                  focusedDimension: vm.focusedDimension,
                ),
              ),
            ),

            // Editable Labels Overlay

            // RADIUS Input (r) - Moved to the RIGHT side
            Positioned(
              left: center.dx + pxRadius + 30,
              top: center.dy + (pxCylinderHeight / 2) - 30,
              child: SiloInputChip(
                dimension: SiloDimension.radius,
                label: 'r',
                value: vm.radius,
                vm: vm,
                onChanged: vm.updateRadius,
              ),
            ),

            // CYLINDER HEIGHT Input (h1) - Left side
            Positioned(
              left: center.dx - pxRadius - 155,
              top: center.dy - (pxCylinderHeight * 0.25),
              child: SiloInputChip(
                dimension: SiloDimension.cylinderHeight,
                label: 'h1',
                value: vm.cylinderHeight,
                vm: vm,
                onChanged: vm.updateCylinderHeight,
              ),
            ),

            // HOPPER HEIGHT Input (h2) - Moved to the LEFT side, below h1
            Positioned(
              left: center.dx - pxRadius - 155,
              top: center.dy + (pxCylinderHeight / 2) + (pxHopperHeight * 0.1),
              child: SiloInputChip(
                dimension: SiloDimension.hopperHeight,
                label: 'h2',
                value: vm.hopperHeight,
                vm: vm,
                onChanged: vm.updateHopperHeight,
              ),
            ),
          ],
        );
      },
    );
  }
}
