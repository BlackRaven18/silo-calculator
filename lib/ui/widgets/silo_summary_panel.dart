import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/silo_view_model.dart';
import '../../core/theme/app_theme.dart';
import 'package:silo_calculator/core/services/l10n_service.dart';

class SiloSummaryPanel extends StatelessWidget {
  const SiloSummaryPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SiloViewModel>();

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildResultLine(
            context,
            context.l10n.grain_max,
            _formatWeight(vm.totalTonnage, context),
          ),
          _buildResultLine(
            context,
            '${context.l10n.current_amount} (${(vm.fillLevel * 100).toStringAsFixed(0)}%):',
            _formatWeight(vm.filledTonnage, context),
            isMain: true,
          ),
          const Divider(height: 24),
          _buildResultLine(
            context,
            ' - ${context.l10n.cylinder}:',
            _formatWeight(vm.cylinderTonnage, context),
          ),
          _buildResultLine(
            context,
            ' - ${context.l10n.hopper}:',
            _formatWeight(vm.hopperTonnage, context),
          ),
          const Divider(height: 24),
          _buildResultLine(
            context,
            '${context.l10n.capacity}:',
            '${vm.totalVolume.toStringAsFixed(2)} m³',
          ),
          const SizedBox(height: 16),
          Builder(
            builder: (context) {
              final color = Theme.of(context).brightness == Brightness.light 
                 ? Colors.black54 
                 : Colors.white54;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, size: 14, color: color),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      context.l10n.tonnage_disclaimer,
                      style: TextStyle(
                        fontSize: 10,
                        color: color,
                        fontStyle: FontStyle.italic,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              );
            }
          ),
        ],
      ),
    );
  }

  String _formatWeight(double tonnes, BuildContext context) {
    if (tonnes < 1.0) {
      return '${(tonnes * 1000).toStringAsFixed(0)} kg';
    }
    return '${tonnes.toStringAsFixed(2)} ${context.l10n.tonnes}';
  }

  Widget _buildResultLine(
    BuildContext context,
    String label,
    String value, {
    bool isMain = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final labelColor = isDark ? Colors.white70 : Colors.grey[700];
    final valueColor = isDark ? Colors.white : Colors.black;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: isMain ? 17 : 15,
                fontWeight: isMain ? FontWeight.bold : FontWeight.normal,
                color: labelColor,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          const SizedBox(width: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerRight,
            child: Text(
              value,
              style: TextStyle(
                fontSize: isMain ? 22 : 18,
                fontWeight: FontWeight.w900,
                color: isMain ? AppTheme.primaryColor : valueColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
