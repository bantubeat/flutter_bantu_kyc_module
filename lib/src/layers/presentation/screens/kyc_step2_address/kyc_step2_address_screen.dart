import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bantu_kyc_module/flutter_bantu_kyc_module.dart';
import 'package:flutter_bantu_kyc_module/src/core/generated/locale_keys.g.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/helpers/ui_alert_helpers.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/localization/string_translate_extension.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_app_bar.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_card.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_header.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_primary_button.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_text_field.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_stepper.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screen_controller/flutter_screen_controller.dart';

import '../../ui_models/kyc_form_data.dart';
import '../../widgets/kyc_form_country_select_field.dart';

part 'step2_controller.dart';

class KycStep2AddressScreen extends StatelessWidget {
  final KycFormDataStep1 previousData;

  const KycStep2AddressScreen({required this.previousData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const KycFormAppBar(),
      floatingActionButton: KycModule.getFloatingMenuWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // --- Stepper Widget ---
            const KycStepper(currentStep: 2),
            const SizedBox(height: 32),
            // --- Main Content Card ---
            ScreenControllerBuilder(
              create: (s) => Step2Controller(s, previousData: previousData),
              builder: (context, ctrl) => KycFormCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KycFormHeader(
                      title: LocaleKeys.kyc_module_step2_title.tr(),
                      subtitle: LocaleKeys.kyc_module_step2_description.tr(),
                    ),
                    const SizedBox(height: 24),
                    // --- Form Fields ---
                    KycFormTextField(
                      label: LocaleKeys.kyc_module_step2_street.tr(),
                      controller: ctrl.streetCtrl,
                    ),
                    const SizedBox(height: 16),
                    KycFormTextField(
                      label: LocaleKeys.kyc_module_step2_city.tr(),
                      controller: ctrl.cityCtrl,
                    ),
                    const SizedBox(height: 16),
                    KycFormTextField(
                      label: LocaleKeys.kyc_module_step2_postal_code.tr(),
                      controller: ctrl.postalCodeCtrl,
                    ),
                    const SizedBox(height: 24),
                    KycFormCountrySelectField(
                      initialSelection: ctrl.selectedCountry?.code,
                      onChanged: ctrl.selectCountry,
                    ),
                    const SizedBox(height: 32),
                    // --- Validation Button ---
                    KycFormPrimaryButton(onPressed: ctrl.onNext),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
