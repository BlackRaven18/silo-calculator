import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/settings_view_model.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const MainAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final settingsViewModel = context.read<SettingsViewModel>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: preferredSize.height,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => settingsViewModel.toggleTheme(),
            icon: Icon(
              isDark
                  ? Icons.wb_sunny_outlined
                  : Icons.nightlight_round_outlined,
            ),
            tooltip: isDark ? 'Tryb jasny' : 'Tryb ciemny',
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
