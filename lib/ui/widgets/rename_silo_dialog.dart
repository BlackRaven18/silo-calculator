import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../view_models/silo_view_model.dart';
import '../../core/services/notification_service.dart';

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
      title: const Text('Zmień nazwę'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Podaj nową nazwę:'),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            autofocus: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
              ),
            ),
            onSubmitted: (_) => _confirm(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('ANULUJ', style: TextStyle(color: Colors.grey)),
        ),
        ElevatedButton(
          onPressed: _confirm,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: const Text('ZMIEŃ'),
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
        'Nazwa została zmieniona na: ${_controller.text}',
      );
    }
  }
}
