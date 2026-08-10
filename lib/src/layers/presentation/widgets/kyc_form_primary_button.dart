import 'package:flutter/material.dart';
import 'package:flutter_bantu_kyc_module/src/core/generated/locale_keys.g.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/localization/string_translate_extension.dart';

class KycFormPrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? label;

  const KycFormPrimaryButton({required this.onPressed, this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          elevation: 2,
        ),
        child: Text(
          label ?? LocaleKeys.kyc_module_common_validate.tr(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
