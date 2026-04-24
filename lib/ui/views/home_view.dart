import 'package:flutter/material.dart';
import '../core/base_scaffold.dart';
import '../../core/theme/app_theme.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.agriculture,
                size: 100,
                color: AppTheme.primaryColor.withValues(alpha: 0.2),
              ),
              const SizedBox(height: 16),
              const Text(
                'Kalkulator silosów',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Wybierz silos lub dodaj nowy, aby rozpocząć obliczenia',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
