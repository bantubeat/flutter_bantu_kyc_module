import 'package:flutter/material.dart';
import 'package:flutter_bantu_kyc_module/src/core/generated/locale_keys.g.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/localization/string_translate_extension.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/screens/kyc_step4_payment_account/kyc_step4_payment_account_controller.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_app_bar.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_card.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_country_select_field.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_header.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_label.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_primary_button.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_text_field.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_upload_box.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_stepper.dart';
import 'package:flutter_screen_controller/flutter_screen_controller.dart';

import 'widgets/account_type_selector.dart';

/// 4. Payment Account Screen
class KycStep4PaymentAccountScreen extends StatelessWidget {
  const KycStep4PaymentAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KycFormAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const KycStepper(currentStep: 4),
            const SizedBox(height: 32),
            KycFormCard(
              child: ScreenControllerBuilder(
                create: KycStep4PaymentAccountController.new,
                builder: (context, controller) {
                  final isMobile =
                      controller.selectedAccountType == EAccountType.mobile;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KycFormHeader(
                        title: LocaleKeys.kyc_module_step4_title.tr(),
                        subtitle: LocaleKeys.kyc_module_step4_description.tr(),
                      ),
                      const SizedBox(height: 24),
                      KycFormLabel(
                        LocaleKeys.kyc_module_step4_account_type.tr(),
                      ),
                      AccountTypeSelector(controller),
                      const SizedBox(height: 16),
                      if (isMobile) ...[
                        KycFormCountrySelectField(
                          initialSelection:
                              controller.selectedPaymentCountry?.code ?? 'CM',
                          onChanged: controller.selectPaymentCountry,
                        ),
                        const SizedBox(height: 16),
                        KycFormTextField(
                          label: LocaleKeys
                              .kyc_module_step4_mobile_operator_name
                              .tr(),
                        ),
                        const SizedBox(height: 16),
                        KycFormTextField(
                          label: LocaleKeys.kyc_module_step4_account_number
                              .tr(),
                        ),
                      ] else ...[
                        KycFormTextField(
                          label: LocaleKeys.kyc_module_step4_account_number
                              .tr(),
                        ),
                        const SizedBox(height: 16),
                        KycFormTextField(
                          label: LocaleKeys
                              .kyc_module_step4_confirm_account_number
                              .tr(),
                        ),
                        const SizedBox(height: 16),
                        KycFormTextField(
                          label: LocaleKeys.kyc_module_step4_bank_name.tr(),
                        ),
                        const SizedBox(height: 16),
                        KycFormTextField(
                          label: LocaleKeys.kyc_module_step4_swift_code.tr(),
                        ),
                      ],
                      const SizedBox(height: 16),
                      KycFormTextField(
                        label: LocaleKeys.kyc_module_step4_account_holder.tr(),
                      ),
                      const SizedBox(height: 24),
                      KycFormUploadBox(
                        image: controller.bankDocument,
                        onTap: controller.pickBankDocument,
                        label: LocaleKeys.kyc_module_step4_load_bank_docs.tr(),
                      ),
                      const SizedBox(height: 32),
                      KycFormPrimaryButton(onPressed: controller.onValidate),
                    ],
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
