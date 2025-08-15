import 'package:flutter/material.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/screens/kyc_step3_id_card/kyc_step3_id_controller.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/screens/kyc_step3_id_card/widgets/pages/kyc_id_type_page.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/screens/kyc_step3_id_card/widgets/pages/kyc_id_upload_page.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_app_bar.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_card.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_stepper.dart';
import 'package:flutter_screen_controller/flutter_screen_controller.dart';

class KycStep3IdCardScreen extends StatelessWidget {
  const KycStep3IdCardScreen({super.key});

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
                  create: KycStep3IdController.new,
                  builder: (context, controller) {
                    return PageView(
                      controller: controller.pageCtrl,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        KycIdTypePage(controller: controller),
                        KycIdUploadPage(isRecto: true, controller: controller),
                        KycIdUploadPage(isRecto: false, controller: controller),
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
