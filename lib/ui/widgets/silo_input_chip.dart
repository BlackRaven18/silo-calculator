import 'package:flutter/material.dart';
import '../../view_models/silo_view_model.dart';
import '../../core/theme/app_theme.dart';
import 'package:flutter/services.dart';

class DecimalInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text.replaceAll(',', '.');

    if (text.split('.').length > 2) {
      return oldValue;
    }

    final regExp = RegExp(r'^\d*\.?\d{0,2}$');
    if (text.isNotEmpty && !regExp.hasMatch(text)) {
      return oldValue;
    }

    if (text.length > 1 && text.startsWith('0') && text[1] != '.') {
      String newText = text;
      while (newText.length > 1 &&
          newText.startsWith('0') &&
          newText[1] != '.') {
        newText = newText.substring(1);
      }
      return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }

    return newValue.copyWith(text: text);
  }
}

class SiloInputChip extends StatefulWidget {
  final SiloDimension dimension;
  final String label;
  final double value;
  final SiloViewModel vm;
  final Function(double) onChanged;

  const SiloInputChip({
    super.key,
    required this.dimension,
    required this.label,
    required this.value,
    required this.vm,
    required this.onChanged,
  });

  @override
  State<SiloInputChip> createState() => _SiloInputChipState();
}

class _SiloInputChipState extends State<SiloInputChip> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.value.toStringAsFixed(2).replaceAll('.00', ''),
    );
  }

  @override
  void didUpdateWidget(SiloInputChip oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value && !FocusScope.of(context).hasFocus) {
      _controller.text = widget.value.toStringAsFixed(2).replaceAll('.00', '');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFocused = widget.vm.focusedDimension == widget.dimension;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Focus(
      onFocusChange: (hasNextFocus) {
        if (hasNextFocus) {
          widget.vm.setFocusedDimension(widget.dimension);
        } else if (widget.vm.focusedDimension == widget.dimension) {
          widget.vm.setFocusedDimension(SiloDimension.none);
        }
      },
      child: Container(
        width: 130,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: isFocused
              ? AppTheme.primaryColor
              : Theme.of(
                  context,
                ).scaffoldBackgroundColor.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isFocused
                ? AppTheme.accentColor
                : AppTheme.primaryColor.withValues(alpha: 0.3),
            width: isFocused ? 3 : 2,
          ),
          boxShadow: [
            if (isFocused)
              BoxShadow(
                color: AppTheme.primaryColor.withValues(alpha: 0.4),
                blurRadius: 12,
              ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${widget.label}:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isFocused
                    ? Colors.white
                    : (isDark ? Colors.white70 : Colors.grey[700]),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextFormField(
                controller: _controller,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [DecimalInputFormatter()],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: isFocused
                      ? Colors.white
                      : (isDark ? Colors.white : Colors.black),
                ),
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                ),
                onChanged: (text) {
                  if (text.isEmpty) return;
                  final newValue = double.tryParse(text);
                  if (newValue != null && newValue >= 0 && newValue <= 100) {
                    widget.onChanged(newValue);
                  }
                },
              ),
            ),
            Text(
              'm',
              style: TextStyle(
                fontSize: 10,
                color: isFocused ? Colors.white70 : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
