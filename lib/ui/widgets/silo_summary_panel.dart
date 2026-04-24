import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/silo_view_model.dart';
import '../../core/theme/app_theme.dart';

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
            'Ilość zboża (MAX):',
            _formatWeight(vm.totalTonnage),
          ),
          _buildResultLine(
            context,
            'Obecna ilość (${(vm.fillLevel * 100).toStringAsFixed(0)}%):',
            _formatWeight(vm.filledTonnage),
            isMain: true,
          ),
          const Divider(height: 24),
          _buildResultLine(
            context,
            ' - walec:',
            _formatWeight(vm.cylinderTonnage),
          ),
          _buildResultLine(
            context,
            ' - lejek:',
            _formatWeight(vm.hopperTonnage),
          ),
          const Divider(height: 24),
          _buildResultLine(
            context,
            'Pojemność:',
            '${vm.totalVolume.toStringAsFixed(2)} m³',
          ),
        ],
      ),
    );
  }

  String _formatWeight(double tonnes) {
    if (tonnes < 1.0) {
      return '${(tonnes * 1000).toStringAsFixed(0)} kg';
    }
    return '${tonnes.toStringAsFixed(2)} T';
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
