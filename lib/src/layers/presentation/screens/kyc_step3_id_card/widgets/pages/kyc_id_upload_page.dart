part of '../../kyc_step3_id_card_screen.dart';

// 2. ID Upload Screen (for both Recto and Verso)
class _KycIdUploadPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isConsentChecked;
  final VoidCallback onPickIdImage;
  final ImageProvider<Object>? pickedImage;
  final void Function(bool?) onToggleConsent;
  final VoidCallback onNext;

  const _KycIdUploadPage({
    required this.title,
    required this.subtitle,
    required this.isConsentChecked,
    required this.pickedImage,
    required this.onPickIdImage,
    required this.onToggleConsent,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KycFormHeader(title: title, subtitle: subtitle),
            const SizedBox(height: 24),
            KycFormUploadBox(
              label: LocaleKeys.kyc_module_step3_load_image.tr(),
              image: pickedImage,
              onTap: onPickIdImage,
            ),
            const SizedBox(height: 24),
            _KycIdConsentCheckbox(
              isChecked: isConsentChecked,
              onChanged: onToggleConsent,
            ),
            const Spacer(),
            KycFormPrimaryButton(onPressed: onNext),
          ],
        ),
      ),
    );
  }
}
