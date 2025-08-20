part of 'kyc_step2_address_screen.dart';

class Step2Controller extends ScreenController {
  final KycFormDataStep1 previousData;
  final streetCtrl = TextEditingController();
  final cityCtrl = TextEditingController();
  final postalCodeCtrl = TextEditingController();
  CountryCode? _selectedCountry;

  Step2Controller(super.state, {required this.previousData});

  void selectCountry(CountryCode country) {
    _selectedCountry = country;
    refreshUI();
  }

  void onNext() {
    final street = streetCtrl.text;
    final city = cityCtrl.text;
    final postalCode = postalCodeCtrl.text;
    final country = _selectedCountry;
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
      UiAlertHelpers.showErrorSnackBar(context, 'Tous les champs sont requis');
    }
  }
}
