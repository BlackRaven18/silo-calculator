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
            'Ilość zboża:',
            '${vm.totalTonnage.toStringAsFixed(2)} T',
            isMain: true,
          ),
          _buildResultLine(
            context,
            ' - walec:',
            '${vm.cylinderTonnage.toStringAsFixed(2)} T',
          ),
          _buildResultLine(
            context,
            ' - lejek:',
            '${vm.hopperTonnage.toStringAsFixed(2)} T',
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
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isMain ? 17 : 15,
              fontWeight: isMain ? FontWeight.bold : FontWeight.normal,
              color: labelColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isMain ? 22 : 18,
              fontWeight: FontWeight.w900,
              color: isMain ? AppTheme.primaryColor : valueColor,
            ),
          ),
        ],
      ),
    );
  }
}
