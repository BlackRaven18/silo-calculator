import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class SiloListPanel extends StatelessWidget {
  const SiloListPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          left: BorderSide(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.2),
            width: 1.5,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Silosy',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert, color: AppTheme.primaryColor),
                ),
              ],
            ),
          ),
          Divider(
            height: 1.5,
            thickness: 1.5,
            color: AppTheme.primaryColor.withValues(alpha: 0.3),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Brak zapisanych silosów',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
