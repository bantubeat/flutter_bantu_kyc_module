import 'package:flutter/material.dart';
import 'package:flutter_bantu_kyc_module/flutter_bantu_kyc_module.dart';
import 'package:flutter_bantu_kyc_module/src/core/generated/locale_keys.g.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/localization/string_translate_extension.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_app_bar.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_card.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_header.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_primary_button.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_text_field.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_stepper.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../widgets/kyc_form_country_select_field.dart';

class KycStep2AddressScreen extends StatefulWidget {
  const KycStep2AddressScreen({super.key});

  @override
  State<KycStep2AddressScreen> createState() => _KycStep2AddressScreenState();
}

class _KycStep2AddressScreenState extends State<KycStep2AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const KycFormAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // --- Stepper Widget ---
            const KycStepper(currentStep: 2),
            const SizedBox(height: 32),
            // --- Main Content Card ---
            KycFormCard(
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
                  ),
                  const SizedBox(height: 16),
                  KycFormTextField(
                    label: LocaleKeys.kyc_module_step2_city.tr(),
                  ),
                  const SizedBox(height: 16),
                  KycFormTextField(
                    label: LocaleKeys.kyc_module_step2_postal_code.tr(),
                  ),
                  const SizedBox(height: 24),
                  const KycFormCountrySelectField(),
                  const SizedBox(height: 32),
                  // --- Validation Button ---
                  KycFormPrimaryButton(
                    onPressed: Modular.get<KycRoutes>().step3.push,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
