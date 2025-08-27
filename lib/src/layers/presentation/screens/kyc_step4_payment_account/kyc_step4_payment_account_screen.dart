import 'package:flutter/material.dart';
import 'package:flutter_bantu_kyc_module/src/core/generated/locale_keys.g.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/localization/string_translate_extension.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/screens/kyc_step4_payment_account/kyc_step4_payment_account_controller.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_card.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_header.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_label.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_primary_button.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_text_field.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_upload_box.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_stepper.dart';
import 'package:flutter_screen_controller/flutter_screen_controller.dart';

import '../../ui_models/kyc_form_data.dart';

/// 4. Payment Account Screen
class KycStep4PaymentAccountScreen extends StatelessWidget {
  final KycFormDataStep3 step3Data;
  const KycStep4PaymentAccountScreen({required this.step3Data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const KycStepper(currentStep: 4),
            const SizedBox(height: 32),
            KycFormCard(
              child: ScreenControllerBuilder(
                create: (s) => KycStep4PaymentAccountController(s, step3Data),
                builder: (context, ctrl) {
                  final isCompany = ctrl.selectedAccountTypeIsCompany;
                  return RadioGroup<bool>(
                    groupValue: isCompany,
                    onChanged: (val) => ctrl.setAccountType(val ?? false),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KycFormHeader(
                          title: LocaleKeys.kyc_module_step4_title.tr(),
                          subtitle: LocaleKeys.kyc_module_step4_description
                              .tr(),
                        ),
                        const SizedBox(height: 24),
                        KycFormLabel(
                          LocaleKeys.kyc_module_step4_account_type.tr(),
                        ),

                        ...[false, true]
                            .map(
                              (isCompanyVal) => [
                                GestureDetector(
                                  onTap: () =>
                                      ctrl.setAccountType(isCompanyVal),
                                  child: Row(
                                    children: [
                                      Radio<bool>.adaptive(
                                        value: isCompanyVal,
                                        activeColor: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        isCompanyVal
                                            ? LocaleKeys
                                                  .kyc_module_step4_account_type_company
                                                  .tr()
                                            : LocaleKeys
                                                  .kyc_module_step4_account_type_particular
                                                  .tr(),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 8),
                              ],
                            )
                            .reduce((l1, l2) => [...l1, ...l2]),

                        const SizedBox(height: 16),

                        if (isCompany) ...[
                          KycFormTextField(
                            label: LocaleKeys.kyc_module_step4_company_name
                                .tr(),
                            controller: ctrl.companyNameCtrl,
                          ),
                          const SizedBox(height: 16),
                        ],

                        KycFormTextField(
                          label: isCompany
                              ? LocaleKeys
                                    .kyc_module_step4_company_registration_number
                                    .tr()
                              : LocaleKeys.kyc_module_step4_nui_number.tr(),
                          controller: ctrl.companyRegistrationNumberCtrl,
                        ),

                        if (isCompany) ...[
                          const SizedBox(height: 16),
                          KycFormTextField(
                            label: LocaleKeys
                                .kyc_module_step4_company_tva_number
                                .tr(),
                            controller: ctrl.companyTvaCtrl,
                          ),
                        ],
                        const SizedBox(height: 24),
                        KycFormUploadBox(
                          image: ctrl.fiscalDocumentt,
                          onTap: ctrl.pickFiscalDocument,
                          label: LocaleKeys.kyc_module_step4_upload_file.tr(),
                        ),
                        const SizedBox(height: 32),
                        KycFormPrimaryButton(onPressed: ctrl.onNext),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
