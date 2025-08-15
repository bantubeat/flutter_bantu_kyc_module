import 'package:flutter/material.dart';

class KycFormLabel extends StatelessWidget {
  final String text;

  const KycFormLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black54,
      ),
    );
  }
}
