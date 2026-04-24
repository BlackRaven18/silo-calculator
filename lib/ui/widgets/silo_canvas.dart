import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/services/notification_service.dart';
import '../../core/theme/app_theme.dart';
import '../../view_models/silo_view_model.dart';
import 'package:silo_calculator/core/services/l10n_service.dart';
import 'create_silo_dialog.dart';
import 'rename_silo_dialog.dart';
import 'silo_painter.dart';
import 'silo_input_chip.dart';

class SiloCanvas extends StatefulWidget {
  const SiloCanvas({super.key});

  @override
  State<SiloCanvas> createState() => _SiloCanvasState();
}

class _SiloCanvasState extends State<SiloCanvas> {
  final TransformationController _transformationController =
      TransformationController();

  void _zoom(double delta) {
    setState(() {
      final Matrix4 matrix = _transformationController.value.clone();
      final double currentScale = matrix.getMaxScaleOnAxis();
      final double newScale = (currentScale + delta).clamp(0.5, 4.0);
      final double scaleMultiplier = newScale / currentScale;

      matrix.multiply(
        Matrix4.diagonal3Values(scaleMultiplier, scaleMultiplier, 1.0),
      );
      _transformationController.value = matrix;
    });
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SiloViewModel>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final center = Offset(
          constraints.maxWidth / 2,
          constraints.maxHeight / 2,
        );

        final totalPhysicalHeight = vm.cylinderHeight + vm.hopperHeight + 1.2;

        final sidePadding = isMobile ? 120.0 : 180.0;

        final scaleHeight =
            (constraints.maxHeight * 0.75) / totalPhysicalHeight;
        final scaleWidth =
            (constraints.maxWidth - (sidePadding * 2)) / (vm.radius * 2);
        final scale = scaleHeight < scaleWidth ? scaleHeight : scaleWidth;

        final pxRadius = vm.radius * scale;
        final pxCylinderHeight = vm.cylinderHeight * scale;
        final pxHopperHeight = vm.hopperHeight * scale;

        final totalSiloPxHeight = pxCylinderHeight + pxHopperHeight;
        final bottomY = center.dy + (pxCylinderHeight / 2) + pxHopperHeight;

        // Dynamic offsets for chips
        final hOffset = isMobile ? 8.0 : 30.0;
        final labelWidth = isMobile ? 100.0 : 135.0;

        void updateFillFromPosition(Offset localPosition) {
          final dyFromBottom = bottomY - localPosition.dy;
          final percent = dyFromBottom / totalSiloPxHeight;
          vm.updateFillLevel(percent);
        }

        return Stack(
          children: [
            InteractiveViewer(
              transformationController: _transformationController,
              minScale: 0.5,
              maxScale: 4.0,
              boundaryMargin: const EdgeInsets.all(double.infinity),
              child: Stack(
                children: [
                  // The Drawing (Interactive Layer)
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
                        scale: scale,
                        isDarkMode: isDark,
                        focusedDimension: vm.focusedDimension,
                      ),
                    ),
                  ),

                  // RADIUS Input (r)
                  Positioned(
                    left: center.dx + pxRadius + hOffset,
                    top: center.dy + (pxCylinderHeight / 2) - 20, // Adjusted
                    child: SiloInputChip(
                      dimension: SiloDimension.radius,
                      label: 'r',
                      value: vm.radius,
                      vm: vm,
                      isSmall: isMobile,
                      onChanged: vm.updateRadius,
                    ),
                  ),

                  // CYLINDER HEIGHT Input (h1)
                  Positioned(
                    left: center.dx - pxRadius - labelWidth - hOffset,
                    top:
                        center.dy -
                        (isMobile ? 18 : 22), // Perfectly centered on h1 bar
                    child: SiloInputChip(
                      dimension: SiloDimension.cylinderHeight,
                      label: 'h1',
                      value: vm.cylinderHeight,
                      vm: vm,
                      isSmall: isMobile,
                      onChanged: vm.updateCylinderHeight,
                    ),
                  ),

                  // HOPPER HEIGHT Input (h2)
                  Positioned(
                    left: center.dx - pxRadius - labelWidth - hOffset,
                    top:
                        center.dy +
                        (pxCylinderHeight / 2) +
                        (pxHopperHeight / 2) -
                        (isMobile ? 18 : 22), // Perfectly centered on h2 bar
                    child: SiloInputChip(
                      dimension: SiloDimension.hopperHeight,
                      label: 'h2',
                      value: vm.hopperHeight,
                      vm: vm,
                      isSmall: isMobile,
                      onChanged: vm.updateHopperHeight,
                    ),
                  ),
                ],
              ),
            ),

            // Static UI Overlays (Don't Zoom)
            _buildActionButtons(context, vm, isMobile),
            _buildSelectedSiloName(context, vm, isMobile),
            _buildZoomControls(isMobile),
          ],
        );
      },
    );
  }

  Widget _buildZoomControls(bool isMobile) {
    return Positioned(
      bottom: 20,
      right: 20,
      child: Column(
        children: [
          _buildZoomButton(Icons.add, () => _zoom(0.2)),
          const SizedBox(height: 12),
          _buildZoomButton(Icons.remove, () => _zoom(-0.2)),
        ],
      ),
    );
  }

  Widget _buildZoomButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: AppTheme.primaryColor),
        style: IconButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: AppTheme.primaryColor,
        ),
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    SiloViewModel vm,
    bool isMobile,
  ) {
    return Positioned(
      top: isMobile ? 12 : 20,
      left: isMobile ? 12 : 20,
      child: Row(
        children: [
          ElevatedButton.icon(
            onPressed: () {
              if (vm.selectedSiloId != null) {
                vm.updateSelectedSilo();
                NotificationService.show(
                  context,
                  '${context.l10n.silo_saved}${vm.selectedSilo?.name}',
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
              size: isMobile ? 16 : 18,
            ),
            label: Text(
              vm.selectedSiloId != null
                  ? context.l10n.update_silo
                  : context.l10n.save_silo,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: isMobile ? 11 : 13,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.9),
              foregroundColor: Colors.white,
              elevation: 8,
              shadowColor: Colors.black45,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 12 : 20,
                vertical: isMobile ? 12 : 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(isMobile ? 12 : 16),
              ),
            ),
          ),
          if (vm.selectedSiloId != null) ...[
            const SizedBox(width: 8),
            IconButton(
              onPressed: () => vm.createNewSilo(),
              icon: Icon(Icons.add, size: isMobile ? 20 : 24),
              tooltip: context.l10n.new_silo,
              style: IconButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppTheme.primaryColor,
                padding: isMobile ? const EdgeInsets.all(8) : null,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSelectedSiloName(
    BuildContext context,
    SiloViewModel vm,
    bool isMobile,
  ) {
    if (vm.selectedSiloId == null) return const SizedBox.shrink();

    return Positioned(
      top: isMobile ? 15 : 25,
      right: isMobile ? 12 : 20,
      child: GestureDetector(
        onTap: () => showDialog(
          context: context,
          builder: (context) => RenameSiloDialog(vm: vm),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 10 : 16,
            vertical: isMobile ? 6 : 8,
          ),
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
              Icon(
                Icons.edit,
                size: isMobile ? 12 : 16,
                color: AppTheme.primaryColor,
              ),
              const SizedBox(width: 6),
              Text(
                vm.selectedSilo?.name ?? '',
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? 14 : 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
