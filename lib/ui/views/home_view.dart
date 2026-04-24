import 'package:flutter/material.dart';
import '../core/base_scaffold.dart';
import '../widgets/silo_canvas.dart';
import '../widgets/silo_controls_panel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BaseScaffold(
      body: Column(
        children: [
          // Main Drawing Area with Interactive Labels
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.black26
                    : Colors.black.withValues(alpha: 0.02),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
                ),
              ),
              child: const SiloCanvas(),
            ),
          ),

          const SiloControlsPanel(),
        ],
      ),
    );
  }
}
