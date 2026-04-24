import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/settings_view_model.dart';
import 'package:silo_calculator/core/services/l10n_service.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsViewModel = context.watch<SettingsViewModel>();
    final langCode = settingsViewModel.languageCode;

    return PopupMenuButton<String>(
      icon: Text(
        _getFlag(langCode),
        style: const TextStyle(fontSize: 20),
      ),
      tooltip: context.l10n.language,
      onSelected: (String code) {
        settingsViewModel.setLanguage(code);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'pl',
          child: Row(
            children: [
              Text(_getFlag('pl')),
              const SizedBox(width: 12),
              Text(context.l10n.pl),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'uk',
          child: Row(
            children: [
              Text(_getFlag('uk')),
              const SizedBox(width: 12),
              Text(context.l10n.uk),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'en',
          child: Row(
            children: [
              Text(_getFlag('en')),
              const SizedBox(width: 12),
              Text(context.l10n.en),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'es',
          child: Row(
            children: [
              Text(_getFlag('es')),
              const SizedBox(width: 12),
              Text(context.l10n.es),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'pt',
          child: Row(
            children: [
              Text(_getFlag('pt')),
              const SizedBox(width: 12),
              Text(context.l10n.pt),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'de',
          child: Row(
            children: [
              Text(_getFlag('de')),
              const SizedBox(width: 12),
              Text(context.l10n.de),
            ],
          ),
        ),
      ],
    );
  }

  String _getFlag(String code) {
    switch (code) {
      case 'pl':
        return '🇵🇱';
      case 'uk':
        return '🇺🇦';
      case 'en':
        return '🇬🇧';
      case 'es':
        return '🇪🇸';
      case 'pt':
        return '🇵🇹';
      case 'de':
        return '🇩🇪';
      default:
        return '🌐';
    }
  }
}
