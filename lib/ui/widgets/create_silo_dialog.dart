import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../view_models/silo_view_model.dart';
import '../../core/services/notification_service.dart';

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
    _controller = TextEditingController(
      text: 'Silos ${widget.vm.savedSilos.length + 1}',
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
      title: const Text('Zapisz silos'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Podaj nazwę dla tego zapisu:'),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'np. Silos Pszenica 1',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('ANULUJ', style: TextStyle(color: Colors.grey)),
        ),
        ElevatedButton(
          onPressed: () {
            widget.vm.saveCurrentSilo(name: _controller.text);
            Navigator.pop(context);
            NotificationService.show(context, 'Silos został zapisany na liście!');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: const Text('ZAPISZ'),
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}
