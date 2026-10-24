part of '../kyc_step3_id_card_screen.dart';

class KycIdConsentCheckbox extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool?> onChanged;

  const KycIdConsentCheckbox({
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
          activeColor: Colors.black,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => onChanged(!isChecked),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: LocaleKeys.kyc_module_step3_warning.tr()),
                  // The whole sentence holding the link is hidden when the
                  // host app does not provide the legal URLs.
                  if (LegalLinks.isAvailable) ...[
                    const TextSpan(text: ' '),
                    TextSpan(
                      text: LocaleKeys.kyc_module_step3_warning_privacy_intro
                          .tr(),
                    ),
                    LegalLinks.span(
                      context,
                      KycLegalDoc.privacy,
                      text: LocaleKeys.kyc_module_step3_warning_privacy_link
                          .tr(),
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    TextSpan(
                      text: LocaleKeys.kyc_module_step3_warning_privacy_end
                          .tr(),
                    ),
                  ],
                ],
              ),
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}
