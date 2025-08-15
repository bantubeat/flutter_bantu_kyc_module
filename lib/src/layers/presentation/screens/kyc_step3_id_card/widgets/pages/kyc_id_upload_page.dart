import 'package:flutter/material.dart';
import 'package:flutter_bantu_kyc_module/src/core/generated/locale_keys.g.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/localization/string_translate_extension.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_header.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_primary_button.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_upload_box.dart';

import '../../kyc_step3_id_controller.dart';
import '../kyc_id_consent_checkbox.dart';

// 2. ID Upload Screen (for both Recto and Verso)
class KycIdUploadPage extends StatelessWidget {
  final bool isRecto;
  final KycStep3IdController controller;

  const KycIdUploadPage({
    required this.isRecto,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final image = isRecto ? controller.rectoIdImage : controller.versoIdImage;
    final consentChecked = isRecto
        ? controller.rectoConsentChecked
        : controller.versoConsentChecked;
    final title = isRecto ? 'Carte Identité (Recto)' : 'Carte Identité (Verso)';
    final subtitle = isRecto
        ? 'Charger une image lissible du recto de votre carte d’identité'
        : 'Charger une image lissible du verso de votre carte d’identité';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KycFormHeader(title: title, subtitle: subtitle),
        const SizedBox(height: 24),
        KycFormUploadBox(
          label: LocaleKeys.kyc_module_step3_load_image.tr(),
          image: image,
          onTap: () => controller.pickIdImage(isRecto),
        ),
        const SizedBox(height: 24),
        KycIdConsentCheckbox(
          isChecked: consentChecked,
          onChanged: (value) =>
              controller.toggleConsent(isRecto: isRecto, value: value),
        ),
        const Spacer(),
        KycFormPrimaryButton(onPressed: controller.onNext),
      ],
    );
  }
}
