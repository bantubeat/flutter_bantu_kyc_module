import 'package:flutter/material.dart';
import 'package:flutter_bantu_kyc_module/src/core/generated/locale_keys.g.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/localization/string_translate_extension.dart';

class KycIdConsentCheckbox extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool?> onChanged;

  const KycIdConsentCheckbox({
    required this.isChecked,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: isChecked,
          onChanged: onChanged,
          activeColor: Theme.of(context).colorScheme.primary,
        ),
        Expanded(
          child: Text(
            LocaleKeys.kyc_module_step3_warning.tr(),
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
