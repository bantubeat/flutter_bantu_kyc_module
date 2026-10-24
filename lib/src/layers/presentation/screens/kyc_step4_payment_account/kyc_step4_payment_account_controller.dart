import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/foundation.dart' show protected;
import 'package:flutter/material.dart'
    show ImageProvider, TextEditingController;
import 'package:flutter_bantu_kyc_module/flutter_bantu_kyc_module.dart';
import 'package:flutter_bantu_kyc_module/src/core/generated/locale_keys.g.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/helpers/image_picker_helper.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/helpers/ui_alert_helpers.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/localization/string_translate_extension.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screen_controller/flutter_screen_controller.dart';
import 'package:image_picker/image_picker.dart' show XFile;

import '../../ui_models/kyc_form_data.dart';
import '../../widgets/account_type_modal.dart';

class KycStep4PaymentAccountController extends ScreenController {
  final KycFormDataStep3 step3Data;
  bool selectedAccountTypeIsCompany;
  CountryCode? selectedCountry;
  void selectCountry(CountryCode countryCode) {
    selectedCountry = countryCode;
    refreshUI();
  }

  final companyRegistrationNumberCtrl = TextEditingController(text: '');
  final companyTvaCtrl = TextEditingController(text: '');
  final companyNameCtrl = TextEditingController(text: '');

  XFile? _fiscalDocumentXFile;
  ImageProvider? fiscalDocumentt;

  KycStep4PaymentAccountController(super.state, this.step3Data)
    : selectedAccountTypeIsCompany =
          step3Data.step2Data.previousData.accountType.isCompany {
    selectedCountry = step3Data.idCountry;
  }

  @protected
  @override
  void onDispose() {
    companyRegistrationNumberCtrl.dispose();
    companyTvaCtrl.dispose();
  }

  void setAccountType(bool isCompany) {
    selectedAccountTypeIsCompany = isCompany;
    refreshUI();
  }

  void pickFiscalDocument() {
    ImagePickerHelper.showPickImage(
      context,
      onImagePicked: (image) async {
        if (image != null) {
          _fiscalDocumentXFile = image;
          fiscalDocumentt = await image.toImageProvider();
          refreshUI();
        }
      },
    );
  }

  void onNext() {
    if ((selectedAccountTypeIsCompany && companyTvaCtrl.text.isEmpty) ||
        (selectedAccountTypeIsCompany && companyNameCtrl.text.isEmpty) ||
        companyRegistrationNumberCtrl.text.isEmpty) {
      return UiAlertHelpers.showErrorSnackBar(
        context,
        LocaleKeys.kyc_module_common_all_fields_required.tr(),
      );
    }

    if (_fiscalDocumentXFile == null) {
      return UiAlertHelpers.showErrorToast(
        'Veuillez sélectionner un document fiscal pour votre entreprise.',
      );
    }

    final kycFormData = KycFormDataStep4(
      step3Data: step3Data,
      isCompany: selectedAccountTypeIsCompany,
      companyRegistrationNumber: companyRegistrationNumberCtrl.text,
      companyTva: companyTvaCtrl.text,
      companyName: companyNameCtrl.text,
      fiscalDocument: _fiscalDocumentXFile,
    );

    Modular.get<KycRoutes>().step5a.push(kycFormData);
  }
}
