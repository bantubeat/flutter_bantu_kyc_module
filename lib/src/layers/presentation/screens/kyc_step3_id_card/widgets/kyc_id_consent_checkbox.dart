part of '../kyc_step3_id_card_screen.dart';

class _KycIdConsentCheckbox extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool?> onChanged;

  const _KycIdConsentCheckbox({
    required this.isChecked,
    required this.onChanged,
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
          child: GestureDetector(
            onTap: () => onChanged(!isChecked),
            child: Text(
              LocaleKeys.kyc_module_step3_warning.tr(),
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}
