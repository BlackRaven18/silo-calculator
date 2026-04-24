import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/settings_view_model.dart';
import 'package:silo_calculator/core/services/l10n_service.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showMenuButton;
  final bool showDrawerButton;

  const MainAppBar({
    super.key,
    required this.title,
    this.showMenuButton = false,
    this.showDrawerButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final settingsViewModel = context.watch<SettingsViewModel>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final langCode = settingsViewModel.languageCode;

    return Container(
      height: preferredSize.height,
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
          if (showDrawerButton)
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.settings_suggest_outlined),
              tooltip: context.l10n.language,
            ),
          if (showDrawerButton) const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
          ),
          IconButton(
            onPressed: () => settingsViewModel.toggleTheme(),
            icon: Icon(
              isDark
                  ? Icons.wb_sunny_outlined
                  : Icons.nightlight_round_outlined,
            ),
            tooltip: isDark
                ? context.l10n.theme_light
                : context.l10n.theme_dark,
          ),
          IconButton(
            onPressed: () =>
                settingsViewModel.setLanguage(langCode == 'pl' ? 'en' : 'pl'),
            icon: const Icon(Icons.language),
            tooltip: context.l10n.language,
          ),
          if (showMenuButton)
            IconButton(
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              icon: const Icon(Icons.menu_open),
              tooltip: context.l10n.my_silos,
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
