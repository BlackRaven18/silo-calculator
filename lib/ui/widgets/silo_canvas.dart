import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/services/notification_service.dart';
import '../../core/theme/app_theme.dart';
import '../../view_models/silo_view_model.dart';
import 'create_silo_dialog.dart';
import 'rename_silo_dialog.dart';
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

        final totalSiloPxHeight = pxCylinderHeight + pxHopperHeight;
        final bottomY = center.dy + (pxCylinderHeight / 2) + pxHopperHeight;

        void updateFillFromPosition(Offset localPosition) {
          final dyFromBottom = bottomY - localPosition.dy;
          final percent = dyFromBottom / totalSiloPxHeight;
          vm.updateFillLevel(percent);
        }

        return Stack(
          children: [
            // The Drawing
            GestureDetector(
              onTapDown: (details) =>
                  updateFillFromPosition(details.localPosition),
              onPanUpdate: (details) =>
                  updateFillFromPosition(details.localPosition),
              child: CustomPaint(
                size: Size.infinite,
                painter: SiloPainter(
                  radius: vm.radius,
                  cylinderHeight: vm.cylinderHeight,
                  hopperHeight: vm.hopperHeight,
                  fillLevel: vm.fillLevel,
                  isDarkMode: isDark,
                  focusedDimension: vm.focusedDimension,
                ),
              ),
            ),

            _buildActionButtons(context, vm),

            _buildSelectedSiloName(context, vm),

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

  Widget _buildActionButtons(BuildContext context, SiloViewModel vm) {
    return Positioned(
      top: 20,
      left: 20,
      child: Row(
        children: [
          ElevatedButton.icon(
            onPressed: () {
              if (vm.selectedSiloId != null) {
                vm.updateSelectedSilo();
                NotificationService.show(
                  context,
                  'Zaktualizowano silos: ${vm.selectedSilo?.name}',
                );
              } else {
                showDialog(
                  context: context,
                  builder: (context) => CreateSiloDialog(vm: vm),
                );
              }
            },
            icon: Icon(
              vm.selectedSiloId != null ? Icons.save : Icons.add_task,
              size: 18,
            ),
            label: Text(
              vm.selectedSiloId != null ? 'ZAKTUALIZUJ' : 'ZAPISZ SILOS',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.9),
              foregroundColor: Colors.white,
              elevation: 8,
              shadowColor: Colors.black45,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          if (vm.selectedSiloId != null) ...[
            const SizedBox(width: 12),
            IconButton(
              onPressed: () => vm.createNewSilo(),
              icon: const Icon(Icons.add),
              tooltip: 'Nowy silos',
              style: IconButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppTheme.primaryColor,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSelectedSiloName(BuildContext context, SiloViewModel vm) {
    if (vm.selectedSiloId == null) return const SizedBox.shrink();

    return Positioned(
      top: 25,
      right: 20,
      child: GestureDetector(
        onTap: () => showDialog(
          context: context,
          builder: (context) => RenameSiloDialog(vm: vm),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppTheme.primaryColor.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.edit, size: 16, color: AppTheme.primaryColor),
              const SizedBox(width: 8),
              Text(
                vm.selectedSilo?.name ?? '',
                style: const TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
