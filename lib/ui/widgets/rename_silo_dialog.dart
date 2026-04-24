import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../view_models/silo_view_model.dart';
import '../../core/services/notification_service.dart';
import 'package:silo_calculator/core/services/l10n_service.dart';

class RenameSiloDialog extends StatefulWidget {
  final SiloViewModel vm;

  const RenameSiloDialog({super.key, required this.vm});

  @override
  State<RenameSiloDialog> createState() => _RenameSiloDialogState();
}

class _RenameSiloDialogState extends State<RenameSiloDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.vm.selectedSilo?.name);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.l10n.rename_silo),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.l10n.provide_new_name),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            autofocus: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppTheme.primaryColor,
                  width: 2,
                ),
              ),
            ),
            onSubmitted: (_) => _confirm(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            context.l10n.cancel.toUpperCase(),
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        ElevatedButton(
          onPressed: _confirm,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(context.l10n.change.toUpperCase()),
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }

  void _confirm() {
    if (_controller.text.isNotEmpty) {
      widget.vm.renameSelectedSilo(_controller.text);
      Navigator.pop(context);
      NotificationService.show(
        context,
        '${context.l10n.name_changed_to}${_controller.text}',
      );
    }
  }
}
