import 'package:flutter/material.dart';
import 'package:silo_calculator/core/services/l10n_service.dart';
import 'package:provider/provider.dart';
import '../../view_models/silo_view_model.dart';
import '../../core/theme/app_theme.dart';
import '../../models/grain.dart';
import 'silo_density_input.dart';

class SiloControlsPanel extends StatelessWidget {
  const SiloControlsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SiloViewModel>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.crop,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppTheme.primaryColor.withValues(alpha: 0.5),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<Grain>(
                value: vm.selectedGrain,
                onChanged: (grain) => vm.updateGrain(grain!),
                items: Grain.defaultGrains.map((g) {
                  return DropdownMenuItem(
                    value: g,
                    child: Text(context.l10n.getLocalizedGrainName(g.name), style: const TextStyle(fontSize: 16)),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            context.l10n.density,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          SiloDensityInput(vm: vm),
        ],
      ),
    );
  }
}
