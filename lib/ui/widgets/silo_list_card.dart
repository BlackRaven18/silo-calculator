import 'package:flutter/material.dart';
import '../../models/silo.dart';
import '../../core/theme/app_theme.dart';

class SiloListCard extends StatelessWidget {
  final Silo silo;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const SiloListCard({
    super.key,
    required this.silo,
    required this.onTap,
    required this.onDelete,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppTheme.primaryColor : AppTheme.primaryColor.withValues(alpha: 0.1),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected 
                  ? AppTheme.primaryColor.withValues(alpha: 0.1) 
                  : Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                silo.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.redAccent,
                  size: 20,
                ),
                onPressed: onDelete,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.grain, size: 14, color: AppTheme.accentColor),
              const SizedBox(width: 6),
              Text(
                silo.grainName,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
          const Divider(height: 24),
          _buildInfoRow('Max:', _formatWeight(silo.maxTonnage), isBold: false),
          const SizedBox(height: 4),
          _buildInfoRow(
            'Obecnie (${(silo.fillLevel * 100).toStringAsFixed(0)}%):',
            _formatWeight(silo.tonnage),
            isBold: true,
          ),
          const SizedBox(height: 12),
          Text(
            'r: ${silo.radius}m, h1: ${silo.cylinderHeight}m, h2: ${silo.hopperHeight}m',
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    ),
   );
  }

  Widget _buildInfoRow(String label, String value, {required bool isBold}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isBold ? AppTheme.primaryColor : null,
            fontSize: isBold ? 16 : 14,
          ),
        ),
      ],
    );
  }

  String _formatWeight(double tonnes) {
    if (tonnes < 1.0) {
      return '${(tonnes * 1000).toStringAsFixed(0)} kg';
    }
    return '${tonnes.toStringAsFixed(2)} T';
  }
}
