import 'package:flutter/material.dart';
import 'app_bar.dart';
import '../widgets/silo_list_panel.dart';

class BaseScaffold extends StatelessWidget {
  final Widget body;
  final String title;

  const BaseScaffold({
    super.key,
    required this.body,
    this.title = 'Kalkulator pojemności silosów',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MainAppBar(title: title),
          Expanded(
            child: Row(
              children: [
                Expanded(child: body),
                const SiloListPanel(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
