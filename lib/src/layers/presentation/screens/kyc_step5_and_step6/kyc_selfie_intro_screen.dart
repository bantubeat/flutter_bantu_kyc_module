import 'package:flutter/material.dart';
import 'package:flutter_bantu_kyc_module/src/core/generated/locale_keys.g.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/localization/string_translate_extension.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/navigation/kyc_routes.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_app_bar.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_card.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_header.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_primary_button.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_stepper.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// 4. Selfie Intro Screen
class KycSelfieIntroPage extends StatelessWidget {
  final bool isStep5;

  const KycSelfieIntroPage({required this.isStep5, super.key});

  @override
  Widget build(BuildContext context) {
    final title = isStep5
        ? LocaleKeys.kyc_module_step5_title.tr()
        : LocaleKeys.kyc_module_step6_title.tr();
    final subtitle = isStep5
        ? LocaleKeys.kyc_module_step5_description.tr()
        : LocaleKeys.kyc_module_step6_description.tr();
    final nextRouteItem = isStep5
        ? Modular.get<KycRoutes>().step5b
        : Modular.get<KycRoutes>().step6b;
    return Scaffold(
      appBar: const KycFormAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            KycStepper(currentStep: isStep5 ? 5 : 6),
            const SizedBox(height: 32),
            Expanded(
              child: KycFormCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KycFormHeader(title: title, subtitle: subtitle),
                    const Spacer(),
                    KycFormPrimaryButton(onPressed: nextRouteItem.push),
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
