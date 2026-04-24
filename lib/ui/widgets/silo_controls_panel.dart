import 'package:flutter/material.dart';
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
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.2),
            width: 1.5,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Uprawa: ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppTheme.primaryColor.withValues(alpha: 0.5),
                  ),
                ),
                child: DropdownButton<Grain>(
                  value: vm.selectedGrain,
                  underline: const SizedBox(),
                  onChanged: (grain) => vm.updateGrain(grain!),
                  items: Grain.defaultGrains.map((g) {
                    return DropdownMenuItem(
                      value: g,
                      child: Text(g.name, style: const TextStyle(fontSize: 16)),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(width: 32),
              const Text(
                'Gęstość: ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(width: 12),
              SiloDensityInput(vm: vm),
            ],
          ),
        ],
      ),
    );
  }
}
