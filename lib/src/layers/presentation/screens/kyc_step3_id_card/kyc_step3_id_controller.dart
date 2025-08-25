part of 'kyc_step3_id_card_screen.dart';

/// Manages the state and logic for the entire KYC identity flow.
class _KycStep3IdController extends ScreenController {
  final KycFormDataStep2 step2Data;
  final pageCtrl = PageController();
  // State for the first screen
  var selectedVerificationMethod = EVerificationMethod.nationalCni;
  CountryCode? selectedCountry;

  // State for the second screen (Recto)
  XFile? _rectoIdImageXFile;
  ImageProvider? rectoIdImage;
  bool rectoConsentChecked = false;

  // State for the third screen (Verso)
  XFile? _versoIdImageXFile;
  ImageProvider? versoIdImage;
  bool versoConsentChecked = false;

  _KycStep3IdController(super.state, this.step2Data) : super() {
    // Initialize the selected country from step 2 data
    selectedCountry = step2Data.country;
  }

  // --- Resource handling ---

  @override
  @protected
  void onDispose() {
    pageCtrl.dispose();
  }

  // --- Logic ---

  // Method to select a verification method
  void selectVerificationMethod(EVerificationMethod? value) {
    if (value != null) {
      selectedVerificationMethod = value;
      refreshUI();
    }
  }

  // Method to select a country
  void selectCountry(CountryCode countryCode) {
    selectedCountry = countryCode;
    refreshUI();
  }

  void pickIdImage({required bool isRecto}) {
    if (isRecto) {
      _pickImage((image) async {
        _rectoIdImageXFile = image;
        rectoIdImage = await image.toImageProvider();
        refreshUI();
      });
    } else {
      _pickImage((image) async {
        _versoIdImageXFile = image;
        versoIdImage = await image.toImageProvider();
        refreshUI();
      });
    }
  }

  // Method to pick an image from the gallery
  Future<void> _pickImage(Function(XFile) onImagePicked) async {
    ImagePickerHelper.showPickImage(
      context,
      onImagePicked: (image) {
        if (image != null) onImagePicked(image);
      },
    );
  }

  // Method to toggle the consent checkbox
  void toggleConsent({required bool isRecto, bool? value}) {
    if (isRecto) {
      rectoConsentChecked = value ?? false;
    } else {
      versoConsentChecked = value ?? false;
    }
    refreshUI();
  }

  void onNext() {
    final currentPage = pageCtrl.page;
    if (currentPage == null) return;
    if (currentPage == 1 && !rectoConsentChecked) {
      UiAlertHelpers.showErrorSnackBar(
        context,
        LocaleKeys.kyc_module_step3_consent_not_checked.tr(),
      );
      return;
    }

    if (currentPage == 2 && !versoConsentChecked) {
      UiAlertHelpers.showErrorSnackBar(
        context,
        LocaleKeys.kyc_module_step3_consent_not_checked.tr(),
      );
      return;
    }

    if (currentPage < 2) {
      pageCtrl.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    } else {
      _onValidate(); // it's last page
    }
  }

  void _onValidate() async {
    final country = selectedCountry;
    final rectoIdImageXFile = _rectoIdImageXFile;
    final versoIdImageXFile = _versoIdImageXFile;
    if (country != null &&
        rectoIdImageXFile != null &&
        versoIdImageXFile != null) {
      final kycFormData = KycFormDataStep3(
        step2Data: step2Data,
        idCountry: country,
        verificationMethod: selectedVerificationMethod,
        rectoIdImage: rectoIdImageXFile,
        versoIdImage: versoIdImageXFile,
      );

      Modular.get<KycRoutes>().step5a.push(KycFormDataStep4(kycFormData));
    } else {
      UiAlertHelpers.showErrorSnackBar(
        context,
        LocaleKeys.kyc_module_common_all_fields_required.tr(),
      );
    }
  }
}
