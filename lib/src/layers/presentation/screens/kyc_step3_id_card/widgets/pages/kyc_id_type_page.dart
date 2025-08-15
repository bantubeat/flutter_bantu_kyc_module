import 'package:flutter/material.dart';
import 'package:flutter_bantu_kyc_module/src/core/generated/locale_keys.g.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/localization/string_translate_extension.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_country_select_field.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_header.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_label.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_primary_button.dart';

import '../../kyc_step3_id_controller.dart';

class KycIdTypePage extends StatelessWidget {
  final KycStep3IdController controller;

  const KycIdTypePage({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
          groupValue: controller.selectedVerificationMethod,
          onChanged: controller.selectVerificationMethod,
          value: EVerificationMethod.nationalCni,
        ),
        _VerificationRadioTile(
          title: LocaleKeys.kyc_module_step3_passport.tr(),
          groupValue: controller.selectedVerificationMethod,
          onChanged: controller.selectVerificationMethod,
          value: EVerificationMethod.passport,
        ),
        _VerificationRadioTile(
          title: LocaleKeys.kyc_module_step3_driving_license.tr(),
          groupValue: controller.selectedVerificationMethod,
          onChanged: controller.selectVerificationMethod,
          value: EVerificationMethod.drivingLicense,
        ),
        const Spacer(),
        KycFormPrimaryButton(onPressed: controller.onNext),
      ],
    );
  }
}

class _VerificationRadioTile<EVerificationMethod> extends StatelessWidget {
  final String title;
  final EVerificationMethod value;
  final EVerificationMethod groupValue;
  final void Function(EVerificationMethod?)? onChanged;

  const _VerificationRadioTile({
    required this.title,
    required this.value,
    required this.groupValue,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<EVerificationMethod>(
      title: Text(title),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      activeColor: Theme.of(context).colorScheme.primary,
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
    );
  }
}
