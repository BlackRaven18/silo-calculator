import 'package:flutter/material.dart';
import '../../models/silo.dart';
import '../../core/theme/app_theme.dart';

class SiloListCard extends StatelessWidget {
  final Silo silo;
  final VoidCallback onDelete;

  const SiloListCard({
    super.key,
    required this.silo,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Łącznie:',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                '${silo.tonnage.toStringAsFixed(2)} T',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'r: ${silo.radius}m, h1: ${silo.cylinderHeight}m, h2: ${silo.hopperHeight}m',
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
