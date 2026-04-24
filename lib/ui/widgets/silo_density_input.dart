import 'package:flutter/material.dart';
import '../../view_models/silo_view_model.dart';
import './silo_input_chip.dart';
import '../../core/theme/app_theme.dart';

class SiloDensityInput extends StatefulWidget {
  final SiloViewModel vm;

  const SiloDensityInput({super.key, required this.vm});

  @override
  State<SiloDensityInput> createState() => _SiloDensityInputState();
}

class _SiloDensityInputState extends State<SiloDensityInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.vm.customDensity.toStringAsFixed(0),
    );
  }

  @override
  void didUpdateWidget(SiloDensityInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.vm.customDensity != widget.vm.customDensity &&
        !FocusScope.of(context).hasFocus) {
      _controller.text = widget.vm.customDensity.toStringAsFixed(0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.5)),
      ),
      child: TextFormField(
        controller: _controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [DecimalInputFormatter()],
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          suffixText: ' kg/m³',
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 12),
          border: InputBorder.none,
        ),
        onChanged: (text) {
          if (text.isEmpty) return;
          final newValue = double.tryParse(text);
          if (newValue != null && newValue > 0) {
            widget.vm.updateDensity(newValue);
          }
        },
      ),
    );
  }
}
