import 'package:flutter/material.dart';

Widget buildTextFieldWithLabel({
  required String label,
  required String value,
  required bool isRTL,
}) {
  return Container(
    height: 50,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: Colors.amber.shade700),
    ),
    child: Row(
      textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 14),
        ),
        const Spacer(),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.amber.shade700,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
