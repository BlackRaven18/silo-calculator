import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../view_models/silo_view_model.dart';
import '../../core/services/notification_service.dart';
import 'package:silo_calculator/core/services/l10n_service.dart';

class CreateSiloDialog extends StatefulWidget {
  final SiloViewModel vm;

  const CreateSiloDialog({super.key, required this.vm});

  @override
  State<CreateSiloDialog> createState() => _CreateSiloDialogState();
}

class _CreateSiloDialogState extends State<CreateSiloDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!mounted) return;
    _controller = TextEditingController(
      text:
          '${context.l10n.default_silo_name} ${widget.vm.savedSilos.length + 1}',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.l10n.save_silo_dialog_title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.l10n.provide_silo_name),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            autofocus: true,
            decoration: InputDecoration(
              hintText: context.l10n.silo_name_hint,
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
          onPressed: () {
            widget.vm.saveCurrentSilo(name: _controller.text);
            Navigator.pop(context);
            NotificationService.show(context, context.l10n.silo_saved_to_list);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(context.l10n.save.toUpperCase()),
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}
