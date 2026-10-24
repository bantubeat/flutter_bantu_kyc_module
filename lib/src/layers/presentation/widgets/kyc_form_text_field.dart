import 'package:flutter/material.dart';

import 'kyc_form_label.dart';

class KycFormTextField extends StatelessWidget {
  final String label;
  final bool readOnly;
  final TextEditingController controller;
  final VoidCallback? onTap;

  const KycFormTextField({
    required this.label,
    required this.controller,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KycFormLabel(label),
        const SizedBox(height: 8),
        TextField(
          readOnly: readOnly,
          controller: controller,
          onTap: onTap,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.black, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
