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

class KycStep1PersonalInfosScreen extends StatefulWidget {
  const KycStep1PersonalInfosScreen({super.key});

  @override
  State<KycStep1PersonalInfosScreen> createState() =>
      _KycStep1PersonalInfosScreenState();
}

class _KycStep1PersonalInfosScreenState
    extends State<KycStep1PersonalInfosScreen> {
  // State for the radio button selection
  String? _selectedGender;

  // Helper widget for gender radio buttons
  Widget _buildGenderOption(String title) {
    return Flexible(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedGender = title;
          });
        },
        child: Row(
          children: [
            Radio<String>(
              value: title,
              groupValue: _selectedGender,
              onChanged: (String? value) {
                setState(() {
                  _selectedGender = value;
                });
              },
              activeColor: const Color(0xFFE8B33B),
            ),
            Flexible(
              child: FittedBox(
                child: Text(title, style: const TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
            const KycStepper(currentStep: 1),
            const SizedBox(height: 32),
            // --- Main Content Card ---
            KycFormCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KycFormHeader(
                    title: LocaleKeys.kyc_module_step1_title.tr(),
                    subtitle: LocaleKeys.kyc_module_step1_description.tr(),
                  ),
                  const SizedBox(height: 24),
                  // --- Form Fields ---
                  KycFormTextField(
                    label: LocaleKeys.kyc_module_step1_surname.tr(),
                  ),
                  const SizedBox(height: 16),
                  KycFormTextField(
                    label: LocaleKeys.kyc_module_step1_name.tr(),
                  ),
                  const SizedBox(height: 16),
                  KycFormTextField(
                    label: LocaleKeys.kyc_module_step1_birthdate.tr(),
                  ),
                  const SizedBox(height: 24),
                  // --- Gender Radio Buttons ---
                  Text(
                    LocaleKeys.kyc_module_step1_gender.tr(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildGenderOption(LocaleKeys.kyc_module_step1_man.tr()),
                      const SizedBox(width: 24),
                      _buildGenderOption(
                        LocaleKeys.kyc_module_step1_woman.tr(),
                      ),
                      const SizedBox(width: 24),
                      _buildGenderOption(
                        LocaleKeys.kyc_module_step1_others.tr(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // --- Validation Button ---
                  KycFormPrimaryButton(
                    onPressed: Modular.get<KycRoutes>().step2.push,
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
