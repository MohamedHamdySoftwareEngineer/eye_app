import 'package:flutter/material.dart';
import 'package:eye/core/utils/styles.dart';

class OptionBox extends StatelessWidget {
  const OptionBox({
    super.key,
    required this.text,
    this.onTap,
    this.icon,
    this.color,
  });

  final String text;
  final VoidCallback? onTap;
  final IconData? icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final containerColor = color ?? Colors.white;
    final borderColor = (color ?? const Color(0xFFB28B67)).withOpacity(0.5);

    return GestureDetector(
      onTap: onTap,
      child: RepaintBoundary(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: borderColor, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 22,
                  color: Styles.brownWithoutShadow18.color,
                ),
                const SizedBox(width: 10),
              ],
              Text(text, style: Styles.brownWithoutShadow18),
            ],
          ),
        ),
      ),
    );
  }
}
