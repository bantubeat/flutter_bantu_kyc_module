part of '../../kyc_step3_id_card_screen.dart';

// 2. ID Upload Screen (for both Recto and Verso)
class _KycIdUploadPage extends StatelessWidget {
  final bool isRecto;
  final _KycStep3IdController controller;

  const _KycIdUploadPage({required this.isRecto, required this.controller});

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
        _KycIdConsentCheckbox(
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
