import 'package:country_code_picker/country_code_picker.dart' show CountryCode;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'
    show ImageProvider, PageController, Curves;
import 'package:flutter_bantu_kyc_module/flutter_bantu_kyc_module.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/helpers/image_picker_helper.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screen_controller/flutter_screen_controller.dart';
import 'package:image_picker/image_picker.dart';

enum EVerificationMethod { passport, nationalCni, drivingLicense }

/// Manages the state and logic for the entire KYC identity flow.
class KycStep3IdController extends ScreenController {
  late PageController pageCtrl;
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

  KycStep3IdController(super.state);

  // --- Resource handling ---

  @override
  @protected
  void onInit() {
    pageCtrl = PageController();
  }

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

  void pickIdImage(bool isRecto) {
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
    if (currentPage == 2) return _onValidate(); // it's last page

    pageCtrl.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  void _onValidate() async {
    Modular.get<KycRoutes>().step4.push();
  }
}
