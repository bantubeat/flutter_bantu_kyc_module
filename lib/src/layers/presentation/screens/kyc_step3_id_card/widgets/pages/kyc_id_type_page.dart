part of '../../kyc_step3_id_card_screen.dart';

class _KycIdTypePage extends StatelessWidget {
  final EVerificationMethod selectedVerificationMethod;
  final void Function(EVerificationMethod?) onSelectVerificationMethod;

  final CountryCode? selectedCountry;
  final void Function(CountryCode) onSelectCountry;

  final VoidCallback onNext;

  const _KycIdTypePage({
    required this.selectedVerificationMethod,
    required this.onSelectVerificationMethod,
    required this.selectedCountry,
    required this.onSelectCountry,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KycFormHeader(
                  title: LocaleKeys.kyc_module_step3_type_page_title.tr(),
                  subtitle: LocaleKeys.kyc_module_step3_type_page_description
                      .tr(),
                ),
                const SizedBox(height: 24),
                KycFormCountrySelectField(
                  label: LocaleKeys.kyc_module_step3_nationality.tr(),
                  initialSelection: selectedCountry?.code,
                  onChanged: onSelectCountry,
                ),
                const SizedBox(height: 24),
                KycFormLabel(
                  LocaleKeys.kyc_module_step3_verification_method.tr(),
                ),
                const SizedBox(height: 12),
                VerificationRadioTile<EVerificationMethod>(
                  title: LocaleKeys.kyc_module_step3_id_card.tr(),
                  value: EVerificationMethod.nationalCni,
                  groupValue: selectedVerificationMethod,
                  onChanged: onSelectVerificationMethod,
                ),
                const SizedBox(height: 12),
                VerificationRadioTile<EVerificationMethod>(
                  title: LocaleKeys.kyc_module_step3_passport.tr(),
                  value: EVerificationMethod.passport,
                  groupValue: selectedVerificationMethod,
                  onChanged: onSelectVerificationMethod,
                ),
                const SizedBox(height: 12),
                VerificationRadioTile<EVerificationMethod>(
                  title: LocaleKeys.kyc_module_step3_driving_license.tr(),
                  value: EVerificationMethod.drivingLicense,
                  groupValue: selectedVerificationMethod,
                  onChanged: onSelectVerificationMethod,
                ),
                const Spacer(),
                KycFormPrimaryButton(
                  onPressed: onNext,
                  label: LocaleKeys.kyc_module_common_next.tr(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VerificationRadioTile<T> extends StatelessWidget {
  final String title;
  final T value;
  final T? groupValue;
  final ValueChanged<T?> onChanged;

  const VerificationRadioTile({
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    super.key,
  });

  bool get _selected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => onChanged(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _selected ? Colors.black : const Color(0xFFE2E5EA),
            width: _selected ? 1.6 : 1.2,
          ),
        ),
        child: Row(
          children: [
            _RadioDot(selected: _selected),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RadioDot extends StatelessWidget {
  final bool selected;

  const _RadioDot({required this.selected});

  @override
  Widget build(BuildContext context) {
    const double size = 24;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(
          color: selected ? Colors.black : const Color(0xFFBFD6F5),
          width: selected ? 2.4 : 2,
        ),
      ),
      child: selected
          ? Center(
              child: Container(
                width: size * 0.5,
                height: size * 0.5,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
              ),
            )
          : null,
    );
  }
}
