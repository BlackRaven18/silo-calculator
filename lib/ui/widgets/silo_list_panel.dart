import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/silo_view_model.dart';
import '../../core/theme/app_theme.dart';
import 'silo_summary_panel.dart';
import 'silo_list_card.dart';

class SiloListPanel extends StatelessWidget {
  const SiloListPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SiloViewModel>();
    final savedSilos = vm.savedSilos;

    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        border: Border(
          left: BorderSide(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Real-time Results Section
          const SiloSummaryPanel(),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withValues(alpha: 0.05),
              border: Border(
                bottom: BorderSide(color: Theme.of(context).dividerColor.withValues(alpha: 0.1)),
                top: BorderSide(color: Theme.of(context).dividerColor.withValues(alpha: 0.1)),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.inventory_2, color: AppTheme.primaryColor, size: 20),
                const SizedBox(width: 12),
                const Text(
                  'MOJE SILOSY',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${savedSilos.length}',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: savedSilos.isEmpty
                ? _buildEmptyState()
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: savedSilos.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final silo = savedSilos[index];
                      return SiloListCard(
                        silo: silo,
                        onDelete: () => vm.deleteSilo(silo.id),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.unarchive_outlined, size: 64, color: Colors.grey.withValues(alpha: 0.3)),
        const SizedBox(height: 16),
        const Text(
          'Brak zapisanych silosów',
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        const Text(
          'Skonfiguruj parametry i kliknij Zapisz',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }

}
