part of 'kyc_step2_address_screen.dart';

class Step2Controller extends ScreenController {
  final KycFormDataStep1 previousData;
  final streetCtrl = TextEditingController();
  final cityCtrl = TextEditingController();
  final postalCodeCtrl = TextEditingController();
  CountryCode? selectedCountry;

  Step2Controller(super.state, {required this.previousData})
    : selectedCountry = CountryCode.tryFromCountryCode(
        previousData.currentUser.pays,
      );

  @protected
  @override
  void onDispose() {
    streetCtrl.dispose();
    cityCtrl.dispose();
    postalCodeCtrl.dispose();
  }

  void selectCountry(CountryCode country) {
    selectedCountry = country;
    refreshUI();
  }

  void onNext() {
    final street = streetCtrl.text;
    final city = cityCtrl.text;
    final postalCode = postalCodeCtrl.text;
    final country = selectedCountry;
    if (country != null &&
        street.isNotEmpty &&
        city.isNotEmpty &&
        postalCode.isNotEmpty) {
      final kycFormData = KycFormDataStep2(
        previousData: previousData,
        street: street,
        city: city,
        postalCode: postalCode,
        country: country,
      );
      Modular.get<KycRoutes>().step3.push(kycFormData);
    } else {
      UiAlertHelpers.showErrorSnackBar(
        context,
        LocaleKeys.kyc_module_common_all_fields_required.tr(),
      );
    }
  }
}
