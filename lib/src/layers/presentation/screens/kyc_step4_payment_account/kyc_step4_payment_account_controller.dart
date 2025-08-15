import 'package:country_code_picker/country_code_picker.dart' show CountryCode;
import 'package:flutter/material.dart' show ImageProvider;
import 'package:flutter_bantu_kyc_module/flutter_bantu_kyc_module.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/helpers/image_picker_helper.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screen_controller/flutter_screen_controller.dart';
import 'package:image_picker/image_picker.dart' show XFile;

enum EAccountType { mobile, bank }

class KycStep4PaymentAccountController extends ScreenController {
  EAccountType? selectedAccountType = EAccountType.mobile;
  CountryCode? selectedPaymentCountry;

  XFile? _bankDocumentXFile;
  ImageProvider? bankDocument;

  KycStep4PaymentAccountController(super.state);

  void selectPaymentCountry(CountryCode countryCode) {
    selectedPaymentCountry = countryCode;
    refreshUI();
  }

  void setAccountType(EAccountType type) {
    selectedAccountType = type;
    refreshUI();
  }

  void pickBankDocument() {
    ImagePickerHelper.showPickImage(
      context,
      onImagePicked: (image) async {
        if (image != null) {
          _bankDocumentXFile = image;
          bankDocument = await image.toImageProvider();
          refreshUI();
        }
      },
    );
  }

  void onValidate() {
    Modular.get<KycRoutes>().step5a.push();
  }
}
