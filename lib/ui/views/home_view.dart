import 'package:flutter/material.dart';
import '../core/base_scaffold.dart';
import '../widgets/silo_canvas.dart';
import '../widgets/silo_controls_panel.dart';
import '../widgets/silo_summary_panel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BaseScaffold(
      body: Row(
        children: [
          _buildControlsSidebar(context),

          // Main Drawing Area
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
        ],
      ),
    );
  }

  Widget _buildControlsSidebar(BuildContext context) {
    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        border: Border(
          right: BorderSide(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: const Column(
        children: [
          SiloSummaryPanel(),
          Divider(height: 1),
          SizedBox(height: 24),
          SiloControlsPanel(),
        ],
      ),
    );
  }
}
