import 'package:flutter/material.dart';
import 'app_bar.dart';
import '../widgets/silo_list_panel.dart';

class BaseScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final Widget? drawer;
  final bool showDrawerButton;

  const BaseScaffold({
    super.key,
    required this.body,
    this.title = 'Kalkulator pojemności silosów',
    this.drawer,
    this.showDrawerButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isDesktop = width > 1100;

    return Scaffold(
      drawer: drawer,
      endDrawer: isDesktop ? null : const SiloListPanel(),
      body: Column(
        children: [
          MainAppBar(
            title: title,
            showMenuButton: !isDesktop,
            showDrawerButton: showDrawerButton && !isDesktop,
          ),
          Expanded(
            child: Row(
              children: [
                if (isDesktop && drawer != null) drawer!,
                Expanded(child: body),
                if (isDesktop) const SiloListPanel(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
