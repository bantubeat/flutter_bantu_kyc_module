part of '../../kyc_step3_id_card_screen.dart';

class _KycIdTypePage extends StatelessWidget {
  final _KycStep3IdController controller;

  const _KycIdTypePage({required this.controller});

  @override
  Widget build(BuildContext context) {
    return RadioGroup(
      groupValue: controller.selectedVerificationMethod,
      onChanged: controller.selectVerificationMethod,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KycFormHeader(
            title: LocaleKeys.kyc_module_step3_type_page_title.tr(),
            subtitle: LocaleKeys.kyc_module_step3_type_page_description.tr(),
          ),
          const SizedBox(height: 24),
          KycFormCountrySelectField(
            label: LocaleKeys.kyc_module_step3_nationality.tr(),
            initialSelection: controller.selectedCountry?.code ?? 'CM',
            onChanged: controller.selectCountry,
          ),
          const SizedBox(height: 24),
          KycFormLabel(LocaleKeys.kyc_module_step3_verification_method.tr()),
          _VerificationRadioTile(
            title: LocaleKeys.kyc_module_step3_id_card.tr(),
            value: EVerificationMethod.nationalCni,
          ),
          _VerificationRadioTile(
            title: LocaleKeys.kyc_module_step3_passport.tr(),
            value: EVerificationMethod.passport,
          ),
          _VerificationRadioTile(
            title: LocaleKeys.kyc_module_step3_driving_license.tr(),
            value: EVerificationMethod.drivingLicense,
          ),
          const Spacer(),
          KycFormPrimaryButton(onPressed: controller.onNext),
        ],
      ),
    );
  }
}

class _VerificationRadioTile<EVerificationMethod> extends StatelessWidget {
  final String title;
  final EVerificationMethod value;

  const _VerificationRadioTile({
    required this.title,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<EVerificationMethod>(
      title: Text(title),
      value: value,
      activeColor: Theme.of(context).colorScheme.primary,
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
    );
  }
}
