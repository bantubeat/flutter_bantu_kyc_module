import 'package:flutter/material.dart';
import 'package:flutter_bantu_kyc_module/flutter_bantu_kyc_module.dart';
import 'package:flutter_bantu_kyc_module/src/core/generated/locale_keys.g.dart';
import 'package:flutter_bantu_kyc_module/src/layers/domain/entities/user_entity.dart';
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
part 'step1_controller.dart';

class KycStep1PersonalInfosScreen extends StatelessWidget {
  final UserEntity currentUser;
  const KycStep1PersonalInfosScreen({required this.currentUser});

  @override
  Widget build(BuildContext context) {
    final genderTitles = {
      EGender.M: LocaleKeys.kyc_module_step1_man.tr(),
      EGender.F: LocaleKeys.kyc_module_step1_woman.tr(),
      EGender.O: LocaleKeys.kyc_module_step1_others.tr(),
    };
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
            ScreenControllerBuilder(
              create: (s) => Step1Controller(s, currentUser),
              builder: (context, ctrl) => KycFormCard(
                child: RadioGroup<EGender>(
                  groupValue: ctrl.selectedGender,
                  onChanged: ctrl.selectGender,
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
                        controller: ctrl.surnameCtrl,
                      ),
                      const SizedBox(height: 16),
                      KycFormTextField(
                        label: LocaleKeys.kyc_module_step1_name.tr(),
                        controller: ctrl.nameCtrl,
                      ),
                      const SizedBox(height: 16),
                      KycFormTextField(
                        label: LocaleKeys.kyc_module_step1_birthdate.tr(),
                        readOnly: true,
                        onTap: ctrl.pickBirthdate,
                        controller: TextEditingController(
                          text: ctrl.pickedBirthdate,
                        ),
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
                          ...genderTitles.keys
                              .map(
                                (value) => [
                                  Flexible(
                                    child: GestureDetector(
                                      onTap: () => ctrl.selectGender(value),
                                      child: Row(
                                        children: [
                                          Radio<EGender>.adaptive(
                                            value: value,
                                            activeColor: Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                          ),
                                          Flexible(
                                            child: FittedBox(
                                              child: Text(
                                                genderTitles[value] ?? '',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 24),
                                ],
                              )
                              .reduce((l1, l2) => [...l1, ...l2]),
                        ],
                      ),
                      const SizedBox(height: 32),
                      // --- Validation Button ---
                      KycFormPrimaryButton(onPressed: ctrl.onNext),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
