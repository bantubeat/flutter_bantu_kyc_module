import 'package:country_code_picker/country_code_picker.dart' show CountryCode;
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

class KycStep4PaymentAccountController extends ScreenController {
  final KycFormDataStep3 step3Data;
  EAccountType selectedAccountType = EAccountType.mobile;

  // Mobile account fields
  // Note: Mobile operator and account number are used for mobile accounts only
  CountryCode? selectedPaymentCountry;
  final mobileOperatorCtrl = TextEditingController(text: '');
  final mobileAccountNumberCtrl = TextEditingController(text: '');

  // Bank account fields
  // Note: Bank name, account number, and SWIFT code are not used for mobile
  final bankNameCtrl = TextEditingController(text: '');
  final bankAccountNumberCtrl = TextEditingController(text: '');
  final bankAccountNumberConfirmCtrl = TextEditingController(text: '');
  final bankSwiftCodeCtrl = TextEditingController(text: '');

  // Common for both mobile and bank accounts
  final accountHolderNameCtrl = TextEditingController(text: '');

  XFile? _bankDocumentXFile;
  ImageProvider? bankDocument;

  KycStep4PaymentAccountController(super.state, this.step3Data);

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

  KycFormDataStep4? _validateMobileAccountInfos() {
    final country = selectedPaymentCountry;
    if (country == null) {
      UiAlertHelpers.showErrorSnackBar(
        context,
        LocaleKeys.kyc_module_common_field_required.tr(
          namedArgs: {'field': LocaleKeys.kyc_module_common_country.tr()},
        ),
      );
      return null;
    }

    if (mobileOperatorCtrl.text.isEmpty) {
      UiAlertHelpers.showErrorSnackBar(
        context,
        LocaleKeys.kyc_module_common_field_required.tr(
          namedArgs: {
            'field': LocaleKeys.kyc_module_step4_mobile_operator_name.tr(),
          },
        ),
      );
      return null;
    }
    if (mobileAccountNumberCtrl.text.isEmpty) {
      UiAlertHelpers.showErrorSnackBar(
        context,
        LocaleKeys.kyc_module_common_field_required.tr(
          namedArgs: {'field': LocaleKeys.kyc_module_step4_account_number.tr()},
        ),
      );
      return null;
    }
    if (accountHolderNameCtrl.text.isEmpty) {
      UiAlertHelpers.showErrorSnackBar(
        context,
        LocaleKeys.kyc_module_common_field_required.tr(
          namedArgs: {'field': LocaleKeys.kyc_module_step4_account_holder.tr()},
        ),
      );
      return null;
    }

    return KycFormDataStep4.mobilePayment(
      step3Data: step3Data,
      paymentCountry: country,
      mobileOperator: mobileOperatorCtrl.text,
      mobileAccountNumber: mobileAccountNumberCtrl.text,
      accountHolderName: accountHolderNameCtrl.text,
      otherDocument: _bankDocumentXFile,
    );
  }

  KycFormDataStep4? _validateBankAccountInfos() {
    if (bankNameCtrl.text.isEmpty) {
      UiAlertHelpers.showErrorSnackBar(
        context,
        LocaleKeys.kyc_module_common_field_required.tr(
          namedArgs: {'field': LocaleKeys.kyc_module_step4_bank_name.tr()},
        ),
      );
      return null;
    }
    if (bankAccountNumberCtrl.text.isEmpty) {
      UiAlertHelpers.showErrorSnackBar(
        context,
        LocaleKeys.kyc_module_common_field_required.tr(
          namedArgs: {'field': LocaleKeys.kyc_module_step4_account_number.tr()},
        ),
      );
      return null;
    }
    if (bankAccountNumberCtrl.text != bankAccountNumberConfirmCtrl.text) {
      UiAlertHelpers.showErrorSnackBar(
        context,
        LocaleKeys.kyc_module_step4_bad_account_number_confirmation.tr(),
      );
      return null;
    }
    if (bankSwiftCodeCtrl.text.isEmpty) {
      UiAlertHelpers.showErrorSnackBar(
        context,
        LocaleKeys.kyc_module_common_field_required.tr(
          namedArgs: {'field': LocaleKeys.kyc_module_step4_swift_code.tr()},
        ),
      );
      return null;
    }
    if (accountHolderNameCtrl.text.isEmpty) {
      UiAlertHelpers.showErrorSnackBar(
        context,
        LocaleKeys.kyc_module_common_field_required.tr(
          namedArgs: {'field': LocaleKeys.kyc_module_step4_account_holder.tr()},
        ),
      );
      return null;
    }

    return KycFormDataStep4.bankPayment(
      step3Data: step3Data,
      bankName: bankNameCtrl.text,
      bankAccountNumber: bankAccountNumberCtrl.text,
      bankSwiftCode: bankSwiftCodeCtrl.text,
      accountHolderName: accountHolderNameCtrl.text,
      bankDocument: _bankDocumentXFile,
    );
  }

  void onNext() {
    KycFormDataStep4? kycFormData;

    // Validate based on the selected account type
    if (selectedAccountType == EAccountType.mobile) {
      kycFormData = _validateMobileAccountInfos();
    } else if (selectedAccountType == EAccountType.bank) {
      kycFormData = _validateBankAccountInfos();
    }

    // If kycFormData is null, it means validation failed
    if (kycFormData != null) {
      Modular.get<KycRoutes>().step5a.push(kycFormData);
    }
  }
}
