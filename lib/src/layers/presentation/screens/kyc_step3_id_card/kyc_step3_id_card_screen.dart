import 'package:country_code_picker/country_code_picker.dart' show CountryCode;
import 'package:flutter/material.dart';
import 'package:flutter_bantu_kyc_module/flutter_bantu_kyc_module.dart';
import 'package:flutter_bantu_kyc_module/src/core/generated/locale_keys.g.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/helpers/image_picker_helper.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/localization/string_translate_extension.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/ui_models/kyc_form_data.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_app_bar.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_card.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_country_select_field.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_header.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_label.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_primary_button.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_upload_box.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_stepper.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screen_controller/flutter_screen_controller.dart';
import 'package:image_picker/image_picker.dart' show XFile;

import '../../helpers/ui_alert_helpers.dart';

part 'kyc_step3_id_controller.dart';
part 'widgets/pages/kyc_id_type_page.dart';
part 'widgets/pages/kyc_id_upload_page.dart';
part 'widgets/kyc_id_consent_checkbox.dart';

class KycStep3IdCardScreen extends StatelessWidget {
  final KycFormDataStep2 step2Data;
  const KycStep3IdCardScreen({required this.step2Data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const KycFormAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // --- Stepper Widget ---
            const KycStepper(currentStep: 3),
            const SizedBox(height: 32),
            // --- Main Content Card ---
            Expanded(
              child: KycFormCard(
                child: ScreenControllerBuilder(
                  create: (s) => _KycStep3IdController(s, step2Data),
                  builder: (context, controller) {
                    return PageView(
                      controller: controller.pageCtrl,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _KycIdTypePage(controller: controller),
                        _KycIdUploadPage(isRecto: true, controller: controller),
                        _KycIdUploadPage(
                          isRecto: false,
                          controller: controller,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
